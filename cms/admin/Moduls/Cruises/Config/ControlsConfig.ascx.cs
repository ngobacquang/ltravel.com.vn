using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.CruisesModul;

public partial class cms_admin_Cruises_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    string pic = FolderPic.Cruises;

    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
            GetOtherSetting();
    }
    void GetOtherSetting()
    {
        #region Cấu hình số lượng
        tbSoCruisesTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoCruisesTrenTrangChu,lang);
        tbSoCruisesKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoCruisesKhacTrenMotTrang, lang);
        tbSoCruisesTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoCruisesTrenTrangDanhMuc, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCruises, lang) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;

        #region Ảnh làm dấu
        hdWatermarkLogo.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCruises_AnhDau, lang);
        if (hdWatermarkLogo.Value.Length > 0)
            ltrWatermarkLogo.Text = ImagesExtension.GetImage(pic, hdWatermarkLogo.Value, "", "", false, false, "");
        #endregion

        rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCruises_ViTri, lang);
        tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCruises_LeNgang, lang);
        tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCruises_LeDoc, lang);
        tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCruises_TyLe, lang);
        tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCruises_TrongSuot, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhCruises, lang) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhCruises_MaxWidth, lang);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhCruises_MaxHeight, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhCruises, lang) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhCruises_MaxWidth, lang);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhCruises_MaxHeight, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        tbTitle.Text = SettingsExtension.GetSettingKey(SettingKey.TitleCruises, lang);
        tbDescription.Text = SettingsExtension.GetSettingKey(SettingKey.DescriptionCruises, lang);

        tbSeoTitle.Text = SettingsExtension.GetSettingKey(SettingKey.SeoTitleCruises,lang);
        tbSeoUrl.Text = SettingsExtension.GetSettingKey(SettingKey.SeoUrlCruises, lang);
        tbSeoKeyword.Text = SettingsExtension.GetSettingKey(SettingKey.SeoKeywordCruises, lang);
        tbSeoDescription.Text = SettingsExtension.GetSettingKey(SettingKey.SeoDescriptionCruises, lang);

        hdShareImage.Value = SettingsExtension.GetSettingKey(SettingKey.SeoImageCruises, lang);
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
        SettingsExtension.SetOtherSettingKey(SettingKey.SoCruisesTrenTrangChu, tbSoCruisesTrenTrangChu.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoCruisesKhacTrenMotTrang, tbSoCruisesKhacTrenMotTrang.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoCruisesTrenTrangDanhMuc, tbSoCruisesTrenTrangDanhMuc.Text, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (cbDongDauAnh.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises, "0", lang);

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
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises_AnhDau, fileName, lang);
        }
        #endregion

        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises_ViTri, rbViTriDongDau.SelectedValue, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises_LeNgang, tbLeX.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises_LeDoc, tbLeY.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises_TyLe, tbPhanTram.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCruises_TrongSuot, tbTrongSuot.Text, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (cbHanCheKichThuoc.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCruises, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCruises, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCruises_MaxWidth, tbHanCheW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCruises_MaxHeight, tbHanCheH.Text, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (cbTaoAnhNho.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCruises, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCruises, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCruises_MaxWidth, tbAnhNhoW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCruises_MaxHeight, tbAnhNhoH.Text, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        SettingsExtension.SetOtherSettingKey(SettingKey.TitleCruises, tbTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DescriptionCruises, tbDescription.Text, lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoTitleCruises, tbSeoTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoUrlCruises, tbSeoUrl.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoKeywordCruises, tbSeoKeyword.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoDescriptionCruises, tbSeoDescription.Text, lang);

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
            SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageCruises, fileName, lang);
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

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageCruises, "", lang);
    }
}
