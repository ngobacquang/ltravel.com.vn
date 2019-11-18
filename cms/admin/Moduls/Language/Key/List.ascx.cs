using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.LanguageModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Language_Key_List : System.Web.UI.UserControl
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetListCodesLanguageKey();
        }
    }

    private string LinkUpdate(string iLanguageKeyId)
    {
        return "admin.aspx?uc=" + CodeApplications.Language + "&suc=UpdateLanguageKey&iLanguageKeyId=" + iLanguageKeyId;
    }

    void GetListCodesLanguageKey()
    {
        top = "";
        fields = "*";
        condition = "";
        order = LanguageKeyColumns.nLanguageKeyTitle + " ASC ";
        DataTable dt = new DataTable();
        dt = LanguageKey.GetLanguageKey(top, fields, condition, order);
        RpListLanguageNationals.DataSource = dt;
        RpListLanguageNationals.DataBind();
    }

    protected void lnk_create_account_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkAdmin.GoAdminSubModul(CodeApplications.Language, "CreateLanguageKey"));
    }

    protected void RpListLanguageNationals_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        switch (c)
        {
            #region delete
            case "delete":
                //Xoá ảnh
                DeleteLanguageItemImage(p);
                LanguageKey.DeleteLanguageKeyAndLanguageItem(p);
                GetListCodesLanguageKey();

                #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", p, logAuthor, "",logCreateDate+": " +logAuthor+" xóa một từ khóa (id: "+p+")");
            #endregion
                break;
            #endregion

            #region edit
            case "edit":
                Response.Redirect(LinkUpdate(p));
                GetListCodesLanguageKey();

                #region Logs
            logAuthor = CookieExtension.GetCookies("LoginSetting");
            logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", p, logAuthor, "",logCreateDate+": " +logAuthor+" thay đổi trạng thái một từ khóa (id: "+p+")");
            #endregion
                break;
            #endregion
        }
    }

    private void DeleteLanguageItemImage(string iLanguageKeyId)
    {
        condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(iLanguageKeyId));
        DataTable dt = new DataTable();
        dt = LanguageItem.GetLanguageItem("", LanguageItemColumns.nLanguageItemParams, condition, "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ImagesExtension.DeleteImageWhenDeleteItem(FolderPic.Language, dt.Rows[i][LanguageItemColumns.nLanguageItemParams].ToString());
        }
    }
    protected void chk_list_CheckedChanged(object sender, EventArgs e)
    {
        //Đoàn sửa
        for (int i = 0; i < RpListLanguageNationals.Items.Count; i++)
        {
            CheckBox ckItem = (CheckBox)RpListLanguageNationals.Items[i].FindControl("chk_item");
            ckItem.Checked = chk_list.Checked;
        }
    }
    protected void lnk_delete_user_checked_Click(object sender, EventArgs e)
    {
        //Đoàn sửa
        string listID = "";
        for (int i = 0; i < RpListLanguageNationals.Items.Count; i++)
        {
            CheckBox ckItem = (CheckBox)RpListLanguageNationals.Items[i].FindControl("chk_item");
            if (ckItem.Checked)
            {
                listID += ckItem.ToolTip + ",";
            }
        }
        if (listID.Length > 0)
        {
            listID = listID.Substring(0, listID.Length - 1);
        }
        char[] splitItem = { ',' };
        foreach (string itemID in listID.Split(splitItem, StringSplitOptions.RemoveEmptyEntries))
        {
            DeleteLanguageItemImage(itemID);
            LanguageKey.DeleteLanguageKeyAndLanguageItem(itemID);
        }
        GetListCodesLanguageKey();
    }

    #region ExportToExcel
    protected void OnExport()
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        //Lấy id của các mục được chọn
        string listID = "";
        for (int i = 0; i <= RpListLanguageNationals.Items.Count - 1; i++)
        {
            CheckBox chkItem = (CheckBox)RpListLanguageNationals.Items[i].FindControl(("chk_item"));
            if (chkItem != null)
            {
                if (chkItem.Checked == true)
                    listID += "," + chkItem.ToolTip;
            }
        }

        string condition = LanguageKeyColumns.iLanguageKeyId + " in(0" + listID + ")";
        string fields = DataExtension.GetListColumns(LanguageKeyColumns.nLanguageKeyTitle, LanguageKeyColumns.nLanguageKeyDesc);
        #region OrderBy
        string orderBy = LanguageKeyColumns.nLanguageKeyTitle;

        #endregion
        dt = LanguageKey.GetLanguageKey("", fields, condition, orderBy);
        //Dat lai ten cho cac cot    
        dt.Columns[0].ColumnName = "Mã từ khoá";
        dt.Columns[1].ColumnName = "Mô tả";
        ds.Tables.Add(dt.Copy());
        ExportExcel1.DSSource = ds;
    }
    #endregion
}