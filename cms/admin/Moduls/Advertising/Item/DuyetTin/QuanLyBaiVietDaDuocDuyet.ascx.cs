using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.AdvertisingModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Advertising_Item_DuyetTin_QuanLyBaiVietDaDuocDuyet : System.Web.UI.UserControl
{
  protected string app = CodeApplications.Advertising;
  protected string pic = FolderPic.Advertising;
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string sortCookiesName = " VISEOMETALANG desc ";
  private string p = "1";
  private string NumberShowItem = "10";

  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";

  private string igid = "";

  private string name = "";

  protected string userId = CookieExtension.GetCookies("UserId");

  private string ArrayId = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["p"] != null)
      p = Request.QueryString["p"];
    if (Request.QueryString["igid"] != null)
      igid = Request.QueryString["igid"];
    if (Request.QueryString["name"] != null)
      name = Request.QueryString["name"];
    if (Request.QueryString["NumberShowItem"] != null)
      NumberShowItem = Request.QueryString["NumberShowItem"].ToString();

    if (!IsPostBack)
    {
      tbTitleSearch.Text = name;
      if (NumberShowItem.Length > 0)
      {
        DdlListShowItem.SelectedValue = NumberShowItem;
        DdlListShowItemTop.SelectedValue = NumberShowItem;
      }

      GetGroupsInDdl();
      GetNew("");
    }
  }

  protected string LayThongTinNguoiDuyet(string iid)
  {
    string s = "";
    DataTable dt = Users.GetUsersByUserId(iid);
    if (dt.Rows.Count > 0)
      s = dt.Rows[0][UsersColumns.UserfirstnameColumn] + " " + dt.Rows[0][UsersColumns.UserlastnameColumn];

    return s;
  }

  protected string LinkUpdate(string iid)
  {
    if (!NumberShowItem.Equals("") && !p.Equals(""))
    {
      return LinkAdmin.GoAdminItem(app, TypePage.UpdateItem, iid, NumberShowItem, p);
    }
    else
    {
      return LinkAdmin.GoAdminItem(app, TypePage.UpdateItem, iid);
    }
  }

  protected string LinkCreate()
  {
    string igidUpdate = "";
    if (!ddlCateSearch.SelectedValue.Equals(""))
    {
      igidUpdate = ddlCateSearch.SelectedValue;
    }
    return LinkAdmin.GoAdminCategory(app, TypePage.CreateItem, igidUpdate);
  }

  void GetNew(string order)
  {
    if (!igid.Equals(""))
    {
      ddlCateSearch.SelectedValue = igid;
      condition = GroupsItemsTSql.GetItemsInGroupCondition(ddlCateSearch.SelectedValue, ItemsTSql.GetItemsByViapp(app));
    }
    else
    {
      condition = DataExtension.AndConditon(
          "VGAPP = '" + app + "'",
          GroupsTSql.GetGroupsByVglang(language));
    }

    #region Hiển thị bài đã duyệt theo trạng thái phân quyền
    string userRole = CookieExtension.GetCookies("RolesUser");
    condition += " AND VIURL = '" + userId + "' ";
    if (HorizaMenuConfig.ShowDuyetTin2)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
      {
        #region Với tài khoản cấp 1 (phóng viên, biên tập viên)
        condition += " AND IIENABLE = '" + PhanQuyen.DuyetTin.Cap2 + "' ";
        #endregion
      }
      else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
      {
        #region Với tài khoản cấp 2 (tổng biên tập)
        condition += " AND IIENABLE = '1' ";
        #endregion
      }
    }
    else if (HorizaMenuConfig.ShowDuyetTin1)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
      {
        #region Với tài khoản cấp 1 (phóng viên, biên tập viên)
        condition += " AND IIENABLE = '1' ";
        #endregion
      }
    }
    #endregion

    if (tbTitleSearch.Text.Length > 0)
    {
      condition += " AND " + SearchTSql.GetSearchMathedCondition(tbTitleSearch.Text, ItemsColumns.VititleColumn);
    }

    if (order.Length > 0)
      orderBy = order;
    else
    {
      orderBy = CookieExtension.GetCookiesSort(sortCookiesName);
      if (orderBy.Length < 1)
        orderBy = " VISEOMETALANG DESC ";
    }

    DataSet ds = new DataSet();
    ds = GroupsItems.GetAllDataPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
    DataTable dt = new DataTable();
    dt = ds.Tables[1];

    string key = "&name=" + tbTitleSearch.Text;
    LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                  Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
                                                  LinkAdmin.UrlAdmin(app, "QuanLyBaiVietDaDuocDuyet",
                                                               ddlCateSearch.SelectedValue, key,
                                                               NumberShowItem), "currentPS", "otherPS", "firstPS",
                                                  "lastPS", "previewPS", "nextPS");
    LtPaggingTop.Text = LtPagging.Text;
    rp_mn_users.DataSource = ds.Tables[0];
    rp_mn_users.DataBind();
  }

  void GetGroupsInDdl()
  {
    DataTable dt = new DataTable();
    fields = "*";
    condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVglang(language),
        GroupsTSql.GetGroupsByVgapp(app),
        " IGENABLE <> 2 ");
    orderBy = "";
    dt = Groups.GetAllGroups(fields, condition, orderBy);

    ddlCateSearch.Items.Add(new ListItem("Tất cả danh mục quảng cáo", ""));
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      ddlCateSearch.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
    }
    ddlCateSearch.SelectedValue = igid;
  }

  protected void rp_mn_users_ItemCommand(object source, RepeaterCommandEventArgs e)
  {

  }

  protected void lbtName_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.VititleColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại        
    GetNew(order);
  }

  protected void lbtDate_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.DiCreateDate, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNew(order);
  }
  protected void lbtDate2_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.VISEOMETALANGColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNew(order);
  }

  protected void ltrSearch_Click(object sender, EventArgs e)
  {
    PostSearch();
  }

  protected void DdlListShowItem_SelectedIndexChanged(object sender, EventArgs e)
  {
    PostSearch();
  }

  protected void DdlListShowItemTop_SelectedIndexChanged(object sender, EventArgs e)
  {
    DdlListShowItem.SelectedValue = DdlListShowItemTop.SelectedValue;
    PostSearch();
  }
  void PostSearch()
  {
    string key = "&name=" + tbTitleSearch.Text;
    Response.Redirect(LinkAdmin.GoAdminCategory(app, "QuanLyBaiVietDaDuocDuyet", ddlCateSearch.SelectedValue,
                                                "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
  }
}