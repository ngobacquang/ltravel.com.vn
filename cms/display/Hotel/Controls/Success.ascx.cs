﻿using System;
using TatThanhJsc.Extension;

public partial class cms_display_Hotel_Controls_Success : System.Web.UI.UserControl
{
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  protected void Page_Load(object sender, EventArgs e)
  {
    ltrContent.Text = SettingsExtension.GetSettingKey("KeyThongBaoDatPhongThanhCong", lang);
  }
}