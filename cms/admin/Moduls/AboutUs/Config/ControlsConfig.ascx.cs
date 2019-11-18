using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.AboutUsModul;

public partial class cms_admin_AboutUs_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    string pic = FolderPic.AboutUs;

    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
            GetOtherSetting();
    }
    void GetOtherSetting()
    {
        #region Cấu hình số lượng
        tbSoAboutUsTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoAboutUsTrenTrangChu,lang);
        tbSoAboutUsKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoAboutUsKhacTrenMotTrang, lang);
        tbSoAboutUsTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoAboutUsTrenTrangDanhMuc, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhAboutUs, lang) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;

        #region Ảnh làm dấu
        hdWatermarkLogo.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhAboutUs_AnhDau, lang);
        if (hdWatermarkLogo.Value.Length > 0)
            ltrWatermarkLogo.Text = ImagesExtension.GetImage(pic, hdWatermarkLogo.Value, "", "", false, false, "");
        #endregion

        rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhAboutUs_ViTri, lang);
        tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhAboutUs_LeNgang, lang);
        tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhAboutUs_LeDoc, lang);
        tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhAboutUs_TyLe, lang);
        tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhAboutUs_TrongSuot, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhAboutUs, lang) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhAboutUs_MaxWidth, lang);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhAboutUs_MaxHeight, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhAboutUs, lang) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhAboutUs_MaxWidth, lang);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhAboutUs_MaxHeight, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        tbTitle.Text = SettingsExtension.GetSettingKey(SettingKey.TitleAboutUs, lang);
        tbDescription.Text = SettingsExtension.GetSettingKey(SettingKey.DescriptionAboutUs, lang);

        tbSeoTitle.Text = SettingsExtension.GetSettingKey(SettingKey.SeoTitleAboutUs,lang);
        tbSeoUrl.Text = SettingsExtension.GetSettingKey(SettingKey.SeoUrlAboutUs, lang);
        tbSeoKeyword.Text = SettingsExtension.GetSettingKey(SettingKey.SeoKeywordAboutUs, lang);
        tbSeoDescription.Text = SettingsExtension.GetSettingKey(SettingKey.SeoDescriptionAboutUs, lang);

        hdShareImage.Value = SettingsExtension.GetSettingKey(SettingKey.SeoImageAboutUs, lang);
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
        SettingsExtension.SetOtherSettingKey(SettingKey.SoAboutUsTrenTrangChu, tbSoAboutUsTrenTrangChu.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoAboutUsKhacTrenMotTrang, tbSoAboutUsKhacTrenMotTrang.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoAboutUsTrenTrangDanhMuc, tbSoAboutUsTrenTrangDanhMuc.Text, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (cbDongDauAnh.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs, "0", lang);

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
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs_AnhDau, fileName, lang);
        }
        #endregion

        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs_ViTri, rbViTriDongDau.SelectedValue, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs_LeNgang, tbLeX.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs_LeDoc, tbLeY.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs_TyLe, tbPhanTram.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhAboutUs_TrongSuot, tbTrongSuot.Text, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (cbHanCheKichThuoc.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhAboutUs, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhAboutUs, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhAboutUs_MaxWidth, tbHanCheW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhAboutUs_MaxHeight, tbHanCheH.Text, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (cbTaoAnhNho.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhAboutUs, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhAboutUs, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhAboutUs_MaxWidth, tbAnhNhoW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhAboutUs_MaxHeight, tbAnhNhoH.Text, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        SettingsExtension.SetOtherSettingKey(SettingKey.TitleAboutUs, tbTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DescriptionAboutUs, tbDescription.Text, lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoTitleAboutUs, tbSeoTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoUrlAboutUs, tbSeoUrl.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoKeywordAboutUs, tbSeoKeyword.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoDescriptionAboutUs, tbSeoDescription.Text, lang);

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
            SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageAboutUs, fileName, lang);
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

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageAboutUs, "", lang);
    }
}
