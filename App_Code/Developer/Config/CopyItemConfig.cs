/// <summary>
/// Lưu các cấu hình cho modul CopyItem
/// </summary>
public class CopyItemConfig
{
  #region Cấu hình ẩn/hiện copy tin cho các modul
  public const bool KeyHienThiCopyChoCustomer = true;
  public const bool KeyHienThiCopyChoDeal = true;
  public const bool KeyHienThiCopyChoFileLibrary = true;
  public const bool KeyHienThiCopyChoHotel = true;
  public const bool KeyHienThiCopyChoNew = true;

  public const bool KeyHienThiCopyChoPhotoAlbum = true;
  public const bool KeyHienThiCopyChoPhotoAlbumMember = true;
  public const bool KeyHienThiCopyChoProduct = true;
  public const bool KeyHienThiCopyChoQA = true;
  public const bool KeyHienThiCopyChoService = true;

  public const bool KeyHienThiCopyChoTour = true;
  public const bool KeyHienThiCopyChoTrainTicket = true;
  public const bool KeyHienThiCopyChoVideo = true;

  public const bool KeyHienThiCopyChoFileLibrary2 = true;
  #endregion

  #region Danh sách website nguồn: chỉ lấy các web trong cùng hệ thống. Dự kiến phát triển sẽ lấy tự động từ modul website
  private string[] valuesListWeb;
  private string[] textListWeb;
  #endregion

  #region Các Modul
  private string[] valuesModul;
  private string[] textModul;
  #endregion

  public CopyItemConfig()
  {
    #region Danh sách web nguồn
    textListWeb = new string[]//(Tên để hiển thị và chuyển quản trị)
                 {
                         "Web hiện tại",
                         "riversilkcity.com.vn",
                         "sunnygardencity.com.vn"
                 };

    valuesListWeb = new string[]//(mã theo trường web trong db)
                 {
                         "",
                         "riversilkcity.com.vn",
                         "sunnygardencity.com.vn"
                 };
    #endregion

    #region Các modul
    textModul = new string[]
               {
                         Developer.ProductKeyword.Product
                         ,Developer.DealKeyword.Deal
                         ,Developer.NewKeyword.New
                         ,Developer.TourKeyword.Tour
                         ,Developer.HotelKeyword.Hotel
                         ,Developer.TrainTicketKeyword.TrainTicket
                         ,Developer.ServiceKeyword.Service
                         ,Developer.FileLibraryKeyword.FileLibrary
                         ,Developer.CustomerKeyword.Customer
                         ,Developer.VideoKeyword.Video
                         ,Developer.PhotoAlbumKeyword.PhotoAlbum
                         ,Developer.QAKeyword.QA
                         ,Developer.FileLibrary2Keyword.FileLibrary2
               };
    valuesModul = new string[]
                 {
                         TatThanhJsc.ProductModul.CodeApplications.Product
                         ,TatThanhJsc.DealModul.CodeApplications.Deal
                         ,TatThanhJsc.NewsModul.CodeApplications.News
                         ,TatThanhJsc.TourModul.CodeApplications.Tour
                         ,TatThanhJsc.HotelModul.CodeApplications.Hotel
                         ,TatThanhJsc.TrainTicketModul.CodeApplications.TrainTicket
                         ,TatThanhJsc.ServiceModul.CodeApplications.Service
                         ,TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary
                         ,TatThanhJsc.CustomerModul.CodeApplications.Customer
                         ,TatThanhJsc.VideoModul.CodeApplications.Video
                         ,TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum
                         ,TatThanhJsc.QAModul.CodeApplications.QA
                         ,TatThanhJsc.FileLibrary2Modul.CodeApplications.FileLibrary2
                 };
    #endregion
  }

  #region Các Modul
  /// <summary>
  /// Danh sách tên của modul, vd: Tinh tức, Sản phẩm...
  /// </summary>
  public string[] TextModul
  {
    get { return textModul; }
  }

  /// <summary>
  /// Danh sách tên của modul, vd: TatThanhJsc.ProductModul.CodeApplications.Product...
  /// </summary>
  public string[] ValuesModul
  {
    get { return valuesModul; }
  }
  #endregion

  #region Danh sách website
  /// <summary>
  /// Danh sách mã web để lấy dữ liệu (mã theo trường web trong db)
  /// </summary>
  public string[] ValuesListWebsite
  {
    get { return valuesListWeb; }
  }

  /// <summary>
  /// Danh sách tên web để lấy dữ liệu (Tên để hiển thị và chuyển quản trị)
  /// </summary>
  public string[] TextListWebsite
  {
    get { return textListWeb; }
  }
  #endregion
}