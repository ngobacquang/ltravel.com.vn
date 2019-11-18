using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.LanguageModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Language_National_List : System.Web.UI.UserControl
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";

    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetListLanguageNationals();
        }
    }

    private string LinkUpdate(string iLanguageNationalId)
    {
        return "admin.aspx?uc=" + CodeApplications.Language + "&suc=UpdateLanguageNational&iLanguageNationalId=" + iLanguageNationalId;
    }

    void GetListLanguageNationals()
    {
        top = "";
        fields = "*";
        condition = "";
        order = LanguageNationalColumns.nLanguageNationalDesc + " ASC ";
        DataTable dt = new DataTable();
        dt = LanguageNational.GetLanguageNational(top, fields, condition, order);
        RpListLanguageNationals.DataSource = dt;
        RpListLanguageNationals.DataBind();
    }

    protected void lnk_create_account_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkAdmin.GoAdminSubModul(CodeApplications.Language, "CreateLanguageNational"));
    }

    protected void RpListLanguageNationals_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        switch (c)
        {
            #region delete
            //case "delete":
            //    if (!language.Equals(p))
            //    {
            //        LanguageNational.DeleteLanguageNationalAndLanguageItem(p);
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteItem",
            //                                            "ThongBao(3000, 'Bạn đang sử dụng ngôn ngữ này vì vậy không thể xóa được!');",
            //                                            true);
            //    }
            //    break;
            #endregion

            #region Edit Status
            case "EditStatus":
                top = "1";
                fields = "iLanguageNationalEnable, nLanguageNationalName";
                condition = LanguageNationalTSql.GetByiLanguageNationalId(p);
                order = "";
                DataTable dt = new DataTable();
                dt = LanguageNational.GetLanguageNational(top, fields, condition, order);

                string[] fieldsEditStatus = { "iLanguageNationalEnable" };
                string[] valuesEditStatus = { "" };
                if (dt.Rows[0]["iLanguageNationalEnable"].ToString().Equals("0"))
                {
                    valuesEditStatus[0] = "1";
                    LanguageNational.UpdateLanguageNational(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), condition);
                }
                else
                {
                    valuesEditStatus[0] = "0";
                    LanguageNational.UpdateLanguageNational(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), condition);
                }

                #region Logs
                string logAuthor = CookieExtension.GetCookies("LoginSetting");
                string logCreateDate = DateTime.Now.ToString();
                Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", dt.Rows[0]["nLanguageNationalName"].ToString(), logAuthor, "", logCreateDate + ": " + logAuthor + " thay đổi trạng thái ngôn ngữ " + dt.Rows[0]["nLanguageNationalName"].ToString());
                #endregion

                GetListLanguageNationals();
                
                break;
            #endregion
            #region edit
            case "edit":
                Response.Redirect(LinkUpdate(p));
                break;
            #endregion
        }
    }

    protected void TextChanged(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;
        string[] fields = { "nLanguageNationalDesc" };
        string[] values = { textbox.Text };
        string condition = LanguageNationalTSql.GetByiLanguageNationalId(textbox.ToolTip);
        LanguageNational.UpdateLanguageNational(DataExtension.UpdateTransfer(fields, values), condition);
        GetListLanguageNationals();
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
}