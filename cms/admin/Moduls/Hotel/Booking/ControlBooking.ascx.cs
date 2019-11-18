using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Hotel_Booking_ControlBooking : System.Web.UI.UserControl
{
  protected string app = TatThanhJsc.HotelModul.CodeApplications.HotelBooking;
  protected string appCate = CodeApplications.Hotel;
  protected string pic = FolderPic.Hotel;
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string sortCookiesName = SortKey.SortHotelItems + "Booking";
  private string p = "1";
  private string NumberShowItem = "10";

  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";

  private string iid = "";

  private string name = "";

  private string ArrayId = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["p"] != null)
      p = Request.QueryString["p"];
    if (Request.QueryString["iid"] != null)
      iid = Request.QueryString["iid"];

    if (Request.QueryString["name"] != null)
      name = Request.QueryString["name"];
    if (Request.QueryString["NumberShowItem"] != null)
      NumberShowItem = Request.QueryString["NumberShowItem"];

    if (!IsPostBack)
    {
      tbTitleSearch.Text = name;
      if (NumberShowItem.Length > 0)
      {
        DdlListShowItem.SelectedValue = NumberShowItem;
        DdlListShowItemTop.SelectedValue = NumberShowItem;
      }

      GetParentCate();
      GetBookings("");
    }
  }

  protected string LayThongTinKhachHang(string info)
  {
    string s = "";

    #region Trích thông tin ra theo kiểu QueryString
    //Lấy tất cả parram được post lên từ máy khách
    var myUrl = info;
    myUrl = HttpUtility.HtmlDecode(myUrl);
    //Chuyển về kiểu QueryString
    var values = HttpUtility.ParseQueryString(myUrl);
    //Lấy ra giá trị theo tên QueryString
    //var t = values["ExpiryDate"];
    var temp = "";

    if (values["hoten"] != null)
    {
      temp = values["hoten"];
      if (temp.Length > 0)
        s += "<b>Họ tên:</b> " + temp + "<br/>";
    }

    if (values["email"] != null)
    {
      temp = values["email"];
      if (temp.Length > 0)
        s += "<b>Email:</b> " + temp + "<br/>";
    }

    if (values["phone"] != null)
    {
      temp = values["phone"];
      if (temp.Length > 0)
        s += "<b>Điện thoại:</b> " + temp + "<br/>";
    }

    if (values["address"] != null)
    {
      temp = values["address"];
      if (temp.Length > 0)
        s += "<b>Địa chỉ:</b> " + temp + "<br/>";
    }
    #endregion

    return s;
  }

  protected string LayThongTinHotel_BangDanhSachPhong(string info)
  {
    string s = "";

    #region Trích thông tin ra theo kiểu QueryString
    //Lấy tất cả parram được post lên từ máy khách
    var myUrl = info;
    myUrl = HttpUtility.HtmlDecode(myUrl);
    //Chuyển về kiểu QueryString
    var values = HttpUtility.ParseQueryString(myUrl);
    //Lấy ra giá trị theo tên QueryString
    //var t = values["ExpiryDate"];
    var temp = "";

    if (values["dataRooms"] != null)
    {
      temp = values["dataRooms"];
      if (temp.Length > 0)
      {
        DataTable dt = JsonConvert.DeserializeObject<DataTable>(temp);
        s += HienBangChiTietPhong(dt);
      }
    }
    #endregion

    return s;
  }

  /// <summary>
  /// Hiện ra bảng danh sách loại phòng khách hàng đã chọn
  /// </summary>
  /// <param name="dtLoaiPhong"></param>
  /// <returns></returns>
  private string HienBangChiTietPhong(DataTable dt)
  {
    string s = "";

    s += @"
<table style='width:100%;border-collapse:collapse;border:solid 1px #d6d6d6'>
<tr>
    <th style='padding:5px;border:solid 1px #d6d6d6;font-weight:bold'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Room types") + @"</th>
    <th style='padding:5px;border:solid 1px #d6d6d6;font-weight:bold'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Room rate/r.n") + @"</th>
    <th style='padding:5px;border:solid 1px #d6d6d6;font-weight:bold'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Discount") + @"</th>
    <th style='padding:5px;border:solid 1px #d6d6d6;font-weight:bold'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Nights") + @"</th>
    <th style='padding:5px;border:solid 1px #d6d6d6;font-weight:bold'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Nr.rooms") + @"</th>
</tr>
";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      s += @"
<tr>
    <td style='padding:5px;border:solid 1px #d6d6d6'>" + dt.Rows[i]["name"] + @"</td>
    <td style='padding:5px;border:solid 1px #d6d6d6;text-align:center'>" + PriceExtension.HienThiGia02(dt.Rows[i]["price"].ToString(),
          dt.Rows[i]["saleoffprice"].ToString()) + @"
    </td>
    <td style='padding:5px;border:solid 1px #d6d6d6;text-align:center'>" + TienDuocGiam(double.Parse(dt.Rows[i]["price"].ToString()),
          double.Parse(dt.Rows[i]["saleoffprice"].ToString())) + @"</td>
    <td style='padding:5px;border:solid 1px #d6d6d6;text-align:center'>
        " + dt.Rows[i]["nights"] + @"
    </td>
    <td style='padding:5px;border:solid 1px #d6d6d6;text-align:center'>
        " + dt.Rows[i]["rooms"] + @"
    </td>
</tr>";
    }

    s += "</table>";

    return s;
  }

  private string TienDuocGiam(double giaNY, double giaKM)
  {
    giaNY = giaNY - giaKM;
    if (giaNY <= 0 || giaKM <= 0)
      return "";
    else
      return LanguageItemExtension.GetnLanguageItemTitleByName("$") +
             NumberExtension.FormatNumber(giaNY.ToString(), false, "", "");
  }

  protected string LayThongTinHotel(string info)
  {
    string s = "";

    #region Trích thông tin ra theo kiểu QueryString
    //Lấy tất cả parram được post lên từ máy khách
    var myUrl = info;
    myUrl = HttpUtility.HtmlDecode(myUrl);
    //Chuyển về kiểu QueryString
    var values = HttpUtility.ParseQueryString(myUrl);
    //Lấy ra giá trị theo tên QueryString
    //var t = values["ExpiryDate"];
    var temp = "";

    if (values["adults"] != null)
    {
      temp = values["adults"];
      if (temp.Length > 0)
        s += "<b>Số người lớn:</b> " + temp + "<br/>";
    }

    if (values["children"] != null)
    {
      temp = values["children"];
      if (temp.Length > 0)
        s += "<b>Số trẻ em (6-11 tuổi):</b> " + temp + "<br/>";
    }

    if (values["infants"] != null)
    {
      temp = values["infants"];
      if (temp.Length > 0)
        s += "<b>Số em bé (0-5 tuổi):</b> " + temp + "<br/>";
    }

    if (values["checkin"] != null)
    {
      temp = values["checkin"];
      if (temp.Length > 0)
        s += "<b>check-in:</b> " + temp + "<br/>";
    }

    if (values["checkout"] != null)
    {
      temp = values["checkout"];
      if (temp.Length > 0)
        s += "<b>check-out:</b> " + temp + "<br/>";
    }

    if (values["detail"] != null)
    {
      temp = values["detail"];
      if (temp.Length > 0)
        s += "<b>Yêu cầu khác:</b> <br/>" + temp.Replace("\n", "<br/>") + "<br/>";
    }
    #endregion

    return s;
  }

  protected string GetItemNameById(string iid)
  {
    DataTable dt = Items.GetItems("1", ItemsColumns.VititleColumn, ItemsTSql.GetById(iid), "");
    if (dt.Rows.Count > 0)
      return dt.Rows[0][ItemsColumns.VititleColumn].ToString();
    return "";
  }

  protected string LinkUpdate(string isid)
  {
    if (!NumberShowItem.Equals("") && !p.Equals(""))
    {
      return LinkAdmin.GoAdminItem(CodeApplications.Hotel, "UpdateBooking", isid, NumberShowItem, p);
    }
    else
    {
      return LinkAdmin.GoAdminItem(CodeApplications.Hotel, "UpdateBooking", isid);
    }
  }

  void GetBookings(string order)
  {
    condition = DataExtension.AndConditon(
        ItemsTSql.GetItemsByViapp(app),
        ItemsColumns.IienableColumn + "<>2",
        ItemsTSql.GetItemsByVilang(language)
    );

    if (tbTitleSearch.Text.Length > 0)
    {
      condition += " AND " + SearchTSql.GetSearchMathedCondition(tbTitleSearch.Text, ItemsColumns.VititleColumn, ItemsColumns.ViurlColumn);
    }

    if (order.Length > 0)
      orderBy = order;
    else
    {
      orderBy = CookieExtension.GetCookiesSort(sortCookiesName);
      if (orderBy.Length < 1)
        orderBy = ItemsColumns.DiCreateDate + " desc ";
    }

    DataSet ds = new DataSet();
    ds = TatThanhJsc.Database.Items.GetItemsPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
    DataTable dt = new DataTable();
    dt = ds.Tables[1];

    LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
        Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
        LinkAdmin.UrlAdmin(CodeApplications.Hotel, TypePage.Booking,
            ddlCateSearch.SelectedValue, "",
            NumberShowItem), "currentPS", "otherPS", "firstPS",
        "lastPS", "previewPS", "nextPS");
    LtPaggingTop.Text = LtPagging.Text;
    rp_mn_users.DataSource = ds.Tables[0];
    rp_mn_users.DataBind();
  }

  void GetParentCate()
  {
    DataTable dt = new DataTable();
    fields = "*";
    condition = DataExtension.AndConditon(
        ItemsTSql.GetByLang(language),
        ItemsTSql.GetByApp(appCate),
        " IIENABLE <> 2 ");
    orderBy = ItemsColumns.VititleColumn;
    dt = Items.GetItems("", fields, condition, orderBy);

    ddlCateSearch.Items.Add(new ListItem("Chọn tour cần xem bình luận", ""));
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      ddlCateSearch.Items.Add(new ListItem(dt.Rows[i][ItemsColumns.VititleColumn].ToString(), dt.Rows[i][ItemsColumns.IidColumn].ToString()));
    }
    ddlCateSearch.SelectedValue = iid;
  }

  protected void lbtDate_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.DiCreateDate, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetBookings(order);
  }

  protected void lbtStatus_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.IiEnable, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetBookings(order);
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
    string key = "name=" + tbTitleSearch.Text;
    Response.Redirect(LinkAdmin.GoAdminCategory(CodeApplications.Hotel, TypePage.Booking, ddlCateSearch.SelectedValue,
                                                "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
  }
}