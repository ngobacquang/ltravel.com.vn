using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Tour_Item_ShortCutItem : System.Web.UI.UserControl
{
  private string app = CodeApplications.Tour;
  private string appCate = CodeApplications.Tour;
  private string appProperty = CodeApplications.TourProperty;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string pic = FolderPic.Tour;

  protected string iid = "";
  private string igid = "";
  private bool insert = false;
  private string suc = "";
  private string p = "";
  private string ni = "";

  string parramSpitString = ",";

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["suc"] != null)
      suc = Request.QueryString["suc"];
    if (suc.Equals(TypePage.CreateItem))
      insert = true;

    if (Request.QueryString["iid"] != null)
      iid = Request.QueryString["iid"];
    if (Request.QueryString["igid"] != null)
      igid = Request.QueryString["igid"];
    if (Request.QueryString["p"] != null)
      p = Request.QueryString["p"];
    if (Request.QueryString["ni"] != null)
      ni = Request.QueryString["ni"];


    #region Gán app, pic cho user control upload ảnh đại diện
    flAnhDaiDien.App = appCate;
    flAnhDaiDien.Pic = pic;
    #endregion

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
    {
      GetParentCate();
      LayCacThongTinLienKet();
      InitialControlsValue(insert);
    }
  }

  protected string SetEnableClass(bool show)
  {
    return show ? "" : "dn-im";
  }

  #region Lấy các thông tin liên kết
  private void LayCacThongTinLienKet()
  {
    LayLienKetPhuongTien();
    LayLienKetBaoGom();

    LayLienKetDiemDenSeQua();

    LayThuocTinh();
  }
  #region Lấy liên kết dịch vụ bao gồm, không bao gồm
  void LayLienKetBaoGom()
  {
    string app = CodeApplications.TourService;
    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn);
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgparentid("0"),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsColumns.IgenableColumn + "<>2"
        );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    DataTable dt = Groups.GetGroups("", fields, condition, orderBy);

    cblBaoGom.DataSource = dt;
    cblBaoGom.DataTextField = GroupsColumns.VgnameColumn;
    cblBaoGom.DataValueField = GroupsColumns.IgidColumn;
    cblBaoGom.DataBind();

    cblKhongBaoGom.DataSource = dt;
    cblKhongBaoGom.DataTextField = GroupsColumns.VgnameColumn;
    cblKhongBaoGom.DataValueField = GroupsColumns.IgidColumn;
    cblKhongBaoGom.DataBind();
    //Ban đầu check tất cả các items ở mục không bao gồm
    for (int i = 0; i < cblKhongBaoGom.Items.Count; i++)
    {
      cblKhongBaoGom.Items[i].Selected = true;
    }
  }
  #endregion

  #region Lấy liên kết các điểm sẽ qua
  private void LayLienKetDiemDenSeQua()
  {
    string app = TatThanhJsc.DestinationModul.CodeApplications.Destination;
    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.IglevelColumn);
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgparentid("0"),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsColumns.IgenableColumn + "<>2"
        );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    DataTable dt = Groups.GetGroups("", fields, condition, orderBy);
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      ltrCacDiemDenChuaChon.Text += @"
<div class='dest0'>
    <label for='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "'><input id='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "' type='checkbox'/>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</label>
    " + LayLienKetDiemDenSeQua_Cap2(dt.Rows[i][GroupsColumns.IgidColumn].ToString(), dt.Rows[i][GroupsColumns.IglevelColumn].ToString()) + @"
</div>";
    }
  }

  private string LayLienKetDiemDenSeQua_Cap2(string parentId, string parentLevel)
  {
    string s = "";
    string app = TatThanhJsc.DestinationModul.CodeApplications.Destination;
    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.IglevelColumn);
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgparentid(parentId),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsColumns.IgenableColumn + "<>2"
        );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    DataTable dt = Groups.GetGroups("", fields, condition, orderBy);
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      s += @"
<div class='dest" + parentLevel + @"'>
    <label for='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "'><input id='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "' type='checkbox'/>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</label>
    " + LayLienKetDiemDenSeQua_Cap2(dt.Rows[i][GroupsColumns.IgidColumn].ToString(), dt.Rows[i][GroupsColumns.IglevelColumn].ToString()) + @"
</div>";
    }

    return s;
  }

  #endregion

  #region Lấy liên kết phương tiện
  void LayLienKetPhuongTien()
  {
    string app = CodeApplications.TourVehicle;
    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn);
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgparentid("0"),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsColumns.IgenableColumn + "<>2"
        );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    DataTable dt = Groups.GetGroups("", fields, condition, orderBy);

    for (int i = 0; i < dt.Rows.Count; i++)
      ddlThoiGianTour.Items.Add(new ListItem(dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), dt.Rows[i][GroupsColumns.IgidColumn].ToString()));
  }
  #endregion

  #region Lấy thuộc tính
  void LayThuocTinh()
  {
    string app = CodeApplications.TourProperty;
    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.VgimageColumn);
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgparentid("0"),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsColumns.IgenableColumn + "<>2"
        );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    DataTable dt = Groups.GetGroups("", fields, condition, orderBy);

    for (int i = 0; i < dt.Rows.Count; i++)
      ddlDiemDen.Items.Add(new ListItem(dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), dt.Rows[i][GroupsColumns.IgidColumn].ToString()));
  }
  #endregion
  #endregion

  private string LinkRedrect()
  {
    if (!ni.Equals("") && !p.Equals(""))
      return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.Tour + "&igid=" +
             ddlParentCate.SelectedValue + "&suc=" + TypePage.Item + "&ni=" + ni + "&p=" + p;
    else
      return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.Tour + "&igid=" +
             ddlParentCate.SelectedValue + "&suc=" + TypePage.Item;
  }

  void GetParentCate()
  {
    DropDownListExtension.LoadParentCates(app, lang, ddlParentCate, false);

    if (!igid.Equals(""))
    {
      ddlParentCate.SelectedValue = igid;
    }
  }

  void InitialControlsValue(bool insert)
  {
    #region update
    if (!insert)
    {
      LtInsertUpdate.Text = Developer.TourKeyword.CapNhatBaiViet;
      btOK.Text = "Đồng ý";
      cbTiepTuc.Visible = false;
      string fields = "*";

      string condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(appCate), ItemsTSql.GetItemsByIid(iid));

      DataTable dt = GroupsItems.GetAllData("1", fields, condition, "");

      hdGroupsItemId.Value = dt.Rows[0][GroupsItemsColumns.IgiidColumn].ToString();
      ddlParentCate.SelectedValue = dt.Rows[0]["IGID"].ToString();

      tbTenTour.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
      tbMaTour.Text = dt.Rows[0][ItemsColumns.VikeyColumn].ToString();
      flAnhDaiDien.Load(dt.Rows[0][ItemsColumns.ViimageColumn].ToString());
      tbMoTa.Text = dt.Rows[0][ItemsColumns.VidescColumn].ToString();

      tbGiaNiemYet.Text = dt.Rows[0][ItemsColumns.FipriceColumn].ToString();
      tbGiaKhuyenMai.Text = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString();

      tbNgayKhoiHanh.Text = dt.Rows[0][ItemsColumns.VISEOMETAPARAMSColumn].ToString();

      tbXuatPhat.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 1);
      tbPhuongTien.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 2);
      tbYoutubeEmbed.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 3);
      tbMaDinhKemBanDoTour.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 4);
      tbGioKhoiHanh.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 5);

      #region SEO
      tbSeoLink.Text = dt.Rows[0]["VISEOLINK"].ToString();
      tbSeoTitle.Text = dt.Rows[0]["VISEOTITLE"].ToString();
      tbSeoKeyword.Text = dt.Rows[0]["VISEOMETAKEY"].ToString();
      tbSeoDescription.Text = dt.Rows[0]["VISEOMETADESC"].ToString();
      #endregion

      tbThuTu.Text = dt.Rows[0][ItemsColumns.IiorderColumn].ToString();
      cbTrangThai.Checked = (dt.Rows[0][ItemsColumns.IienableColumn].ToString() == "1");

      tbNgayDang.Text = dt.Rows[0][ItemsColumns.DicreatedateColumn].ToString();
      hdTotalView.Value = dt.Rows[0][ItemsColumns.IitotalviewColumn].ToString();

      tbGiaChoNguoiLon.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 1);
      tbGiaChoTreViThanhNien.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 2);
      tbGiaChoTreEm.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 3);
      tbGiaChoEmBe.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 4);

      ddlThoiGianTour.SelectedValue = dt.Rows[0][ItemsColumns.ViurlColumn].ToString();
      ddlDiemDen.SelectedValue = dt.Rows[0][ItemsColumns.ViauthorColumn].ToString();
    }
    #endregion
    #region  insert
    else
    {
      LtInsertUpdate.Text = Developer.TourKeyword.ThemMoiBaiViet;
      btOK.Text = "Đồng ý";
      tbNgayDang.Text = DateTime.Now.ToString();
      tbTenTour.Focus();
    }
    #endregion
  }

  void ResetControls()
  {
    #region Reset các textbox, textbox nào có chứa css class là NotReset thì sẽ không bị reset
    foreach (Control control in this.Controls)
    {
      if (control is TextBox)
        if (((TextBox)control).CssClass != "NotReset")
          ((TextBox)control).Text = "";

      if (control is HiddenField)
        ((HiddenField)control).Value = "";
    }
    #endregion

    flAnhDaiDien.Reset();

    tbNgayDang.Text = DateTime.Now.ToString();
    try
    {
      tbThuTu.Text = (Convert.ToInt32(tbThuTu.Text) + 1).ToString();
    }
    catch { }
    tbTenTour.Focus();
  }

  protected void btOK_Click(object sender, EventArgs e)
  {
    string content = StringExtension.GhepChuoi("",
        tbXuatPhat.Text,
        tbPhuongTien.Text,
        tbYoutubeEmbed.Text,
        tbMaDinhKemBanDoTour.Text,
        tbGioKhoiHanh.Text);

    #region Trạng thái
    string trangThai = "0";
    if (cbTrangThai.Checked == true)
      trangThai = "1";
    #endregion

    #region Seo
    if (tbSeoLink.Text.Trim().Equals(""))
    {
      tbSeoLink.Text = tbTenTour.Text;
    }
    if (tbSeoTitle.Text.Trim().Equals(""))
    {
      tbSeoTitle.Text = tbTenTour.Text;
    }
    if (tbSeoKeyword.Text.Trim().Equals(""))
    {
      tbSeoKeyword.Text = tbTenTour.Text;
    }
    if (tbSeoDescription.Text.Trim().Equals(""))
    {
      tbSeoDescription.Text = tbMoTa.Text;
    }
    #endregion

    #region Ngày đăng
    if (tbNgayDang.Text == "")
      tbNgayDang.Text = DateTime.Now.ToString();
    #endregion

    string giaChuanKhiDatTour = StringExtension.GhepChuoi("", tbGiaChoNguoiLon.Text, tbGiaChoTreViThanhNien.Text, tbGiaChoTreEm.Text,
        tbGiaChoEmBe.Text);

    #region Insert
    if (insert)
    {
      string image = flAnhDaiDien.Save(false, tbMoTa.Text);
      GroupsItems.InsertItemsGroupsItems(lang, app, tbMaTour.Text, tbTenTour.Text, tbMoTa.Text, content,
          image, ddlThoiGianTour.SelectedValue, ddlDiemDen.SelectedValue, tbSeoTitle.Text, tbSeoLink.Text,
          StringExtension.ReplateTitle(tbSeoLink.Text),
          tbSeoKeyword.Text, tbSeoDescription.Text, giaChuanKhiDatTour, "", tbNgayKhoiHanh.Text, "", tbGiaNiemYet.Text,
          tbGiaKhuyenMai.Text, "", "", tbNgayDang.Text,
          DateTime.Now.ToString(), DateTime.Now.ToString(), tbThuTu.Text, ddlParentCate.SelectedValue,
          tbNgayDang.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), tbThuTu.Text, trangThai);

      #region Lấy ra id của items vừa được thêm
      iid = GetInsertedId(app, tbTenTour.Text, tbNgayDang.Text);
      #endregion

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTenTour.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới " + tbTenTour.Text);
      #endregion

    }
    #endregion
    #region Update
    else
    {
      string image = flAnhDaiDien.Save(true, tbMoTa.Text);

      GroupsItems.DeleteGroupsItems(GroupsItemsTSql.GetGroupsItemsByIgiid(hdGroupsItemId.Value));
      GroupsItems.UpdateItemsGroupsItems(lang, app, tbMaTour.Text, tbTenTour.Text, tbMoTa.Text, content,
          image, ddlThoiGianTour.SelectedValue, ddlDiemDen.SelectedValue, tbSeoTitle.Text, tbSeoLink.Text,
          StringExtension.ReplateTitle(tbSeoLink.Text),
          tbSeoKeyword.Text, tbSeoDescription.Text, giaChuanKhiDatTour, "", tbNgayKhoiHanh.Text, "", tbGiaNiemYet.Text,
          tbGiaKhuyenMai.Text, "", hdTotalView.Value,
          tbNgayDang.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), tbThuTu.Text,
          ddlParentCate.SelectedValue, tbNgayDang.Text, DateTime.Now.ToString(), DateTime.Now.ToString(),
          tbThuTu.Text, trangThai, iid);

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTenTour.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật " + tbTenTour.Text);
      #endregion
    }
    #endregion

    #region Thuộc tính tour, mỗi thuộc tính làm một bản ghi liên kết Groups_Items

    #endregion

    #region After Insert/Update

    if (cbTiepTuc.Checked == true)
    {
      ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
          "ThongBao(3000,'Đã tạo: " + tbTenTour.Text + "');", true);
      ResetControls();
    }
    else
    {
      Response.Redirect(LinkRedrect());
    }

    #endregion
  }

  #region Thuộc tính
  private void InsertProperty(string igid, string iid)
  {
    string condition = DataExtension.AndConditon(GroupsItemsTSql.GetByIgid(igid), GroupsItemsTSql.GetByIid(iid));
    DataTable dt = GroupsItems.GetGroupsItems("1", GroupsItemsColumns.IgiidColumn, condition, "");
    if (dt.Rows.Count == 0)
      GroupsItems.InsertGroupsItems(igid, iid, "", DateTime.Now.ToString(), DateTime.Now.ToString(),
          DateTime.Now.ToString(), "");
  }

  void DeleteProperty(string igid, string iid)
  {
    GroupsItems.DeleteGroupsItems(DataExtension.AndConditon(GroupsItemsTSql.GetByIgid(igid),
        GroupsItemsTSql.GetByIid(iid)));
  }

  #endregion

  string GetInsertedId(string app, string title, string createDate)
  {
    string condition = DataExtension.AndConditon(
        ItemsTSql.GetByApp(app),
        ItemsTSql.GetByTitle(title),
        ItemsTSql.GetByCreateDate(createDate)
        );
    DataTable dt = Items.GetItems("1", ItemsColumns.IidColumn, condition, ItemsColumns.IidColumn + " desc");
    if (dt.Rows.Count > 0)
      return dt.Rows[0][ItemsColumns.IidColumn].ToString();
    return "";
  }

  protected void btCancel_Click(object sender, EventArgs e)
  {
    Response.Redirect(LinkRedrect());
  }
}