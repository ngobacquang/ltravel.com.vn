using System;
using System.Data;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.SystemWebsiteModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_SystemWebsite_Logs_Logs : System.Web.UI.UserControl
{
    private string top = "", fields = "", condition = "", orderby = "";
    private string p = "1";
    private string ni = "20";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["p"] != null)
            p = Request.QueryString["p"];

        if (!IsPostBack)
            GetList();
    }

    private void GetList()
    {
        condition = LogsTSql.GetLogsByvlType("");
        orderby = LogsColumns.dlCreateDateColumn + " desc";
        DataSet ds = Logs.GetLogsPagging(p, ni, condition, orderby);

        ltrPagging.Text = "<div class='AdminPagging'>" + PagingExtension.SpilitPages(
            int.Parse(ds.Tables[1].Rows[0]["TotalRows"].ToString()),
            int.Parse(ni), int.Parse(p),
            LinkAdmin.UrlAdmin(CodeApplications.Systemwebsite, "logs", "", "", ni),
            "currentPS", "otherPS", "firstPS", "lastPS", "previewPS", "nextPS") + "</div>";

        DataTable dt = new DataTable();
        dt = ds.Tables[0];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ltrList.Text += @"
<div class='item'>
    " + dt.Rows[i][LogsColumns.vlDescColumn] + @" - <span><a target='_blank' href='" + dt.Rows[i][LogsColumns.vlUrlColumn] + @"'>" + dt.Rows[i][LogsColumns.vlUrlColumn] + @"</a></span>
</div>";
        }
    }
}