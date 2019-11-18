using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.SystemWebsiteModul;


public partial class cms_admin_System_website_OtherSettings_AdmOtherSettings : System.Web.UI.UserControl
{
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = TatThanhJsc.SystemWebsiteModul.FolderPic.SystemWebsite;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Gán đường dẫn cho ckeditor
        foreach (Control control in this.Controls)
        {
            if (control is CKEditor.NET.CKEditorControl)
                ((CKEditor.NET.CKEditorControl)control).FilebrowserImageBrowseUrl
                    =
                    UrlExtension.WebisteUrl + "ckeditor/ckfinder/ckfinder.aspx?type=Images&path=" + pic;
        }
        #endregion
        if (!IsPostBack)
            GetOtherSetting();
    }
    void GetOtherSetting()
    {
        //Lay thong tin trang popup tai trang chu
        ddlShowpopup.SelectedValue = SettingsExtension.GetSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyHienThiPopupTaiTrangChu, language);
        tbPopupDetail.Text = SettingsExtension.GetSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyChiTietTrangPopup, language);
        hdOldDetail.Value = SettingsExtension.GetSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyChiTietTrangPopup, language);

        tbPopupContent.Text = SettingsExtension.GetSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyNoiDungPopupTaiTrangChu, language);
        hdOldContent.Value = SettingsExtension.GetSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyNoiDungPopupTaiTrangChu, language);
    }
    protected void btSave_Click(object sender, EventArgs e)
    {       
        //Lay thong tin trang popup tai trang chu
        SettingsExtension.SetOtherSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyHienThiPopupTaiTrangChu, ddlShowpopup.SelectedValue, language);

        string newDetail = ContentExtendtions.ProcessStringContent(tbPopupDetail.Text, hdOldDetail.Value,FolderPic.SystemWebsite);
        SettingsExtension.SetOtherSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyChiTietTrangPopup, newDetail, language);

        string newContent = ContentExtendtions.ProcessStringContent(tbPopupContent.Text, hdOldContent.Value, FolderPic.SystemWebsite);
        SettingsExtension.SetOtherSettingKey(TatThanhJsc.Extension.SettingsExtension.KeyNoiDungPopupTaiTrangChu, newContent, language);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "alert('Cập nhật thành công!');", true);

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", SettingsExtension.KeyHienThiPopupTaiTrangChu, logAuthor,
            "",
            logCreateDate + ": " + logAuthor + " cập nhật thông tin hệ thống (" + SettingsExtension.KeyHienThiPopupTaiTrangChu + ")");

        #endregion
    }

}
