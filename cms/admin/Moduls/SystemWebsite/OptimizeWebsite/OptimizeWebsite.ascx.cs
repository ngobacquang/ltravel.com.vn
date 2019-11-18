using System;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;

public partial class cms_admin_System_website_OptimizeWebsite_AdmOptimizeWebsite : System.Web.UI.UserControl
{
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetContentInControl();
        }
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
     
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyTitleWebsite, txt_title_website.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyDescMetatagWebsite, TbDescWebsite.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyKeyWebsite, txt_key_website.Text, language);

        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyKeyGoogleAnalytics, TbGoogleAnalytics.Text, language);

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", "Thông tin tối ưu website", logAuthor,
            "",
            logCreateDate + ": " + logAuthor + " cập nhật thông tin hệ thống (Thông tin tối ưu website)");

        #endregion
    }

    void GetContentInControl()
    {
        txt_title_website.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyTitleWebsite, language);
        TbDescWebsite.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyDescMetatagWebsite, language); ;
        txt_key_website.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyKeyWebsite, language);
        TbGoogleAnalytics.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyKeyGoogleAnalytics, language);        
    }
}
