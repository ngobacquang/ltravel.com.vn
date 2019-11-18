using System;
using System.Web.UI;
using TatThanhJsc.ContactModul;
using TatThanhJsc.Extension;

public partial class cms_admin_Moduls_ContactUs_AboutUs_ControlItem : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = TatThanhJsc.ContactModul.FolderPic.Contact;

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
        {
            tbNoiDungTrangLienHe.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentContactWebsite, language);
            hdNoiDungTrangLienHe.Value = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentContactWebsite, language);

            tbThongBaoSauKhiGuiLienHe.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyThongBaoSauKhiGuiLienHe, language);
            hdThongBaoSauKhiGuiLienHe.Value = SettingsExtension.GetSettingKey(SettingsExtension.KeyThongBaoSauKhiGuiLienHe, language);


            tbThongBaoSauKhiGuiDKDichVu.Text = SettingsExtension.GetSettingKey("ThongBaoSauKhiGuiDKDichVu", language);
        }
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyContentContactWebsite,
            ContentExtendtions.ProcessStringContent(tbNoiDungTrangLienHe.Text, hdNoiDungTrangLienHe.Value,
                FolderPic.Contact), language);


        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyThongBaoSauKhiGuiLienHe,
            ContentExtendtions.ProcessStringContent(tbThongBaoSauKhiGuiLienHe.Text, hdThongBaoSauKhiGuiLienHe.Value,
                FolderPic.Contact), language);

        SettingsExtension.SetOtherSettingKey("ThongBaoSauKhiGuiDKDichVu",tbThongBaoSauKhiGuiDKDichVu.Text, language);
    }
}