using System;
using TatThanhJsc.SystemWebsiteModul;

using TatThanhJsc.Extension;

public partial class cms_admin_Controls_Header_AdmControlsHeaderLogo : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string imgname = SettingsExtension.GetSettingKey(SettingsExtension.KeyLogoAdminWebsite, TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin());
            if (imgname.Length > 0)
                lt_imgage_Logo.Text = "<img class='SizeImage' src='" + FolderPic.SystemWebsite + "/" + imgname + "' />";
        }
    }
}
