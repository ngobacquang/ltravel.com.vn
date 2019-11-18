using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Extension;
using TatThanhJsc.PhotoAlbumModul;
using TatThanhJsc.TSql;
using TatThanhJsc.Columns;
using System.Data;
using TatThanhJsc.Database;

public partial class cms_admin_Moduls_PhotoAlbum_PopUp_Items_ViewCommentsReply : System.Web.UI.Page
{
    string top = "";
    string field = "";
    string condition = "";
    string orderby = "";
    
    string isid = "";
    string iid = "";

    string app = CodeApplications.PhotoAlbumComment + "Reply";
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["iid"] != null)
            iid = Request.QueryString["iid"].ToString();
        if (Request.QueryString["isid"] != null)
            isid = Request.QueryString["isid"].ToString();

        if (!IsPostBack)
            GetListReply();
    }

    void GetListReply()
    {
        condition = DataExtension.AndConditon
            (
            SubitemsTSql.GetSubitemsByIid(iid),
            SubitemsTSql.GetSubitemsByVsurl(isid),//lấy trả lời
            SubitemsTSql.GetSubitemsByVskey(app)
            );
        orderby = SubitemsColumns.DscreatedateColumn + " desc ";
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("", "*", condition, orderby);
        rptList.DataSource = dt;
        rptList.DataBind();
    }
    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string name = e.CommandName;
        string id = e.CommandArgument.ToString();
        switch (name)
        {
            case "delete":
                Subitems.DeleteSubitems(id);
                GetListReply();
                break;
            default: break;
        }
    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        Subitems.InsertSubitems(iid, lang, app, tbName.Text, tbNoiDung.Text, "", "", tbName.Text, isid, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
        tbName.Text = "";
        tbNoiDung.Text = "";
        GetListReply();
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/Moduls/PhotoAlbum/Item/Popup/ViewComments.aspx?iid=" + iid + "&isid=" + isid);
    }
}