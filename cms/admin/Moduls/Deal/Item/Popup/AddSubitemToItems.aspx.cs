using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.DealModul;
using TatThanhJsc.TSql;


public partial class cms_admin_ModulMain_Video_PopUp_Items_AddSubitemToItems : System.Web.UI.Page
{
    string top = "";
    string fields = "";
    string orderby = "";
    string condition = "";
    string app = CodeApplications.DealSubitemOther;
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    protected string iid = "";
    string pathFolderPic = FolderPic.Deal;
    public static bool update = false;//Bien danh dau cap nhat hay them moi    
    private static string hd_img = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["iid"] != null)
            iid = QueryStringExtension.GetQueryString("iid");
        if (Request.QueryString["isid"] != null)
            currentIsid.Value = QueryStringExtension.GetQueryString("isid");
        else
            currentIsid.Value = "";

        if (!IsPostBack)
        {            
            GetItemsInfo();
            GetList();
            KhoiTaoXuLyAnh();

            if (currentIsid.Value.Length > 0)
                OpenUpdatePanel(currentIsid.Value);
        }
    }

    void KhoiTaoXuLyAnh()
    {
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;
        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_AnhDau, language);
        #endregion
        hdViTriDongDau.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_ViTri, language);
        hdLeX.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_LeNgang, language);
        hdLeY.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_LeDoc, language);
        hdTyLe.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_TyLe, language);
        hdTrongSuot.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhDeal_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDeal, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDeal_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhDeal_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDeal, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDeal_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhDeal_MaxHeight, language);
        #endregion
    }

    #region GetItemsInfo
    void GetItemsInfo()
    {
        fields = DataExtension.GetListColumns(ItemsColumns.VititleColumn, ItemsColumns.FipriceColumn, ItemsColumns.FisalepriceColumn);
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Items.GetItems("", fields, ItemsTSql.GetItemsByIid(iid), "");
        #region ThongTinCoBan
        ltrName.Text = @"
<div class='fwb'>
    Tên deal: " + dt.Rows[0][ItemsColumns.VititleColumn].ToString() + @"
</div>
<div class='cbh20'><!----></div>
";
        #endregion
    }
    #endregion    
    protected void btInsert_Click(object sender, EventArgs e)
    {
        ltrInsertUpdate.Text = "Thêm mới loại";
        update = false;
        pnList.Visible = false;
        pnInsert.Visible = true;        
    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        #region Image
        string vimg = "";
        string vimg_thumb = "";
        if (flimg.PostedFile.ContentLength > 0)
        {
            string filename = flimg.FileName;
            string fileex = filename.Substring(filename.LastIndexOf("."));
            string path = Request.PhysicalApplicationPath + "/" + pathFolderPic + "/";
            if (ImagesExtension.ValidType(fileex))
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
                //khi hiển thị chỉ cần dựa vào tên ảnh gốc để biết ảnh đó có ảnh nhỏ hay không, việc này được thực hiện bởi ImagesExtension.GetImage, lập trình không cần làm gì thêm.
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

        /*
         * Thêm mới loại
         * modul - vskey,vsemail - mã màu,vstitle - tên, vsimage - loại, vsauthor - thứ tự, isenable - trạng thái
         */        

        if (!update)
            Subitems.InsertSubitems(iid, language, app, tbName.Text, tbMoTa.Text, vimg, tbPrice.Text, tbOrder.Text, tbPriceOld.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), ddlStatus.SelectedValue);
        else
        {
            if (vimg.Equals(""))
                vimg = hd_img;
            else
                ImagesExtension.DeleteImageWhenDeleteItem(pathFolderPic, hd_img);
            Subitems.UpdateSubitems(iid, language, app, tbName.Text, tbMoTa.Text, vimg, tbPrice.Text, tbOrder.Text, tbPriceOld.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), ddlStatus.SelectedValue, currentIsid.Value);
        }

        ResetControls();
        GetList();
        pnList.Visible = true;
        pnInsert.Visible = false;
    }
    void ResetControls()
    {
        tbName.Text = "";
        tbOrder.Text = "";
        tbMoTa.Text = "";
        tbPrice.Text = "";
        tbPriceOld.Text = "";

        hd_img = "";
        ltimg.Text = "";
    }    
    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/Moduls/Deal/Item/PopUp/AddSubitemToItems.aspx?iid=" + iid);
    }
    void GetList()
    {
        condition = DataExtension.AndConditon
            (            
            SubitemsTSql.GetSubitemsByIid(iid),
            SubitemsTSql.GetSubitemsByVskey(app)
            );
        orderby =  SubitemsColumns.VsatuthorColumn + " asc";
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("", "*", condition, orderby);
        rptList.DataSource = dt;
        rptList.DataBind();
    }
    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        fields = "*";
        condition = SubitemsTSql.GetSubitemsByIsid(p);
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("", "*", condition, "");
        switch (c)
        {
            #region Delete
            case "delete":
                ImagesExtension.DeleteImageWhenDeleteItem(pathFolderPic, dt.Rows[0][SubitemsColumns.VsimageColumn].ToString());
                Subitems.DeleteSubitems(p);
                GetList();
                break;
            #endregion
            #region Edit Enable
            case "EditEnable":                
                string[] fieldsEnable = { SubitemsColumns.IsenableColumn };
                string[] valuesEnable = { "" };
                if (dt.Rows[0][SubitemsColumns.IsenableColumn].ToString().Equals("0"))
                {
                    valuesEnable[0] = "1";
                    Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                else
                {
                    valuesEnable[0] = "0";
                    Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                GetList();
                break;
            #endregion
            #region Edit
            case "edit":
                //OpenUpdatePanel(p);
                Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/Moduls/Deal/Item/PopUp/AddSubitemToItems.aspx?iid=" + iid + "&isid=" + p);
                break;
            #endregion
        }
    }
    void OpenUpdatePanel(string isid)
    {
        ltrInsertUpdate.Text = "Cập nhật loại";
        update = true;
        currentIsid.Value = isid;
        pnList.Visible = false;
        pnInsert.Visible = true;        
        condition = SubitemsTSql.GetSubitemsByIsid(isid);
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("", "*", condition, "");
        if (dt.Rows.Count > 0)
        {            
            tbName.Text = dt.Rows[0][SubitemsColumns.VstitleColumn].ToString();
            tbOrder.Text = dt.Rows[0][SubitemsColumns.VsatuthorColumn].ToString();
            ddlStatus.SelectedValue = dt.Rows[0][SubitemsColumns.IsenableColumn].ToString();
            ltimg.Text = ImagesExtension.GetImage(pathFolderPic, dt.Rows[0][SubitemsColumns.VsimageColumn].ToString(), "", "hotelImage", false, false, "");
            hd_img = dt.Rows[0][SubitemsColumns.VsimageColumn].ToString();

            tbMoTa.Text = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
            tbPrice.Text = dt.Rows[0][SubitemsColumns.VsemailColumn].ToString();
            tbPriceOld.Text = dt.Rows[0][SubitemsColumns.VsurlColumn].ToString();
        }
    }

    protected void UpdateOrder(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;

        string[] fields = { SubitemsColumns.VsatuthorColumn };
        string[] values = { "N'" + textbox.Text + "'" };
        string condition = SubitemsTSql.GetSubitemsByIsid(textbox.ToolTip);
        Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fields, values), condition);
        //GetListDeals("");
    }

    protected void UpdateTitle(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;

        string[] fields = { SubitemsColumns.VstitleColumn };
        string[] values = { "N'" + textbox.Text + "'" };
        string condition = SubitemsTSql.GetSubitemsByIsid(textbox.ToolTip);
        Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fields, values), condition);
        //GetListDeals("");
    }
}
