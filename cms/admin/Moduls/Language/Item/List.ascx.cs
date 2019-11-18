using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.LanguageModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Language_Item_List : System.Web.UI.UserControl
{
    private string language = Cookie.GetLanguageValueAdmin();
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

    protected void RpListLanguageNationals_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        switch (c)
        {
            #region edit
            case "edit":
                EditValue(p);
                #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
                Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", p, logAuthor, "",
                    logCreateDate + ": " + logAuthor + " đổi giá trị một từ khóa (" + p + ")");
            #endregion
                break;
            #endregion
        }
    }

    protected void TextChanged(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;
        if (SetCountItem(textbox.ToolTip).Equals("0")) //Nếu key language chưa có giá trị, insert mới
        {
            string value = textbox.Text.Replace("'", "''");
            LanguageItem.InsertLanguageItem(language, textbox.ToolTip, value, "", "");
        }
        else//Nếu key language có giá trị rồi, update
        {
            string value = textbox.Text.Replace("'", "''");
            string[] fields = { "nLanguageItemTitle" };
            string[] values = { "N'" + value + "'" };
            string condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(textbox.ToolTip),
                                                        LanguageItemTSql.GetByiLanguageNationalId(language));
            LanguageItem.UpdateLanguageItem(DataExtension.UpdateTransfer(fields, values), condition);
        }
    }

    private void EditValue(string iLanguageKeyId)
    {
        //Nếu key language chưa có giá trị
        if (SetCountItem(iLanguageKeyId).Equals("0"))
        {
            for (int i = 0; i <= RpListLanguageNationals.Items.Count - 1; i++)
            {
                TextBox tbTitle = (TextBox)RpListLanguageNationals.Items[i].FindControl(("TbLanguageWord"));
                string value = tbTitle.Text.Replace("'", "''");
                if (tbTitle.ToolTip.Equals(iLanguageKeyId))
                {
                    LanguageItem.InsertLanguageItem(language, iLanguageKeyId, value, "", "");
                }
            }
        }
        else //Nếu key language có giá trị rồi
        {
            for (int i = 0; i <= RpListLanguageNationals.Items.Count - 1; i++)
            {
                TextBox tbTitle = (TextBox)RpListLanguageNationals.Items[i].FindControl(("TbLanguageWord"));
                string value = tbTitle.Text.Replace("'", "''");
                if (tbTitle.ToolTip.Equals(iLanguageKeyId))
                {
                    string[] fields = { "nLanguageItemTitle" };
                    string[] values = { "N'" + value + "'" };
                    string condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(iLanguageKeyId),
                                                                LanguageItemTSql.GetByiLanguageNationalId(language));
                    LanguageItem.UpdateLanguageItem(DataExtension.UpdateTransfer(fields, values), condition);
                }
            }
        }
    }

    string SetCountItem(string iLanguageKeyId)
    {
        top = "1";
        fields = " * ";
        condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(iLanguageKeyId),
                                             LanguageItemTSql.GetByiLanguageNationalId(language));
        order = "";
        DataTable dt = new DataTable();
        dt = LanguageItem.GetLanguageItem(top, fields, condition, order);
        return dt.Rows.Count.ToString();
    }

    protected string GetWordItem(string iLanguageKeyId)
    {
        top = "1";
        fields = " * ";
        condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(iLanguageKeyId),
                                             LanguageItemTSql.GetByiLanguageNationalId(language));
        order = "";
        DataTable dt = new DataTable();
        dt = LanguageItem.GetLanguageItem(top, fields, condition, order);
        string s = "";
        if (dt.Rows.Count > 0)
        {
            s = dt.Rows[0]["nLanguageItemTitle"].ToString();
        }
        return s;
    }

    protected string GetImageItem(string iLanguageKeyId)
    {
        top = "1";
        fields = LanguageItemColumns.nLanguageItemParams; ;
        condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(iLanguageKeyId),
                                             LanguageItemTSql.GetByiLanguageNationalId(language));
        order = "";
        DataTable dt = new DataTable();
        dt = LanguageItem.GetLanguageItem(top, fields, condition, order);
        string s = "";

        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0][LanguageItemColumns.nLanguageItemParams].ToString().Length > 0)
                s = "<img src='" + UrlExtension.WebisteUrl + FolderPic.Language + "/" + dt.Rows[0][LanguageItemColumns.nLanguageItemParams].ToString() + "' class='anhtukhoa' id='img" + iLanguageKeyId + "'/>";
            else
                s = "<img src='" + UrlExtension.WebisteUrl + "pic/icon/no_image.gif' class='anhtukhoa' id='img" + iLanguageKeyId + "'/>";
        }
        else
            s = "<img src='" + UrlExtension.WebisteUrl + "pic/icon/no_image.gif' class='anhtukhoa' id='img" + iLanguageKeyId + "'/>";
        return s;
    }
    protected void btnUpdateAll_Click(object sender, EventArgs e)
    {
        string arrayListFile = "";
        for (int i = 0; i < RpListLanguageNationals.Items.Count; i++)
        {
            TextBox tbTitle = (TextBox)RpListLanguageNationals.Items[i].FindControl(("TbLanguageWord"));
            arrayListFile += tbTitle.ToolTip + ",";
        }
        char[] Split = { ',' };
        foreach (string itemID in arrayListFile.Split(Split, StringSplitOptions.RemoveEmptyEntries))
        {
            EditValue(itemID);
        }

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", "", logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật giá trị danh sách từ khóa ");
        #endregion
    }
}