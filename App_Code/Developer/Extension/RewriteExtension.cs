using System.Configuration;
using System.Data;
using System.Data.OleDb;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;

/// <summary>
/// Summary description for RewriteExtension
/// </summary>
public class RewriteExtension
{
  #region Các keyword - lưu ý không được để bằng chuỗi rỗng
  public static string Extensions = ".html";
  public static string Homepage = "";

  public static string AboutUs = "";
  public static string Booking = "";
  public static string Blog = "";
  public static string Cart = "";
  public static string ContactUs = "";
  public static string Content = "";
  public static string Cruises = "";
  public static string Customer = "";
  public static string CustomerReviews = "";
  public static string Deal = "";
  public static string Destination = "";
  public static string FileLibrary = "";
  public static string FileLibrary2 = "";
  public static string Forum = "";
  public static string Hotel = "";
  public static string Member = "";
  public static string MenuContent = "";
  public static string New = "";
  public static string News = "";
  public static string PageSingleContent = "";
  public static string PhotoAlbum = "";
  public static string PhotoAlbumMember = "";
  public static string Product = "";
  public static string QA = "";
  public static string Search = "";
  public static string Service = "";
  public static string Tag = "";
  public static string Tour = "";
  public static string TrainTicket = "";
  public static string Video = "";
  public static string Website = "";
  #endregion

  /// <summary>
  /// Đổi giá trị các biến rewrite theo ngôn ngữ hiện tại
  /// </summary>
  /// <param name="lang"></param>
  public static void SetRewriteByLanguage(string lang)
  {
    Homepage = LanguageItemExtension.GetnLanguageItemTitleByName("trang-chu", lang);
    AboutUs = LanguageItemExtension.GetnLanguageItemTitleByName("gioi-thieu", lang);
    Blog = LanguageItemExtension.GetnLanguageItemTitleByName("blog", lang);
    Booking = LanguageItemExtension.GetnLanguageItemTitleByName("booking", lang);
    Cart = LanguageItemExtension.GetnLanguageItemTitleByName("cart", lang);
    ContactUs = LanguageItemExtension.GetnLanguageItemTitleByName("lien-he", lang);
    Content = LanguageItemExtension.GetnLanguageItemTitleByName("content", lang);
    Cruises = LanguageItemExtension.GetnLanguageItemTitleByName("cruises", lang);
    Customer = LanguageItemExtension.GetnLanguageItemTitleByName("customer", lang);
    CustomerReviews = LanguageItemExtension.GetnLanguageItemTitleByName("cam-nhan-khach-hang", lang);
    Deal = LanguageItemExtension.GetnLanguageItemTitleByName("hoi-thao-du-hoc", lang);
    Destination = LanguageItemExtension.GetnLanguageItemTitleByName("destination", lang);
    FileLibrary = LanguageItemExtension.GetnLanguageItemTitleByName("hoc-bong-du-hoc", lang);
    FileLibrary2 = LanguageItemExtension.GetnLanguageItemTitleByName("file-library-2", lang);
    Forum = LanguageItemExtension.GetnLanguageItemTitleByName("forum", lang);
    Hotel = LanguageItemExtension.GetnLanguageItemTitleByName("khach-san", lang);
    Member = LanguageItemExtension.GetnLanguageItemTitleByName("members", lang);
    MenuContent = LanguageItemExtension.GetnLanguageItemTitleByName("gioi-thieu", lang);
    New = LanguageItemExtension.GetnLanguageItemTitleByName("tin-tuc", lang);
    News = LanguageItemExtension.GetnLanguageItemTitleByName("tin-tuc", lang);
    PageSingleContent = LanguageItemExtension.GetnLanguageItemTitleByName("article", lang);
    PhotoAlbum = LanguageItemExtension.GetnLanguageItemTitleByName("hinh-anh", lang);
    PhotoAlbumMember = LanguageItemExtension.GetnLanguageItemTitleByName("photo-member", lang);
    Product = LanguageItemExtension.GetnLanguageItemTitleByName("dia-diem-du-hoc", lang);
    QA = LanguageItemExtension.GetnLanguageItemTitleByName("hoi-dap", lang);
    Search = LanguageItemExtension.GetnLanguageItemTitleByName("search", lang);
    Service = LanguageItemExtension.GetnLanguageItemTitleByName("dich-vu", lang);
    Tag = LanguageItemExtension.GetnLanguageItemTitleByName("tags", lang);
    Tour = LanguageItemExtension.GetnLanguageItemTitleByName("tour", lang);
    TrainTicket = LanguageItemExtension.GetnLanguageItemTitleByName("train-ticket", lang);
    Video = LanguageItemExtension.GetnLanguageItemTitleByName("video", lang);
    Website = LanguageItemExtension.GetnLanguageItemTitleByName("website", lang);
  }

  #region Các phương thức
  public static string GetLinkMenu(string vgdesc)
  {
    string go = MenuExtension.GetQueryString(vgdesc, "go");
    string igid = MenuExtension.GetQueryString(vgdesc, "igid");
    string iid = MenuExtension.GetQueryString(vgdesc, "iid");

    if (iid != "")
      return GetLinkMenuItem(iid);
    else
        if (igid != "")
      return GetLinkMenuCate(igid);
    else if (go != "")
      return GetLinkMenuIndex(go);
    else
      return vgdesc;
  }

  private static string GetLinkMenuIndex(string go)
  {
    return UrlExtension.WebisteUrl + go.ToLower() + RewriteExtension.Extensions;
  }

  private static string GetLinkMenuCate(string igid)
  {
    return UrlExtension.WebisteUrl + GetSeoLinkByIgid(igid) + RewriteExtension.Extensions;
  }

  private static string GetLinkMenuItem(string iid)
  {
    return UrlExtension.WebisteUrl + GetSeoLinkByIid(iid) + RewriteExtension.Extensions;
  }

  #region Get by title
  /// <summary>
  /// Lấy thông tin về Groups theo title
  /// </summary>
  /// <param name="title"></param>
  /// <param name="condition"></param>
  /// <returns></returns>
  public static DataTable GetGroupsByTitle(string title, string condition)
  {
    string web = ConfigurationManager.AppSettings["WebName"];

    OleDbCommand cmd = new OleDbCommand("Groups_GetGroupsByTitle");
    cmd.CommandType = CommandType.StoredProcedure;
    cmd.Parameters.AddWithValue("@title", title);
    cmd.Parameters.AddWithValue("@condition", condition);
    cmd.Parameters.AddWithValue("@web", web);
    return SQLDatabase.GetData(cmd);
  }

  /// <summary>
  /// Lấy thông tin của Items theo title
  /// </summary>
  /// <param name="title"></param>
  /// <param name="condition"></param>
  /// <returns></returns>
  public static DataTable GetItemsByTitle(string title, string condition)
  {
    string web = ConfigurationManager.AppSettings["WebName"];

    OleDbCommand cmd = new OleDbCommand("Items_GetItemsByTitle");
    cmd.CommandType = CommandType.StoredProcedure;
    cmd.Parameters.AddWithValue("@title", title);
    cmd.Parameters.AddWithValue("@condition", condition);
    cmd.Parameters.AddWithValue("@web", web);
    return SQLDatabase.GetData(cmd);
  }
  #endregion

  public static DataTable GetUserByRole(string role)
  {
    string web = ConfigurationManager.AppSettings["WebName"];

    OleDbCommand cmd = new OleDbCommand("GetUserByRoles");
    cmd.CommandType = CommandType.StoredProcedure;
    cmd.Parameters.AddWithValue("@Role", role);
    cmd.Parameters.AddWithValue("@web", web);
    return SQLDatabase.GetData(cmd);
  }

  public static string GetSeoLinkByIid(string iid)
  {
    DataTable dt = Items.GetItems("1", TatThanhJsc.Columns.ItemsColumns.VISEOLINKSEARCHColumn,
        TatThanhJsc.TSql.ItemsTSql.GetById(iid), "");
    if (dt.Rows.Count > 0) return dt.Rows[0][TatThanhJsc.Columns.ItemsColumns.VISEOLINKSEARCHColumn].ToString().ToLower();
    else return "";
  }


  public static string GetSeoLinkByIgid(string igid)
  {
    DataTable dt = Groups.GetGroups("1", TatThanhJsc.Columns.GroupsColumns.VGSEOLINKSEARCHColumn,
        TatThanhJsc.TSql.GroupsTSql.GetById(igid), "");
    if (dt.Rows.Count > 0) return dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VGSEOLINKSEARCHColumn].ToString().ToLower();
    else return "";
  }
  #endregion
}