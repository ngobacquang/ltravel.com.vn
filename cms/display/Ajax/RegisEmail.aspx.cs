using System;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.LanguageModul;
using TatThanhJsc.TSql;
using CodeApplications = TatThanhJsc.MemberModul.CodeApplications;

public partial class cms_display_Ajax_RegisEmail : System.Web.UI.Page
{
  private readonly JavaScriptSerializer js = new JavaScriptSerializer();

  private readonly string lang = Cookie.GetLanguageValueDisplay();

  protected void Page_Load(object sender, EventArgs e)
  {
    InserContactUs();
  }

  private void InserContactUs()
  {
    var email = Request.Params["email"];
    var trangThai = "1";

    #region Thêm tài khoản

    //Thêm tài khoản
    Members.InsertMembers(
      CodeApplications.MemberNewsletter, email, "", "", "", "", email, DateTime.Now.ToString(), "", "", "",
      "", "", "", "", "", trangThai, "", "", "", "", "", "", "");

    #endregion

    #region Gửi email thông báo đến email hệ thống

    var emailhethong = SettingsExtension.GetSettingKey(SettingsExtension.KeyMailWebsite, lang);
    var emailkhac = email + "," + SettingsExtension.GetSettingKey("MailBanTin", lang);
    var listemail = emailkhac.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries);
    var date = DateTime.Now.ToString();
    var subject = LanguageItemExtension.GetnLanguageItemTitleByName("Thông báo từ") + " " + UrlExtension.WebisteUrl + " " + date;
    var body = @"
    <div style='font:bold 14px Arial;padding-bottom:15px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Xin chào! Bạn có đăng ký nhận thông tin từ") + " " + UrlExtension.WebisteUrl + @"</div>
    <div style='font:bold 12px Arial;padding-bottom:10px'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Chi tiết") + @":</div>
    <ul>
      <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Email") + @": " + email + @"</li>
      <li>" + LanguageItemExtension.GetnLanguageItemTitleByName("Gửi lúc") + @": " + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + @"</li>
    </ul>";

    EmailExtension.SendEmail(emailhethong, subject, body, listemail);
    #endregion

    #region Thông báo hoàn thành và reset các texbox
    string[] reply = { "success" };
    Response.Output.Write(js.Serialize(reply));
    #endregion
  }
}