using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.MemberModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Member_List_Shortcut : System.Web.UI.UserControl
{
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";

    private string app = CodeApplications.Member;
    private string pic = FolderPic.Member;

    private bool insert = false;

    private string imid = "";

    private string LinkRedirect()
    {
        return UrlExtension.WebisteUrl + "admin.aspx?uc=" + app + "&suc=" + TypePage.Item;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["iid"] != null)
            imid = Request.QueryString["iid"].ToString();

        if (Request.QueryString["suc"] != null)
        {
            if (Request.QueryString["suc"] == TypePage.CreateItem)
                insert = true;
        }            

        InitialControlsValue(insert);
        KhoiTaoXuLyAnh();  
    }


    void KhoiTaoXuLyAnh()
    {
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember, lang) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;
        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_AnhDau, lang);
        #endregion
        hdViTriDongDau.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_ViTri, lang);
        hdLeX.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_LeNgang, lang);
        hdLeY.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_LeDoc, lang);
        hdTyLe.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_TyLe, lang);
        hdTrongSuot.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhMember_TrongSuot, lang);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhMember, lang) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhMember_MaxWidth, lang);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhMember_MaxHeight, lang);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhMember, lang) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhMember_MaxWidth, lang);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhMember_MaxHeight, lang);
        #endregion
    }

    void InitialControlsValue(bool insert)
    {
        #region update
        if (!insert)
        {
            btOK.Text = "Đồng ý";
            cbTiepTuc.Visible = false;
            DataTable dt=new DataTable();
            dt = Members.GetMembersCondition("1", "*", MembersTSql.GetMembersByImid(imid), "");

            tbTenDangNhap.Text = dt.Rows[0][MembersColumns.vMemberAccount].ToString();
            tbTenDangNhap.Enabled = false;
            hdTenDangNhap.Value = SecurityExtension.Encode(dt.Rows[0][MembersColumns.vMemberAccount].ToString());

            ltrGhiChuMatKhau.Text = "<div class='GhiChuMatKhau'>Để trống ô mật khẩu nếu không muốn thay đổi</div>";
            tbMatKhau.Text = dt.Rows[0][MembersColumns.vMemberPassword].ToString();
            tbNhapLaiMatKhau.Text = dt.Rows[0][MembersColumns.vMemberPassword].ToString();
            RequiredFieldValidator2.Visible = false;
            RequiredFieldValidator3.Visible = false;

            tbEmail.Text = dt.Rows[0][MembersColumns.vMemberEmail].ToString();

            tbHoTen.Text = dt.Rows[0][MembersColumns.vMemberName].ToString();
            tbNgaySinh.Text = ((DateTime)dt.Rows[0][MembersColumns.dMemberBirthday]).ToString("MM/dd/yyyy");
            ddlGioiTinh.SelectedValue = tbTenDangNhap.Text = dt.Rows[0][MembersColumns.vMemberIdentityCard].ToString();
            tbDiaChi.Text = dt.Rows[0][MembersColumns.vMemberAddress].ToString();
            tbDienThoai.Text = dt.Rows[0][MembersColumns.vMemberPhone].ToString();
            tbTrinhDoHocVan.Text = dt.Rows[0][MembersColumns.vMemberEdu].ToString();
            tbNgheNghiep.Text = dt.Rows[0][MembersColumns.vMemberJob].ToString();
            tbQuanHeXaHoi.Text = dt.Rows[0][MembersColumns.vMemberRelationship].ToString();
            tbTenDangNhap.Text = dt.Rows[0][MembersColumns.vMemberAccount].ToString();
            tbChieuCao.Text = dt.Rows[0][MembersColumns.VmemberheightColumn].ToString();
            tbCanNang.Text = dt.Rows[0][MembersColumns.VmemberweightColumn].ToString();
            tbCauGioiThieuNgan.Text = dt.Rows[0][MembersColumns.VmemberblastColumn].ToString();
            ddlKichHoat.SelectedValue = dt.Rows[0][MembersColumns.iMemberIsApproved].ToString();
            ddlTrangThai.SelectedValue = dt.Rows[0][MembersColumns.iMemberIsLockedOut].ToString();

            #region Image
            if (!dt.Rows[0][MembersColumns.vMemberImage].ToString().Equals(""))
            {
                ltimg.Text = ImagesExtension.GetImage(pic, dt.Rows[0][MembersColumns.vMemberImage].ToString(), "", "imgItem", false, false, "", false);
                lnk_delete_Image_current.Visible = true;
            }
            else
            {
                ltimg.Visible = false;
                lnk_delete_Image_current.Visible = false;
            }
            hd_img.Value = dt.Rows[0][MembersColumns.vMemberImage].ToString();
            #endregion

            #region Các trường không xuất hiện trên form
            hdvProperty.Value= dt.Rows[0][MembersColumns.VpropertyColumn].ToString();
            hdvMemberYahooNick.Value = dt.Rows[0][MembersColumns.vMemberYahooNick].ToString();
            hdvMemberPasswordQuestion.Value = dt.Rows[0][MembersColumns.vMemberPasswordQuestion].ToString();
            hdvMemberPasswordAnswer.Value = dt.Rows[0][MembersColumns.vMemberPasswordAnswer].ToString();
            hdvMemberComment.Value = dt.Rows[0][MembersColumns.vMemberComment].ToString();
            hdiMemberTotalLogin.Value = dt.Rows[0][MembersColumns.ImemberTotalLoginColumn].ToString();
            hdiMemberTotalview.Value = dt.Rows[0][MembersColumns.ImembertotalviewColumn].ToString();
            #endregion
        }
        #endregion
        #region  insert
        else
        {                       
            tbTenDangNhap.Focus();
        }
        #endregion
    }

    void ResetControls()
    {
        foreach (System.Web.UI.Control textBox in this.Controls)
        {
            if (textBox is System.Web.UI.WebControls.TextBox)
            {
                ((TextBox) textBox).Text = "";
            }
        }
        
        ltimg.Text = "";
        hd_img.Value = "";

        //Gọi lại khởi tạo xử lý ảnh
        KhoiTaoXuLyAnh();
    }

    protected void lnk_delete_Image_current_Click(object sender, EventArgs e)
    {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hd_img.Value);
        ltimg.Visible = false;
        hd_img.Value = "";
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkRedirect());
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        if (CheckExistedAcount(tbTenDangNhap.Text, insert,SecurityExtension.Decode(hdTenDangNhap.Value)))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Tên đăng nhập này đã được sử dụng. Vui lòng chọn tên đăng nhập khác.');", true);
            tbTenDangNhap.Focus();
            return;
        }

        if (CheckExistedEmail(tbEmail.Text, insert, SecurityExtension.Decode(hdTenDangNhap.Value)))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Email này đã được sử dụng. Vui lòng chọn email khác.');", true);
            tbEmail.Focus();
            return;
        }

        if (tbNgaySinh.Text.Length < 1)
            tbNgaySinh.Text = DateTime.Now.AddYears(-20).ToString();
    
        #region Image
        string vimg = "";
        string vimg_thumb = "";
        if (flimg.PostedFile.ContentLength > 0)
        {
            string filename = flimg.FileName;
            string fileex = filename.Substring(filename.LastIndexOf("."));
            string path = Request.PhysicalApplicationPath + "/" + pic + "/";
            if (TatThanhJsc.Extension.ImagesExtension.ValidType(fileex))
            {
                string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
                if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
                string ticks = DateTime.Now.Ticks.ToString();
                #region Lưu ảnh đại diện theo 2 trường hợp: tạo ảnh nhỏ hoặc không.
                //Kiểm tra xem có tạo ảnh nhỏ hay ko
                //Nếu không tạo ảnh nhỏ, tên tệp lưu bình thường theo kiểu: tên_tệp.phần_mở_rộng
                //Nếu tạo ảnh nhỏ, tên tệp sẽ theo kiểu: tên_tệp_HasThumb.phần_mở_rộng
                //Khi đó tên tệp ảnh nhỏ sẽ theo kiểu:   tên_tệp_HasThumb_Thumb.phần_mở_rộng
                //Với cách lưu tên ảnh này, khi thực hiện lưu vào csdl chỉ cần lưu tên ảnh gốc
                //khi hiển thị chỉ cần dựa vào tên ảnh gốc để biết ảnh đó có ảnh nhỏ hay không, việc này được thực hiện bởi TatThanhJsc.Extension.ImagesExtension.GetImage, lập trình không cần làm gì thêm.
                if (cbTaoAnhNho.Checked)
                    vimg = fileNotEx + "_" + ticks + "_HasThumb" + fileex;
                else
                    vimg = fileNotEx + "_" + ticks + fileex;
                flimg.SaveAs(path + vimg);
                #endregion
                #region Hạn chế kích thước
                if (cbHanCheKichThuoc.Checked)
                    ImagesExtension.ResizeImage(path + vimg, "", tbHanCheW.Text, tbHanCheH.Text);
                #endregion
                #region Đóng dấu ảnh
                if (cbDongDauAnh.Checked)
                    ImagesExtension.CreateWatermark(path + vimg, path + hdLogoImage.Value, hdViTriDongDau.Value, hdLeX.Value, hdLeY.Value, hdTyLe.Value, hdTrongSuot.Value);
                #endregion
                #region Tạo ảnh nhỏ: Thực hiện cuối để đảm bảo ảnh nhỏ cũng có con dấu
                if (cbTaoAnhNho.Checked)
                {
                    vimg_thumb = fileNotEx + "_" + ticks + "_HasThumb_Thumb" + fileex;
                    ImagesExtension.ResizeImage(path + vimg, path + vimg_thumb, tbAnhNhoW.Text, tbAnhNhoH.Text);

                    
                }
                #endregion

                
            }
        }  

        #endregion



        #region Insert
        if (insert)
        {            
            Members.InsertMembers(
                app,tbTenDangNhap.Text,tbMatKhau.Text,tbHoTen.Text,tbDiaChi.Text,tbDienThoai.Text,
                tbEmail.Text,tbNgaySinh.Text,ddlGioiTinh.SelectedValue,tbQuanHeXaHoi.Text,tbTrinhDoHocVan.Text,tbNgheNghiep.Text,
                "",vimg,"","",ddlKichHoat.Text,ddlTrangThai.SelectedValue,"","0","0",
                tbCanNang.Text, tbChieuCao.Text, tbCauGioiThieuNgan.Text);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTenDangNhap.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới thành viên " + tbTenDangNhap.Text);
            #endregion

        }
        #endregion
        #region Update
        else
        {
            if (vimg.Equals(""))            
                vimg = hd_img.Value;            
            else            
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hd_img.Value);                        

            Members.UpdateMembersInfo(imid,hdvProperty.Value,SecurityExtension.Decode(hdTenDangNhap.Value),tbHoTen.Text,
                tbDiaChi.Text,tbDienThoai.Text,tbEmail.Text,tbNgaySinh.Text,ddlGioiTinh.SelectedValue,
                tbQuanHeXaHoi.Text,tbTrinhDoHocVan.Text,tbNgheNghiep.Text,hdvMemberYahooNick.Value,vimg,
                hdvMemberPasswordQuestion.Value,hdvMemberPasswordAnswer.Value,
                ddlKichHoat.SelectedValue,ddlTrangThai.SelectedValue,hdvMemberComment.Value,hdiMemberTotalLogin.Value,hdiMemberTotalview.Value,
                tbCanNang.Text,tbChieuCao.Text,tbCauGioiThieuNgan.Text);

            if (tbMatKhau.Text.Length > 0 && tbMatKhau.Text == tbNhapLaiMatKhau.Text)            
                Members.UpdateMembersPasswordByAccount(SecurityExtension.Decode(hdTenDangNhap.Value),tbMatKhau.Text);            

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTenDangNhap.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật thành viên " + tbTenDangNhap.Text);
            #endregion
        }
        #endregion       

        #region After Insert/Update
        if (cbTiepTuc.Checked)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Đã tạo: " + tbTenDangNhap.Text + "');", true);
            ResetControls();
        }
        else
            Response.Redirect(LinkRedirect());
        #endregion
    }

    /// <summary>
    /// Kiểm tra xem tài khoản này đã có trong bảng member hay chưa, nếu là cập nhật sẽ kiểm tra các dòng trừ dòng hiện tại
    /// </summary>
    /// <param name="acount"></param>
    /// <param name="insert"></param>
    /// <param name="tenDangNhapHienTai"></param>
    /// <returns></returns>
    private bool CheckExistedAcount(string acount, bool insert, string tenDangNhapHienTai)
    {
        condition = MembersTSql.GetMembersByVmemberaccount(acount);
        if (!insert)
            condition = DataExtension.AndConditon(condition, MembersColumns.vMemberAccount + " <> '" + tenDangNhapHienTai + "'");
        DataTable dt = new DataTable();
        dt = Members.GetMembersCondition("1", MembersColumns.IMID, condition, "");
        return dt.Rows.Count > 0;
    }

    /// <summary>
    /// Kiểm tra xem email này đã có trong bảng member hay chưa, nếu là cập nhật sẽ kiểm tra các dòng trừ dòng hiện tại
    /// </summary>
    /// <param name="email"></param>
    /// <param name="insert"></param>
    /// <param name="tenDangNhapHienTai"></param>
    /// <returns></returns>
    private bool CheckExistedEmail(string email, bool insert, string tenDangNhapHienTai)
    {
        condition = MembersTSql.GetMembersByVmemberemail(email);
        if (!insert)
            condition = DataExtension.AndConditon(condition, MembersColumns.vMemberAccount + " <> '" + tenDangNhapHienTai + "'");
        DataTable dt = new DataTable();
        dt = Members.GetMembersCondition("1", MembersColumns.IMID, condition, "");
        return dt.Rows.Count > 0;
    }
}