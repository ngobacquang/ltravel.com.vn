using System;
using System.Configuration;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;


public partial class cms_admin_Controls_Header_AdmControlsHeaderTopMenu : System.Web.UI.UserControl
{
    private string LoginSetting = "LoginSetting";
    protected void Page_Load(object sender, EventArgs e)
    {
        SetEnableModuls();
        if (!IsPostBack)
        {
            lt_username.Text = CookieExtension.GetCookies("UserName");            
        }
    }

    void SetEnableModuls()
    {
        if (HorizaMenuConfig.ShowWebsite && ConfigurationManager.AppSettings["WebName"] == "")
            pnWebsiteModul.Visible = true;
        else
            pnWebsiteModul.Visible = false;
        
        pnLanguage.Visible = HorizaMenuConfig.ShowLanguage;
    }

    protected void lnk_logout_Click(object sender, EventArgs e)
    {     
        #region Xoá cookies LoginSetting
        CookieExtension.ClearCookies(LoginSetting);
        #endregion

        #region Xóa cookie RolesUser
        CookieExtension.ClearCookies("RolesUser");        
        #endregion

        #region Cập nhật lần đăng xuất cuối
        string values = TatThanhJsc.TSql.UsersTSql.GetUsersByUserlastlockoutdate(DateTime.Now.ToString());
        string conditionUpdate = TatThanhJsc.TSql.UsersTSql.GetUsersByUsername(CookieExtension.GetCookies("UserName"));
        TatThanhJsc.Database.Users.UpdateUsers(values, conditionUpdate);
        #endregion                

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", logAuthor, logAuthor, "", logCreateDate + ": " + logAuthor + " đăng xuất khỏi hệ thống quản trị");
        #endregion

        Response.Redirect("login.aspx");
    }
    protected void lnk_about_username_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin.aspx?uc=" + TatThanhJsc.UserModul.CodeApplications.User + "&suc=manager");
    }
    protected void LbSystem_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin.aspx?uc=" + TatThanhJsc.SystemWebsiteModul.CodeApplications.Systemwebsite + "");
    }
    protected void LbAccount_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin.aspx?uc=" + TatThanhJsc.UserModul.CodeApplications.User + "&suc=manager");
    }
    protected void lbLanguage_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin.aspx?uc=" + TatThanhJsc.LanguageModul.CodeApplications.Language + "");
    }
    
}
