using System;
using TatThanhJsc.Extension;

public partial class cms_display_CommonControls_CommonHeader : System.Web.UI.UserControl
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
      ltrHotline.Text = GetHotline();
  }

  private string GetHotline()
  {
    string s = "";
    string hotline = SettingsExtension.GetSettingKey(SettingsExtension.KeyHotLine, lang);
    string link = "tel:" + hotline;
    s = @"
    <div class='item'>
      <div class='item-img'>
        <a href='" + link + @"' class='iconPhone'>
          <img src='/Themes/Theme01/Assets/Css/Images/_Icon/icon-phone.png' />
        </a>
      </div>
      <div class='item-body'>                    
        <a href='" + link + @"' class='subitem-title nb-color-m3'><i>" + LanguageItemExtension.GetnLanguageItemTitleByName("Hotline") + @"</i></a>
        <a href='" + link + @"' class='title item-title nb-color-m2'>" + hotline + @"</a>
      </div>
    </div>";

    return s;
  }
}