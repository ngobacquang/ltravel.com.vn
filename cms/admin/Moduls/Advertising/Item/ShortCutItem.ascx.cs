using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.AdvertisingModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Advertising_Item_ShortCutItem : System.Web.UI.UserControl
{
  private string app = CodeApplications.Advertising;
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string pic = FolderPic.Advertising;

  private string iid = "";
  private string igid = "";
  private bool insert = false;
  private string hd_insert_update = "";
  private string p = "";
  private string ni = "";

  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["suc"] != null)
      hd_insert_update = Request.QueryString["suc"];
    if (Request.QueryString["iid"] != null)
      iid = Request.QueryString["iid"];
    if (Request.QueryString["igid"] != null)
      igid = Request.QueryString["igid"];
    if (Request.QueryString["p"] != null)
      p = Request.QueryString["p"];
    if (Request.QueryString["ni"] != null)
      ni = Request.QueryString["ni"];
    if (hd_insert_update.Equals("CreateItem"))
      insert = true;
    if (!IsPostBack)
    {
      ltrTrangThai.Text = "<div class='text pt2'>" + Developer.AdvertisingKeyword.TrangThai + @"</div>";
      GetGroupsInDdl();
      InitialControlsValue(insert);
    }
  }

  private string LinkRedrect()
  {
    if (!ni.Equals("") && !p.Equals(""))
    {
      return UrlExtension.WebisteUrl + "admin.aspx?uc=" + app + "&igid=" + ddl_group_product.SelectedValue + "&suc=d&ni=" + ni + "&p=" + p;
    }
    else
    {
      return UrlExtension.WebisteUrl + "admin.aspx?uc=" + app + "&igid=" + ddl_group_product.SelectedValue + "&suc=d";
    }
  }

  void GetGroupsInDdl()
  {
    DataTable dt = new DataTable();
    dt = Groups.GetAllGroups("*", DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(app) + " AND IGENABLE <> '2' ", GroupsTSql.GetGroupsByVglang(language)), "");
    if (dt.Rows.Count > 0)
    {
      for (int i = 0; i < dt.Rows.Count; i++)
      {
        ddl_group_product.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
      }
    }
    if (!igid.Equals(""))
    {
      ddl_group_product.SelectedValue = igid;
    }
  }

  void InitialControlsValue(bool insert)
  {
    #region update
    if (!insert)
    {
      LtInsertUpdate.Text = Developer.AdvertisingKeyword.CapNhat;
      btn_insert_update.Text = "Đồng ý";
      ckbContinue.Visible = false;
      fields = "*";
      condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(app), ItemsTSql.GetItemsByIid(iid));
      DataTable dt = new DataTable();
      dt = GroupsItems.GetAllData(top, fields, condition, orderBy);
      txt_width_adv.Text = dt.Rows[0]["VIKEY"].ToString();
      txt_title.Text = dt.Rows[0]["VITITLE"].ToString();
      txt_height_adv.Text = dt.Rows[0]["VIDESC"].ToString();
      txt_link_adv.Text = dt.Rows[0]["VISEOLINK"].ToString();
      txt_link_to_image.Text = dt.Rows[0]["VIAUTHOR"].ToString();
      TbDesc.Text = dt.Rows[0][ItemsColumns.VISEOTITLEColumn].ToString();
      ddl_type_open.SelectedValue = dt.Rows[0]["VIPARAMS"].ToString();
      txt_order.Text = dt.Rows[0]["IORDER"].ToString();

      hdNguoiDangCu.Value = dt.Rows[0]["VIURL"].ToString();
      hdThongTinThem.Value = dt.Rows[0]["VISEOMETACANONICAL"].ToString();
      hdEnable.Value = dt.Rows[0]["IIENABLE"].ToString();
      hdNgayXuatBan.Value = dt.Rows[0]["VISEOMETALANG"].ToString();

      if (dt.Rows[0]["FIPRICE"].ToString().Equals("1"))
      {
        ltimg.Text = ImagesExtension.GetImage(pic, dt.Rows[0]["VIIMAGE"].ToString(), "", "admImageEditAdv", false, false, "");
      }
      else
      {
        ltimg.Text = ImagesExtension.GetImageFlash(pic, dt.Rows[0]["VIIMAGE"].ToString(), "admImageEditAdv", false);
      }
      hdImg.Value = dt.Rows[0]["VIIMAGE"].ToString();



      if (dt.Rows[0]["FIPRICE"].ToString().Equals("1"))
      {
        ltimg2.Text = ImagesExtension.GetImage(pic, StringExtension.LayChuoi(dt.Rows[0]["VICONTENT"].ToString(), "", 1), "", "admImageEditAdv", false, false, "");
      }
      else
      {
        ltimg2.Text = ImagesExtension.GetImageFlash(pic, StringExtension.LayChuoi(dt.Rows[0]["VICONTENT"].ToString(), "", 1), "admImageEditAdv", false);
      }
      hdImg2.Value = StringExtension.LayChuoi(dt.Rows[0]["VICONTENT"].ToString(), "", 1);


      ddl_group_product.SelectedValue = dt.Rows[0]["IGID"].ToString();
      if (dt.Rows[0]["IIENABLE"].ToString().Equals("0"))
      {
        chk_status.Checked = false;
      }
      else
      {
        chk_status.Checked = true;
      }

      #region Ẩn nút hiển thị bài viết với tính năng duyệt tin
      if (AdvertisingConfig.KeyDuyetTin)
      {
        string userRole = CookieExtension.GetCookies("RolesUser");
        #region Với tính năng duyệt tin 2 cấp (phóng viên, biên tập => trưởng ban biên tập => tổng biên tập)
        if (HorizaMenuConfig.ShowDuyetTin2)
        {
          if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
          {
            #region Với tài khoản cấp 1 (phóng viên, biên tập)
            pnTichChonDeHienThi.Visible = false;
            ltrTrangThai.Visible = false;
            chk_status.Checked = false;
            #endregion
          }
          else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
          {
            #region Với tài khoản cấp 2 (trưởng ban biên tập)
            pnTichChonDeHienThi.Visible = false;
            ltrTrangThai.Visible = false;
            chk_status.Checked = false;
            #endregion
          }
          else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
          {
            #region Với tài khoản cấp 3 (tổng biên tập)
            chk_status.Text = Developer.DuyetTinKeyword.XuatBanQuangCao;
            #endregion
          }
        }
        #endregion
        #region Với tính năng duyệt tin 1 cấp (phóng viên, biên tập viên => tổng biên tập)
        else if (HorizaMenuConfig.ShowDuyetTin1)
        {
          if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
          {
            #region Với tài khoản cấp 2 (phóng viên, biên tập)
            pnTichChonDeHienThi.Visible = false;
            ltrTrangThai.Visible = false;
            chk_status.Checked = false;
            #endregion
          }
          else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
          {
            #region Với tài khoản cấp 3 (tổng biên tập)
            chk_status.Text = Developer.DuyetTinKeyword.XuatBanQuangCao;
            #endregion
          }
        }
        #endregion
      }
      #endregion
    }
    #endregion
    #region  insert
    else
    {
      LtInsertUpdate.Text = Developer.AdvertisingKeyword.ThemMoi;
      btn_insert_update.Text = "Đồng ý";
      txt_title.Focus();

      #region Ẩn nút hiển thị bài viết với tính năng duyệt tin
      if (AdvertisingConfig.KeyDuyetTin)
      {
        chk_status.Checked = false;
        string userRole = CookieExtension.GetCookies("RolesUser");
        #region Với tính năng duyệt tin 2 cấp (phóng viên, biên tập => trưởng ban biên tập => tổng biên tập)
        if (HorizaMenuConfig.ShowDuyetTin2)
        {
          if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
          {
            #region Với tài khoản cấp 1 (phóng viên, biên tập)
            pnTichChonDeHienThi.Visible = false;
            #endregion
          }
          else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
          {
            #region Với tài khoản cấp 2 (trưởng ban biên tập)
            pnTichChonDeHienThi.Visible = false;
            #endregion
          }
          else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
          {
            #region Với tài khoản cấp 3 (tổng biên tập)
            chk_status.Text = Developer.DuyetTinKeyword.XuatBanQuangCao;
            #endregion
          }
        }
        #endregion
        #region Với tính năng duyệt tin 1 cấp (phóng viên, biên tập viên => tổng biên tập)
        else if (HorizaMenuConfig.ShowDuyetTin1)
        {
          if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
          {
            #region Với tài khoản cấp 2 (phóng viên, biên tập)
            pnTichChonDeHienThi.Visible = false;
            #endregion
          }
          else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
          {
            #region Với tài khoản cấp 3 (tổng biên tập)
            chk_status.Text = Developer.DuyetTinKeyword.XuatBanQuangCao;
            #endregion
          }
        }
        #endregion
      }
      #endregion
    }
    #endregion
  }

  void ResetControls()
  {
    txt_width_adv.Text = "";
    txt_title.Text = "";
    TbDesc.Text = "";
    txt_height_adv.Text = "";
    txt_link_adv.Text = "";
    txt_link_to_image.Text = "";
    ddl_type_open.SelectedIndex = 0;
    ltimg.Text = "";
    hdImg.Value = "";

    ltimg2.Text = "";
    hdImg2.Value = "";

    try
    {
      txt_order.Text = (Convert.ToInt32(txt_order.Text) + 1).ToString();
    }
    catch { }
    txt_title.Focus();
  }

  protected void btn_insert_update_Click(object sender, EventArgs e)
  {
    #region Image
    string fileType = "1";//1: ảnh thường, 2: flash
    string vimg = "";
    if (flimg.FileName.Length > 0 && flimg.PostedFile.ContentLength > 0)
    {
      string filename = flimg.FileName;
      string fileex = filename.Substring(filename.LastIndexOf(".")).ToLower();
      string path = Request.PhysicalApplicationPath + "/" + pic + "/";
      if (ImagesExtension.ValidType(fileex, ",.jpg,.jpeg,.png,.gif,.swf,"))
      {
        string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
        if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
        string ticks = DateTime.Now.Ticks.ToString();
        vimg = fileNotEx + "_" + ticks + fileex;
        flimg.SaveAs(path + vimg);
      }
      if (fileex == ".swf") fileType = "2";//Ảnh flash
    }
    #endregion

    #region Image2
    string vimg2 = "";
    if (flimg2.FileName.Length > 0 && flimg2.PostedFile.ContentLength > 0)
    {
      string filename = flimg2.FileName;
      string fileex = filename.Substring(filename.LastIndexOf(".")).ToLower();
      string path = Request.PhysicalApplicationPath + "/" + pic + "/";
      if (ImagesExtension.ValidType(fileex, ",.jpg,.jpeg,.png,.gif,.swf,"))
      {
        string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
        if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
        string ticks = DateTime.Now.Ticks.ToString();
        vimg2 = fileNotEx + "_" + ticks + fileex;
        flimg2.SaveAs(path + vimg2);
      }
    }
    #endregion

    #region Status
    string status = "0";
    if (chk_status.Checked == true)
    {
      status = "1";
    }
    #endregion

    #region IID người đăng
    string iidNguoiDang = "";
    string thongtindangbai = "";
    string ngayxuatban = "";
    if (AdvertisingConfig.KeyDuyetTin)
    {
      if (HorizaMenuConfig.ShowDuyetTin1 || HorizaMenuConfig.ShowDuyetTin2)
      {
        iidNguoiDang = CookieExtension.GetCookies("userId");
        ngayxuatban = DateTime.Now.ToString();
      }
    }
    #endregion

    #region Insert
    if (insert)
    {
      string vicontent = StringExtension.GhepChuoi("", vimg2);
      GroupsItems.InsertItemsGroupsItems(language, app, txt_width_adv.Text, txt_title.Text,
                                         txt_height_adv.Text, vicontent, vimg, iidNguoiDang, txt_link_to_image.Text,
                                         TbDesc.Text, txt_link_adv.Text, "", "", "", thongtindangbai, ngayxuatban, "", ddl_type_open.SelectedValue, fileType, "",
                                         "", "", DateTime.Now.ToString(), DateTime.Now.ToString(),
                                         DateTime.Now.ToString(), "", ddl_group_product.SelectedValue,
                                         DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(),
                                         txt_order.Text, status);

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_title.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới " + txt_title.Text);
      #endregion
    }
    #endregion
    #region Update
    else
    {
      if (vimg.Length < 1)
      {
        fileType = "1";//1: ảnh thường, 2: flash
        vimg = hdImg.Value;
        string fileex = "";
        if (vimg.LastIndexOf(".") > -1)
          fileex = vimg.Substring(vimg.LastIndexOf(".")).ToLower();
        if (fileex == ".swf") fileType = "2";//Ảnh flash
      }
      else
      {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImg.Value);
      }

      if (vimg2.Length < 1)
      {
        vimg2 = hdImg2.Value;
      }
      else
      {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImg2.Value);
      }
      string vicontent = StringExtension.GhepChuoi("", vimg2);

      if (AdvertisingConfig.KeyDuyetTin)
      {
        string userRole = CookieExtension.GetCookies("RolesUser");
        if (HorizaMenuConfig.ShowDuyetTin2)
        {
          if (hdEnable.Value == PhanQuyen.DuyetTin.Cap1 && StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
            status = "0";
          else if (hdEnable.Value == "1" && StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
            status = "1";
          else if (hdEnable.Value != "0" && hdEnable.Value != "1")
            status = hdEnable.Value;
        }
        else
        {
          if (hdEnable.Value == PhanQuyen.DuyetTin.Cap2 && StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
            status = "0";
          else if (hdEnable.Value != "0" && hdEnable.Value != "1")
            status = hdEnable.Value;
        }
      }

      string nguoiDangCu = hdNguoiDangCu.Value;
      string thongtincu = hdThongTinThem.Value;
      string ngayxuatbancu = hdNgayXuatBan.Value;
      GroupsItems.UpdateItemsGroupsItems(language, app, txt_width_adv.Text, txt_title.Text,
                                         txt_height_adv.Text, vicontent, vimg, nguoiDangCu, txt_link_to_image.Text,
                                         TbDesc.Text, txt_link_adv.Text, "", "", "", thongtincu, ngayxuatbancu, "", ddl_type_open.SelectedValue, fileType, "",
                                         "", "", DateTime.Now.ToString(), DateTime.Now.ToString(),
                                         DateTime.Now.ToString(), "", ddl_group_product.SelectedValue,
                                         DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(),
                                         txt_order.Text, status, iid);

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_title.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật " + txt_title.Text);
      #endregion
    }
    #endregion

    #region After Insert/Update
    if (ckbContinue.Checked == true)
    {
      ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Đã tạo: " + txt_title.Text + "');", true);
      ResetControls();
    }
    else
      Response.Redirect(LinkRedrect());
    #endregion
  }

  protected void btn_cancel_Click(object sender, EventArgs e)
  {
    Response.Redirect(LinkRedrect());
  }

}