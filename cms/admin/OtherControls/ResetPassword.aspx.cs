using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Extension;


public partial class SubControls_ResetPassword : System.Web.UI.Page
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderby = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void BtnLogin_Click(object sender, EventArgs e)
    {
        top = "1";
        fields = DataExtension.GetListColumns(UsersColumns.UseridColumn, UsersColumns.UseremailColumn);
        condition = TatThanhJsc.TSql.UsersTSql.GetUsersByUsername(TbAccount.Text);
        orderby = "";
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Users.GetUsers(top, fields, condition, orderby);
        if (dt.Rows.Count > 0)
        {
            string clientIP = "";
            clientIP = Request.UserHostAddress;
            string ipAddress = "";
            ipAddress = System.Net.Dns.GetHostAddresses(System.Net.Dns.GetHostName()).GetValue(0).ToString();
            string NewPassword = (clientIP + DateTime.Now.ToString());
            NewPassword = SecurityExtension.BuildPassword(NewPassword);
            NewPassword = NewPassword.Substring(0, 8);
            string RoadLinkConfirm = SecurityExtension.BuildPassword(ipAddress + NewPassword);

            string values = UsersColumns.UserpasswordsaltColumn + "=N'" +
                            (NewPassword + TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems + RoadLinkConfirm +
                             TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems + "0") + "'";
            string conditionUpdate = TatThanhJsc.TSql.UsersTSql.GetUsersByUsername(TbAccount.Text);          


            TatThanhJsc.Database.Users.UpdateUsers(values,conditionUpdate);
            string ContentEmail = "";
            ContentEmail = @"
<div>Xin chào bạn!</div>
<br />
<div>Chúng tôi đã nhận được yêu cầu khôi phục mật khẩu tại website "+UrlExtension.WebisteUrl+@"</div>
<div>Thông tin mật khẩu mới như sau:</div>
<div>
    <ul>
        <li>Tài khoản: " + TbAccount.Text + @"</li>
        <li>Mật khẩu mới: " + NewPassword + @"</li>
    </ul>
</div>
<br />
<div>Nếu bạn không yêu cầu khôi phục mật khẩu, bạn không cần làm gì nữa.</div>
<div>Nếu bạn muốn khôi phục mật khẩu, vui lòng kích vào đường link dưới đây để kích hoạt mật khẩu mới!</div>
<div>" + UrlExtension.WebisteUrl + "cms/admin/OtherControls/ConfirmPassword.aspx?Account=" + TbAccount.Text + "&Confirm=" + RoadLinkConfirm + @"</div>
";
            
            EmailExtension.SendEmail(dt.Rows[0][UsersColumns.UseremailColumn].ToString(), "Khôi phục mật khẩu website: " + UrlExtension.WebisteUrl, ContentEmail);
            ScriptManager.RegisterStartupScript(this, GetType(), "ResetPassword", "alert('Đã gửi mật khẩu mới tới email " + dt.Rows[0][UsersColumns.UseremailColumn].ToString() + ", vui lòng kích hoạt mật khẩu mới tại địa chỉ email của bạn!');", true);                
        }
        else
        {           
            ScriptManager.RegisterStartupScript(this, GetType(), "", "alert('Tài khoản không đúng!');", true);
            TbAccount.Text = "";            
            return;
        }
    }
    protected void LBLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect(UrlExtension.WebisteUrl + "Login.aspx");
    }
}
