using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;


public partial class cms_admin_Moduls_System_website_Config_AdmSystemConfig : System.Web.UI.UserControl
{
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        loadContent();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyBatTatTuDongLayAnh, ddlShowpopup.SelectedValue, lang);

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", SettingsExtension.KeyBatTatTuDongLayAnh, logAuthor,
            "",
            logCreateDate + ": " + logAuthor + " cập nhật thông tin hệ thống (" +
            SettingsExtension.KeyBatTatTuDongLayAnh + ")");

        #endregion
    }

    void loadContent()
    {
        ddlShowpopup.SelectedValue = SettingsExtension.GetSettingKey(SettingsExtension.KeyBatTatTuDongLayAnh, lang);
    }
}