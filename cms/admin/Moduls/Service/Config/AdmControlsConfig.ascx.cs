using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.ServiceModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Service_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

  string pic = FolderPic.Service;
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
    tbSoServiceTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoServiceTrenTrangChu, lang);
    tbSoServiceKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoServiceKhacTrenMotTrang, lang);
    tbSoServiceTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoServiceTrenTrangDanhMuc, lang);

    tbBaiVietTrangLichHoc.Text = SettingsExtension.GetSettingKey("BaiVietTrangLichHoc", lang);
    tbThongBaoDatDichVuThanhCong.Text = SettingsExtension.GetSettingKey("ThongBaoDatDichVuThanhCong", lang);

    #region Đóng dấu ảnh
    if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhService, lang) == "1")
      cbDongDauAnh.Checked = true;
    else
      cbDongDauAnh.Checked = false;

    #region Ảnh làm dấu
    hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhService_AnhDau, lang);
    if (hdLogoImage.Value.Length > 0)
      ltrLogoImage.Text = TatThanhJsc.Extension.ImagesExtension.GetImage(pic, hdLogoImage.Value, "", "", false, false, "");
    #endregion

    rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhService_ViTri, lang);
    tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhService_LeNgang, lang);
    tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhService_LeDoc, lang);
    tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhService_TyLe, lang);
    tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhService_TrongSuot, lang);
    #endregion

    #region Hạn chế kích thước ảnh đại diện
    if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhService, lang) == "1")
      cbHanCheKichThuoc.Checked = true;
    else
      cbHanCheKichThuoc.Checked = false;

    tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhService_MaxWidth, lang);
    tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhService_MaxHeight, lang);
    #endregion

    #region Tạo ảnh nhỏ cho ảnh đại diện
    if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhService, lang) == "1")
      cbTaoAnhNho.Checked = true;
    else
      cbTaoAnhNho.Checked = false;

    tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhService_MaxWidth, lang);
    tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhService_MaxHeight, lang);
    #endregion

    LoadConfigs("cms/admin/Moduls/Service/Index.ascx");

    #region Cấu hình tối ưu seo
    tbTitle.Text = SettingsExtension.GetSettingKey(SettingKey.TitleService, lang);
    tbDescription.Text = SettingsExtension.GetSettingKey(SettingKey.DescriptionService, lang);

    tbSeoTitle.Text = SettingsExtension.GetSettingKey(SettingKey.SeoTitleService, lang);
    tbSeoUrl.Text = SettingsExtension.GetSettingKey(SettingKey.SeoUrlService, lang);
    tbSeoKeyword.Text = SettingsExtension.GetSettingKey(SettingKey.SeoKeywordService, lang);
    tbSeoDescription.Text = SettingsExtension.GetSettingKey(SettingKey.SeoDescriptionService, lang);

    hdShareImage.Value = SettingsExtension.GetSettingKey(SettingKey.SeoImageService, lang);
    if (hdShareImage.Value.Length > 0)
    {
      ltrShareImage.Text = ImagesExtension.GetImage(pic, hdShareImage.Value, "", "", false, false, "");
      btnXoaAnhHienTai.Visible = true;
    }
    #endregion
  }

  protected void btSave_Click(object sender, EventArgs e)
  {
    SettingsExtension.SetOtherSettingKey(SettingKey.SoServiceTrenTrangChu, tbSoServiceTrenTrangChu.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SoServiceKhacTrenMotTrang, tbSoServiceKhacTrenMotTrang.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SoServiceTrenTrangDanhMuc, tbSoServiceTrenTrangDanhMuc.Text, lang);

    SettingsExtension.SetOtherSettingKey("BaiVietTrangLichHoc", tbBaiVietTrangLichHoc.Text, lang);
    SettingsExtension.SetOtherSettingKey("ThongBaoDatDichVuThanhCong", tbThongBaoDatDichVuThanhCong.Text, lang);

    #region Đóng dấu ảnh
    if (cbDongDauAnh.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService, "0", lang);

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
      SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService_AnhDau, fileName, lang);
    }
    #endregion

    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService_ViTri, rbViTriDongDau.SelectedValue, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService_LeNgang, tbLeX.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService_LeDoc, tbLeY.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService_TyLe, tbPhanTram.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhService_TrongSuot, tbTrongSuot.Text, lang);
    #endregion

    #region Hạn chế kích thước ảnh đại diện
    if (cbHanCheKichThuoc.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhService, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhService, "0", lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhService_MaxWidth, tbHanCheW.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhService_MaxHeight, tbHanCheH.Text, lang);
    #endregion

    #region Tạo ảnh nhỏ cho ảnh đại diện
    if (cbTaoAnhNho.Checked)
      SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhService, "1", lang);
    else
      SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhService, "0", lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhService_MaxWidth, tbAnhNhoW.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhService_MaxHeight, tbAnhNhoH.Text, lang);
    #endregion

    SaveConfigs();

    #region Cấu hình tối ưu seo
    SettingsExtension.SetOtherSettingKey(SettingKey.TitleService, tbTitle.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.DescriptionService, tbDescription.Text, lang);

    SettingsExtension.SetOtherSettingKey(SettingKey.SeoTitleService, tbSeoTitle.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoUrlService, tbSeoUrl.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoKeywordService, tbSeoKeyword.Text, lang);
    SettingsExtension.SetOtherSettingKey(SettingKey.SeoDescriptionService, tbSeoDescription.Text, lang);

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
      SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageService, fileName, lang);
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

    SettingsExtension.SetOtherSettingKey(SettingKey.SeoImageService, "", lang);
  }

  #region Cấu hình hiển thị trang chủ
  void SaveConfigs()
  {
    foreach (Control pnConfig in pnCauHinhTrangChu.Controls)
    {
      if (typeof(System.Web.UI.WebControls.Panel) == pnConfig.GetType())
      {
        HiddenField hd1 = new HiddenField();
        TextBox tb1 = new TextBox();
        CheckBox cb1 = new CheckBox();
        foreach (Control pnSubConfig in pnConfig.Controls)
        {
          if (typeof(System.Web.UI.WebControls.HiddenField) == pnSubConfig.GetType())
            hd1 = (HiddenField)pnSubConfig;

          if (typeof(System.Web.UI.WebControls.TextBox) == pnSubConfig.GetType())
            tb1 = (TextBox)pnSubConfig;

          if (typeof(System.Web.UI.WebControls.CheckBox) == pnSubConfig.GetType())
            cb1 = (CheckBox)pnSubConfig;
        }
        SaveConfig(hd1.Value, tb1.Text, cb1.Checked);
      }
    }
  }

  private void SaveConfig(string fullkey, string order, bool status)
  {
    string split = "->";
    string encodekey = SecurityExtension.BuildPassword(fullkey);
    string firstkey = fullkey.Substring(0, fullkey.IndexOf(split));

    fullkey = order + split + fullkey + split + (status == true ? "1" : "0");

    DataTable dt = new DataTable();
    condition = DataExtension.AndConditon(
        SettingsTSql.GetSettingsByVskey(encodekey),
        SettingsTSql.GetSettingsByVslang(lang)
        );
    dt = Settings.GetSettingsCondition("1", "*", condition, "");
    if (dt.Rows.Count < 1)
    {
      Settings.InsertSettings(encodekey, firstkey, fullkey, lang);
    }
    else
    {
      Settings.UpdateSettings(SettingsTSql.GetSettingsByVsvalue(fullkey), condition);
    }
  }

  /// <summary>
  /// Lấy ra các cấu hình theo đường đẫn của control cha
  /// </summary>
  /// <param name="vsdesc">Đường dẫn của control cha, vd: cms/admin/Moduls/Service/Index.ascx</param>
  private void LoadConfigs(string vsdesc)
  {
    string split = "->";
    DataTable dt = new DataTable();
    dt = Settings.GetSettingsCondition("", SettingsColumns.VsvalueColumn, SettingsTSql.GetSettingsByVsdesc(vsdesc), SettingsColumns.VsvalueColumn);
    string order = "";
    string fullkey = "";
    string status = "";
    string[] list = new string[4];

    foreach (Control pnConfig in pnCauHinhTrangChu.Controls)
    {
      if (typeof(System.Web.UI.WebControls.Panel) == pnConfig.GetType())
      {
        HiddenField hd1 = new HiddenField();
        TextBox tb1 = new TextBox();
        CheckBox cb1 = new CheckBox();
        foreach (Control pnSubConfig in pnConfig.Controls)
        {
          if (typeof(System.Web.UI.WebControls.HiddenField) == pnSubConfig.GetType())
            hd1 = (HiddenField)pnSubConfig;

          if (typeof(System.Web.UI.WebControls.TextBox) == pnSubConfig.GetType())
            tb1 = (TextBox)pnSubConfig;

          if (typeof(System.Web.UI.WebControls.CheckBox) == pnSubConfig.GetType())
            cb1 = (CheckBox)pnSubConfig;


          for (int i = 0; i < dt.Rows.Count; i++)
          {
            list = dt.Rows[i][SettingsColumns.VsvalueColumn].ToString().Split(new string[] { split }, StringSplitOptions.None);
            order = list[0];
            fullkey = list[1] + split + list[2];
            status = list[3];

            if (hd1.Value.Equals(fullkey, StringComparison.CurrentCultureIgnoreCase))
            {
              tb1.Text = order;
              cb1.Checked = status == "1";
            }
          }
        }
      }
    }
  }
  #endregion
}
