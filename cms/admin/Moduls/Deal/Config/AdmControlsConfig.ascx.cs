using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.DealModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Deal_Controls_AdmControlsConfiguration : System.Web.UI.UserControl
{
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    string pic = FolderPic.Deal;
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderby = "";


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
        tbSoDealTrenTrangChu.Text = SettingsExtension.GetSettingKey(SettingKey.SoDealTrenTrangChu, language);
        tbSoDealKhacTrenMotTrang.Text = SettingsExtension.GetSettingKey(SettingKey.SoDealKhacTrenMotTrang, language);
        tbSoDealTrenTrangDanhMuc.Text = SettingsExtension.GetSettingKey(SettingKey.SoDealTrenTrangDanhMuc, language);

        tbDauDonHangDeal.Text = SettingsExtension.GetSettingKey(SettingKey.NoiDungDauDonHangDeal, language);
        tbCuoiDonHangDeal.Text = SettingsExtension.GetSettingKey(SettingKey.NoiDungCuoiDonHangDeal, language);
        txtThongBaoCart.Text = SettingsExtension.GetSettingKey(SettingKey.KeyThongBaoSauDatHangDeal, language);

        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;

        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_AnhDau, language);
        if (hdLogoImage.Value.Length > 0)
            ltrLogoImage.Text = ImagesExtension.GetImage(pic, hdLogoImage.Value, "", "", false, false, "");
        #endregion

        rbViTriDongDau.SelectedValue = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_ViTri, language);
        tbLeX.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_LeNgang, language);
        tbLeY.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_LeDoc, language);
        tbPhanTram.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_TyLe, language);
        tbTrongSuot.Text = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDeal, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDeal_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDeal_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDeal, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDeal_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDeal_MaxHeight, language);
        #endregion

        LoadConfigs("cms/admin/Moduls/Deal/Index.ascx");
        
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        SettingsExtension.SetOtherSettingKey(SettingKey.SoDealTrenTrangChu, tbSoDealTrenTrangChu.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoDealKhacTrenMotTrang, tbSoDealKhacTrenMotTrang.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.SoDealTrenTrangDanhMuc, tbSoDealTrenTrangDanhMuc.Text, language);

        SettingsExtension.SetOtherSettingKey(SettingKey.NoiDungDauDonHangDeal, tbDauDonHangDeal.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.NoiDungCuoiDonHangDeal, tbCuoiDonHangDeal.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.KeyThongBaoSauDatHangDeal, txtThongBaoCart.Text, language);

        #region Đóng dấu ảnh
        if (cbDongDauAnh.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal, "0", language);

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
            SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal_AnhDau, fileName, language);
        }
        #endregion

        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal_ViTri, rbViTriDongDau.SelectedValue, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal_LeNgang, tbLeX.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal_LeDoc, tbLeY.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal_TyLe, tbPhanTram.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.DongDauAnhDeal_TrongSuot, tbTrongSuot.Text, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (cbHanCheKichThuoc.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDeal, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDeal, "0", language);

        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDeal_MaxWidth, tbHanCheW.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.HanCheKichThuocAnhDeal_MaxHeight, tbHanCheH.Text, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (cbTaoAnhNho.Checked)
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDeal, "1", language);
        else
            SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDeal, "0", language);

        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDeal_MaxWidth, tbAnhNhoW.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingKey.TaoAnhNhoChoAnhDeal_MaxHeight, tbAnhNhoH.Text, language);
        #endregion

        SaveConfigs();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Cập nhật thành công !');", true);
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
            SettingsTSql.GetSettingsByVslang(language)
            );
        dt = Settings.GetSettingsCondition("1", "*", condition, "");
        if (dt.Rows.Count < 1)
        {
            Settings.InsertSettings(encodekey, firstkey, fullkey, language);
        }
        else
        {
            Settings.UpdateSettings(SettingsTSql.GetSettingsByVsvalue(fullkey), condition);
        }
    }

    /// <summary>
    /// Lấy ra các cấu hình theo đường đẫn của control cha
    /// </summary>
    /// <param name="vsdesc">Đường dẫn của control cha, vd: cms/admin/Moduls/New/Index.ascx</param>
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
