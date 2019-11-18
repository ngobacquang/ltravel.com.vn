using System;
using TatThanhJsc.Extension;


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

        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyMailWebsite,tbEmail.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyMailPasswordWebsite,tbPassword.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyEmailPhu, tbSubEmail.Text, language);
        GetContentInControl();
    }

    void GetContentInControl()
    {
        tbEmail.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailWebsite, language);
        tbPassword.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailPasswordWebsite, language);
        tbSubEmail.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyEmailPhu, language);
    }
}
