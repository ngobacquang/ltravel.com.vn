using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_ModulMain_User_AdmIndex : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            GetInfoUser();
    }

    void GetInfoUser()
    {
        string userId = CookieExtension.GetCookies("UserId");
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Users.GetUsersByUserId(userId);
        if (dt.Rows.Count > 0)
        {
            ltrTaiKhoan.Text = dt.Rows[0][UsersColumns.UsernameColumn].ToString();
            ltrHoTen.Text = dt.Rows[0][UsersColumns.UserfirstnameColumn].ToString() + " " + dt.Rows[0][UsersColumns.UserlastnameColumn].ToString();
            ltrEmail.Text = dt.Rows[0][UsersColumns.UseremailColumn].ToString();
            ltrDienThoai.Text = dt.Rows[0][UsersColumns.UserphonenumberColumn].ToString();
            ltrDiaChi.Text = dt.Rows[0][UsersColumns.UseraddressColumn].ToString();
            ltrGhiChu.Text = dt.Rows[0][UsersColumns.UsercommentColumn].ToString();
            ltrNgayTao.Text = TimeExtension.FormatTime(dt.Rows[0][UsersColumns.UsercreatedateColumn], 6);
            ltrLanDangXuatCuoi.Text = TimeExtension.FormatTime(dt.Rows[0][UsersColumns.UserlastlockoutdateColumn], 6);
            ltrLanDangNhapCuoi.Text = TimeExtension.FormatTime(dt.Rows[0][UsersColumns.UserlastlogindateColumn], 6);

            tbTen.Text = dt.Rows[0][UsersColumns.UserlastnameColumn].ToString();
            tbHo.Text = dt.Rows[0][UsersColumns.UserfirstnameColumn].ToString();
            tbDiaChi.Text = dt.Rows[0][UsersColumns.UseraddressColumn].ToString();
            tbDienThoai.Text = dt.Rows[0][UsersColumns.UserphonenumberColumn].ToString();
            tbSoCMND.Text = dt.Rows[0][UsersColumns.UseridentitycardColumn].ToString();
        }
    }
    protected void lbtChangePassword_Click(object sender, EventArgs e)
    {
        pnInfo.Visible = false;
        pnChangePassword.Visible = true;
    }
    protected void lbtChangeInfo_Click(object sender, EventArgs e)
    {
        pnInfo.Visible = false;
        pnChangeInfo.Visible = true;
    }
    protected void btOKChangePassword_Click(object sender, EventArgs e)
    {
        string userName = CookieExtension.GetCookies("UserName");
        string userId = CookieExtension.GetCookies("UserId");
        DataTable dt = new DataTable();
        dt = Users.GetUsersByUserNameAndPassword(userName, tbMatKhauCu.Text);
        if (dt.Rows.Count > 0)
        {
            TatThanhJsc.Database.Users.ChangePasswordUsers(userId, tbMatKhauCu.Text, tbMatKhauMoi.Text);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "ThongBao(3000,'Cập nhật mật khẩu thành công');", true);
            pnChangePassword.Visible = false;
            pnInfo.Visible = true;
            GetInfoUser();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Mật khẩu cũ không chính xác.');", true);
        }
    }
    protected void btCancelChangePassword_Click(object sender, EventArgs e)
    {
        pnChangePassword.Visible = false;
        pnInfo.Visible = true;
        GetInfoUser();
    }
    protected void btOKChangeInfo_Click(object sender, EventArgs e)
    {
        string userId = CookieExtension.GetCookies("UserId");
        string condition = UsersTSql.GetUsersByUserid(userId);

        string[] fields = { UsersColumns.UserfirstnameColumn, UsersColumns.UserlastnameColumn, UsersColumns.UseraddressColumn, UsersColumns.UserphonenumberColumn, UsersColumns.UseridentitycardColumn };
        string[] value = { "N'" + tbHo.Text + "'", "N'" + tbTen.Text + "'", "N'" + tbDiaChi.Text + "'", "N'" + tbDienThoai.Text + "'", "N'" + tbSoCMND.Text + "'" };

        Users.UpdateUsers(DataExtension.UpdateTransfer(fields, value), condition);

        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "ThongBao(3000,'Cập nhật thông tin thành công');", true);

        pnChangeInfo.Visible = false;
        pnInfo.Visible = true;
        GetInfoUser();
    }
    protected void btCancelChangeInfo_Click(object sender, EventArgs e)
    {
        pnChangeInfo.Visible = false;
        pnInfo.Visible = true;
        GetInfoUser();
    }
}
