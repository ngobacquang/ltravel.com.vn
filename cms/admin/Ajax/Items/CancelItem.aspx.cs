using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Ajax_CancelItem : System.Web.UI.Page
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  string iid = "";
  string userid = "";
  string uc = "";
  string content = "";

  protected void Page_Load(object sender, EventArgs e)
  {
    uc = Request["uc"];
    iid = Request["iid"];
    userid = Request["userid"];
    content = Request["content"];

    HuyBai();
    Response.End();
  }


  void HuyBai()
  {
    #region Lấy tiêu đề bài viết
    string postTitle = "";
    string condition2 = ItemsTSql.GetById(iid);
    string fields = DataExtension.GetListColumns(ItemsColumns.VititleColumn, ItemsColumns.VISEOMETAPARAMSColumn);
    string orderby = GroupsColumns.IgorderColumn;
    DataTable dt = new DataTable();
    dt = GroupsItems.GetAllData("1", fields, condition2, orderby);
    if (dt.Rows.Count > 0)
      postTitle = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
    #endregion

    #region Lấy info người đăng bài
    string tenNguoiDangBai = "";
    string emailNguoiDangBai = "";
    DataTable dtUserDangBai = Users.GetUsersByUserId(userid);
    if (dtUserDangBai.Rows.Count > 0)
    {
      tenNguoiDangBai = dtUserDangBai.Rows[0][UsersColumns.UserfirstnameColumn].ToString() + " " + dtUserDangBai.Rows[0][UsersColumns.UserlastnameColumn].ToString();
      emailNguoiDangBai = dtUserDangBai.Rows[0][UsersColumns.UseremailColumn].ToString();
    }
    #endregion

    #region Lấy info người hủy bài
    DataTable dtUserHuyBai = Users.GetUsersByUserId(CookieExtension.GetCookies("UserId"));

    string tenNguoiHuyBai = "";

    if (dtUserHuyBai.Rows.Count > 0)
      tenNguoiHuyBai = dtUserHuyBai.Rows[0][UsersColumns.UserfirstnameColumn].ToString() + " " + dtUserHuyBai.Rows[0][UsersColumns.UserlastnameColumn].ToString();
    #endregion

    #region Đổi trạng thái hiển thị của item
    string[] fieldsDelGroup = { "IIENABLE" };
    string[] valuesDelGroup = { "3" };
    string condition = " IID = '" + iid + "' ";
    TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);
    #endregion

    #region Thêm thông tin ("", người hủy, thời gian hủy, nội dung hủy)
    string data = StringExtension.GhepChuoi("", tenNguoiHuyBai, content);
    string[] fieldsDelGroup2 = { "VISEOMETACANONICAL" };
    string[] valuesDelGroup2 = { "N'" + data + "'" };
    string[] fieldsDelGroup3 = { "VISEOMETALANG" };
    string[] valuesDelGroup3 = { "'" + DateTime.Now.ToString() + "'" };
    condition = " IID = '" + iid + "' ";
    TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup2, valuesDelGroup2), condition);
    TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup3, valuesDelGroup3), condition);
    #endregion

    #region Gửi mail tới thành viên
    string link = "", contentEmail = "";
    link = UrlExtension.WebisteUrl + "admin.aspx?uc=" + uc + "&suc=QuanLyBaiVietBiHuy";
    contentEmail = @"
		<div style='color:#333'>
			<div>" + LanguageItemExtension.GetnLanguageItemTitleByName("Xin chào") + @" " + tenNguoiDangBai + @"!</div>
			<br/>
			<div>" + LanguageItemExtension.GetnLanguageItemTitleByName("Bài viết") + " <b>" + postTitle + @"</b> " + LanguageItemExtension.GetnLanguageItemTitleByName("của bạn đã bị hủy bỏ bởi") + @" <span style='color: blue'>" + tenNguoiHuyBai + @"</span> " + LanguageItemExtension.GetnLanguageItemTitleByName("với lời nhắn") + @":</div>
			<br />
			<div>""" + content + @"""</div>
			<br />
			<div>" + LanguageItemExtension.GetnLanguageItemTitleByName("Để xem danh sách các bài viết bị hủy, vui lòng click vào") + @" <a href='" + link + @"'>" + LanguageItemExtension.GetnLanguageItemTitleByName("đây") + @"</a>.</div>			
		</div>";

    EmailExtension.SendEmail(emailNguoiDangBai, "Thông báo hủy bài viết từ " + UrlExtension.WebisteUrl, contentEmail);
    #endregion
  }
}