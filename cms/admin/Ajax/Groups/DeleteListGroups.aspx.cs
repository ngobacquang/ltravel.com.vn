using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;


public partial class cms_admin_Ajax_Groups_DeleteListGroups : System.Web.UI.Page
{
    private string condition = "";
    private string listigid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        listigid = Request["listigid"];
        DeleteCate();
        Response.End();
    }

    void DeleteCate()
    {
        string[] arrigid = listigid.Split(Convert.ToChar(","));


        for (int i = 0; i < arrigid.Length - 1; i++)
        {
            string[] fieldsDelGroup = { "IGENABLE", GroupsColumns.DgupdateColumn };
            string[] valuesDelGroup = { "2", "'" + DateTime.Now.ToString() + "'" };
            condition = " CHARINDEX('," + arrigid[i] + ",',IGPARENTSID) > 0 ";
            Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);


            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            string title = GetTitle(arrigid[i]);
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", title, logAuthor, "", logCreateDate + ": " + logAuthor + " xóa " + title + " (id: " + arrigid[i] + ")");
            #endregion
        }
        
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