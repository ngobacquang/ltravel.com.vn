using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.CruisesModul;
using TatThanhJsc.TSql;
public partial class cms_admin_Moduls_Cruises_Item_Popup_PopupThemLichTrinhAspx : System.Web.UI.Page
{
    private string LoginSetting = "LoginSetting";

    private string app = CodeApplications.CruisesItinerary;
    private string appCate = CodeApplications.Cruises;
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = FolderPic.Cruises;

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
        tbHoatDongChiTiet.FilebrowserImageBrowseUrl = UrlExtension.WebisteUrl + "ckeditor/ckfinder/ckfinder.aspx?type=Images&path=" + pic;        
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
                ltrHead.Text = "Thêm lịch trình";
            else
                ltrHead.Text = "Sửa lịch trình";

            LayCacThongTinLienKet();
        }
    }

    private void LayCacThongTinLienKet()
    {
        LayLienKetDiemDenSeQua();
        InitialControlsValue();
    }

    private void InitialControlsValue()
    {
        //Trường hợp sửa lịch trình
        if(isid != "")
        {
            string condition = DataExtension.AndConditon(SubitemsTSql.GetSubitemsByVskey(app),
                SubitemsTSql.GetSubitemsByIsid(isid));

            DataTable dt = Subitems.GetSubItems("1", "*", condition, "");
            if(dt.Rows.Count > 0)
            {
                tbNgay.Text = StringExtension.LayChuoi(dt.Rows[0][SubitemsColumns.VstitleColumn].ToString(), "", 1);
                tbTenHoatDong.Text = StringExtension.LayChuoi(dt.Rows[0][SubitemsColumns.VstitleColumn].ToString(), "", 2);
                flAnhDaiDien.Load(dt.Rows[0][SubitemsColumns.VsimageColumn].ToString());

                #region Các điểm đến sẽ qua
                if (dt.Rows[0][SubitemsColumns.VsurlColumn].ToString().StartsWith("text-"))
                    tbCacDiemDenSeQua.Text = dt.Rows[0][SubitemsColumns.VsurlColumn].ToString().Substring("text-".Length);
                if (dt.Rows[0][SubitemsColumns.VsurlColumn].ToString().StartsWith("id-"))
                {
                    hdIdCacDiemDenSeQua.Value = "," + dt.Rows[0][SubitemsColumns.VsurlColumn].ToString().Substring("id-".Length) + ",";
                }
                #endregion

                #region Bữa ăn
                string listId = "," + dt.Rows[0][SubitemsColumns.VsemailColumn].ToString() + ",";
                for(int i = 0; i < cblBuaAn.Items.Count; i++)
                {
                    if(listId.IndexOf("," + cblBuaAn.Items[i].Value + ",") > -1)
                        cblBuaAn.Items[i].Selected = true;
                }
                #endregion

                tbThuTu.Text = dt.Rows[0][SubitemsColumns.VsatuthorColumn].ToString();
                cbTrangThai.Checked = (dt.Rows[0][SubitemsColumns.IsenableColumn].ToString() == "1");

                tbHoatDongChiTiet.Text = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
                hdHoatDongChiTiet.Value = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
            }
        }
    }



    #region Lấy liên kết các điểm sẽ qua
    private void LayLienKetDiemDenSeQua()
    {
        string s = "";
        string app = TatThanhJsc.DestinationModul.CodeApplications.Destination;
        string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.IglevelColumn);
        string condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByVgapp(app),
            GroupsTSql.GetGroupsByIgparentid("0"),
            GroupsTSql.GetGroupsByVglang(lang),
            GroupsColumns.IgenableColumn + "<>2"
            );
        string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
        DataTable dt = Groups.GetGroups("", fields, condition, orderBy);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            s += @"
<div class='dest0'>
    <label for='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "'><input id='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "' type='checkbox'/>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</label>
    " + LayLienKetDiemDenSeQua_Cap2(dt.Rows[i][GroupsColumns.IgidColumn].ToString(), dt.Rows[i][GroupsColumns.IglevelColumn].ToString()) + @"
</div>";
        }

        ltrCacDiemDenChuaChon.Text = s;
    }

    private string LayLienKetDiemDenSeQua_Cap2(string parentId, string parentLevel)
    {
        string s = "";
        string app = TatThanhJsc.DestinationModul.CodeApplications.Destination;
        string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.IglevelColumn);
        string condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByVgapp(app),
            GroupsTSql.GetGroupsByIgparentid(parentId),
            GroupsTSql.GetGroupsByVglang(lang),
            GroupsColumns.IgenableColumn + "<>2"
            );
        string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
        DataTable dt = Groups.GetGroups("", fields, condition, orderBy);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            s += @"
<div class='dest" + parentLevel + @"'>
    <label for='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "'><input id='cbd_0_" + dt.Rows[i][GroupsColumns.IgidColumn] + "' type='checkbox'/>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</label>
    " + LayLienKetDiemDenSeQua_Cap2(dt.Rows[i][GroupsColumns.IgidColumn].ToString(), dt.Rows[i][GroupsColumns.IglevelColumn].ToString()) + @"
</div>";
        }

        return s;
    }

    #endregion
    protected void btOK_Click(object sender, EventArgs e)
    {
        #region Các điểm đến
        string cacDiemDen = tbCacDiemDenSeQua.Text;
        if (cacDiemDen.Trim() == "")//Nếu không nhập thì lấy danh sách id tích chọn
        {
            cacDiemDen = hdIdCacDiemDenSeQua.Value;
            if (cacDiemDen != "")
                cacDiemDen = "id-" + cacDiemDen;
        }
        else
        {
            cacDiemDen = "text-" + cacDiemDen;
        }
        #endregion

        string hoatDongChiTiet = ContentExtendtions.ProcessStringContent(tbHoatDongChiTiet.Text, hdHoatDongChiTiet.Value, pic);
        string tenHoatDong = StringExtension.GhepChuoi("", tbNgay.Text, tbTenHoatDong.Text);
        
        #region Bữa ăn
        string buaAn = "";
        for (int i = 0; i < cblBuaAn.Items.Count; i++)
        {
            if (cblBuaAn.Items[i].Selected)
                buaAn += cblBuaAn.Items[i].Value + ",";
        }
        #endregion

        #region Trạng thái
        string trangThai = "0";
        if (cbTrangThai.Checked == true)
            trangThai = "1";
        #endregion

        if(isid != "")
        {
            string image = flAnhDaiDien.Save(true, hoatDongChiTiet);
            Subitems.UpdateSubitems(iid, lang, app, tenHoatDong, hoatDongChiTiet, image, buaAn, tbThuTu.Text, cacDiemDen,
                DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), trangThai, isid);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "",
            //"jAlert('Đã sửa: " + tbNgay.Text + ": " + tbTenHoatDong.Text + "','Thông báo')", true);

            ltrThongBao.Text = "Thông báo: đã sửa " + tbTenHoatDong.Text;
        }
        else
        {
            string image = flAnhDaiDien.Save(false, hoatDongChiTiet);
            Subitems.InsertSubitems(iid, lang, app, tenHoatDong, hoatDongChiTiet, image, buaAn, tbThuTu.Text, cacDiemDen,
            DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), trangThai);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "",
            //"jAlert('Đã tạo: " + tbNgay.Text + ": " + tbTenHoatDong.Text + "','Thông báo')", true);

            ltrThongBao.Text = "Thông báo: đã tạo " + tbTenHoatDong.Text;
        }        

        ResetControls();
    }
    void ResetControls()
    {
        tbNgay.Text = tbTenHoatDong.Text = tbCacDiemDenSeQua.Text = tbHoatDongChiTiet.Text = "";
        hdHoatDongChiTiet.Value = hdIdCacDiemDenSeQua.Value = "";
        cblBuaAn.ClearSelection();

        flAnhDaiDien.Reset();
                
        try
        {
            tbThuTu.Text = (Convert.ToInt32(tbThuTu.Text) + 1).ToString();
        }
        catch { }
        tbNgay.Focus();
    }
}