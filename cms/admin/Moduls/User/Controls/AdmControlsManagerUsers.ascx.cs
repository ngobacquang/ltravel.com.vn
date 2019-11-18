using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
using Developer;

public partial class cms_admin_ModulMain_User_Controls_AdmControlsManagerUsers : System.Web.UI.UserControl
{
  string s_del = "";

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      LoadListRoles();
      LoadDuyetTin();
      GetAllUsers();
    }
  }

  #region Kiểm tra tính năng duyệt tin, nếu có thì hiển thị danh sách phân quyền
  void LoadDuyetTin()
  {
    if (HorizaMenuConfig.ShowDuyetTin2)
    {
      plDuyetTin.Visible = true;
      cblDuyetTin.Items.Add(new ListItem(DuyetTinKeyword.Cap3, PhanQuyen.DuyetTin.Cap3));
      cblDuyetTin.Items.Add(new ListItem(DuyetTinKeyword.Cap2, PhanQuyen.DuyetTin.Cap2));
      cblDuyetTin.Items.Add(new ListItem(DuyetTinKeyword.Cap1, PhanQuyen.DuyetTin.Cap1));
      cblDuyetTin.Items[0].Selected = true;
    }
    else if (HorizaMenuConfig.ShowDuyetTin1)
    {
      plDuyetTin.Visible = true;
      cblDuyetTin.Items.Add(new ListItem(DuyetTinKeyword.Cap3, PhanQuyen.DuyetTin.Cap3));
      cblDuyetTin.Items.Add(new ListItem(DuyetTinKeyword.Cap2, PhanQuyen.DuyetTin.Cap2));
      cblDuyetTin.Items[0].Selected = true;
    }
  }
  #endregion

  void GetAllUsers()
  {
    DataTable dt = new DataTable();
    dt = Users.GetAllUsers("");
    rp_mn_users.DataSource = dt;
    rp_mn_users.DataBind();
  }

  void LoadListRoles()
  {
    TatThanhJsc.UserModul.Roles listRoles = new TatThanhJsc.UserModul.Roles();
    for (int i = 0; i < listRoles.Values.Length; i++)
    {
      switch (listRoles.Values[i]) {
        case PhanQuyen.LayRoleModul.AboutUs:
          if (HorizaMenuConfig.ShowAboutUs)
            cblRole.Items.Add(new ListItem(AboutUsKeyword.AboutUs, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Blog:
          if (HorizaMenuConfig.ShowBlog)
            cblRole.Items.Add(new ListItem(BlogKeyword.Blog, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.CopyItem:
          if (HorizaMenuConfig.ShowCopyItem)
            cblRole.Items.Add(new ListItem("Copy tin", listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Cruises:
          if (HorizaMenuConfig.ShowCruises)
            cblRole.Items.Add(new ListItem(CruisesKeyword.Cruises, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Customer:
          if (HorizaMenuConfig.ShowCustomer)
            cblRole.Items.Add(new ListItem(CustomerKeyword.Customer, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.CustomerReviews:
          if (HorizaMenuConfig.ShowCustomerReviews)
            cblRole.Items.Add(new ListItem(CustomerReviewsKeyword.CustomerReviews, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Deal:
          if (HorizaMenuConfig.ShowDeal)
            cblRole.Items.Add(new ListItem(DealKeyword.Deal, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Email:
          if (HorizaMenuConfig.ShowEmail)
            cblRole.Items.Add(new ListItem("Nhận Email", listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.FileLibrary:
          if (HorizaMenuConfig.ShowFilelibrary)
            cblRole.Items.Add(new ListItem(FileLibraryKeyword.FileLibrary, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.FileLibrary2:
          if (HorizaMenuConfig.ShowFilelibrary2)
            cblRole.Items.Add(new ListItem(FileLibrary2Keyword.FileLibrary2, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Hotel:
          if (HorizaMenuConfig.ShowHotel)
            cblRole.Items.Add(new ListItem(HotelKeyword.Hotel, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Language:
          if (HorizaMenuConfig.ShowLanguage)
            cblRole.Items.Add(new ListItem("Ngôn ngữ", listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Menu:
          if (HorizaMenuConfig.ShowMenu)
            cblRole.Items.Add(new ListItem(MenuKeyword.Menu, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.New:
          if (HorizaMenuConfig.ShowNew)
            cblRole.Items.Add(new ListItem(NewKeyword.New, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.PhotoAlbum:
          if (HorizaMenuConfig.ShowPhotoAlbum)
            cblRole.Items.Add(new ListItem(PhotoAlbumKeyword.PhotoAlbum, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Product:
          if (HorizaMenuConfig.ShowProduct)
            cblRole.Items.Add(new ListItem(ProductKeyword.Product, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.QA:
          if (HorizaMenuConfig.ShowQA)
            cblRole.Items.Add(new ListItem(QAKeyword.QA, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Service:
          if (HorizaMenuConfig.ShowService)
            cblRole.Items.Add(new ListItem(ServiceKeyword.Service, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Tag:
          if (HorizaMenuConfig.ShowTag)
            cblRole.Items.Add(new ListItem(TagKeyword.Tag, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Video:
          if (HorizaMenuConfig.ShowVideo)
            cblRole.Items.Add(new ListItem(VideoKeyword.Video, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Website:
          if (HorizaMenuConfig.ShowWebsite)
            cblRole.Items.Add(new ListItem(WebsiteKeyword.Website, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.User:
          if (HorizaMenuConfig.ShowUser)
            cblRole.Items.Add(new ListItem("Tài khoản", listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Systemwebsite:
          if (HorizaMenuConfig.ShowSystemwebsite)
            cblRole.Items.Add(new ListItem("Hệ thống", listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.ContactUs:
          if (HorizaMenuConfig.ShowContact)
            cblRole.Items.Add(new ListItem(ContactKeyword.Contact, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Content:
          if (HorizaMenuConfig.ShowContent)
            cblRole.Items.Add(new ListItem(ContentKeyword.Content, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.SiteMap:
          if (HorizaMenuConfig.ShowSiteMap)
            cblRole.Items.Add(new ListItem(SiteMapKeyword.SiteMap, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.LinkWebsite:
          if (HorizaMenuConfig.ShowDcLink)
            cblRole.Items.Add(new ListItem("Kiểm tra trùng link", listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.SupportOnline:
          if (HorizaMenuConfig.ShowSupportOnline)
            cblRole.Items.Add(new ListItem(SupportOnlineKeyword.SupportOnline, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Vote:
          if (HorizaMenuConfig.ShowVote)
            cblRole.Items.Add(new ListItem(VoteKeyword.Vote, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Member:
          if (HorizaMenuConfig.ShowMember)
            cblRole.Items.Add(new ListItem(MemberKeyword.Member, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Other:
          if (HorizaMenuConfig.ShowOther)
            cblRole.Items.Add(new ListItem("Module phụ", listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Destination:
          if (HorizaMenuConfig.ShowDestination)
            cblRole.Items.Add(new ListItem(DestinationKeyword.Destination, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Advertising:
          if (HorizaMenuConfig.ShowAdv)
            cblRole.Items.Add(new ListItem(AdvertisingKeyword.Advertising, listRoles.Values[i]));
          break;
        case PhanQuyen.LayRoleModul.Tour:
          if (HorizaMenuConfig.ShowTour)
            cblRole.Items.Add(new ListItem(TourKeyword.Tour, listRoles.Values[i]));
          break;
      }
    }
  }

  protected void lnk_create_account_Click(object sender, EventArgs e)
  {
    hd_insert_update.Value = "insert";
    btn_insert_update.Text = "Đồng ý";
    pn_list_users.Visible = false;
    pn_insert_update.Visible = true;
    hd_insert_update.Value = "insert";
    txt_UserName.Enabled = true;
  }

  protected void rp_mn_users_ItemCommand(object source, RepeaterCommandEventArgs e)
  {
    string c = e.CommandName.Trim();
    string p = e.CommandArgument.ToString().Trim();
    DataTable dt = new DataTable();
    dt = TatThanhJsc.Database.Users.GetUsersByUserId(p);
    string userNameUpdate = dt.Rows[0][UsersColumns.UsernameColumn].ToString();
    if (userNameUpdate == "admin" && CookieExtension.GetCookies("UserName") != "admin")
    {
      ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Chỉ có chính tài khoản admin mới có thể thay đổi thông tin tài khoản có tên admin');", true);
      return;
    }
    switch (c)
    {
      #region Delete User
      case "delete":
        if (userNameUpdate == CookieExtension.GetCookies("UserName"))
        {
          ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Không thể xoá tài khoản mà bạn đang đăng nhập.');", true);
          return;
        }
        Users.DeleteRolesUsers(p);
        GetAllUsers();

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", dt.Rows[0][UsersColumns.UsernameColumn].ToString(), logAuthor, "", logCreateDate + ": " + logAuthor + " xóa tài khoản " + dt.Rows[0][UsersColumns.UsernameColumn].ToString());
        #endregion
        break;
      #endregion
      #region Edit Enable
      case "EditEnable":
        if (dt.Rows[0]["UserIsApproved"].ToString().Equals("0"))
        {
          TatThanhJsc.Database.Users.UpdateEnableUser("1", p);
        }
        else
        {
          TatThanhJsc.Database.Users.UpdateEnableUser("0", p);
        }
        GetAllUsers();

        #region Logs
        logAuthor = CookieExtension.GetCookies("LoginSetting");
        logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", dt.Rows[0][UsersColumns.UsernameColumn].ToString(), logAuthor, "", logCreateDate + ": " + logAuthor + " thay đổi trạng thái tài khoản " + dt.Rows[0][UsersColumns.UsernameColumn].ToString());
        #endregion

        break;
      #endregion
      #region Change Password of user
      case "ChangePassword":
        hd_userid.Value = p;
        ltChangePassword.Text = "Đồi mật khẩu của tài khoản";
        pnChangePassword.Visible = true;
        pn_insert_update.Visible = false;
        pn_list_users.Visible = false;

        if (CookieExtension.GetCookies("UserName") == "admin")
          pnMatKhauCu.Visible = false;
        break;
      #endregion
      #region Edit User
      case "edit":
        btn_insert_update.Text = "Đồng ý";
        hd_insert_update.Value = "edit";
        hd_userid.Value = p;
        pn_insert_update.Visible = true;
        pn_list_users.Visible = false;
        pnChangePassword.Visible = false;
        txt_password.Visible = false;
        txt_UserName.Enabled = false;
        ltPw1.Text = "<div class='pt8 cRed'>*****</div>";
        txt_repeat_password.Visible = false;
        ltRpPw1.Text = "<div class='pt8 cRed'>*****</div>";
        HdRoldId.Value = dt.Rows[0]["RoleId"].ToString();
        #region Roles
        DataTable dtRoles = new DataTable();
        dtRoles = TatThanhJsc.Database.Roles.GetRolesByRoleId(dt.Rows[0]["RoleId"].ToString());
        string RoleDescription = dtRoles.Rows[0]["RoleDescription"].ToString();
        for (int i = 0; i < cblRole.Items.Count; i++)
        {
          if (StringExtension.RoleInListRoles(cblRole.Items[i].Value, RoleDescription))
            cblRole.Items[i].Selected = true;
          else
            cblRole.Items[i].Selected = false;          
        }

        #region Kiểm tra nếu có tính năng duyệt tin thì lấy phân quyền ra
        if (HorizaMenuConfig.ShowDuyetTin1 || HorizaMenuConfig.ShowDuyetTin2)
        {
          for (int j = 0; j < cblDuyetTin.Items.Count; j++)
          {
            if (StringExtension.RoleInListRoles(cblDuyetTin.Items[j].Value, RoleDescription))
              cblDuyetTin.Items[j].Selected = true;
            else
              cblDuyetTin.Items[j].Selected = false;
          }
        }
        #endregion

        #endregion
        txt_UserName.Text = dt.Rows[0]["UserName"].ToString();
        txt_password.Text = dt.Rows[0]["UserPassword"].ToString();
        txt_fname.Text = dt.Rows[0]["UserFirstName"].ToString();
        txt_lname.Text = dt.Rows[0]["UserLastName"].ToString();
        txt_address.Text = dt.Rows[0]["UserAddress"].ToString();
        txt_phone.Text = dt.Rows[0]["UserPhoneNumber"].ToString();
        txt_email.Text = dt.Rows[0]["UserEmail"].ToString();
        txt_identitycard.Text = dt.Rows[0]["UserIdentityCard"].ToString();
        ddl_approved.SelectedValue = dt.Rows[0]["UserIsApproved"].ToString();
        txt_comment.Text = dt.Rows[0]["UserComment"].ToString();
        #region Time
        HdTimeCreate.Value = dt.Rows[0]["UserCreateDate"].ToString();
        HdUserLastLogindate.Value = dt.Rows[0]["UserLastLogindate"].ToString();
        HdLastPasswordChangedDate.Value = dt.Rows[0]["UserLastPasswordChangedDate"].ToString();
        HdUserLastLockoutDate.Value = dt.Rows[0]["UserLastLockoutDate"].ToString();
        break;
        #endregion
        #endregion
    }
  }

  protected void cbCheckAll_CheckedChanged(object sender, EventArgs e)
  {
    for (int i = 0; i < cblRole.Items.Count; i++)
      cblRole.Items[i].Selected = cbCheckAll.Checked;
  }

  protected void btn_cancel_Click(object sender, EventArgs e)
  {
    pn_list_users.Visible = true;
    pn_insert_update.Visible = false;
  }

  protected void btn_insert_update_Click(object sender, EventArgs e)
  {
    #region Check Role        
    string ParamsSpilitRole = TatThanhJsc.AdminModul.Keyword.ParamsSpilitRole;
    string RoleDescription = ParamsSpilitRole;
    for (int i = 0; i < cblRole.Items.Count; i++)
    {
      if (cblRole.Items[i].Selected == true)
        RoleDescription += cblRole.Items[i].Value + ParamsSpilitRole;
    }

    #region Kiểm tra nếu có tính năng duyệt tin thì lưu quyền vào database
    if (HorizaMenuConfig.ShowDuyetTin1 || HorizaMenuConfig.ShowDuyetTin2)
    {
      for (int j = 0; j < cblDuyetTin.Items.Count; j++)
      {
        if (cblDuyetTin.Items[j].Selected == true)
          RoleDescription += cblDuyetTin.Items[j].Value + ParamsSpilitRole;
      }
    }
    #endregion

    #endregion
    #region Insert
    if (hd_insert_update.Value.Equals("insert"))
    {
      if (ExistedUser(txt_UserName.Text))
      {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Tài khoản này đã tồn tại, vui lòng chọn tên tài khoản khác.');", true);
        return;
      }
      TatThanhJsc.Database.Users.InsertRolesUsers("", RoleDescription, "", txt_UserName.Text.Trim(), txt_password.Text,
                             "", txt_fname.Text, txt_lname.Text, txt_address.Text,
                             txt_phone.Text.Trim(), txt_email.Text, txt_identitycard.Text,
                             "", "", ddl_approved.SelectedValue,
                             "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), txt_comment.Text);

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_UserName.Text.Trim(), logAuthor, "", logCreateDate + ": " + logAuthor + " thêm mới tài khoản " + txt_UserName.Text.Trim());
      #endregion
    }
    #endregion
    #region Update
    else
    {
      TatThanhJsc.Database.Users.UpdateRolesUsers(hd_userid.Value, HdRoldId.Value, "", RoleDescription, "", txt_UserName.Text,
                             txt_fname.Text, txt_lname.Text,
                             txt_address.Text, txt_phone.Text.Trim(), txt_email.Text, txt_identitycard.Text,
                             "", "", ddl_approved.SelectedValue,
                             "", HdTimeCreate.Value, HdUserLastLogindate.Value, HdLastPasswordChangedDate.Value, HdUserLastLockoutDate.Value, txt_comment.Text);

      #region Logs
      string logAuthor = CookieExtension.GetCookies("LoginSetting");
      string logCreateDate = DateTime.Now.ToString();
      Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_UserName.Text.Trim(), logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật tài khoản " + txt_UserName.Text.Trim());
      #endregion
    }

    #endregion
    #region Return values after click button
    pn_insert_update.Visible = false;
    pn_list_users.Visible = true;
    txt_UserName.Text = "";
    txt_password.Text = "";
    txt_fname.Text = "";
    txt_lname.Text = "";
    txt_address.Text = "";
    txt_phone.Text = "";
    txt_email.Text = "";
    txt_identitycard.Text = "";
    ddl_approved.SelectedValue = "1";
    txt_comment.Text = "";
    GetAllUsers();
    #endregion
  }

  private bool ExistedUser(string username)
  {
    DataTable dt = new DataTable();
    dt = Users.GetUsers("", UsersColumns.UseridColumn, UsersTSql.GetUsersByUsername(username), "");
    if (dt.Rows.Count > 0)
      return true;
    return false;
  }

  protected void btnChangePassword_Click(object sender, EventArgs e)
  {
    string userId = hd_userid.Value;
    DataTable dt = new DataTable();
    dt = Users.GetUsersByUserId(userId);
    if (dt.Rows.Count > 0)
    {
      string oldPassword = SecurityExtension.BuildPassword(tbChangeOldPassword.Text);
      //Nếu nhập đúng mật khẩu cũ hoặc đang đăng nhập với tài khoản admin
      if (oldPassword == dt.Rows[0][UsersColumns.UserpasswordColumn].ToString() || CookieExtension.GetCookies("UserName") == "admin")
      {
        if (CookieExtension.GetCookies("UserName") == "admin")
          oldPassword = dt.Rows[0][UsersColumns.UserpasswordColumn].ToString();

        if (oldPassword.Length > 0)
        {
          TatThanhJsc.Database.Users.ChangePasswordUsers(userId, oldPassword, SecurityExtension.BuildPassword(tbChangeNewPassword.Text), false);
          ScriptManager.RegisterStartupScript(this, this.GetType(), "",
              "ThongBao(3000,'Cập nhật mật khẩu thành công');", true);
          pn_insert_update.Visible = false;
          pn_list_users.Visible = true;
          pnChangePassword.Visible = false;

          #region Logs
          string logAuthor = CookieExtension.GetCookies("LoginSetting");
          string logCreateDate = DateTime.Now.ToString();
          Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", dt.Rows[0][UsersColumns.UsernameColumn].ToString(), logAuthor, "", logCreateDate + ": " + logAuthor + " đổi mật khẩu tài khoản " + dt.Rows[0][UsersColumns.UsernameColumn].ToString());
          #endregion
        }
        else
        {
          ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Mật khẩu cũ không chính xác.');", true);
        }
      }
      else
      {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Mật khẩu cũ không chính xác.');", true);
      }
    }
    else
    {
      ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Cập nhật mật khẩu thất bại.');", true);
    }
  }

  protected void btnBack_Click(object sender, EventArgs e)
  {
    pn_insert_update.Visible = false;
    pn_list_users.Visible = true;
    pnChangePassword.Visible = false;
  }

  protected void chk_list_CheckedChanged(object sender, EventArgs e)
  {
    //Đoàn sửa
    for (int i = 0; i < rp_mn_users.Items.Count; i++)
    {
      CheckBox chkDelete = (CheckBox)rp_mn_users.Items[i].FindControl(("chk_item"));
      if (chkDelete != null)
      {
        chkDelete.Checked = chk_list.Checked;
      }
    }
  }

  protected void lnk_delete_user_checked_Click(object sender, EventArgs e)
  {
    lnk_delete_user_checked.Attributes.Add("onclick", "return confirm_delete();");
    for (int i = 0; i <= rp_mn_users.Items.Count - 1; i++)
    {
      CheckBox chkDelete = (CheckBox)rp_mn_users.Items[i].FindControl(("chk_item"));
      if (chkDelete != null)
      {
        if (chkDelete.Checked)
        {
          s_del += chkDelete.ToolTip;
          s_del += ",";
        }
      }
      else
      {
        return;
      }
    }
    if (s_del.Length > 0)
    {
      s_del = s_del.Substring(0, (s_del.Length - 1));
    }
    else
    {
      return;
    }

    string[] str = s_del.Split(Convert.ToChar(","));
    DataTable dt = new DataTable();
    dt = Users.GetUsers("1", UsersColumns.UseridColumn, UsersTSql.GetUsersByUsername("admin"), "");
    string userAdminId = "";
    if (dt.Rows.Count > 0)
      userAdminId = dt.Rows[0][UsersColumns.UseridColumn].ToString();
    for (int j = 0; j < str.Length; j++)
    {
      if (str[j] != userAdminId && str[j] != CookieExtension.GetCookies("UserId")) //Không xoá tài khoản admin
      {
        Users.DeleteRolesUsers(str[j]);

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();

        string username = GetAccountName(str[j]);

        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", username, logAuthor, "", logCreateDate + ": " + logAuthor + " xóa tài khoản " + username);
        #endregion
      }
    }
    GetAllUsers();
  }

  private string GetAccountName(string userId)
  {
    DataTable dt = new DataTable();
    dt = TatThanhJsc.Database.Users.GetUsersByUserId(userId);
    if (dt.Rows.Count > 0)
      return dt.Rows[0][UsersColumns.UsernameColumn].ToString();
    return "";
  }

}
