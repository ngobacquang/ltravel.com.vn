using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
using TatThanhJsc.WebsiteModul;


public partial class cms_admin_ModulMain_Website_PopUp_Items_AddPictureToCate : System.Web.UI.Page
{
    string top = "";
    string fields = "";
    string orderby = "";
    string condition = "";
    string app = CodeApplications.WebsiteImagesOther;
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    protected string igid = "";
    string pathFolderPic = FolderPic.Website;
    public static bool update = false;//Bien danh dau cap nhat hay them moi    
    private static string hd_img = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["igid"] != null)
            igid = QueryStringExtension.GetQueryString("igid");
        if (Request.QueryString["iid"] != null)
            currentIid.Value = QueryStringExtension.GetQueryString("iid");
        else
            currentIid.Value = "";

        if (!IsPostBack)
        {
            GetCateInfo();
            GetList();
            KhoiTaoXuLyAnh();

            if (currentIid.Value.Length > 0)
                OpenUpdatePanel(currentIid.Value);
        }
    }

    void KhoiTaoXuLyAnh()
    {
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;
        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_AnhDau, language);
        #endregion
        hdViTriDongDau.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_ViTri, language);
        hdLeX.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_LeNgang, language);
        hdLeY.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_LeDoc, language);
        hdTyLe.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_TyLe, language);
        hdTrongSuot.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhWebsite, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhWebsite_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhWebsite_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhWebsite, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhWebsite_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhWebsite_MaxHeight, language);
        #endregion
    }

    #region GetCateInfo
    void GetCateInfo()
    {
        fields = "*";
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Groups.GetGroups("", fields, GroupsTSql.GetGroupsByIgid(igid), "");
        #region ThongTinCoBan
            ltrName.Text = @"
<div class='fwb'>
    Tên tổ chức: " + dt.Rows[0][GroupsColumns.VgnameColumn].ToString() + @"
</div>
<div class='cbh20'><!----></div>
";
        #endregion
    }
    #endregion    
    protected void btInsert_Click(object sender, EventArgs e)
    {
        ltrInsertUpdate.Text = "Thêm mới hình ảnh";
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
       
        if (!update)
            GroupsItems.InsertItemsGroupsItems(language, app, "", tbName.Text,"","",vimg,"","","","","","","","","","","","0","0","0","0",DateTime.Now.ToString(),DateTime.Now.ToString(),DateTime.Now.ToString(),tbOrder.Text,igid,DateTime.Now.ToString(),DateTime.Now.ToString(),DateTime.Now.ToString(),tbOrder.Text,ddlStatus.SelectedValue);
        else
        {
            if (vimg.Equals(""))
                vimg = hd_img;
            else
                ImagesExtension.DeleteImageWhenDeleteItem(pathFolderPic, hd_img);

            TatThanhJsc.Database.Items.UpdateItems(language, app, "", tbName.Text, "", "", vimg, "", "", "", "", "", "", "", "", "", "", "", "0", "0", "0", "0", tbOrder.Text, DateTime.Now.ToString(),DateTime.Now.ToString(),ddlStatus.SelectedValue,currentIid.Value);
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
        hd_img = "";
        ltimg.Text = "";
    }    
    protected void btCancel_Click(object sender, EventArgs e)
    {
        //ResetControls();
        //pnList.Visible = true;
        //pnInsert.Visible = false;

        Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/Moduls/Website/Cate/PopUp/AddPictureToCate.aspx?igid=" + igid);
    }
    void GetList()
    {
        condition = DataExtension.AndConditon
            (            
            GroupsItemsTSql.GetItemsInGroupCondition(igid,ItemsColumns.IienableColumn+"<>2"),
            ItemsTSql.GetItemsByViapp(app)
            );
        orderby = ItemsColumns.IiorderColumn;
        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData("", "*", condition, orderby);
        rptList.DataSource = dt;
        rptList.DataBind();
    }
    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        fields = "*";
        condition = ItemsTSql.GetItemsByIid(p);
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Items.GetItems("1", "*", condition, "");
        switch (c)
        {
            #region Delete
            case "delete":
                ImagesExtension.DeleteImageWhenDeleteItem(pathFolderPic, dt.Rows[0][ItemsColumns.ViimageColumn].ToString());
                TatThanhJsc.Database.Items.DeleteItems(p);
                GetList();
                break;
            #endregion
            #region Edit Enable
            case "EditEnable":
                string[] fieldsEnable = { ItemsColumns.IienableColumn };
                string[] valuesEnable = { "" };
                if (dt.Rows[0][ItemsColumns.IienableColumn].ToString().Equals("0"))
                {
                    valuesEnable[0] = "1";
                   TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                else
                {
                    valuesEnable[0] = "0";
                    TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                GetList();
                break;
            #endregion
            #region Edit
            case "edit":
                //OpenUpdatePanel(p);
                Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/Moduls/Website/Cate/PopUp/AddPictureToCate.aspx?igid=" + igid + "&iid=" + p);
                break;
            #endregion
        }
    }
    void OpenUpdatePanel(string iid)
    {
        ltrInsertUpdate.Text = "Cập nhật hình ảnh";
        update = true;
        currentIid.Value = iid;
        pnList.Visible = false;
        pnInsert.Visible = true;        
        condition = ItemsTSql.GetItemsByIid(iid);
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Items.GetItems("1", "*", condition, "");
        if (dt.Rows.Count > 0)
        {           
            tbName.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
            tbOrder.Text = dt.Rows[0][ItemsColumns.IiorderColumn].ToString();
            ddlStatus.SelectedValue = dt.Rows[0][ItemsColumns.IienableColumn].ToString();
            ltimg.Text = ImagesExtension.GetImage(pathFolderPic, dt.Rows[0][ItemsColumns.ViimageColumn].ToString(), "", "hotelImage", false, false, "");
            hd_img = dt.Rows[0][ItemsColumns.ViimageColumn].ToString();
        }
    }

    protected void UpdateOrder(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;

        string[] fields = { ItemsColumns.IiorderColumn };
        string[] values = { "N'" + textbox.Text + "'" };
        string condition = ItemsTSql.GetItemsByIid(textbox.ToolTip);
        TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fields, values), condition);
        //GetListWebsites("");
    }

    protected void UpdateTitle(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;

        string[] fields = { ItemsColumns.VititleColumn };
        string[] values = { "N'" + textbox.Text + "'" };
        string condition = ItemsTSql.GetItemsByIid(textbox.ToolTip);
        TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fields, values), condition);
        //GetListWebsites("");
    }
}
