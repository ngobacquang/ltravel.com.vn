using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.CustomerReviewsModul;

public partial class cms_admin_CustomerReviews_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    string pic = FolderPic.CustomerReviews;

    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
            GetOtherSetting();
    }
    void GetOtherSetting()
    {
        #region Cấu hình số lượng
        tbSoCustomerReviewsTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoCustomerReviewsTrenTrangChu,lang);
        tbSoCustomerReviewsKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoCustomerReviewsKhacTrenMotTrang, lang);
        tbSoCustomerReviewsTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoCustomerReviewsTrenTrangDanhMuc, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCustomerReviews, lang) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;

        #region Ảnh làm dấu
        hdWatermarkLogo.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCustomerReviews_AnhDau, lang);
        if (hdWatermarkLogo.Value.Length > 0)
            ltrWatermarkLogo.Text = ImagesExtension.GetImage(pic, hdWatermarkLogo.Value, "", "", false, false, "");
        #endregion

        rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCustomerReviews_ViTri, lang);
        tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCustomerReviews_LeNgang, lang);
        tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCustomerReviews_LeDoc, lang);
        tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCustomerReviews_TyLe, lang);
        tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhCustomerReviews_TrongSuot, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhCustomerReviews, lang) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhCustomerReviews_MaxWidth, lang);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhCustomerReviews_MaxHeight, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhCustomerReviews, lang) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhCustomerReviews_MaxWidth, lang);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhCustomerReviews_MaxHeight, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        tbTitle.Text = SettingsExtension.GetSettingKey(SettingKey.TitleCustomerReviews, lang);
        tbDescription.Text = SettingsExtension.GetSettingKey(SettingKey.DescriptionCustomerReviews, lang);

        tbSeoTitle.Text = SettingsExtension.GetSettingKey(SettingKey.SeoTitleCustomerReviews,lang);
        tbSeoUrl.Text = SettingsExtension.GetSettingKey(SettingKey.SeoUrlCustomerReviews, lang);
        tbSeoKeyword.Text = SettingsExtension.GetSettingKey(SettingKey.SeoKeywordCustomerReviews, lang);
        tbSeoDescription.Text = SettingsExtension.GetSettingKey(SettingKey.SeoDescriptionCustomerReviews, lang);

        hdShareImage.Value = SettingsExtension.GetSettingKey(SettingKey.SeoImageCustomerReviews, lang);
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
        SettingsExtension.SetOtherSettingKey(SettingKey.SoCustomerReviewsTrenTrangChu, tbSoCustomerReviewsTrenTrangChu.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoCustomerReviewsKhacTrenMotTrang, tbSoCustomerReviewsKhacTrenMotTrang.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoCustomerReviewsTrenTrangDanhMuc, tbSoCustomerReviewsTrenTrangDanhMuc.Text, lang);
        #endregion

        #region Cấu hình đóng dấu ảnh
        #region Đóng dấu ảnh
        if (cbDongDauAnh.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews, "0", lang);

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
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews_AnhDau, fileName, lang);
        }
        #endregion

        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews_ViTri, rbViTriDongDau.SelectedValue, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews_LeNgang, tbLeX.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews_LeDoc, tbLeY.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews_TyLe, tbPhanTram.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhCustomerReviews_TrongSuot, tbTrongSuot.Text, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (cbHanCheKichThuoc.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCustomerReviews, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCustomerReviews, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCustomerReviews_MaxWidth, tbHanCheW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhCustomerReviews_MaxHeight, tbHanCheH.Text, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (cbTaoAnhNho.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCustomerReviews, "1", lang);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCustomerReviews, "0", lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCustomerReviews_MaxWidth, tbAnhNhoW.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhCustomerReviews_MaxHeight, tbAnhNhoH.Text, lang);
        #endregion
        #endregion

        #region Cấu hình tối ưu seo
        SettingsExtension.SetOtherSettingKey(SettingKey.TitleCustomerReviews, tbTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.DescriptionCustomerReviews, tbDescription.Text, lang);

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoTitleCustomerReviews, tbSeoTitle.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoUrlCustomerReviews, tbSeoUrl.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoKeywordCustomerReviews, tbSeoKeyword.Text, lang);
        SettingsExtension.SetOtherSettingKey(SettingKey.SeoDescriptionCustomerReviews, tbSeoDescription.Text, lang);

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
            SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageCustomerReviews, fileName, lang);
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

        SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageCustomerReviews, "", lang);
    }
}
