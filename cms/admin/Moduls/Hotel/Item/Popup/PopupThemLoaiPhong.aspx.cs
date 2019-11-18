using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;
public partial class cms_admin_Moduls_Hotel_Item_Popup_PopupThemLoaiPhongAspx : System.Web.UI.Page
{
    private string LoginSetting = "LoginSetting";

    private string app = CodeApplications.Hotel;
    private string appCate = CodeApplications.Hotel;
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = FolderPic.Hotel;

    private string iid = "";
    private string isid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        #region Kiểm tra đăng nhập
        if (!CookieExtension.CheckValidCookies(LoginSetting))
        {
            this.Visible = false;
            return;
        }
        #endregion

        #region Gán app, pic cho user control upload ảnh đại diện
        flAnhDaiDien.App = appCate;
        flAnhDaiDien.Pic = pic;
        #endregion

        #region Gán đường dẫn cho ckeditor
        tbChiTiet.FilebrowserImageBrowseUrl = UrlExtension.WebisteUrl + "ckeditor/ckfinder/ckfinder.aspx?type=Images&path=" + pic;        
        #endregion

        if(Request.QueryString["iid"] != null)
            iid = StringExtension.RemoveSqlInjectionChars(Request.QueryString["iid"]);

        if (Request.QueryString["isid"] != null)
            isid = StringExtension.RemoveSqlInjectionChars(Request.QueryString["isid"]);

        if(iid == "")
        {
            this.Visible = false;
            return;
        }

        if(!IsPostBack)
        {
            if(isid == "")
                ltrHead.Text = "Thêm loại phòng";
            else
                ltrHead.Text = "Sửa loại phòng";

            LayCacThongTinLienKet();
        }
    }

    private void LayCacThongTinLienKet()
    {
        LayLienKetBaoGom();
        InitialControlsValue();
    }

    private void InitialControlsValue()
    {
        //Trường hợp sửa loại phòng
        if(isid != "")
        {
            string condition = DataExtension.AndConditon(SubitemsTSql.GetSubitemsByVskey(app),
                SubitemsTSql.GetSubitemsByIsid(isid));

            DataTable dt = Subitems.GetSubItems("1", "*", condition, "");
            if(dt.Rows.Count > 0)
            {
                tbLoaiPhong.Text = dt.Rows[0][SubitemsColumns.VstitleColumn].ToString();                
                tbSuChuaToiDa.Text= dt.Rows[0][SubitemsColumns.isTotalSubitem].ToString();

                tbGiaNiemYet.Text = dt.Rows[0][SubitemsColumns.fsPrice].ToString();
                tbGiaKhuyenMai.Text = dt.Rows[0][SubitemsColumns.fsSalePrice].ToString();

                #region Bao gồm
                string baoGom = "," + dt.Rows[0][SubitemsColumns.VsemailColumn] + ",";
                for (int i = 0; i < cblBaoGom.Items.Count; i++)
                {
                    if (baoGom.IndexOf("," + cblBaoGom.Items[i].Value + ",") > -1)
                        cblBaoGom.Items[i].Selected = true;
                    else
                        cblBaoGom.Items[i].Selected = false;
                }
                #endregion

                tbChiTiet.Text = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
                hdChiTiet.Value = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();

                flAnhDaiDien.Load(dt.Rows[0][SubitemsColumns.VsimageColumn].ToString());

                ddlCoTheTraPhongKhong.SelectedValue= dt.Rows[0][SubitemsColumns.isParam1].ToString();
                ddlCoGomBuaSangKhong.SelectedValue = dt.Rows[0][SubitemsColumns.isParam2].ToString();

                tbDienTichPhong.Text = dt.Rows[0][SubitemsColumns.vsParam1].ToString();
                tbLoaiGiuong.Text = dt.Rows[0][SubitemsColumns.vsParam2].ToString();
                tbHuongPhong.Text = dt.Rows[0][SubitemsColumns.VsurlColumn].ToString();

                tbThuTu.Text = dt.Rows[0][SubitemsColumns.isOrder].ToString();
                cbTrangThai.Checked = (dt.Rows[0][SubitemsColumns.IsenableColumn].ToString() == "1");
            }
        }
    }

    #region Lấy liên kết dịch vụ bao gồm, không bao gồm
    void LayLienKetBaoGom()
    {
        string app = CodeApplications.HotelFacilityRoom;
        string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn);
        string condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByVgapp(app),
            GroupsTSql.GetGroupsByIgparentid("0"),
            GroupsTSql.GetGroupsByVglang(lang),
            GroupsColumns.IgenableColumn + "<>2"
            );
        string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
        DataTable dt = Groups.GetGroups("", fields, condition, orderBy);

        //DataRow dr = dt.NewRow();
        //dr[0] = "0";
        //dr[1] = "Chọn/bỏ tất cả";
        //dt.Rows.InsertAt(dr,0);

        cblBaoGom.DataSource = dt;
        cblBaoGom.DataTextField = GroupsColumns.VgnameColumn;
        cblBaoGom.DataValueField = GroupsColumns.IgidColumn;
        cblBaoGom.DataBind();
    }
    #endregion


    protected void btOK_Click(object sender, EventArgs e)
    {
        #region Bao gồm - included
        string baoGom = "";
        for (int i = 0; i < cblBaoGom.Items.Count; i++)
        {
            if (cblBaoGom.Items[i].Selected)
                baoGom += cblBaoGom.Items[i].Value + ",";
        }
        if (baoGom != "")
            baoGom = baoGom.Remove(baoGom.Length - ",".Length);
        #endregion

        string chiTiet = ContentExtendtions.ProcessStringContent(tbChiTiet.Text, hdChiTiet.Value, pic);
        
        #region Trạng thái
        string trangThai = "0";
        if (cbTrangThai.Checked == true)
            trangThai = "1";
        #endregion

        if(isid != "")
        {
            string image = flAnhDaiDien.Save(true, chiTiet);
            Subitems.UpdateSubitemsFull(iid, lang, app, tbLoaiPhong.Text, chiTiet, image, baoGom, "", tbHuongPhong.Text,
                DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), trangThai, isid,
                tbGiaNiemYet.Text,
                tbGiaKhuyenMai.Text, "", "", "", tbSuChuaToiDa.Text, tbThuTu.Text,
                ddlCoTheTraPhongKhong.SelectedValue, ddlCoGomBuaSangKhong.SelectedValue, tbDienTichPhong.Text,
                tbLoaiGiuong.Text, DateTime.Now.ToString(), DateTime.Now.ToString());


            ltrThongBao.Text = "Thông báo: đã sửa " + tbLoaiPhong.Text;
        }
        else
        {
            string image = flAnhDaiDien.Save(false, chiTiet);
            Subitems.InsertSubitemsFull(iid, lang, app, tbLoaiPhong.Text, chiTiet, image, baoGom, "", tbHuongPhong.Text,
                DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), trangThai, tbGiaNiemYet.Text,
                tbGiaKhuyenMai.Text, "", "", "", tbSuChuaToiDa.Text, tbThuTu.Text,
                ddlCoTheTraPhongKhong.SelectedValue, ddlCoGomBuaSangKhong.SelectedValue, tbDienTichPhong.Text,
                tbLoaiGiuong.Text, DateTime.Now.ToString(), DateTime.Now.ToString());

            
            ltrThongBao.Text = "Thông báo: đã tạo " + tbLoaiPhong.Text;
        }        

        ResetControls();
    }
    void ResetControls()
    {
        tbLoaiPhong.Text = tbGiaNiemYet.Text = tbGiaKhuyenMai.Text = tbLoaiGiuong.Text =tbHuongPhong.Text= tbChiTiet.Text="";
        hdChiTiet.Value = "";
        cblBaoGom.ClearSelection();

        flAnhDaiDien.Reset();
                
        try
        {
            tbThuTu.Text = (Convert.ToInt32(tbThuTu.Text) + 1).ToString();
        }
        catch { }
        tbLoaiPhong.Focus();
    }
}