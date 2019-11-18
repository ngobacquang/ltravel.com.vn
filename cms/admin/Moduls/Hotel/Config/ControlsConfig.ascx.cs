using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;

public partial class cms_admin_Hotel_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  string pic = FolderPic.Hotel;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
      GetOtherSetting();
  }
  void GetOtherSetting()
  {
    #region Cấu hình số lượng
    tbSoHotelTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoHotelTrenTrangChu, lang);
    tbSoHotelKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoHotelKhacTrenMotTrang, lang);
    tbSoHotelTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoHotelTrenTrangDanhMuc, lang);
    #endregion

    tbThongBaoDatPhongThanhCong.Text = SettingsExtension.GetSettingKey("KeyThongBaoDatPhongThanhCong", lang);
    tbNoiDungCuoiTrangDanhSach.Text = SettingsExtension.GetSettingKey("KeyNoiDungCuoiTrangDanhSachHotel", lang);


    #region Cấu hình đóng dấu ảnh
    #region Đóng dấu ảnh
    if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhHotel, lang) == "1")
      cbDongDauAnh.Checked = true;
    else
      cbDongDauAnh.Checked = false;

    #region Ảnh làm dấu
    hdWatermarkLogo.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhHotel_AnhDau, lang);
    if (hdWatermarkLogo.Value.Length > 0)
      ltrWatermarkLogo.Text = ImagesExtension.GetImage(pic, hdWatermarkLogo.Value, "", "", false, false, "");
    #endregion

    rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhHotel_ViTri, lang);
    tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhHotel_LeNgang, lang);
    tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhHotel_LeDoc, lang);
    tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhHotel_TyLe, lang);
    tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhHotel_TrongSuot, lang);
    #endregion

    #region Hạn chế kích thước ảnh đại diện
    if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhHotel, lang) == "1")
      cbHanCheKichThuoc.Checked = true;
    else
      cbHanCheKichThuoc.Checked = false;

    tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhHotel_MaxWidth, lang);
    tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhHotel_MaxHeight, lang);
    #endregion

    #region Tạo ảnh nhỏ cho ảnh đại diện
    if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhHotel, lang) == "1")
      cbTaoAnhNho.Checked = true;
    else
      cbTaoAnhNho.Checked = false;

    tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhHotel_MaxWidth, lang);
    tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhHotel_MaxHeight, lang);
    #endregion
    #endregion

    #region Cấu hình tối ưu seo
    tbTitle.Text = SettingsExtension.GetSettingKey(SettingKey.TitleHotel, lang);
    tbDescription.Text = SettingsExtension.GetSettingKey(SettingKey.DescriptionHotel, lang);

    tbSeoTitle.Text = SettingsExtension.GetSettingKey(SettingKey.SeoTitleHotel, lang);
    tbSeoUrl.Text = SettingsExtension.GetSettingKey(SettingKey.SeoUrlHotel, lang);
    tbSeoKeyword.Text = SettingsExtension.GetSettingKey(SettingKey.SeoKeywordHotel, lang);
    tbSeoDescription.Text = SettingsExtension.GetSettingKey(SettingKey.SeoDescriptionHotel, lang);

    hdShareImage.Value = SettingsExtension.GetSettingKey(SettingKey.SeoImageHotel, lang);
    if (hdShareImage.Value.Length > 0)
    {
      ltrShareImage.Text = ImagesExtension.GetImage(pic, hdShareImage.Value, "", "", false, false, "");
      btnXoaAnhHienTai.Visible = true;
    }
    #endregion
  }

  protected void btSave_Click(object sender, EventArgs e)
  {
    #region Cấu hình số lượng
    SettingsExtension.SetOtherSettingKey(SettingKey.SoHotelTrenTrangChu, tbSoHotelTrenTrangChu.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SoHotelKhacTrenMotTrang, tbSoHotelKhacTrenMotTrang.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SoHotelTrenTrangDanhMuc, tbSoHotelTrenTrangDanhMuc.Text, lang);
    #endregion

    SettingsExtension.SetOtherSettingKey("KeyThongBaoDatPhongThanhCong", tbThongBaoDatPhongThanhCong.Text, lang);
    SettingsExtension.SetOtherSettingKey("KeyNoiDungCuoiTrangDanhSachHotel", tbNoiDungCuoiTrangDanhSach.Text, lang);


    #region Cấu hình đóng dấu ảnh
    #region Đóng dấu ảnh
    if (cbDongDauAnh.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel, "0", lang);

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
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel_AnhDau, fileName, lang);
    }
    #endregion

    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel_ViTri, rbViTriDongDau.SelectedValue, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel_LeNgang, tbLeX.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel_LeDoc, tbLeY.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel_TyLe, tbPhanTram.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhHotel_TrongSuot, tbTrongSuot.Text, lang);
    #endregion

    #region Hạn chế kích thước ảnh đại diện
    if (cbHanCheKichThuoc.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhHotel, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhHotel, "0", lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhHotel_MaxWidth, tbHanCheW.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhHotel_MaxHeight, tbHanCheH.Text, lang);
    #endregion

    #region Tạo ảnh nhỏ cho ảnh đại diện
    if (cbTaoAnhNho.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhHotel, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhHotel, "0", lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhHotel_MaxWidth, tbAnhNhoW.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhHotel_MaxHeight, tbAnhNhoH.Text, lang);
    #endregion
    #endregion

    #region Cấu hình tối ưu seo
    SettingsExtension.SetOtherSettingKey(SettingKey.TitleHotel, tbTitle.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DescriptionHotel, tbDescription.Text, lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.SeoTitleHotel, tbSeoTitle.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoUrlHotel, tbSeoUrl.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoKeywordHotel, tbSeoKeyword.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoDescriptionHotel, tbSeoDescription.Text, lang);

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
      SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageHotel, fileName, lang);
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

    SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageHotel, "", lang);
  }
}
