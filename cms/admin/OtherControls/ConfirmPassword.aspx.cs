using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using TatThanhJsc.Extension;


public partial class SubControls_ConfirmPassword : System.Web.UI.Page
{
    private string Account = "";
    private string RoadConfirm = "";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderby = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Account"] != null)        
            Account = QueryStringExtension.GetQueryString("Account");
        if (Request.QueryString["Confirm"] != null)
            RoadConfirm = QueryStringExtension.GetQueryString("Confirm");
        
        if (!IsPostBack)
        {
            top = "1";
            fields = "*";
            condition = TatThanhJsc.TSql.UsersTSql.GetUsersByUsername(Account);
            DataTable dt = new DataTable();
            dt = TatThanhJsc.Database.Users.GetUsers(top, fields, condition, orderby);
            if (dt.Rows.Count > 0)
            {
                string vPassword = dt.Rows[0][TatThanhJsc.Columns.UsersColumns.UserpasswordsaltColumn].ToString();
                string newPassword = StringExtension.LayChuoi(vPassword, TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 0);
                string oldConfirm = StringExtension.LayChuoi(vPassword, TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 1);
                string notReset = StringExtension.LayChuoi(vPassword, TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 2);
                if (notReset == "0" && RoadConfirm.Equals(oldConfirm))
                {                    
                    //Cập nhật mật khẩu
                    string values = TatThanhJsc.TSql.UsersTSql.GetUsersByUserpassword(SecurityExtension.BuildPassword(newPassword));
                    string conditionUpdate = TatThanhJsc.TSql.UsersTSql.GetUsersByUsername(Account);
                    TatThanhJsc.Database.Users.UpdateUsers(values, conditionUpdate);
                    //Cập nhật trạng thái về đã được kích hoạt mật khẩu
                    values = TatThanhJsc.TSql.UsersTSql.GetUsersByUserpasswordsalt(" ");
                    conditionUpdate = TatThanhJsc.TSql.UsersTSql.GetUsersByUsername(Account);
                    TatThanhJsc.Database.Users.UpdateUsers(values, conditionUpdate);
                    //Thông báo thành công
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "alert('Kích hoạt mật khẩu thành công! Bạn có thể đăng nhập website bằng mật khẩu mới.');location.href='" + UrlExtension.WebisteUrl + "Login.aspx';", true);                    
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "alert('Link kích hoạt này đã được sử dụng. Nếu bạn vẫn không đăng nhập được tài khoản của mình, vui lòng sử dụng lại chức năng khôi phục mật mẩu!');location.href='" + UrlExtension.WebisteUrl + "SubControls/ResetPassword.aspx';", true);                    
                }
            }
            else
            {
                return;
            }
        }
    }

}
