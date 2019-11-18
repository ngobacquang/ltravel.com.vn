using System;
using System.Data;
using Developer;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class _Default : System.Web.UI.Page
{
  protected string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();

  #region Các querystring
  private string title = "";
  private string go = "";
  private string page = "";
  private string igid = "";
  private string iid = "";

  protected string cRewrite = "";
  #endregion

  #region Các giá trị trong thẻ title, meta keywords, meta description
  private string titleTagContent = "";
  private string metaKewordsTagContent = "";
  private string metaDescriptionTagContent = "";

  private string imageShareSrc = "";
  private string pic = "";
  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {
    #region Các querystring
    if (Request.QueryString["go"] != null)
      go = QueryStringExtension.GetQueryString("go");
    if (Request.QueryString["page"] != null)
      page = QueryStringExtension.GetQueryString("page");
    if (Request.QueryString["igid"] != null)
      igid = QueryStringExtension.GetQueryString("igid");
    if (Request.QueryString["iid"] != null)
      iid = QueryStringExtension.GetQueryString("iid");

    if (Request.QueryString["title"] != null)
      title = QueryStringExtension.GetQueryString("title");
    #endregion

    if (!IsPostBack)
    {
      RewriteExtension.SetRewriteByLanguage(lang);

      GetItemsOrGroupsInfoByTitle();

      if (go.Length < 1 && Session["go"] != null)
        go = Session["go"].ToString();

      GetTitleAndOtherTag();

      GetFavicon();
      GetGoogleAnalyticsCode();

      if (Session["rewrite"] != null)
        cRewrite = Session["rewrite"].ToString();
    }
  }

  #region Các phần tối ưu cho seo
  #region Lấy thông tin theo Items
  /// <summary>
  /// Lấy các thông tin items, groups theo title, ưu tiên tìm items trước groups, dữ liệu sẽ lưu vào Session["dataByTitle"], đồng thời xác định igid hoặc iid và go
  /// </summary>
  void GetItemsOrGroupsInfoByTitle()
  {
    #region Xóa các session cũ
    //Các Session lưu lại các thông tin để ko cần mất công lấy lại lần nữa tại các modul
    //Session["igid"]: igid hiện tại
    //Session["iid"]: iid hiện tại
    //Session["rewrite"]: RewriteExtension. hiện tại, vd: RewriteExtension.Product
    //Session["app"]: modul hiện tại: vd: TatThanhJsc.ProductModul.CodeApplications.Product
    //Session["apptitle"]: Tiêu đề modul hiện tại: vd: "Sản phẩm"
    //Session["vititle"]: vititle hiện tại
    //Session["vilink"]: link seo hiện tại của items
    //Session["dataByTitle"]: lưu dữ liệu tìm thấy theo title để khi vào trang chi tiết không cần lấy lại
    Session["go"] = null;
    Session["igid"] = null; Session["iid"] = null; Session["rewrite"] = null;
    Session["app"] = null; Session["apptitle"] = null; Session["vititle"] = null; Session["vilink"] = null;
    Session["MultipPageContent"] = null;
    Session["dataByTitle"] = null;
    Session["dataByTitle_Cate"] = null;//Lưu danh mục đang chứa items hiện tại
    igid = iid = "";
    #endregion

    if (Request.QueryString["title"] != null)
    {
      #region Kiểm tra trước xem có items theo title này không
      string condition = ItemsTSql.GetItemsByVilang(lang);
      DataTable dt = RewriteExtension.GetItemsByTitle(title, ItemsTSql.GetItemsByIienable("1"));

      if (dt.Rows.Count > 0)
      {
        Session["dataByTitle"] = dt;

        Session["iid"] = dt.Rows[0][ItemsColumns.IidColumn].ToString();
        Session["go"] = GetGoByApp(dt.Rows[0][ItemsColumns.ViappColumn].ToString());

        //Lấy thông tin Groups của Items, có lưu Session["igid"]
        GetGroupsInfoByItemId(dt.Rows[0][ItemsColumns.IidColumn].ToString(), dt.Rows[0][ItemsColumns.ViappColumn].ToString());

        return;//Nếu có items rồi thì không cần kiểm tra groups nữa
      }
      #endregion

      #region Kiểm tra xem có groups theo title này không - chỉ kiểm tra khi không có items

      condition = DataExtension.AndConditon(
          GroupsTSql.GetGroupsByVglang(lang),
          GroupsTSql.GetGroupsByIgenable("1"),
          //CMS mới bỏ phần trang nội dung ở menu nên không tìm theo menu nữa
          GroupsColumns.VgappColumn + "<>'" + TatThanhJsc.MenuModul.CodeApplications.MenuMain + "'",
          GroupsColumns.VgappColumn + "<>'" + TatThanhJsc.MenuModul.CodeApplications.MenuBottom + "'",
          GroupsColumns.VgappColumn + "<>'" + TatThanhJsc.MenuModul.CodeApplications.MenuOther + "'",
          GroupsColumns.VgappColumn + "<>'" + TatThanhJsc.MenuModul.CodeApplications.MenuTop + "'"
          );
      dt = RewriteExtension.GetGroupsByTitle(title, condition);
      if (dt.Rows.Count > 0)
      {
        Session["dataByTitle"] = dt;
        Session["dataByTitle_Cate"] = dt;

        Session["igid"] = dt.Rows[0][GroupsColumns.IgidColumn].ToString();
        Session["go"] = GetGoByApp(dt.Rows[0][GroupsColumns.VgappColumn].ToString());

        #region Phục vụ xử lý trong trang giới thiệu
        if (StringExtension.LayChuoi(dt.Rows[0][GroupsColumns.VgparamsColumn].ToString(), "", 4) == "1")
          Session["MultipPageContent"] = "1"; //Trang giới thiệu đa cấp
        else
          Session["MultipPageContent"] = null;
        #endregion
      }
      #endregion

    }

    //Trường hợp vào trang chủ modul
    if (Session["dataByTitle"] == null)
    {
      Session["go"] = GetAppByGo(Request.QueryString["go"]);
    }
  }

  private void GetGroupsInfoByItemId(string iid, string viapp)
  {
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVgapp(viapp),
        GroupsTSql.GetGroupsByVglang(lang),
        ItemsTSql.GetItemsByIid(iid)
        );
    DataTable dt = GroupsItems.GetAllData("1", "groups.*", condition, "");
    if (dt.Rows.Count > 0)
    {
      Session["dataByTitle_Cate"] = dt;
      Session["igid"] = dt.Rows[0][GroupsColumns.IgidColumn].ToString();
    }

  }

  #region Lấy go, pic theo app
  private string GetGoByApp(string app)
  {
    Session["app"] = app;

    if (app == TatThanhJsc.AboutUsModul.CodeApplications.AboutUs)
    {
      go = RewriteExtension.AboutUs;
      pic = TatThanhJsc.AboutUsModul.FolderPic.AboutUs;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Giới thiệu");
      Session["rewrite"] = RewriteExtension.AboutUs;
    }
    else if (app == TatThanhJsc.ContactModul.CodeApplications.Contact)
    {
      go = RewriteExtension.ContactUs;
      pic = TatThanhJsc.ContactModul.FolderPic.Contact;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Contact us");
      Session["rewrite"] = RewriteExtension.ContactUs;
    }
    else if (app == TatThanhJsc.ContentModul.CodeApplications.Content)
    {
      go = RewriteExtension.Content;
      pic = TatThanhJsc.ContentModul.FolderPic.Content;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Bài viết");
      Session["rewrite"] = RewriteExtension.Content;
    }
    else if (app == TatThanhJsc.CustomerModul.CodeApplications.Customer)
    {
      go = RewriteExtension.Customer;
      pic = TatThanhJsc.CustomerModul.FolderPic.Customer;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Customer");
      Session["rewrite"] = RewriteExtension.Customer;
    }
    else if (app == TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews)
    {
      go = RewriteExtension.CustomerReviews;
      pic = TatThanhJsc.CustomerReviewsModul.FolderPic.CustomerReviews;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Customer Comments");
      Session["rewrite"] = RewriteExtension.CustomerReviews;
    }
    else if (app == TatThanhJsc.CruisesModul.CodeApplications.Cruises)
    {
      go = RewriteExtension.Cruises;
      pic = TatThanhJsc.CruisesModul.FolderPic.Cruises;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Cruises");
      Session["rewrite"] = RewriteExtension.Cruises;
    }
    else if (app == TatThanhJsc.DealModul.CodeApplications.Deal)
    {
      go = RewriteExtension.Deal;
      pic = TatThanhJsc.DealModul.FolderPic.Deal;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Hội thảo du học");
      Session["rewrite"] = RewriteExtension.Deal;
    }
    else if (app == TatThanhJsc.DestinationModul.CodeApplications.Destination)
    {
      go = RewriteExtension.Destination;
      pic = TatThanhJsc.DestinationModul.FolderPic.Destination;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Destination");
      Session["rewrite"] = RewriteExtension.Destination;
    }
    else if (app == TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary)
    {
      go = RewriteExtension.FileLibrary;
      pic = TatThanhJsc.FileLibraryModul.FolderPic.FileLibrary;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Học bổng du học");
      Session["rewrite"] = RewriteExtension.FileLibrary;
    }
    else if (app == TatThanhJsc.FileLibrary2Modul.CodeApplications.FileLibrary2)
    {
      go = RewriteExtension.FileLibrary2;
      pic = TatThanhJsc.FileLibrary2Modul.FolderPic.FileLibrary2;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tài liệu 2");
      Session["rewrite"] = RewriteExtension.FileLibrary2;
    }
    else if (app == TatThanhJsc.ForumModul.CodeApplications.Forum)
    {
      go = RewriteExtension.Forum;
      pic = TatThanhJsc.ForumModul.FolderPic.Forum;

      Session["apptitle"] = "";
      Session["rewrite"] = "";
    }
    else if (app == TatThanhJsc.HotelModul.CodeApplications.Hotel)
    {
      go = RewriteExtension.Hotel;
      pic = TatThanhJsc.HotelModul.FolderPic.Hotel;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Accomodation");
      Session["rewrite"] = RewriteExtension.Hotel;
    }
    else if (app == TatThanhJsc.MenuModul.CodeApplications.MenuMain ||
             app == TatThanhJsc.MenuModul.CodeApplications.MenuBottom ||
             app == TatThanhJsc.MenuModul.CodeApplications.MenuTop ||
             app == TatThanhJsc.MenuModul.CodeApplications.MenuOther)
    {
      go = RewriteExtension.MenuContent;
      pic = TatThanhJsc.MenuModul.FolderPic.Menu;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Menu");
      Session["rewrite"] = RewriteExtension.MenuContent;
    }
    else if (app == TatThanhJsc.NewsModul.CodeApplications.News)
    {
      go = RewriteExtension.News;
      pic = TatThanhJsc.NewsModul.FolderPic.News;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tin tức - sự kiện");
      Session["rewrite"] = RewriteExtension.News;
    }
    else if (app == TatThanhJsc.OtherModul.CodeApplications.PageSingleContent)
    {
      go = RewriteExtension.PageSingleContent;
      pic = TatThanhJsc.OtherModul.FolderPic.PageSingleContent;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Bài viết");
      Session["rewrite"] = RewriteExtension.PageSingleContent;
    }
    else if (app == TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum)
    {
      go = RewriteExtension.PhotoAlbum;
      pic = TatThanhJsc.PhotoAlbumModul.FolderPic.PhotoAlbum;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Thư viện hình ảnh");
      Session["rewrite"] = RewriteExtension.PhotoAlbum;
    }
    else if (app == TatThanhJsc.PhotoAlbumMemberModul.CodeApplications.PhotoAlbumMember)
    {
      go = RewriteExtension.PhotoAlbumMember;
      pic = TatThanhJsc.PhotoAlbumMemberModul.FolderPic.PhotoAlbumMember;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Hình ảnh thành viên");
      Session["rewrite"] = RewriteExtension.PhotoAlbumMember;
    }
    else if (app == TatThanhJsc.ProductModul.CodeApplications.Product)
    {
      go = RewriteExtension.Product;
      pic = TatThanhJsc.ProductModul.FolderPic.Product;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Du học các nước");
      Session["rewrite"] = RewriteExtension.Product;
    }
    else if (app == TatThanhJsc.QAModul.CodeApplications.QA)
    {
      go = RewriteExtension.QA;
      pic = TatThanhJsc.QAModul.FolderPic.QA;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Hỏi đáp - tư vấn");
      Session["rewrite"] = RewriteExtension.QA;
    }
    else if (app == TatThanhJsc.ServiceModul.CodeApplications.Service)
    {
      go = RewriteExtension.Service;
      pic = TatThanhJsc.ServiceModul.FolderPic.Service;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Transport Services");
      Session["rewrite"] = RewriteExtension.Service;
    }
    else if (app == TatThanhJsc.TourModul.CodeApplications.Tour)
    {
      go = RewriteExtension.Tour;
      pic = TatThanhJsc.TourModul.FolderPic.Tour;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tour");
      Session["rewrite"] = RewriteExtension.Tour;
    }
    else if (app == TatThanhJsc.TrainTicketModul.CodeApplications.TrainTicket)
    {
      go = RewriteExtension.TrainTicket;
      pic = TatThanhJsc.TrainTicketModul.FolderPic.TrainTicket;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Vé tàu");
      Session["rewrite"] = RewriteExtension.TrainTicket;
    }
    else if (app == TatThanhJsc.VideoModul.CodeApplications.Video)
    {
      go = RewriteExtension.Video;
      pic = TatThanhJsc.VideoModul.FolderPic.Video;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Thư viện video");
      Session["rewrite"] = RewriteExtension.Video;
    }
    else if (app == TatThanhJsc.WebsiteModul.CodeApplications.Website)
    {
      go = RewriteExtension.Website;
      pic = TatThanhJsc.WebsiteModul.FolderPic.Website;

      Session["apptitle"] = WebsiteKeyword.Website1;
      Session["rewrite"] = RewriteExtension.Website;
    }
    else if (app == RewriteExtension.Search)
    {
      go = RewriteExtension.Search;
      pic = "";

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tìm kiếm");
      Session["rewrite"] = RewriteExtension.Search;
    }

    return go;
  }

  private string GetAppByGo(string go)
  {
    if (go == RewriteExtension.AboutUs)
    {
      pic = TatThanhJsc.AboutUsModul.FolderPic.AboutUs;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Giới thiệu");
      Session["rewrite"] = RewriteExtension.AboutUs;
      Session["app"] = TatThanhJsc.AboutUsModul.CodeApplications.AboutUs;
    }
    else
    if (go == RewriteExtension.ContactUs)
    {
      pic = TatThanhJsc.ContactModul.FolderPic.Contact;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Contact us");
      Session["rewrite"] = RewriteExtension.ContactUs;
      Session["app"] = TatThanhJsc.ContactModul.CodeApplications.Contact;
    }
    else
    if (go == RewriteExtension.Content)
    {
      pic = TatThanhJsc.ContentModul.FolderPic.Content;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Bài viết");
      Session["rewrite"] = RewriteExtension.Content;
      Session["app"] = TatThanhJsc.ContentModul.CodeApplications.Content;
    }
    else
    if (go == RewriteExtension.Customer)
    {
      pic = TatThanhJsc.CustomerModul.FolderPic.Customer;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Customer");
      Session["rewrite"] = RewriteExtension.Customer;
      Session["app"] = TatThanhJsc.CustomerModul.CodeApplications.Customer;
    }
    else
    if (go == RewriteExtension.CustomerReviews)
    {
      pic = TatThanhJsc.CustomerReviewsModul.FolderPic.CustomerReviews;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Customer Comments");
      Session["rewrite"] = RewriteExtension.CustomerReviews;
      Session["app"] = TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews;
    }
    else
    if (go == RewriteExtension.Cruises)
    {
      pic = TatThanhJsc.CruisesModul.FolderPic.Cruises;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Cruises");
      Session["rewrite"] = RewriteExtension.Cruises;
      Session["app"] = TatThanhJsc.CruisesModul.CodeApplications.Cruises;
    }
    else
    if (go == RewriteExtension.Deal)
    {
      pic = TatThanhJsc.DealModul.FolderPic.Deal;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Hội thảo du học");
      Session["rewrite"] = RewriteExtension.Deal;
      Session["app"] = TatThanhJsc.DealModul.CodeApplications.Deal;
    }
    else
    if (go == RewriteExtension.Destination)
    {
      pic = TatThanhJsc.DestinationModul.FolderPic.Destination;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Destination");
      Session["rewrite"] = RewriteExtension.Destination;
      Session["app"] = TatThanhJsc.DestinationModul.CodeApplications.Destination;
    }
    else
    if (go == RewriteExtension.FileLibrary)
    {
      pic = TatThanhJsc.FileLibraryModul.FolderPic.FileLibrary;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Học bổng du học");
      Session["rewrite"] = RewriteExtension.FileLibrary;
      Session["app"] = TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary;
    }
    else
    if (go == RewriteExtension.FileLibrary2)
    {
      pic = TatThanhJsc.FileLibrary2Modul.FolderPic.FileLibrary2;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tài liệu 2");
      Session["rewrite"] = RewriteExtension.FileLibrary2;
      Session["app"] = TatThanhJsc.FileLibrary2Modul.CodeApplications.FileLibrary2;
    }
    else
    if (go == RewriteExtension.Forum)
    {
      pic = TatThanhJsc.ForumModul.FolderPic.Forum;

      Session["apptitle"] = "";
      Session["rewrite"] = "";
      Session["app"] = "";
    }
    else
    if (go == RewriteExtension.Hotel)
    {
      pic = TatThanhJsc.HotelModul.FolderPic.Hotel;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Accomodation");
      Session["rewrite"] = RewriteExtension.Hotel;
      Session["app"] = TatThanhJsc.HotelModul.CodeApplications.Hotel;
    }
    else
    if (go == RewriteExtension.News)
    {
      pic = TatThanhJsc.NewsModul.FolderPic.News;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tin tức - sự kiện");
      Session["rewrite"] = RewriteExtension.News;
      Session["app"] = TatThanhJsc.NewsModul.CodeApplications.News;
    }
    else
    if (go == RewriteExtension.PhotoAlbum)
    {
      pic = TatThanhJsc.PhotoAlbumModul.FolderPic.PhotoAlbum;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Thư viện hình ảnh");
      Session["rewrite"] = RewriteExtension.PhotoAlbum;
      Session["app"] = TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum;
    }
    else
    if (go == RewriteExtension.PhotoAlbumMember)
    {
      pic = TatThanhJsc.PhotoAlbumMemberModul.FolderPic.PhotoAlbumMember;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Hình ảnh thành viên");
      Session["rewrite"] = RewriteExtension.PhotoAlbumMember;
      Session["app"] = TatThanhJsc.PhotoAlbumMemberModul.CodeApplications.PhotoAlbumMember;
    }
    else
    if (go == RewriteExtension.Product)
    {
      pic = TatThanhJsc.ProductModul.FolderPic.Product;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Du học các nước");
      Session["rewrite"] = RewriteExtension.Product;
      Session["app"] = TatThanhJsc.ProductModul.CodeApplications.Product;
    }
    else
    if (go == RewriteExtension.QA)
    {
      pic = TatThanhJsc.QAModul.FolderPic.QA;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Hỏi đáp - tư vấn");
      Session["rewrite"] = RewriteExtension.QA;
      Session["app"] = TatThanhJsc.QAModul.CodeApplications.QA;
    }
    else
    if (go == RewriteExtension.Service)
    {
      pic = TatThanhJsc.ServiceModul.FolderPic.Service;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Transport Services");
      Session["rewrite"] = RewriteExtension.Service;
      Session["app"] = TatThanhJsc.ServiceModul.CodeApplications.Service;
    }
    else
    if (go == RewriteExtension.Tour)
    {
      pic = TatThanhJsc.TourModul.FolderPic.Tour;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tour");
      Session["rewrite"] = RewriteExtension.Tour;
      Session["app"] = TatThanhJsc.TourModul.CodeApplications.Tour;
    }
    else
    if (go == RewriteExtension.TrainTicket)
    {
      pic = TatThanhJsc.TrainTicketModul.FolderPic.TrainTicket;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Vé tàu");
      Session["rewrite"] = RewriteExtension.TrainTicket;
      Session["app"] = TatThanhJsc.TrainTicketModul.CodeApplications.TrainTicket;
    }
    else
    if (go == RewriteExtension.Video)
    {
      pic = TatThanhJsc.VideoModul.FolderPic.Video;

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Thư viện video");
      Session["rewrite"] = RewriteExtension.Video;
      Session["app"] = TatThanhJsc.VideoModul.CodeApplications.Video;
    }
    else
    if (go == RewriteExtension.Website)
    {
      pic = TatThanhJsc.WebsiteModul.FolderPic.Website;

      Session["apptitle"] = WebsiteKeyword.Website1;
      Session["rewrite"] = RewriteExtension.Website;
      Session["app"] = TatThanhJsc.WebsiteModul.CodeApplications.Website;
    }
    else
    if (go == RewriteExtension.Search)
    {
      pic = "";

      Session["apptitle"] = LanguageItemExtension.GetnLanguageItemTitleByName("Tìm kiếm");
      Session["rewrite"] = RewriteExtension.Search;
      Session["app"] = RewriteExtension.Search;
    }

    return go;
  }

  #endregion
  #endregion

  #region Gán giá trị cho thẻ title, các thẻ meta keywords, meta description
  /// <summary>
  /// Gán giá trị cho thẻ title, các thẻ meta keywords, meta description
  /// </summary>
  void GetTitleAndOtherTag()
  {
    #region Có groups hoặc items
    if (Session["dataByTitle"] != null)
    {
      DataTable dt = (DataTable)Session["dataByTitle"];

      if (dt.Columns[0].ColumnName == ItemsColumns.IidColumn)//Có items
      {
        #region titleTagContent
        titleTagContent = dt.Rows[0][ItemsColumns.VISEOTITLEColumn].ToString().Replace("\"", "");
        if (titleTagContent == "")
          titleTagContent = dt.Rows[0][ItemsColumns.VititleColumn].ToString().Replace("\"", "");
        #endregion
        #region metaKeywordsTagContent
        metaKewordsTagContent = dt.Rows[0][ItemsColumns.VISEOMETAKEYColumn].ToString().Replace("\"", "");
        if (metaKewordsTagContent == "")
          metaKewordsTagContent = dt.Rows[0][ItemsColumns.VititleColumn].ToString().Replace("\"", "");
        #endregion
        #region metaDescriptionTagContent
        metaDescriptionTagContent = dt.Rows[0][ItemsColumns.VISEOMETADESCColumn].ToString().Replace("\"", "");
        if (metaDescriptionTagContent == "")
          metaDescriptionTagContent = dt.Rows[0][ItemsColumns.VidescColumn].ToString().Replace("\"", "");
        #endregion

        #region imageShareSrc
        imageShareSrc = GetImageShareSrc(dt.Rows[0][ItemsColumns.ViimageColumn].ToString(),
            dt.Rows[0][ItemsColumns.VicontentColumn].ToString());
        #endregion
      }
      else//Có groups
      {
        #region titleTagContent
        titleTagContent = dt.Rows[0][GroupsColumns.VGSEOTITLEColumn].ToString().Replace("\"", "");
        if (titleTagContent == "")
          titleTagContent = dt.Rows[0][GroupsColumns.VgnameColumn].ToString().Replace("\"", "");
        #endregion
        #region metaKeywordsTagContent
        metaKewordsTagContent = dt.Rows[0][GroupsColumns.VGSEOMETAKEYColumn].ToString().Replace("\"", "");
        if (metaKewordsTagContent == "")
          metaKewordsTagContent = dt.Rows[0][GroupsColumns.VgnameColumn].ToString().Replace("\"", "");
        #endregion
        #region metaDescriptionTagContent
        metaDescriptionTagContent = dt.Rows[0][GroupsColumns.VGSEOMETADESCColumn].ToString().Replace("\"", "");
        if (metaDescriptionTagContent == "")
          metaDescriptionTagContent = dt.Rows[0][GroupsColumns.VgdescColumn].ToString().Replace("\"", "");
        #endregion

        #region imageShareSrc
        imageShareSrc = GetImageShareSrc(dt.Rows[0][GroupsColumns.VgimageColumn].ToString(),
            dt.Rows[0][GroupsColumns.VgcontentColumn].ToString());
        #endregion
      }
    }
    #endregion
    #region else - lấy theo modul hoặc trang chủ
    else
    {
      //Lấy theo modul --> tạm lấy trang chủ, sẽ nâng cấp cho mỗi trang chủ modul có phần tối ưu seo

      //Lấy theo trang chủ
      #region titleTagContent
      titleTagContent = SettingsExtension.GetSettingKey(SettingsExtension.KeyTitleWebsite, lang).Replace("\"", "");
      #endregion
      #region metaKeywordsTagContent
      metaKewordsTagContent = SettingsExtension.GetSettingKey(SettingsExtension.KeyKeyWebsite, lang).Replace("\"", "");
      #endregion
      #region metaDescriptionTagContent
      metaDescriptionTagContent = SettingsExtension.GetSettingKey(SettingsExtension.KeyDescMetatagWebsite, lang).Replace("\"", "");
      #endregion

      #region imageShareSrc
      imageShareSrc = UrlExtension.WebisteUrl + TatThanhJsc.SystemWebsiteModul.FolderPic.SystemWebsite + "/" + SettingsExtension.GetSettingKey("LogoShareHomepage", lang);
      #endregion
    }
    #endregion

    #region Gán giá trị ra trang html
    ltrTitle.Text = titleTagContent;
    ltrMetaOther.Text = "\r\n<meta name=\"keywords\" content=\"" + metaKewordsTagContent + "\" />";
    ltrMetaOther.Text += "\r\n<meta name=\"description\" content=\"" + metaDescriptionTagContent + "\" />";
    #endregion

    #region Các thẻ share facebook
    ltrMetaShare.Text = "\r\n<meta property=\"og:title\" content=\"" + titleTagContent + "\" />";
    ltrMetaShare.Text += "\r\n<meta property=\"og:type\" content=\"" + GetContentType() + "\" />";
    ltrMetaShare.Text += "\r\n<meta property=\"og:url\" content=\"" + GetUrl() + "\" />";
    ltrMetaShare.Text += "\r\n<meta property=\"og:image\" content=\"" + imageShareSrc + "\" />";

    ltrMetaShare.Text += "\r\n<meta property=\"og:description\" content=\"" + metaDescriptionTagContent + "\" />";
    #endregion
  }
  #endregion

  #region GoogleAnalytics và các mã có thể gắn vào head
  protected void GetGoogleAnalyticsCode()
  {
    ltrGA.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyKeyGoogleAnalytics, lang);
  }
  #endregion

  #region Favicon
  private void GetFavicon()
  {
    ltrFavicon.Text = "\r\n<link rel=\"Shortcut icon\" href=\"" + UrlExtension.WebisteUrl + TatThanhJsc.SystemWebsiteModul.FolderPic.SystemWebsite + "/" + SettingsExtension.GetSettingKey(SettingsExtension.KeyFavicon, lang) + "\" type=\"image/x-icon\"/>";
  }
  #endregion

  #region Các thẻ meta cho share facebook
  string GetUrl()
  {
    string s = "";

    s = (Request.Url.GetLeftPart(UriPartial.Authority) + Request.RawUrl).ToLower();

    if (s.EndsWith("default.aspx?"))
      s = s.Remove(s.Length - "default.aspx?".Length);
    if (s.EndsWith("default.aspx"))
      s = s.Remove(s.Length - "default.aspx".Length);
    return s;
  }
  string GetContentType()
  {
    string s = "article";
    if (go == "video")
      s = "video.movie";
    return s;
  }

  /// <summary>
  /// Lấy đường dẫn tới ảnh nếu image trống sẽ lấy ảnh đầu tiên trong nội dung
  /// </summary>    
  /// <param name="image"></param>
  /// <param name="content"></param>
  /// <returns></returns>
  private string GetImageShareSrc(string image, string content)
  {
    if (image.Length < 1)
      return ImagesExtension.GetFirstImageInContent(content);
    else
      return UrlExtension.WebisteUrl + pic + "/" + image;
  }
  #endregion
  #endregion
}