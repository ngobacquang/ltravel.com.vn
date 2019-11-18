using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.OtherModul;

public partial class cms_admin_Tag_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    string pic = FolderPic.Tag;
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderby = "";    


    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
            GetOtherSetting();
    }
    void GetOtherSetting()
    {

        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;

        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_AnhDau, language);
        if (hdLogoImage.Value.Length > 0)
            ltrLogoImage.Text = ImagesExtension.GetImage(pic, hdLogoImage.Value, "", "", false, false, "");
        #endregion

        rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_ViTri, language);
        tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_LeNgang, language);
        tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_LeDoc, language);
        tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_TyLe, language);
        tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTag, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTag_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTag_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTag, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTag_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTag_MaxHeight, language);
        #endregion        
        
    }
    protected void btSave_Click(object sender, EventArgs e)
    {

        #region Đóng dấu ảnh
        if (cbDongDauAnh.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag, "0", language);

        #region Ảnh làm dấu
        if (fulDongDauAnh.PostedFile.ContentLength > 0)
        {
            //Xoá ảnh cũ
            if (hdLogoImage.Value.Length > 0)
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hdLogoImage.Value);

            //Lưu ảnh mới
            string fileName = "";
            if (ImagesExtension.ValidType(fulDongDauAnh.FileName))
            {
                string fileEx = fulDongDauAnh.FileName.Substring(fulDongDauAnh.FileName.LastIndexOf("."));
                fileName = "WatermarkLogo" + fileEx;
                fulDongDauAnh.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + fileName);
                ltrLogoImage.Text = ImagesExtension.GetImage(pic, fileName, "", "", false, false, "");
            }
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag_AnhDau, fileName, language);
        }
        #endregion

        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag_ViTri, rbViTriDongDau.SelectedValue, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag_LeNgang, tbLeX.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag_LeDoc, tbLeY.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag_TyLe, tbPhanTram.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTag_TrongSuot, tbTrongSuot.Text, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (cbHanCheKichThuoc.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTag, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTag, "0", language);

        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTag_MaxWidth, tbHanCheW.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTag_MaxHeight, tbHanCheH.Text, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (cbTaoAnhNho.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTag, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTag, "0", language);

        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTag_MaxWidth, tbAnhNhoW.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTag_MaxHeight, tbAnhNhoH.Text, language);
        #endregion        

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Cập nhật thành công !');", true);
    }    
}
