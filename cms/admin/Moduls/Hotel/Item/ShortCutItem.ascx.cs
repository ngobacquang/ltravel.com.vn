using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Hotel_Item_ShortCutItem : System.Web.UI.UserControl
{
  private string app = CodeApplications.Hotel;
  private string appCate = CodeApplications.Hotel;
  private string appProperty = CodeApplications.HotelProperty;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string pic = FolderPic.Hotel;

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

  #region Lấy các thông tin liên kết
  private void LayCacThongTinLienKet()
  {
    LayLienKetBaoGom();

    LayLienKetDiemDenSeQua();

    LayThuocTinh();
  }
  #region Lấy liên kết dịch vụ bao gồm, không bao gồm
  void LayLienKetBaoGom()
  {
    string app = CodeApplications.HotelFacility;
    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn);
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgparentid("0"),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsColumns.IgenableColumn + "<>2"
        );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    DataTable dt = Groups.GetGroups("", fields, condition, orderBy);

    //DataRow dr = dt.NewRow();
    //dr[0] = "0";
    //dr[1] = "Chọn/bỏ tất cả";
    //dt.Rows.InsertAt(dr,0);

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

  #region Lấy thuộc tính
  void LayThuocTinh()
  {
    string app = CodeApplications.HotelProperty;
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
    {
      cblThuocTinh.Items.Add(
          new ListItem(
              ImagesExtension.GetImage(pic, dt.Rows[i][GroupsColumns.VgimageColumn].ToString(),
                  dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), "imgProp", false, false, "") +
              dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), dt.Rows[i][GroupsColumns.IgidColumn].ToString()));
    }
  }
  #endregion
  #endregion

  private string LinkRedrect()
  {
    if (!ni.Equals("") && !p.Equals(""))
      return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.Hotel + "&igid=" +
             ddlParentCate.SelectedValue + "&suc=" + TypePage.Item + "&ni=" + ni + "&p=" + p;
    else
      return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.Hotel + "&igid=" +
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
      LtInsertUpdate.Text = Developer.HotelKeyword.CapNhatBaiViet;
      btOK.Text = "Đồng ý";
      cbTiepTuc.Visible = false;
      string fields = "*";

      string condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(appCate), ItemsTSql.GetItemsByIid(iid));

      DataTable dt = GroupsItems.GetAllData("1", fields, condition, "");

      hdGroupsItemId.Value = dt.Rows[0][GroupsItemsColumns.IgiidColumn].ToString();
      ddlParentCate.SelectedValue = dt.Rows[0]["IGID"].ToString();

      tbTenHotel.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
      tbMaHotel.Text = dt.Rows[0][ItemsColumns.VikeyColumn].ToString();
      flAnhDaiDien.Load(dt.Rows[0][ItemsColumns.ViimageColumn].ToString());
      tbMoTa.Text = dt.Rows[0][ItemsColumns.VidescColumn].ToString();

      tbGiaNiemYet.Text = dt.Rows[0][ItemsColumns.FipriceColumn].ToString();
      tbGiaKhuyenMai.Text = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString();

      ddlXepHang.SelectedValue = dt.Rows[0][ItemsColumns.ViauthorColumn].ToString();

      tbTongSoKhach.Text = dt.Rows[0][ItemsColumns.IitotalsubitemsColumn].ToString();
      tbSoPhongConLai.Text = dt.Rows[0][ItemsColumns.VISEOMETAPARAMSColumn].ToString();

      tbTongQuan.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 1);
      hdTongQuan.Value = tbTongQuan.Text;

      #region Các điểm đến sẽ qua
      if (dt.Rows[0][ItemsColumns.ViurlColumn].ToString().StartsWith("text-"))
        tbCacDiemDenSeQua.Text = dt.Rows[0][ItemsColumns.ViurlColumn].ToString().Substring("text-".Length);
      if (dt.Rows[0][ItemsColumns.ViurlColumn].ToString().StartsWith("id-"))
      {
        string listId = "," + dt.Rows[0][ItemsColumns.ViurlColumn].ToString().Substring("id-".Length) + ",";
        hdIdCacDiemDenSeQua.Value = listId;
      }
      #endregion

      tbDiaChiChiTiet.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 3);

      #region Bản đồ
      tbMaDinhKemBanDoHotel.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 4);
      GoogleMapMarkLocation.ViDo = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 5);
      GoogleMapMarkLocation.KinhDo = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 6);
      #endregion

      #region Bao gồm
      string baoGom = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 7);
      if (baoGom.StartsWith("text-"))
        tbBaoGom.Text = baoGom.Substring("text-".Length);
      if (baoGom.StartsWith("id-"))
      {
        string listId = "," + baoGom.Substring("id-".Length) + ",";
        for (int i = 0; i < cblBaoGom.Items.Count; i++)
        {
          if (listId.IndexOf("," + cblBaoGom.Items[i].Value + ",") > -1)
            cblBaoGom.Items[i].Selected = true;
          else
            cblBaoGom.Items[i].Selected = false;
        }
      }
      #endregion

      #region Không bao gồm
      string khongBaoGom = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 8);
      if (khongBaoGom.StartsWith("text-"))
        tbKhongBaoGom.Text = khongBaoGom.Substring("text-".Length);
      if (khongBaoGom.StartsWith("id-"))
      {
        string listId = "," + khongBaoGom.Substring("id-".Length) + ",";
        for (int i = 0; i < cblKhongBaoGom.Items.Count; i++)
        {
          if (listId.IndexOf("," + cblKhongBaoGom.Items[i].Value + ",") > -1)
            cblKhongBaoGom.Items[i].Selected = true;
          else
            cblKhongBaoGom.Items[i].Selected = false;
        }
      }
      #endregion

      #region SEO
      tbSeoLink.Text = dt.Rows[0]["VISEOLINK"].ToString();
      tbSeoTitle.Text = dt.Rows[0]["VISEOTITLE"].ToString();
      tbSeoKeyword.Text = dt.Rows[0]["VISEOMETAKEY"].ToString();
      tbSeoDescription.Text = dt.Rows[0]["VISEOMETADESC"].ToString();
      #endregion

      tbDieuKhoanKhac.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 9);
      hdDieuKhoanKhac.Value = tbDieuKhoanKhac.Text;

      tbThuTu.Text = dt.Rows[0][ItemsColumns.IiorderColumn].ToString();
      cbTrangThai.Checked = (dt.Rows[0][ItemsColumns.IienableColumn].ToString() == "1");

      tbNgayDang.Text = dt.Rows[0][ItemsColumns.DicreatedateColumn].ToString();
      hdTotalView.Value = dt.Rows[0][ItemsColumns.IitotalviewColumn].ToString();

      #region Thuộc tính

      DienThongTinThuocTinh(dt.Rows[0][ItemsColumns.IidColumn].ToString());

      #endregion
    }
    #endregion
    #region  insert
    else
    {
      LtInsertUpdate.Text = Developer.HotelKeyword.ThemMoiBaiViet;
      btOK.Text = "Đồng ý";
      tbNgayDang.Text = DateTime.Now.ToString();
      tbTenHotel.Focus();
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
    tbTenHotel.Focus();
  }

  protected void btOK_Click(object sender, EventArgs e)
  {

    string tongQuan = ContentExtendtions.ProcessStringContent(tbTongQuan.Text, hdTongQuan.Value, pic);
    string lichTrinh = "";

    #region Bao gồm - included
    string baoGom = ContentExtendtions.ProcessStringContent(tbBaoGom.Text, hdBaoGom.Value, pic);
    if (baoGom.Trim() == "")//Nếu không nhập bao gồm thì lấy danh sách id tích chọn
    {
      for (int i = 0; i < cblBaoGom.Items.Count; i++)
      {
        if (cblBaoGom.Items[i].Selected)
          baoGom += cblBaoGom.Items[i].Value + ",";
      }
      if (baoGom != "")
        baoGom = "id-" + baoGom;
    }
    else
    {
      baoGom = "text-" + baoGom;
    }
    #endregion

    #region Không bao gồm - excluded
    string khongBaoGom = ContentExtendtions.ProcessStringContent(tbKhongBaoGom.Text, hdKhongBaoGom.Value, pic);
    if (khongBaoGom.Trim() == "")//Nếu không nhập không bao gồm thì lấy danh sách id tích chọn
    {
      for (int i = 0; i < cblKhongBaoGom.Items.Count; i++)
      {
        if (cblKhongBaoGom.Items[i].Selected)
          khongBaoGom += cblKhongBaoGom.Items[i].Value + ",";
      }
      if (khongBaoGom != "")
        khongBaoGom = "id-" + khongBaoGom;
    }
    else
    {
      khongBaoGom = "text-" + khongBaoGom;
    }
    #endregion

    string dieuKhoanKhac = ContentExtendtions.ProcessStringContent(tbDieuKhoanKhac.Text, hdDieuKhoanKhac.Value, pic);

    string content = StringExtension.GhepChuoi("",
        tongQuan,
        lichTrinh,
        tbDiaChiChiTiet.Text,
        tbMaDinhKemBanDoHotel.Text,
        GoogleMapMarkLocation.ViDo,
        GoogleMapMarkLocation.KinhDo,
        baoGom,
        khongBaoGom,
        dieuKhoanKhac);

    #region Các điểm đến
    string cacDiemDen = tbCacDiemDenSeQua.Text;
    if (cacDiemDen.Trim() == "")//Nếu không nhập thì lấy danh sách id tích chọn
    {
      cacDiemDen = hdIdCacDiemDenSeQua.Value;
      if (cacDiemDen != "")
        cacDiemDen = "id-" + cacDiemDen;
    }
    else
    {
      cacDiemDen = "text-" + cacDiemDen;
    }
    #endregion

    #region Trạng thái
    string trangThai = "0";
    if (cbTrangThai.Checked == true)
      trangThai = "1";
    #endregion
    #region Seo
    if (tbSeoLink.Text.Trim().Equals(""))
    {
      tbSeoLink.Text = tbTenHotel.Text;
    }
    if (tbSeoTitle.Text.Trim().Equals(""))
    {
      tbSeoTitle.Text = tbTenHotel.Text;
    }
    if (tbSeoKeyword.Text.Trim().Equals(""))
    {
      tbSeoKeyword.Text = tbTenHotel.Text;
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

    #region Insert
    if (insert)
    {
      string image = flAnhDaiDien.Save(false, tongQuan);
      GroupsItems.InsertItemsGroupsItems(lang, app, tbMaHotel.Text, tbTenHotel.Text, tbMoTa.Text, content,
          image, cacDiemDen, ddlXepHang.SelectedValue, tbSeoTitle.Text, tbSeoLink.Text,
          StringExtension.ReplateTitle(tbSeoLink.Text),
          tbSeoKeyword.Text, tbSeoDescription.Text, "", "", tbSoPhongConLai.Text, "", tbGiaNiemYet.Text,
          tbGiaKhuyenMai.Text, tbTongSoKhach.Text, "", tbNgayDang.Text,
          DateTime.Now.ToString(), DateTime.Now.ToString(), tbThuTu.Text, ddlParentCate.SelectedValue,
          tbNgayDang.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), tbThuTu.Text, trangThai);

      #region Lấy ra id của items vừa được thêm
      iid = GetInsertedId(app, tbTenHotel.Text, tbNgayDang.Text);
      #endregion

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTenHotel.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới " + tbTenHotel.Text);
      #endregion

    }
    #endregion
    #region Update
    else
    {
      string image = flAnhDaiDien.Save(true, tongQuan);

      GroupsItems.DeleteGroupsItems(GroupsItemsTSql.GetGroupsItemsByIgiid(hdGroupsItemId.Value));
      GroupsItems.UpdateItemsGroupsItems(lang, app, tbMaHotel.Text, tbTenHotel.Text, tbMoTa.Text, content,
          image, cacDiemDen, ddlXepHang.SelectedValue, tbSeoTitle.Text, tbSeoLink.Text,
          StringExtension.ReplateTitle(tbSeoLink.Text),
          tbSeoKeyword.Text, tbSeoDescription.Text, "", "", tbSoPhongConLai.Text, "", tbGiaNiemYet.Text,
          tbGiaKhuyenMai.Text, tbTongSoKhach.Text, hdTotalView.Value,
          tbNgayDang.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), tbThuTu.Text,
          ddlParentCate.SelectedValue, tbNgayDang.Text, DateTime.Now.ToString(), DateTime.Now.ToString(),
          tbThuTu.Text, trangThai, iid);

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTenHotel.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật " + tbTenHotel.Text);
      #endregion
    }
    #endregion

    #region Thuộc tính tour, mỗi thuộc tính làm một bản ghi liên kết Groups_Items
    //Lặp qua mỗi thuộc tính --> gọi hàm thêm mới, cập nhật thuộc tính
    for (int i = 0; i < cblThuocTinh.Items.Count; i++)
    {
      if (cblThuocTinh.Items[i].Selected)
        InsertProperty(cblThuocTinh.Items[i].Value, iid);
      else
        DeleteProperty(cblThuocTinh.Items[i].Value, iid);
    }
    #endregion

    #region After Insert/Update

    if (cbTiepTuc.Checked == true)
    {
      ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
          "ThongBao(3000,'Đã tạo: " + tbTenHotel.Text + "');", true);
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

  private void DienThongTinThuocTinh(string iid)
  {
    string condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(appProperty), ItemsTSql.GetItemsByIid(iid));
    DataTable dt = GroupsItems.GetAllData("", "groups_items.igid", condition, "");

    for (int i = 0; i < dt.Rows.Count; i++)
    {
      cblThuocTinh.Items.FindByValue(dt.Rows[i][GroupsColumns.IgidColumn].ToString()).Selected = true;
    }
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