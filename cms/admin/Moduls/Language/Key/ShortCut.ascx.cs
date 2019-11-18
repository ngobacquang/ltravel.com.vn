using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.LanguageModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Language_Key_ShortCut : System.Web.UI.UserControl
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";

    private string pic = FolderPic.Language;
    private string suc = "";
    private bool HdInsertUpdate;
    private string iLanguageKeyId = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }
        if (Request.QueryString["iLanguageKeyId"] != null)
        {
            iLanguageKeyId = Request.QueryString["iLanguageKeyId"];
        }
        if (suc.Equals("CreateLanguageKey"))
        {
            HdInsertUpdate = true;
        }
        if (!IsPostBack)
        {
            LtInsertUpdate.Text = "Thêm mới ngôn ngữ";
            InitialControlsValue();
        }
    }

    void InitialControlsValue()
    {
        if (HdInsertUpdate == false)
        {
            LtInsertUpdate.Text = "Cập nhật thông tin mã từ khóa";
            top = "1";
            fields = "*";
            condition = LanguageKeyTSql.GetByiLanguageKeyId(iLanguageKeyId);
            order = "";
            DataTable dt = new DataTable();
            dt = LanguageKey.GetLanguageKey(top, fields, condition, order);
            TbCode.Text = dt.Rows[0]["nLanguageKeyTitle"].ToString();
            tbDesc.Text = dt.Rows[0]["nLanguageKeyDesc"].ToString();
            pnThemMaTuKhoa.Visible = false;
        }
        else
        {
            LtInsertUpdate.Text = "Thêm mới mã từ khóa website";
            pnThemMaTuKhoa.Visible = true;
        }
    }

    protected void BtnOk_Click(object sender, EventArgs e)
    {
        if (HdInsertUpdate == true)
        {
            //Kiểm tra xem mã từ khoá này có bị trùng không
            DataTable dt = new DataTable();
            dt = LanguageKey.GetLanguageKey("", LanguageKeyColumns.iLanguageKeyId, LanguageKeyTSql.GetBynLanguageKeyTitle(TbCode.Text), "");
            if (dt.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
                    "ThongBao(3000, 'Lỗi trùng từ khoá: " + TbCode.Text + "');", true);
                return;
            }
            else
            {
                LanguageKey.InsertLanguageKeyProc(TbCode.Text, tbDesc.Text);
                #region Logs
                string logAuthor = CookieExtension.GetCookies("LoginSetting");
                string logCreateDate = DateTime.Now.ToString();
                Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", TbCode.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới từ khóa " + TbCode.Text);
                #endregion
            }
        }
        else
        {
            //Kiểm tra xem mã từ khoá này có bị trùng không
            DataTable dt = new DataTable();
            dt = LanguageKey.GetLanguageKey("", LanguageKeyColumns.iLanguageKeyId, DataExtension.AndConditon(LanguageKeyTSql.GetBynLanguageKeyTitle(TbCode.Text), LanguageKeyColumns.iLanguageKeyId + "<>" + iLanguageKeyId), "");
            if (dt.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
                    "ThongBao(3000, 'Lỗi trùng từ khoá: " + TbCode.Text + "');", true);
                return;
            }
            else
            {
                LanguageKey.UpdateLanguageKey(iLanguageKeyId, TbCode.Text, tbDesc.Text);
                #region Logs
                string logAuthor = CookieExtension.GetCookies("LoginSetting");
                string logCreateDate = DateTime.Now.ToString();
                Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", TbCode.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật từ khóa " + TbCode.Text);
                #endregion
            }
        }
        if (pnThemMaTuKhoa.Visible)
        {
            if (ckTiepTuc.Checked)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000, 'Đã tạo: " + TbCode.Text + "');", true);
                TbCode.Text = "";
                tbDesc.Text = "";
            }
            else
                Response.Redirect(LinkAdmin.GoAdminSubModul(CodeApplications.Language, "code"));
        }
        else
            Response.Redirect(LinkAdmin.GoAdminSubModul(CodeApplications.Language, "code"));
    }
}