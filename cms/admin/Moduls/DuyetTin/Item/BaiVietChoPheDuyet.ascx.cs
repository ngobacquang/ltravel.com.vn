using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_DuyetTin_Item_BaiVietChoPheDuyet : System.Web.UI.UserControl
{
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string sortCookiesName = " DCREATEDATE desc ";

  private string modul = "";
  private string p = "1";
  private string NumberShowItem = "10";
  private string DateFrom = "";
  private string DateTo = "";
  private string title = "";
  private string user = "";

  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";

  protected string status = "";
  protected string userId = CookieExtension.GetCookies("UserId");

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["modul"] != null)
      modul = Request.QueryString["modul"];
    if (Request.QueryString["p"] != null)
      p = Request.QueryString["p"];
    if (Request.QueryString["NumberShowItem"] != null)
      NumberShowItem = Request.QueryString["NumberShowItem"].ToString();
    if (Request.QueryString["DateFrom"] != null)
      DateFrom = Request.QueryString["DateFrom"];
    if (Request.QueryString["DateTo"] != null)
      DateTo = Request.QueryString["DateTo"];
    if (Request.QueryString["title"] != null)
      title = Request.QueryString["title"];
    if (Request.QueryString["user"] != null)
      user = Request.QueryString["user"];

    if (!IsPostBack)
    {
      if (NumberShowItem.Length > 0)
      {
        DdlListShowItem.SelectedValue = NumberShowItem;
        DdlListShowItemTop.SelectedValue = NumberShowItem;
      }

      GetNew("");
    }
  }

  protected string LayInfoNguoiDang(string iid)
  {
    string s = "";
    DataTable dt = new DataTable();
    dt = Users.GetUsersByUserId(iid);

    if (dt.Rows.Count > 0)
      s = dt.Rows[0]["UserFirstName"].ToString() + " " + dt.Rows[0]["UserLastName"].ToString();

    return s;
  }

  void GetNew(string order)
  {
    if (!modul.Equals(""))
    {
      condition = DataExtension.AndConditon(
          "VGAPP = '" + modul + "'",
          GroupsTSql.GetGroupsByVglang(language));
    }
    else
    {
      condition = DataExtension.AndConditon(
      DataExtension.OrConditon(
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.AboutUsModul.CodeApplications.AboutUs),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.AdvertisingModul.CodeApplications.Advertising),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ProductModul.CodeApplications.Product),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.DealModul.CodeApplications.Deal),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ServiceModul.CodeApplications.Service),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.NewsModul.CodeApplications.News),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.VideoModul.CodeApplications.Video),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.QAModul.CodeApplications.QA),
      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews)
      ),
      GroupsTSql.GetGroupsByVglang(language));
    }

    #region Hiển thị bài đã duyệt theo trạng thái phân quyền
    string userRole = CookieExtension.GetCookies("RolesUser");
    if (HorizaMenuConfig.ShowDuyetTin2)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
      {
        #region Với tài khoản cấp 2 (trưởng ban biên tập)
        condition += " AND IIENABLE = '" + PhanQuyen.DuyetTin.Cap1 + "' ";
        status = PhanQuyen.DuyetTin.Cap2;
        #endregion
      }
      else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
      {
        #region Với tài khoản cấp 3 (tổng biên tập)
        condition += " AND IIENABLE = '" + PhanQuyen.DuyetTin.Cap2 + "' ";
        status = "0";
        #endregion
      }
    }
    else if (HorizaMenuConfig.ShowDuyetTin1)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
      {
        #region Với tài khoản cấp 3 (tổng biên tập)
        condition += " AND IIENABLE = '" + PhanQuyen.DuyetTin.Cap2 + "' ";
        status = "0";
        #endregion
      }
    }
    #endregion

    if (!title.Equals(""))
    {
      condition += " AND " + SearchTSql.GetSearchMathedCondition(title, ItemsColumns.VititleColumn);
    }

    if (!DateFrom.Equals(""))
    {
      DateTime dFrom = DateTime.ParseExact(DateFrom, "dd/MM/yyyy", null);
      condition += " AND DICREATEDATE >= '" + dFrom.ToString("yyyy-MM-dd HH:mm:ss") + "'";
    }

    if (!DateTo.Equals(""))
    {
      DateTime dTo = DateTime.ParseExact(DateTo, "dd/MM/yyyy", null).AddDays(1);
      condition += " AND DICREATEDATE < '" + dTo.ToString("yyyy-MM-dd HH:mm:ss") + "'";
    }

    if (!user.Equals(""))
    {
      condition += " AND " + SearchTSql.GetSearchMathedCondition(user, ItemsColumns.ViUrl);
    }

    if (order.Length > 0)
      orderBy = order;
    else
    {
      orderBy = CookieExtension.GetCookiesSort(sortCookiesName);
      if (orderBy.Length < 1)
        orderBy = " DCREATEDATE DESC ";
    }

    DataSet ds = new DataSet();
    ds = GroupsItems.GetAllDataPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
    DataTable dt = new DataTable();
    dt = ds.Tables[1];

    string key = "modul=" + modul + "&user=" + user + "&title=" + title + "&DateFrom=" + DateFrom + "&DateTo=" + DateTo + "&NumberShowItem=" + NumberShowItem;
    string linkSearch = UrlExtension.WebisteUrl + "/admin.aspx?uc=DuyetTin&suc=BaiVietChoPheDuyet&" + key;
    LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                  Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
                                                  linkSearch, "currentPS", "otherPS", "firstPS",
                                                  "lastPS", "previewPS", "nextPS");
    LtPaggingTop.Text = LtPagging.Text;
    rp_mn_users.DataSource = ds.Tables[0];
    rp_mn_users.DataBind();
  }

  protected string GetPicByApp(string app)
  {
    string s = "";
    switch (app)
    {
      case TatThanhJsc.AboutUsModul.CodeApplications.AboutUs:
        s = TatThanhJsc.AboutUsModul.FolderPic.AboutUs;
        break;

      case TatThanhJsc.ProductModul.CodeApplications.Product:
        s = TatThanhJsc.ProductModul.FolderPic.Product;
        break;

      case TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary:
        s = TatThanhJsc.FileLibraryModul.FolderPic.FileLibrary;
        break;

      case TatThanhJsc.ServiceModul.CodeApplications.Service:
        s = TatThanhJsc.ServiceModul.FolderPic.Service;
        break;

      case TatThanhJsc.NewsModul.CodeApplications.News:
        s = TatThanhJsc.NewsModul.FolderPic.News;
        break;

      case TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum:
        s = TatThanhJsc.PhotoAlbumModul.FolderPic.PhotoAlbum;
        break;

      case TatThanhJsc.VideoModul.CodeApplications.Video:
        s = TatThanhJsc.VideoModul.FolderPic.Video;
        break;

      case TatThanhJsc.QAModul.CodeApplications.QA:
        s = TatThanhJsc.QAModul.FolderPic.QA;
        break;

      case TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews:
        s = TatThanhJsc.CustomerReviewsModul.FolderPic.CustomerReviews;
        break;
    }
    return s;
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

  /// ////////////////////////////////////////////////////
  protected void lbtDate_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.VISEOMETALANGColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNew(order);
  }

  protected void DdlListShowItem_SelectedIndexChanged(object sender, EventArgs e)
  {
    NumberShowItem = DdlListShowItem.SelectedValue;
    PostSearch();
  }

  protected void DdlListShowItemTop_SelectedIndexChanged(object sender, EventArgs e)
  {
    NumberShowItem = DdlListShowItemTop.SelectedValue;
    PostSearch();
  }
  void PostSearch()
  {
    string key = "modul=" + modul + "&user=" + user + "&title=" + title + "&DateFrom=" + DateFrom + "&DateTo=" + DateTo + "&NumberShowItem=" + NumberShowItem;
    Response.Redirect(UrlExtension.WebisteUrl + "/admin.aspx?uc=DuyetTin&suc=BaiVietChoPheDuyet&p=1&" + key);
  }
}