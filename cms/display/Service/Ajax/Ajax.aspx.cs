﻿using System;
using System.Data;
using System.Web.Script.Serialization;
using TatThanhJsc.Columns;
using TatThanhJsc.ServiceModul;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Service_Ajax_Ajax : System.Web.UI.Page
{
  private JavaScriptSerializer js = new JavaScriptSerializer();

  private string action = "";
  private string app = CodeApplications.Service;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string pic = FolderPic.Service;
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
        case "Inquiry":
          Inquiry();
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

    #region Lấy thông tin
    string name = Request.Params["name"];
    string phone = Request.Params["phone"];
    string email = Request.Params["email"];
    string nationality = Request.Params["nationality"];
    string service = Request.Params["service"];
    string content = Request.Params["content"];

    string thongtinkhac = StringExtension.GhepChuoi("", phone, email, nationality);
    string igid = GetFirstCateId();
    #endregion

    GroupsItems.InsertItemsGroupsItems(lang, "QLDDDV", "", service, "",
      content, "",
      "", name, "", "", "", "", "", "", "", "",
      thongtinkhac,
      "0", "0", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(),
      DateTime.Now.ToString(), "", igid,
      DateTime.Now.ToString(), DateTime.Now.ToString(),
      DateTime.Now.ToString(),
      "", "0");

    #region Gửi email thông báo đến
    string emailhethong = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailWebsite, lang);
    string emailkhac = SettingsExtension.GetSettingKey(SettingsExtension.KeyEmailPhu, lang);
    string[] listemail = emailkhac.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
    string date = DateTime.Now.ToString();
    string subject = LanguageItemExtension.GetnLanguageItemTitleByName("Thông báo từ") + " " + UrlExtension.WebisteUrl + " " + date;
    string body =
    @"
    <div style='font:bold 14px Arial;padding-bottom:15px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Xin chào! Bạn có một đơn đặt dịch vụ từ") + @" " + UrlExtension.WebisteUrl + @"</div>
    <div style='font:bold 12px Arial;padding-bottom:10px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Chi tiết") + @":</div>
    <ul>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Họ tên") + @": " + name + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Điện thoại") + @": " + phone + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Email") + @": " + email + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Quốc tích") + @": " + nationality + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Gửi lúc") + @": " + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Dịch vụ đăng ký") + @": " + service + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Nội dung") + @": " + content + @"</li>
    </ul>";
    EmailExtension.SendEmail(emailhethong, subject, body, listemail);
    #endregion

    string[] strArrayReturn = { s };
    Response.Write(js.Serialize(strArrayReturn));
  }

  private void Inquiry()
  {
    string s = "Success";

    #region Lấy thông tin
    string name = Request.Params["name"];
    string email = Request.Params["email"];
    string content = Request.Params["content"];

    string thongtinkhac = StringExtension.GhepChuoi("", email);
    string igid = GetFirstCateId();
    #endregion

    GroupsItems.InsertItemsGroupsItems(lang, "QLDDKTV", "", "Đăng ký tư vấn dịch vụ", "",
      content, "",
      "", name, "", "", "", "", "", "", "", "",
      thongtinkhac,
      "0", "0", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(),
      DateTime.Now.ToString(), "", igid,
      DateTime.Now.ToString(), DateTime.Now.ToString(),
      DateTime.Now.ToString(),
      "", "0");

    #region Gửi email thông báo đến
    string emailhethong = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailWebsite, lang);
    string emailkhac = SettingsExtension.GetSettingKey(SettingsExtension.KeyEmailPhu, lang);
    string[] listemail = emailkhac.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
    string date = DateTime.Now.ToString();
    string subject = LanguageItemExtension.GetnLanguageItemTitleByName("Thông báo từ") + " " + UrlExtension.WebisteUrl + " " + date;
    string body =
    @"
    <div style='font:bold 14px Arial;padding-bottom:15px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Xin chào! Bạn có một đơn đăng ký tư vấn dịch vụ từ") + @" " + UrlExtension.WebisteUrl + @"</div>
    <div style='font:bold 12px Arial;padding-bottom:10px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Chi tiết") + @":</div>
    <ul>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Họ tên") + @": " + name + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Email") + @": " + email + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Gửi lúc") + @": " + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + @"</li>
    <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Nội dung") + @": " + content + @"</li>
    </ul>";
    EmailExtension.SendEmail(emailhethong, subject, body, listemail);
    #endregion

    string[] strArrayReturn = { s };
    Response.Write(js.Serialize(strArrayReturn));
  }
}