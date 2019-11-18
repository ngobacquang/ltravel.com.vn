using System;
using System.Web.UI;
using System.Windows.Forms.VisualStyles;
using TatThanhJsc.DestinationModul;
using TatThanhJsc.Extension;

public partial class cms_admin_Destination_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    string pic = FolderPic.Destination;

    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
            GetOtherSetting();
    }
    void GetOtherSetting()
    {
        #region Cấu hình số lượng
        tbSoDestinationTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoDestinationTrenTrangChu,lang);
        tbSoDestinationKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoDestinationKhacTrenMotTrang, lang);
        tbSoDestinationTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoDestinationTrenTrangDanhMuc, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDestination, lang) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;

        #region Ảnh làm dấu
        hdWatermarkLogo.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDestination_AnhDau, lang);
        if (hdWatermarkLogo.Value.Length > 0)
            ltrWatermarkLogo.Text = ImagesExtension.GetImage(pic, hdWatermarkLogo.Value, "", "", false, false, "");
        #endregion

        rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDestination_ViTri, lang);
        tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDestination_LeNgang, lang);
        tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDestination_LeDoc, lang);
        tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDestination_TyLe, lang);
        tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDestination_TrongSuot, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDestination, lang) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDestination_MaxWidth, lang);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDestination_MaxHeight, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDestination, lang) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDestination_MaxWidth, lang);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDestination_MaxHeight, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        tbTitle.Text = SettingsExtension.GetSettingKey(SettingKey.TitleDestination, lang);
        tbDescription.Text = SettingsExtension.GetSettingKey(SettingKey.DescriptionDestination, lang);

        tbSeoTitle.Text = SettingsExtension.GetSettingKey(SettingKey.SeoTitleDestination,lang);
        tbSeoUrl.Text = SettingsExtension.GetSettingKey(SettingKey.SeoUrlDestination, lang);
        tbSeoKeyword.Text = SettingsExtension.GetSettingKey(SettingKey.SeoKeywordDestination, lang);
        tbSeoDescription.Text = SettingsExtension.GetSettingKey(SettingKey.SeoDescriptionDestination, lang);

        hdShareImage.Value = SettingsExtension.GetSettingKey(SettingKey.SeoImageDestination, lang);
        if(hdShareImage.Value.Length > 0)
        {
            ltrShareImage.Text = ImagesExtension.GetImage(pic, hdShareImage.Value, "", "", false, false, "");
            btnXoaAnhHienTai.Visible = true;
        }        
        #endregion
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        #region Cấu hình số lượng
        SettingsExtension.SetOtherSettingKey(SettingKey.SoDestinationTrenTrangChu, tbSoDestinationTrenTrangChu.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoDestinationKhacTrenMotTrang, tbSoDestinationKhacTrenMotTrang.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoDestinationTrenTrangDanhMuc, tbSoDestinationTrenTrangDanhMuc.Text, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (cbDongDauAnh.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination, "0", lang);

        #region Ảnh làm dấu
        if (fulDongDauAnh.PostedFile.ContentLength > 0)
        {
            //Xoá ảnh cũ
            if (hdWatermarkLogo.Value.Length > 0)
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hdWatermarkLogo.Value);

            //Lưu ảnh mới
            string fileName = "";
            if (ImagesExtension.ValidType(fulDongDauAnh.FileName))
            {
                string fileEx = fulDongDauAnh.FileName.Substring(fulDongDauAnh.FileName.LastIndexOf("."));
                fileName = "WatermarkLogo" + fileEx;
                fulDongDauAnh.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + fileName);
                ltrWatermarkLogo.Text = ImagesExtension.GetImage(pic, fileName, "", "", false, false, "");
            }
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination_AnhDau, fileName, lang);
        }
        #endregion

        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination_ViTri, rbViTriDongDau.SelectedValue, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination_LeNgang, tbLeX.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination_LeDoc, tbLeY.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination_TyLe, tbPhanTram.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDestination_TrongSuot, tbTrongSuot.Text, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (cbHanCheKichThuoc.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDestination, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDestination, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDestination_MaxWidth, tbHanCheW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDestination_MaxHeight, tbHanCheH.Text, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (cbTaoAnhNho.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDestination, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDestination, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDestination_MaxWidth, tbAnhNhoW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDestination_MaxHeight, tbAnhNhoH.Text, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        SettingsExtension.SetOtherSettingKey(SettingKey.TitleDestination, tbTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DescriptionDestination, tbDescription.Text, lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoTitleDestination, tbSeoTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoUrlDestination, tbSeoUrl.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoKeywordDestination, tbSeoKeyword.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoDescriptionDestination, tbSeoDescription.Text, lang);

        #region Hình ảnh khi share
        if (flShareImage.PostedFile.ContentLength > 0)
        {
            //Xoá ảnh cũ
            if (hdShareImage.Value.Length > 0)
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hdShareImage.Value);

            //Lưu ảnh mới
            string fileName = "";
            if (ImagesExtension.ValidType(flShareImage.FileName))
            {
                string filename = flShareImage.FileName;
                string fileEx = flShareImage.FileName.Substring(flShareImage.FileName.LastIndexOf("."));
                string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
                if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
                string ticks = DateTime.Now.Ticks.ToString();
                fileName = fileNotEx + "_" + ticks + fileEx;


                flShareImage.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + fileName);
                ltrShareImage.Text = ImagesExtension.GetImage(pic, fileName, "", "", false, false, "");
            }
            SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageDestination, fileName, lang);
        }
        #endregion
        #endregion

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Cập nhật thành công !');", true);
    }

    protected void btnXoaAnhHienTai_Click(object sender, EventArgs e)
    {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hdShareImage.Value);
        hdShareImage.Value = "";
        btnXoaAnhHienTai.Visible = false;
        ltrShareImage.Text = "";

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageDestination, "", lang);
    }
}
