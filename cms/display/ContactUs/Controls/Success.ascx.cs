﻿using System;
using TatThanhJsc.Extension;

public partial class cms_display_ContactUs_Controls_Success : System.Web.UI.UserControl
{
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  protected void Page_Load(object sender, EventArgs e)
  {
    ltrContent.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyThongBaoSauKhiGuiLienHe, lang);
  }
}