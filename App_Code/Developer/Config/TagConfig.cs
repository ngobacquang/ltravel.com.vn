
/// <summary>
/// Lưu các cấu hình cho modul Tag
/// </summary>
public class TagConfig
{
  #region Cấu hình ẩn/hiện các tag cho các modul
  public const bool KeyHienThiTagChoCustomer = false;
  public const bool KeyHienThiTagChoDeal = false;
  public const bool KeyHienThiTagChoFileLibrary = false;
  public const bool KeyHienThiTagChoHotel = false;
  public const bool KeyHienThiTagChoNew = false;

  public const bool KeyHienThiTagChoPhotoAlbum = false;
  public const bool KeyHienThiTagChoPhotoAlbumMember = false;
  public const bool KeyHienThiTagChoProduct = false;
  public const bool KeyHienThiTagChoQA = false;
  public const bool KeyHienThiTagChoService = false;

  public const bool KeyHienThiTagChoTour = false;
  public const bool KeyHienThiTagChoTrainTicket = false;
  public const bool KeyHienThiTagChoVideo = false;

  public const bool KeyHienThiTagChoFileLibrary2 = false;
  public const bool KeyHienThiTagChoBlog = true;
  #endregion

  #region Các Modul
  private string[] values;
  private string[] text;
  #endregion

  public TagConfig()
  {
    #region Các modul

    text = new string[]
    {
            "Tất cả các modul"
            , "Destination"
            , "Travel styles"
            , "Cruises"
            , "Hotels"
            , "Customer reviews"
            , "News"
            , "Video"
            , "Blog"
            , "Deal"
    };
    values = new string[]
    {
            "",
            TatThanhJsc.DestinationModul.CodeApplications.Destination,
            TatThanhJsc.TourModul.CodeApplications.Tour,
            TatThanhJsc.CruisesModul.CodeApplications.Cruises,
            TatThanhJsc.HotelModul.CodeApplications.Hotel,
            TatThanhJsc.CustomerModul.CodeApplications.Customer,
            TatThanhJsc.NewsModul.CodeApplications.News,
            TatThanhJsc.VideoModul.CodeApplications.Video,
            TatThanhJsc.BlogModul.CodeApplications.Blog,
            TatThanhJsc.DealModul.CodeApplications.Deal
        };

    #endregion
  }

  #region Các Modul
  /// <summary>
  /// Danh sách tên của modul, vd: Tinh tức, Sản phẩm...
  /// </summary>
  public string[] Text
  {
    get { return text; }
  }

  /// <summary>
  /// Danh sách tên của modul, vd: TatThanhJsc.ProductModul.CodeApplications.Product...
  /// </summary>
  public string[] Values
  {
    get { return values; }
  }
  #endregion

}