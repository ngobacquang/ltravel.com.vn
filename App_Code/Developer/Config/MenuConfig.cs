using TatThanhJsc.MenuModul;

/// <summary>
/// Lưu các cấu hình cho modul menu
/// </summary>
public class MenuConfig
{
  #region Các menu
  private string[] values;
  private string[] text;
  #endregion

  #region Các modul để liệt kê khi tạo menu và chọn modul có sẵn
  private string[] valuesModul;
  private string[] textModul;
  private string[] appsModul;
  #endregion

  public MenuConfig()
  {
    #region Các menu

    text = new string[]
    {
      "menu chính"
      //, "menu đầu trang"
      //, "menu khác"
      , "menu cuối trang"
    };
    values = new string[]
    {
      CodeApplications.MenuMain
      //, CodeApplications.MenuTop
      //, CodeApplications.MenuOther
      , CodeApplications.MenuBottom
    };
    #endregion

    #region Các modul để liệt kê khi tạo menu và chọn modul có sẵn

    textModul = new string[]
    {
      "Chọn modul",
      "Home",
      "Giới thiệu", // AboutUs - gioi-thieu
      "Tour", // Tour - tour
      "Dịch vụ", // Service - dich-vu
      "Khách sạn", // Hotel - khach-san
      "Ý kiến khách hàng", // CustomerReviews - y-kien-khach-hang
      "Liên hệ" // ContactUs - lien-he
    };
    valuesModul = new string[]
    {
      "",//"Chọn modul",
      "/",//"Home",            
      "?go=" + RewriteExtension.AboutUs, // "Giới thiệu", // AboutUs - gioi-thieu
      "?go=" + RewriteExtension.Tour, // "Tour", // Tour - tour
      "?go=" + RewriteExtension.Service, // "Dịch vụ", // Service - dich-vu
      "?go=" + RewriteExtension.Hotel, // "Khách sạn", // Hotel - khach-san
      "?go=" + RewriteExtension.CustomerReviews, // "Cảm nhận khách hàng", // CustomerReviews - cam-nhan-khach-hang
      "?go=" + RewriteExtension.ContactUs // "Liên hệ" // - ContactUs - lien-he
    };
    appsModul = new string[]
    {
      "", // "Chọn modul",
      "", // "Home",
      TatThanhJsc.AboutUsModul.CodeApplications.AboutUs,
      TatThanhJsc.TourModul.CodeApplications.Tour,
      TatThanhJsc.ServiceModul.CodeApplications.Service,
      TatThanhJsc.HotelModul.CodeApplications.Hotel,
      TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews,
      "", // "Liên hệ", // - ContactUs - lien-he
    };
    #endregion
  }

  #region Các menu
  /// <summary>
  /// Danh sách tên của menu, vd: menu chính, menu trên...
  /// </summary>
  public string[] Text
  {
    get { return text; }
  }

  /// <summary>
  /// Danh sách tên của app, vd: CodeApplications.MenuMain, CodeApplications.MenuTop...
  /// </summary>
  public string[] Values
  {
    get { return values; }
  }
  #endregion

  #region Các modul để liệt kê khi tạo menu và chọn modul có sẵn
  /// <summary>
  /// Danh sách tên của modul, vd: Tin tức, Sản phẩm...
  /// </summary>
  public string[] TextModul
  {
    get { return textModul; }
  }

  /// <summary>
  /// Danh sách tên của modul, vd: "?go="+RewriteExtension.Product, "?go="+RewriteExtension.News...
  /// </summary>
  public string[] ValuesModul
  {
    get { return valuesModul; }
  }

  /// <summary>
  /// Danh sách app của modul, vd: CodeApplication.Product, CodeApplication.News...
  /// </summary>
  public string[] AppsModul
  {
    get { return appsModul; }
  }
  #endregion
}