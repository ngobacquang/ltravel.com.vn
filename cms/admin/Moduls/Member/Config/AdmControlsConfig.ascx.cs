using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.MemberModul;

public partial class cms_admin_Member_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    string pic = FolderPic.Member;
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
        tbSoMemberTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoMemberTrenTrangChu,language);
        tbSoMemberKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoMemberKhacTrenMotTrang, language);
        tbSoMemberTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoMemberTrenTrangDanhMuc, language);      

        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;

        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_AnhDau, language);
        if (hdLogoImage.Value.Length > 0)
            ltrLogoImage.Text = TatThanhJsc.Extension.ImagesExtension.GetImage(pic, hdLogoImage.Value, "", "", false, false, "");
        #endregion

        rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_ViTri, language);
        tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_LeNgang, language);
        tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_LeDoc, language);
        tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_TyLe, language);
        tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhMember, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhMember_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhMember_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhMember, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhMember_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhMember_MaxHeight, language);
        #endregion
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        SettingsExtension.SetOtherSettingKey(SettingKey.SoMemberTrenTrangChu, tbSoMemberTrenTrangChu.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoMemberKhacTrenMotTrang, tbSoMemberKhacTrenMotTrang.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoMemberTrenTrangDanhMuc, tbSoMemberTrenTrangDanhMuc.Text, language);       

        #region Đóng dấu ảnh
        if (cbDongDauAnh.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember, "0", language);

        #region Ảnh làm dấu
        if (fulDongDauAnh.PostedFile.ContentLength > 0)
        {
            //Xoá ảnh cũ
            if (hdLogoImage.Value.Length > 0)
                TatThanhJsc.Extension.ImagesExtension.DeleteImageWhenDeleteItem(pic, hdLogoImage.Value);

            //Lưu ảnh mới
            string fileName = "";
            if (TatThanhJsc.Extension.ImagesExtension.ValidType(fulDongDauAnh.FileName))
            {
                string fileEx = fulDongDauAnh.FileName.Substring(fulDongDauAnh.FileName.LastIndexOf("."));
                fileName = "WatermarkLogo" + fileEx;
                fulDongDauAnh.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + fileName);
                ltrLogoImage.Text = TatThanhJsc.Extension.ImagesExtension.GetImage(pic, fileName, "", "", false, false, "");
            }
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember_AnhDau, fileName, language);
        }
        #endregion

        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember_ViTri, rbViTriDongDau.SelectedValue, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember_LeNgang, tbLeX.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember_LeDoc, tbLeY.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember_TyLe, tbPhanTram.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhMember_TrongSuot, tbTrongSuot.Text, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (cbHanCheKichThuoc.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhMember, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhMember, "0", language);

        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhMember_MaxWidth, tbHanCheW.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhMember_MaxHeight, tbHanCheH.Text, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (cbTaoAnhNho.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhMember, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhMember, "0", language);

        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhMember_MaxWidth, tbAnhNhoW.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhMember_MaxHeight, tbAnhNhoH.Text, language);
        #endregion

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Cập nhật thành công !');", true);
    }    
}
