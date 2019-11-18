using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;

public partial class cms_admin_Tour_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  string pic = FolderPic.Tour;

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
    tbThongTinThanhToan.Text = SettingsExtension.GetSettingKey(SettingKey.NoiDungCuoiDonHang, lang);
    tbDieuKhoanThanhToan.Text = SettingsExtension.GetSettingKey(SettingKey.NoiDungDauDonHang, lang);

    ChoPhepTTATM.SelectedValue = SettingsExtension.GetSettingKey("ChoPhepTTATM", lang);
    ChoPhepTTCK.SelectedValue = SettingsExtension.GetSettingKey("ChoPhepTTCK", lang);

    tbThongBaoDatTourThanhCong.Text = SettingsExtension.GetSettingKey("ThongBaoDatTourThanhCong", lang);
    tbNoiDungCuoiDanhSach.Text = SettingsExtension.GetSettingKey("NoiDungCuoiTrangDanhSachTour", lang);

    #region Cấu hình số lượng
    tbSoTourTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoTourTrenTrangChu, lang);
    tbSoTourKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoTourKhacTrenMotTrang, lang);
    tbSoTourTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoTourTrenTrangDanhMuc, lang);
    #endregion

    #region Cấu hình đóng dấu ảnh
    #region Đóng dấu ảnh
    if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTour, lang) == "1")
      cbDongDauAnh.Checked = true;
    else
      cbDongDauAnh.Checked = false;

    #region Ảnh làm dấu
    hdWatermarkLogo.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTour_AnhDau, lang);
    if (hdWatermarkLogo.Value.Length > 0)
      ltrWatermarkLogo.Text = ImagesExtension.GetImage(pic, hdWatermarkLogo.Value, "", "", false, false, "");
    #endregion

    rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTour_ViTri, lang);
    tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTour_LeNgang, lang);
    tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTour_LeDoc, lang);
    tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTour_TyLe, lang);
    tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTour_TrongSuot, lang);
    #endregion

    #region Hạn chế kích thước ảnh đại diện
    if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTour, lang) == "1")
      cbHanCheKichThuoc.Checked = true;
    else
      cbHanCheKichThuoc.Checked = false;

    tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTour_MaxWidth, lang);
    tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTour_MaxHeight, lang);
    #endregion

    #region Tạo ảnh nhỏ cho ảnh đại diện
    if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTour, lang) == "1")
      cbTaoAnhNho.Checked = true;
    else
      cbTaoAnhNho.Checked = false;

    tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTour_MaxWidth, lang);
    tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTour_MaxHeight, lang);
    #endregion
    #endregion

    #region Cấu hình tối ưu seo
    tbTitle.Text = SettingsExtension.GetSettingKey(SettingKey.TitleTour, lang);
    tbDescription.Text = SettingsExtension.GetSettingKey(SettingKey.DescriptionTour, lang);

    tbSeoTitle.Text = SettingsExtension.GetSettingKey(SettingKey.SeoTitleTour, lang);
    tbSeoUrl.Text = SettingsExtension.GetSettingKey(SettingKey.SeoUrlTour, lang);
    tbSeoKeyword.Text = SettingsExtension.GetSettingKey(SettingKey.SeoKeywordTour, lang);
    tbSeoDescription.Text = SettingsExtension.GetSettingKey(SettingKey.SeoDescriptionTour, lang);

    hdShareImage.Value = SettingsExtension.GetSettingKey(SettingKey.SeoImageTour, lang);
    if (hdShareImage.Value.Length > 0)
    {
      ltrShareImage.Text = ImagesExtension.GetImage(pic, hdShareImage.Value, "", "", false, false, "");
      btnXoaAnhHienTai.Visible = true;
    }
    #endregion
  }

  protected void btSave_Click(object sender, EventArgs e)
  {
    SettingsExtension.SetOtherSettingKey(SettingKey.NoiDungCuoiDonHang, tbThongTinThanhToan.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.NoiDungDauDonHang, tbDieuKhoanThanhToan.Text, lang);

    SettingsExtension.SetOtherSettingKey("ChoPhepTTATM", ChoPhepTTATM.SelectedValue, lang);
    SettingsExtension.SetOtherSettingKey("ChoPhepTTCK", ChoPhepTTCK.SelectedValue, lang);

    SettingsExtension.SetOtherSettingKey("ThongBaoDatTourThanhCong", tbThongBaoDatTourThanhCong.Text, lang);
    SettingsExtension.SetOtherSettingKey("NoiDungCuoiTrangDanhSachTour", tbNoiDungCuoiDanhSach.Text, lang);

    #region Cấu hình số lượng
    SettingsExtension.SetOtherSettingKey(SettingKey.SoTourTrenTrangChu, tbSoTourTrenTrangChu.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SoTourKhacTrenMotTrang, tbSoTourKhacTrenMotTrang.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SoTourTrenTrangDanhMuc, tbSoTourTrenTrangDanhMuc.Text, lang);
    #endregion

    #region Cấu hình đóng dấu ảnh
    #region Đóng dấu ảnh
    if (cbDongDauAnh.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour, "0", lang);

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
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour_AnhDau, fileName, lang);
    }
    #endregion

    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour_ViTri, rbViTriDongDau.SelectedValue, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour_LeNgang, tbLeX.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour_LeDoc, tbLeY.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour_TyLe, tbPhanTram.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhTour_TrongSuot, tbTrongSuot.Text, lang);
    #endregion

    #region Hạn chế kích thước ảnh đại diện
    if (cbHanCheKichThuoc.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTour, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTour, "0", lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTour_MaxWidth, tbHanCheW.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhTour_MaxHeight, tbHanCheH.Text, lang);
    #endregion

    #region Tạo ảnh nhỏ cho ảnh đại diện
    if (cbTaoAnhNho.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTour, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTour, "0", lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTour_MaxWidth, tbAnhNhoW.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhTour_MaxHeight, tbAnhNhoH.Text, lang);
    #endregion
    #endregion

    #region Cấu hình tối ưu seo
    SettingsExtension.SetOtherSettingKey(SettingKey.TitleTour, tbTitle.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DescriptionTour, tbDescription.Text, lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.SeoTitleTour, tbSeoTitle.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoUrlTour, tbSeoUrl.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoKeywordTour, tbSeoKeyword.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoDescriptionTour, tbSeoDescription.Text, lang);

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
      SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageTour, fileName, lang);
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

    SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageTour, "", lang);
  }
}
