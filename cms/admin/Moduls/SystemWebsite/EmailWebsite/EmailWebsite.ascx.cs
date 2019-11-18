using System;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using System.Web.UI;

public partial class cms_admin_System_website_EmailWebsite_AdmEmailWebsite : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetContentInControl();
        }
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {

        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyMailWebsite, tbEmail.Text, language);
        string password = tbPassword.Text;
        if (password.Length < 1)
            password = hdOldPassword.Value;
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyMailPasswordWebsite, password, language);
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyEmailPhu, tbSubEmail.Text, language);
        GetContentInControl();
        if (password.Length > 0)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "ThongBao(3000,'Cập nhật thành công')", true);

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", SettingsExtension.KeyMailWebsite, logAuthor,
            "",
            logCreateDate + ": " + logAuthor + " cập nhật thông tin hệ thống (" +
            SettingsExtension.KeyMailWebsite + ")");

        #endregion
    }

    void GetContentInControl()
    {
        tbEmail.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailWebsite, language);        
        hdOldPassword.Value = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailPasswordWebsite, language);
        if (hdOldPassword.Value.Length > 0) ltrPasswordStatus.Text = "Đã nhập mật khẩu";
        else ltrPasswordStatus.Text = "Chưa nhập mật khẩu";
        tbSubEmail.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyEmailPhu, language);
    }
}
