using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;
public partial class cms_admin_Moduls_Hotel_Item_Popup_PopupThemHinhAnhAspx : System.Web.UI.Page
{
    private string LoginSetting = "LoginSetting";

    private string app = CodeApplications.HotelPhoto;
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
                ltrHead.Text = "Thêm hình ảnh";
            else
                ltrHead.Text = "Sửa hình ảnh";

            LayCacThongTinLienKet();
        }
    }

    private void LayCacThongTinLienKet()
    {
        InitialControlsValue();
    }

    private void InitialControlsValue()
    {
        //Trường hợp sửa hình ảnh
        if(isid != "")
        {
            string condition = DataExtension.AndConditon(SubitemsTSql.GetSubitemsByVskey(app),
                SubitemsTSql.GetSubitemsByIsid(isid));

            DataTable dt = Subitems.GetSubItems("1", "*", condition, "");
            if(dt.Rows.Count > 0)
            {
                tbTieuDe.Text = dt.Rows[0][SubitemsColumns.VstitleColumn].ToString();
                tbMoTa.Text = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
                flAnhDaiDien.Load(dt.Rows[0][SubitemsColumns.VsimageColumn].ToString());


                tbThuTu.Text = dt.Rows[0][SubitemsColumns.VsatuthorColumn].ToString();
                cbTrangThai.Checked = (dt.Rows[0][SubitemsColumns.IsenableColumn].ToString() == "1");
            }
        }
    }



    
    protected void btOK_Click(object sender, EventArgs e)
    {        
        #region Trạng thái
        string trangThai = "0";
        if (cbTrangThai.Checked == true)
            trangThai = "1";
        #endregion

        if(isid != "")
        {
            string image = flAnhDaiDien.Save(true, "");
            Subitems.UpdateSubitems(iid, lang, app, tbTieuDe.Text, tbMoTa.Text, image, "", tbThuTu.Text, "",
                DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), trangThai, isid);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "",
            //"jAlert('Đã sửa: " + tbTieuDe.Text + "','Thông báo')", true);

            ltrThongBao.Text = "Thông báo: đã sửa " + tbTieuDe.Text;
        }
        else
        {
            string image = flAnhDaiDien.Save(false, "");
            Subitems.InsertSubitems(iid, lang, app, tbTieuDe.Text, tbMoTa.Text, image, "", tbThuTu.Text, "",
            DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), trangThai);

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "",
            //"jAlert('Đã tạo: " + tbTieuDe.Text + "','Thông báo')", true);

            ltrThongBao.Text = "Thông báo: đã tạo " + tbTieuDe.Text;
        }        

        ResetControls();
    }
    void ResetControls()
    {
        tbTieuDe.Text = tbMoTa.Text = "";

        flAnhDaiDien.Reset();
                
        try
        {
            tbThuTu.Text = (Convert.ToInt32(tbThuTu.Text) + 1).ToString();
        }
        catch { }
        tbTieuDe.Focus();
    }
}