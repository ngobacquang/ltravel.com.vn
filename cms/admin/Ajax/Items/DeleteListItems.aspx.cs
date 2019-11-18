using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;


public partial class cms_admin_Ajax_Items_DeleteListItems : System.Web.UI.Page
{
    private string condition = "";
    private string listigid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        listigid = Request["listigid"];
        DeleteListItem();
        Response.End();
    }

    void DeleteListItem()
    {
        string[] arrigid = listigid.Split(Convert.ToChar(","));
        for (int i = 0; i < arrigid.Length - 1; i++)
        {
            string[] fieldsDelGroup = { "IIENABLE"};
            string[] valuesDelGroup = { "2"};
            condition = " IID = '"  + arrigid[i] + "' ";
            TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            string title = GetTitle(arrigid[i]);
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", title, logAuthor, "", logCreateDate + ": " + logAuthor + " xóa " + title + " (id: " + arrigid[i] + ")");
            #endregion
        }
    }
    #region Logs
    private string GetTitle(string iid)
    {
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Items.GetItems("1", ItemsColumns.VititleColumn, ItemsTSql.GetItemsByIid(iid), "");
        if (dt.Rows.Count > 0)
            return dt.Rows[0][ItemsColumns.VititleColumn].ToString();
        return "";
    }
    #endregion
}