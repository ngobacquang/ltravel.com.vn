using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;


public partial class cms_admin_Ajax_Groups_RestoreGroup : System.Web.UI.Page
{
    private string condition = "";
    private string igid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        igid = Request["igid"];
        RestoreCate();
        Response.End();
    }

    void RestoreCate()
    {
        string[] fieldsDelGroup = { "IGENABLE", GroupsColumns.DgupdateColumn };
        string[] valuesDelGroup = { "1", "'" + DateTime.Now.ToString() + "'" };
        condition = " CHARINDEX('," + igid + ",',IGPARENTSID) > 0 ";
        Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        string title = GetTitle(igid);
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", title, logAuthor, "", logCreateDate + ": " + logAuthor + " khôi phục " + title + " (id: " + igid + ")");
        #endregion
    }

    #region Logs
    private string GetTitle(string igid)
    {
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Groups.GetGroups("1", GroupsColumns.VgnameColumn, GroupsTSql.GetGroupsByIgid(igid), "");
        if (dt.Rows.Count > 0)
            return dt.Rows[0][GroupsColumns.VgnameColumn].ToString();
        return "";
    }
    #endregion
}