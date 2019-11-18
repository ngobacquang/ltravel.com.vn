using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using TatThanhJsc;

using TatThanhJsc.Extension;
using TatThanhJsc.SystemWebsiteModul;

public partial class cms_admin_System_website_AdmIndex : System.Web.UI.UserControl
{
  string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      LtLogo.Text = "<div class='pb10'><img src='" + FolderPic.SystemWebsite + "/" + SettingsExtension.GetSettingKey(SettingsExtension.KeyLogoAdminWebsite, language) + "' width='300px' /></div>";
      LtFavicon.Text = "<div class='pb10'><img src='" + FolderPic.SystemWebsite + "/" + SettingsExtension.GetSettingKey(SettingsExtension.KeyFavicon, language) + "' width='100px' /></div>";
      LtPhone.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyPhoneContact, language);
      LtHotLine.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyHotLine, language);
      LtContentFooter.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentFooterWebsite + "Top", language);
      LtEmail.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailWebsite, language);

      LtTitleWeb.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyTitleWebsite, language);
      LtDescWeb.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyDescMetatagWebsite, language);
      LtKeyWordWeb.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyKeyWebsite, language);
    }
  }
}
