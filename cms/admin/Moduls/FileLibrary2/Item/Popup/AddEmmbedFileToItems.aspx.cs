using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.FileLibrary2Modul;
using TatThanhJsc.TSql;


public partial class cms_admin_ModulMain_FileLibrary2_PopUp_Items_AddEmmbedFileToItems : System.Web.UI.Page
{
    string top = "";
    string fields = "";
    string orderby = "";
    string condition = "";
    string app = CodeApplications.FileLibrary2EmmbedFilesOther;
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    protected string iid = "";
    string pathFolderPic = FolderPic.FileLibrary2;
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

    protected string LayThongTinTep(string vscontent)
    {
        string s="";

        string file = StringExtension.LayChuoi(vscontent, "", 1);
        string fileLink = StringExtension.LayChuoi(vscontent, "", 2);

        if (file.Length > 0)
        {
            s = "<a href='" + TatThanhJsc.Extension.UrlExtension.WebisteUrl + pathFolderPic + "/" +
                         file + "' target='_blank'>" +
                         file + "</a>";
        }
        if(fileLink.Length>0)
            s += "<br/>" + "<a href='" + fileLink + "' target='_blank'>" +fileLink + "</a>";

        return s;
    }
    void KhoiTaoXuLyAnh()
    {
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhFileLibrary2, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;
        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhFileLibrary2_AnhDau, language);
        #endregion
        hdViTriDongDau.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhFileLibrary2_ViTri, language);
        hdLeX.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhFileLibrary2_LeNgang, language);
        hdLeY.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhFileLibrary2_LeDoc, language);
        hdTyLe.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhFileLibrary2_TyLe, language);
        hdTrongSuot.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhFileLibrary2_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhFileLibrary2, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhFileLibrary2_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhFileLibrary2_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhFileLibrary2, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhFileLibrary2_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhFileLibrary2_MaxHeight, language);
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
    Tên tệp đính kèm: " + dt.Rows[0][ItemsColumns.VititleColumn].ToString() + @"
</div>
<div class='cbh20'><!----></div>
";
        #endregion
    }
    #endregion    
    protected void btInsert_Click(object sender, EventArgs e)
    {
        ltrInsertUpdate.Text = "Thêm mới tệp đính kèm";
        update = false;
        pnList.Visible = false;
        pnInsert.Visible = true;        
    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        string vimg = "";//Không xử lý thêm ảnh mà chỉ thêm file
        //#region Image
        //string vimg = "";
        //string vimg_thumb = "";
        //if (flimg.PostedFile.ContentLength > 0)
        //{
        //    string filename = flimg.FileName;
        //    string fileex = filename.Substring(filename.LastIndexOf("."));
        //    string path = Request.PhysicalApplicationPath + "/" + pathFolderPic + "/";
        //    if (ImagesExtension.ValidType(fileex))
        //    {
        //        string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
        //        if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
        //        string ticks = DateTime.Now.Ticks.ToString();
        //        #region Lưu ảnh đại diện theo 2 trường hợp: tạo ảnh nhỏ hoặc không.
        //        //Kiểm tra xem có tạo ảnh nhỏ hay ko
        //        //Nếu không tạo ảnh nhỏ, tên tệp lưu bình thường theo kiểu: tên_tệp.phần_mở_rộng
        //        //Nếu tạo ảnh nhỏ, tên tệp sẽ theo kiểu: tên_tệp_HasThumb.phần_mở_rộng
        //        //Khi đó tên tệp ảnh nhỏ sẽ theo kiểu:   tên_tệp_HasThumb_Thumb.phần_mở_rộng
        //        //Với cách lưu tên ảnh này, khi thực hiện lưu vào csdl chỉ cần lưu tên ảnh gốc
        //        //khi hiển thị chỉ cần dựa vào tên ảnh gốc để biết ảnh đó có ảnh nhỏ hay không, việc này được thực hiện bởi ImagesExtension.GetImage, lập trình không cần làm gì thêm.
        //        if (cbTaoAnhNho.Checked)
        //            vimg = fileNotEx + "_" + ticks + "_HasThumb" + fileex;
        //        else
        //            vimg = fileNotEx + "_" + ticks + fileex;
        //        flimg.SaveAs(path + vimg);
        //        #endregion
        //        #region Hạn chế kích thước
        //        if (cbHanCheKichThuoc.Checked)
        //            ImagesExtension.ResizeImage(path + vimg, "", tbHanCheW.Text, tbHanCheH.Text);
        //        #endregion
        //        #region Đóng dấu ảnh
        //        if (cbDongDauAnh.Checked)
        //            ImagesExtension.CreateWatermark(path + vimg, path + hdLogoImage.Value, hdViTriDongDau.Value, hdLeX.Value, hdLeY.Value, hdTyLe.Value, hdTrongSuot.Value);
        //        #endregion
        //        #region Tạo ảnh nhỏ: Thực hiện cuối để đảm bảo ảnh nhỏ cũng có con dấu
        //        if (cbTaoAnhNho.Checked)
        //        {
        //            vimg_thumb = fileNotEx + "_" + ticks + "_HasThumb_Thumb" + fileex;
        //            ImagesExtension.ResizeImage(path + vimg, path + vimg_thumb, tbAnhNhoW.Text, tbAnhNhoH.Text);

        //            
        //        }
        //        #endregion

        //        
        //    }
        //}
        //#endregion

        #region File
        string file = "";
        string fileLink = tbFileLink.Text;
        if (flFile.PostedFile.ContentLength > 0)
        {
            string filename = flFile.FileName;
            string fileex = filename.Substring(filename.LastIndexOf("."));
            string path = Request.PhysicalApplicationPath + "/" + pathFolderPic + "/";

            string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
            if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
            string ticks = DateTime.Now.Ticks.ToString();
            #region Lưu tệp đính kèm
            file = fileNotEx + "_" + ticks + fileex;
            flFile.SaveAs(path + file);
            #endregion
        }
        #endregion        

        /*
         * Thêm mới tệp đính kèm
         * modul - vskey,vsemail - mã màu,vstitle - tên, vsimage - tệp đính kèm, vsauthor - thứ tự, isenable - trạng thái
         */
        string color = "";
        if (!update)
        {
            string vicontent = StringExtension.GhepChuoi("", file, fileLink);
            Subitems.InsertSubitems(iid, language, app, tbName.Text, vicontent, vimg, color, tbOrder.Text, "",
                DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), ddlStatus.SelectedValue);
        }
        else
        {
            if (vimg.Equals(""))
                vimg = hd_img;
            else
                ImagesExtension.DeleteImageWhenDeleteItem(pathFolderPic, hd_img);

            if (file.Equals(""))
                file = hdFile.Value;
            else
                TatThanhJsc.Extension.ImagesExtension.DeleteImageWhenDeleteItem(pathFolderPic, hdFile.Value);

            string vicontent = StringExtension.GhepChuoi("", file, fileLink);

            Subitems.UpdateSubitems(iid, language, app, tbName.Text, vicontent, vimg, color, tbOrder.Text, "",
                DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), ddlStatus.SelectedValue,
                currentIsid.Value);
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

        tbFileLink.Text = "";
        hdFile.Value = "";
    }    
    protected void btCancel_Click(object sender, EventArgs e)
    {
        //ResetControls();
        //pnList.Visible = true;
        //pnInsert.Visible = false;

        Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/Moduls/FileLibrary2/Item/PopUp/AddEmmbedFileToItems.aspx?iid=" + iid);
    }
    void GetList()
    {
        condition = DataExtension.AndConditon
            (            
            SubitemsTSql.GetSubitemsByIid(iid),
            SubitemsTSql.GetSubitemsByVskey(app)
            );
        orderby = SubitemsColumns.VsemailColumn + " asc," + SubitemsColumns.VsatuthorColumn + " asc";
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
                Response.Redirect(UrlExtension.WebisteUrl + "cms/admin/Moduls/FileLibrary2/Item/PopUp/AddEmmbedFileToItems.aspx?iid=" + iid + "&isid=" + p);
                break;
            #endregion
        }
    }
    void OpenUpdatePanel(string isid)
    {
        ltrInsertUpdate.Text = "Cập nhật tệp đính kèm";
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

            #region Files

            string vscontent = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
            string file = StringExtension.LayChuoi(vscontent, "", 1);
            string fileLink = StringExtension.LayChuoi(vscontent, "", 2);

            if (file.Length > 0)
            {
                ltrFiles.Text = "Tệp hiện tại: <a href='" + TatThanhJsc.Extension.UrlExtension.WebisteUrl + pathFolderPic + "/" +
                             file + "' target='_blank'>" +
                             file + "</a>";                
            }
            else
            {
                ltrFiles.Visible = false;                
            }
            hdFile.Value = file;

            tbFileLink.Text = fileLink;
            #endregion

        }
    }

    protected void UpdateOrder(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;

        string[] fields = { SubitemsColumns.VsatuthorColumn };
        string[] values = { "N'" + textbox.Text + "'" };
        string condition = SubitemsTSql.GetSubitemsByIsid(textbox.ToolTip);
        Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fields, values), condition);
        //GetListFileLibrary2s("");
    }

    protected void UpdateTitle(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;

        string[] fields = { SubitemsColumns.VstitleColumn };
        string[] values = { "N'" + textbox.Text + "'" };
        string condition = SubitemsTSql.GetSubitemsByIsid(textbox.ToolTip);
        Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fields, values), condition);
        //GetListFileLibrary2s("");
    }

    protected void chk_list_CheckedChanged(object sender, EventArgs e)
    {
        for (int i = 0; i < rptList.Items.Count; i++)
        {
            CheckBox chkDelete = (CheckBox)rptList.Items[i].FindControl(("chk_item"));
            if (chkDelete != null)
            {
                chkDelete.Checked = chk_list.Checked;
            }
        }
    }

    protected void lnk_delete_user_checked_Click(object sender, EventArgs e)
    {
        string ArrayId = "";
        for (int i = 0; i <= rptList.Items.Count - 1; i++)
        {
            CheckBox chkDelete = (CheckBox)rptList.Items[i].FindControl(("chk_item"));
            if (chkDelete != null)
            {
                if (chkDelete.Checked)
                {
                    ArrayId += chkDelete.ToolTip;
                    ArrayId += ",";
                }
            }
            else
            {
                return;
            }
        }
        if (ArrayId.Length > 0)
        {
            ArrayId = ArrayId.Substring(0, (ArrayId.Length - 1));
        }
        else
        {
            return;
        }

        char[] splitItem = { ',' };


        fields = DataExtension.GetListColumns(SubitemsColumns.IsidColumn, SubitemsColumns.VsimageColumn);
        condition = " ISID in(" + ArrayId + ") ";
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("", fields, condition, "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ImagesExtension.DeleteImageWhenDeleteItem(pathFolderPic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString());
            Subitems.DeleteSubitems(dt.Rows[i][SubitemsColumns.IsidColumn].ToString());
        }

        chk_list.Checked = false;
        GetList();
    }
}
