using System;
using System.Data;
using System.Web;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;


public partial class admin : System.Web.UI.Page
{
  private string LoginSetting = "LoginSetting";
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
      RewriteExtension.SetRewriteByLanguage(lang);

    if (Request.QueryString["login"] != null && Request.QueryString["login"] == "1")
    {
      DataTable dt = new DataTable();

      string username = QueryStringExtension.GetQueryString("username");
      string password = QueryStringExtension.GetQueryString("password");

      string condition = DataExtension.AndConditon(
          UsersTSql.GetUsersByUsername(username),
          UsersTSql.GetUsersByUserpassword(password));
      if (username == "admin")
        dt = Users.GetUsers("1", "*", condition, "", "%");
      else
        dt = Users.GetUsers("1", "*", condition, "");

      if (dt.Rows.Count > 0)
      {
        if (dt.Rows[0][UsersColumns.UserisapprovedColumn].ToString() == "1")
        {

          CookieExtension.SaveCookies(LoginSetting, dt.Rows[0][UsersColumns.UsernameColumn].ToString());
          #region UserName
          CookieExtension.SaveCookies("UserName", dt.Rows[0][UsersColumns.UsernameColumn].ToString());
          #endregion
          #region UserId
          CookieExtension.SaveCookies("UserId", dt.Rows[0][UsersColumns.UseridColumn].ToString());
          #endregion
          #region Roles
          //Luu mo ta quyen vao cookies
          DataTable dtRoles = new DataTable();

          dtRoles = Roles.GetRolesByRoleId(dt.Rows[0]["RoleId"].ToString(), "%");
          string RoleDescription = dtRoles.Rows[0]["RoleDescription"].ToString();
          CookieExtension.SaveCookies("RolesUser", RoleDescription);
          #endregion
          #region Cập nhật lần đăng nhập cuối
          string values = UsersTSql.GetUsersByUserlastlogindate(DateTime.Now.ToString());
          string conditionUpdate = UsersTSql.GetUsersByUsername(username);
          Users.UpdateUsers(values, conditionUpdate);
          #endregion


          #region Logs
          string logAuthor = CookieExtension.GetCookies("LoginSetting");
          string logCreateDate = DateTime.Now.ToString();
          Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", logAuthor, logAuthor, "", logCreateDate + ": " + logAuthor + " đăng nhập vào hệ thống quản trị");
          #endregion

          if (Request.Cookies["RefererUrl"] != null)
            Response.Redirect(Request.Cookies["RefererUrl"].Value.ToString());
          else
            Response.Redirect("admin.aspx");
        }
        else
        {
          Response.Redirect("login.aspx");
        }
      }
      else
      {
        Response.Redirect("login.aspx");
      }
    }

    //if(!IsPostBack)
    //    LogsExtension.InsertAdminLogs();

    if (CookieExtension.CheckValidCookies(LoginSetting))
    {
      phControl.Controls.Add(LoadControl("cms/admin/Moduls/Controls.ascx"));
    }
    else
    {
      HttpCookie urlCookie = new HttpCookie("RefererUrl");
      urlCookie.Value = Request.Url.ToString();
      Response.Cookies.Add(urlCookie);
      Response.Redirect("login.aspx");
    }
  }
}