using System;
using System.Data;
using System.Web.Script.Serialization;
using TatThanhJsc.Columns;
using TatThanhJsc.TourModul;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Tour_Ajax_Ajax : System.Web.UI.Page
{
  private JavaScriptSerializer js = new JavaScriptSerializer();

  private string action = "";
  private string app = CodeApplications.Tour;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string pic = FolderPic.Tour;
  protected void Page_Load(object sender, EventArgs e)
  {
    action = Request["action"];
    if (!IsPostBack)
    {
      switch (action)
      {
        case "Booking":
          Booking();
          break;
        case "GetPrice":
          GetPrice();
          break;
      }
    }
  }

  #region Danh sách
  private string GetHotline()
  {
    string s = "";
    string hotlines = SettingsExtension.GetSettingKey(SettingsExtension.KeyHotLine, lang);

    foreach (string hotline in hotlines.Split(new string[] { " - " }, StringSplitOptions.RemoveEmptyEntries))
    {
      s += "<a href='tel:" + hotline + "' title='" + hotline + "' class='dib'>" + hotline + "</a><span> - </span>";
    }

    if (s.EndsWith("<span> - </span>"))
      s = s.Remove(s.Length - "<span> - </span>".Length);

    return s;
  }

  /// <summary>
  /// Gửi liên hệ và trả về thông báo (nếu thông báo trống tức là gửi liên hệ thành công)
  /// </summary>
  /// <returns></returns>
  protected string SendContact(string tbHoTen_dkh, string tbDienThoai_dkh, string tbEmail_dkh, string tbDiaChi_dkh, string noiDung, string firstCateId)
  {
    string check = "";
    try
    {
      string thongtinkhac = StringExtension.GhepChuoi("", tbDienThoai_dkh, tbDiaChi_dkh, "", "");
      GroupsItems.InsertItemsGroupsItems(lang, app, "", "<b>Đơn đăng ký tư vấn dịch vụ</b>", tbEmail_dkh,
                                         noiDung, "",
                                         "", tbHoTen_dkh, "", "", "", "", "", "", "", "",
                                         thongtinkhac,
                                         "0", "0", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(),
                                         DateTime.Now.ToString(), "", firstCateId,
                                         DateTime.Now.ToString(), DateTime.Now.ToString(),
                                         DateTime.Now.ToString(),
                                         "", "0");
    }
    catch
    {
      check = LanguageItemExtension.GetnLanguageItemTitleByName("Có lỗi xảy ra, vui lòng thử lại sau!");
    }
    return check;
  }

  private string GetFirstCateId()
  {
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVglang(lang)
        );
    string order = GroupsColumns.IgorderColumn;

    DataTable dt = Groups.GetGroups("1", "*", condition, order);

    if (dt.Rows.Count > 0)
      return dt.Rows[0][GroupsColumns.IgId].ToString();

    return "0";
  }

  private string LayEmailPhongBan(string igid)
  {
    string s = "";
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByIgid(igid),
        GroupsTSql.GetGroupsByVgapp(app)
        );
    DataTable dt = new DataTable();
    dt = Groups.GetGroups("1", GroupsColumns.VgcontentColumn, condition, "");
    if (dt.Rows.Count > 0)
      s = StringExtension.LayChuoi(dt.Rows[0][GroupsColumns.VgcontentColumn].ToString(), "", 4);
    return s;
  }
  #endregion

  private void Booking()
  {
    string s = "Success";

    string iid = StringExtension.RemoveSqlInjectionChars(Request.Form["iid"]);
    string name = StringExtension.RemoveSqlInjectionChars(Request.Form["name"]);
    string phone = StringExtension.RemoveSqlInjectionChars(Request.Form["phone"]);
    string email = StringExtension.RemoveSqlInjectionChars(Request.Form["email"]);
    string nationality = StringExtension.RemoveSqlInjectionChars(Request.Form["nationality"]);
    string departureTime = StringExtension.RemoveSqlInjectionChars(Request.Form["departureTime"]);
    string totalPrice = StringExtension.RemoveSqlInjectionChars(Request.Form["totalPrice"]);
    string trip = StringExtension.RemoveSqlInjectionChars(Request.Form["trip"]);
    string content = StringExtension.RemoveSqlInjectionChars(Request.Form["content"]);
    string nguoilon = StringExtension.RemoveSqlInjectionChars(Request.Form["nguoilon"]);
    string trevithanhnien = StringExtension.RemoveSqlInjectionChars(Request.Form["trevithanhnien"]);
    string treem = StringExtension.RemoveSqlInjectionChars(Request.Form["treem"]);
    string embe = StringExtension.RemoveSqlInjectionChars(Request.Form["embe"]);

    if (totalPrice != LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ"))
      totalPrice = totalPrice + " " + LanguageItemExtension.GetnLanguageItemTitleByName("VND");

    string detail = @"
    <div>" + LanguageItemExtension.GetnLanguageItemTitleByName("Thông tin tour:") + @"</div>
    <ul>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Tên Tour") + ": <b>" + trip + @"</b></li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Ngày khởi hành") + ": <b>" + departureTime + @"</b></li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng người lớn") + ": <b>" + nguoilon + @"</b></li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng trẻ em từ 8 - 11 tuổi") + ": <b>" + trevithanhnien + @"</b></li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng trẻ em từ 3 - 7 tuổi") + ": <b>" + treem + @"</b></li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng trẻ em nhỏ hơn 3 tuổi") + ": <b>" + embe + @"</b></li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Tổng giá tiền") + ": <b style='color:#e90d0d'>" + totalPrice + @"</b></li>
    </ul>
    <div>" + LanguageItemExtension.GetnLanguageItemTitleByName("Thông tin người đặt:") + @"</div>
    <ul>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Họ tên") + ": " + name + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Điện thoại") + ": " + phone + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Email") + ": " + email + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Quốc tịch") + ": " + nationality + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Ghi chú") + ": " + content + @"</li>
    </ul>";

    Subitems.InsertSubitems(iid, lang, CodeApplications.TourBooking, "Đơn đặt tour", detail, "", "", "", "", DateTime.Now.ToString(),
    DateTime.Now.ToString(), DateTime.Now.ToString(), "0", "");

    #region Gửi email thông báo đến email hệ thống 
    string emailhethong = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailWebsite, lang);
    string emailkhac = SettingsExtension.GetSettingKey(SettingsExtension.KeyEmailPhu, lang);
    string[] listemail = emailkhac.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
    string date = DateTime.Now.ToString();
    string subject = LanguageItemExtension.GetnLanguageItemTitleByName("Thông báo đặt tour từ") + " " + UrlExtension.WebisteUrl + " " + date;
    string body = @"
    <div style='font:bold 14px Arial;padding-bottom:15px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Xin chào! Bạn có một đơn đăng ký đặt tour tại") + " " + TatThanhJsc.Extension.UrlExtension.WebisteUrl + @"</div>
    <div style='font:bold 12px Arial;padding-bottom:10px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Thông tin chi tiết") + @":</div>
    " + detail + @"";

    EmailExtension.SendEmail(emailhethong, subject, body, listemail);
    #endregion

    string[] strArrayReturn = { s };
    Response.Write(js.Serialize(strArrayReturn));
  }

  private void GetPrice()
  {
    string s = "Success";
    string iid = Request.Params["iid"];

    string ToTalPrice = "";
    string ToTalPriceOrigin = "";

    string GiaNguoiLon = "";
    string GiaTreViThanhNien = "";
    string GiaTreEm = "";
    string GiaEmBe = "";

    DataTable dt = GroupsItems.GetAllData("1", "*", ItemsTSql.GetById(iid), ItemsColumns.IiorderColumn + " desc ");

    if (dt.Rows.Count > 0)
    {
      ToTalPriceOrigin = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString() == "0" ? dt.Rows[0][ItemsColumns.FipriceColumn].ToString() == "0" ? LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ") : dt.Rows[0][ItemsColumns.FipriceColumn].ToString() : dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString();

      if (ToTalPriceOrigin != LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ"))
        ToTalPrice = NumberExtension.FormatNumber(ToTalPriceOrigin);
      else
        ToTalPrice = LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ");

      GiaNguoiLon = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 1);
      GiaTreViThanhNien = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 2);
      GiaTreEm = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 3);
      GiaEmBe = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 4);
    }

    string[] strArrayReturn = { s, ToTalPriceOrigin, ToTalPrice, GiaNguoiLon, GiaTreViThanhNien, GiaTreEm, GiaEmBe };
    Response.Write(js.Serialize(strArrayReturn));
  }
}