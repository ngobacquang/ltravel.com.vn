using System;
using TatThanhJsc.Extension;

public partial class cms_display_CommonControls_CommonFooter : System.Web.UI.UserControl
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      ltrFooterCopyright.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentFooterWebsite + "Top", lang);
      ltrTripadvisor.Text = SettingsExtension.GetSettingKey("KeyTripadvisor", lang);
      ltrOnline.Text = NumberExtension.FormatNumber(OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.UsersCount.ToString());
      ltrTotal.Text = NumberExtension.FormatNumber(SettingsExtension.GetSettingKey(SettingsExtension.KeyTotalView, lang));
    }
  }
}