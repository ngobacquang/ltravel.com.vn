using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TrainTicketModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_TrainTicket_Item_ShortCutItem : System.Web.UI.UserControl
{
    private string app = CodeApplications.TrainTicket;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = FolderPic.TrainTicket;
    private string propertyModul = CodeApplications.TrainTicketProperty;
    
    private string iid = "";
    private string igid = "";
    private bool insert = false;
    private string hd_insert_update = "";
    private string p = "";
    private string ni = "";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    string parramSpitString = ",";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
            hd_insert_update = Request.QueryString["suc"];
        if (Request.QueryString["iid"] != null)
            iid = Request.QueryString["iid"];
        if (Request.QueryString["igid"] != null)
            igid = Request.QueryString["igid"];
        if (Request.QueryString["p"] != null)
            p = Request.QueryString["p"];
        if (Request.QueryString["ni"] != null)
            ni = Request.QueryString["ni"];
        if (hd_insert_update.Equals("CreateItem"))
            insert = true;

        Index1.btnHandler += new cms_api_TrainTicket_Item_Index.OnButtonClick(WebUserControl1_btnHandler);

        #region Gán đường dẫn cho ckeditor
        foreach (Control control in this.Controls)
        {
            if (control is CKEditor.NET.CKEditorControl)
                ((CKEditor.NET.CKEditorControl)control).FilebrowserImageBrowseUrl
                    =
                    UrlExtension.WebisteUrl + "ckeditor/ckfinder/ckfinder.aspx?type=Images&path=" + pic;
        }
        #endregion

        if (!IsPostBack)
        {
            SetEnableControls();
            GetGroupsInDdl();
            GetNicks();
            GetProperties();
            InitialControlsValue(insert);
            KhoiTaoXuLyAnh();            
        }
    }

    

    #region Khởi tạo các thông tin bổ xung
    #region NickHoTro
    void GetNicks()
    {
        if (TrainTicketConfig.KeyHienThiAddNickChoTrainTicket)
        {
            fields = "*";
            condition = DataExtension.AndConditon
                (
                GroupsTSql.GetGroupsByVglang(language),
                GroupsTSql.GetGroupsByVgapp(TatThanhJsc.OtherModul.CodeApplications.SupportOnline),
                ItemsTSql.GetItemsByIienable("1")
                );
            orderBy = " Groups.igid asc, " + GroupsItemsColumns.IorderColumn + " asc ";
            DataTable dt = new DataTable();
            dt = GroupsItems.GetAllData("", fields, condition, orderBy);
            rptNicks.DataSource = dt;
            rptNicks.DataBind();
        }
    }
    #endregion
    #region ThuocTinhTrainTicket
    void GetProperties()
    {
        if (TrainTicketConfig.KeyHienThiQuanLyThuocTinhTrainTicket)
        {
            fields = "*";
            condition = DataExtension.AndConditon
                (
                GroupsTSql.GetGroupsByVglang(language),
                GroupsTSql.GetGroupsByVgapp(propertyModul),
                " IGENABLE <> '2' "
                );
            orderBy = GroupsColumns.IgorderColumn;
            DataTable dt = new DataTable();
            dt = Groups.GetGroups("", fields, condition, orderBy);
            rptProperties.DataSource = dt;
            rptProperties.DataBind();
        }
    }
    #endregion
    #region ThuocTinhLocTrainTicket
    string appFilter = CodeApplications.TrainTicketFilterProperties;
    /// <summary>
    /// Lấy danh igid các thuộc tính lọc đã được add vào danh mục (kết quả trả về dạng ,igid1,igid2,)
    /// </summary>
    /// <returns></returns>
    string GetListFilterProperties()
    {
        top = ""; fields = GroupsColumns.VgparamsColumn + "," + GroupsColumns.VgnameColumn;
        orderBy = "";
        condition = GroupsTSql.GetGroupsByIgid(ddl_group_TrainTicket.SelectedValue);
        DataTable dt = new DataTable();
        dt = Groups.GetGroups(top, fields, condition, orderBy);
        if (dt.Rows.Count > 0)
            return dt.Rows[0][GroupsColumns.VgparamsColumn].ToString();
        else
            return "";
    }

    /// <summary>
    /// Lấy danh sách các thuộc tính đã được add cho danh mục
    /// </summary>
    void GetFilterProperties()
    {
        if (TrainTicketConfig.KeyHienThiThuocTinhLocTrainTicket)
        {
            condition = DataExtension.AndConditon(
                        GroupsTSql.GetGroupsByVglang(language),
                        GroupsTSql.GetGroupsByVgapp(appFilter),
                        GroupsTSql.GetGroupsByIgenable("1"),
                        "charindex('" + parramSpitString + "'+cast(" + GroupsColumns.IgidColumn + " as varchar(10))+'" + parramSpitString + "','" + GetListFilterProperties() + "') >0");
            DataTable dt = new DataTable();
            dt = Groups.GetGroups("", "*", condition, "");

            rptParentFilter.DataSource = dt;
            rptParentFilter.DataBind();
        }
    }
    /// <summary>
    /// Lấy danh sách các thuộc tính lọc con
    /// </summary>
    /// <param name="igid">igid của thuộc tính cha</param>
    /// <param name="vgparrams">parram của thuộc tính cha (lưu thiết lập cho chọn 1 hoặc nhiều thuộc tính con)</param>
    /// <param name="allowMultipSelect">0: chỉ lấy ra thuộc tính con nếu thuộc tính cha thiết lập chỉ cho chọn 1 thuộc tính con/1 sp</param>
    /// <returns></returns>
    protected DataTable GetSubFilter(string igid, string vgparrams, string allowMultipSelect)
    {
        DataTable dtSubs = new DataTable();
        if (vgparrams == allowMultipSelect)
        {
            fields = GroupsColumns.IgidColumn + "," + GroupsColumns.VgnameColumn;
            condition = DataExtension.AndConditon
                (
                GroupsTSql.GetGroupsByVgapp(appFilter),
                GroupsTSql.GetGroupsByIgparentid(igid),
                GroupsTSql.GetGroupsByIgenable("1")
                );
            dtSubs = Groups.GetGroups("", fields, condition, "");
        }
        return dtSubs;
    }
    #endregion
    #endregion

    #region Kiểm tra các chức năng phụ(add nick, thuộc tính, lọc...) có được hiển thị hay không
    /// <summary>
    /// Hiển thị hoặc ẩn các chức năng theo thiết lập trong bảng Settings
    /// </summary>
    void SetEnableControls()
    {
        //Ẩn hiện chức năng Add nick
        if (TrainTicketConfig.KeyHienThiAddNickChoTrainTicket) pnAddNickHoTroTrucTuyen.Visible = true;
        else pnAddNickHoTroTrucTuyen.Visible = false;

        //Ẩn hiện chức năng Thuộc tính Vé tàu
        if (TrainTicketConfig.KeyHienThiQuanLyThuocTinhTrainTicket) pnThuocTinhTrainTicket.Visible = true;
        else pnThuocTinhTrainTicket.Visible = false;

        //Ẩn hiện chức năng Thuộc tính lọc
        if (TrainTicketConfig.KeyHienThiThuocTinhLocTrainTicket) pnThuocTinhLoc.Visible = true;
        else pnThuocTinhLoc.Visible = false;
    }
    #endregion

    void KhoiTaoXuLyAnh()
    {
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;
        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_AnhDau, language);
        #endregion
        hdViTriDongDau.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_ViTri, language);
        hdLeX.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_LeNgang, language);
        hdLeY.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_LeDoc, language);
        hdTyLe.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_TyLe, language);
        hdTrongSuot.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTrainTicket, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTrainTicket_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTrainTicket_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTrainTicket, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTrainTicket_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTrainTicket_MaxHeight, language);
        #endregion
    }

    private string LinkRedrect()
    {
        if (!ni.Equals("") && !p.Equals(""))
        {
            return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.TrainTicket + "&igid=" + ddl_group_TrainTicket.SelectedValue + "&suc=d&ni=" + ni + "&p=" + p;
        }
        else
        {
            return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.TrainTicket + "&igid=" + ddl_group_TrainTicket.SelectedValue + "&suc=d";
        }
    }

    void GetGroupsInDdl()
    {
        DataTable dt = new DataTable();
        dt = Groups.GetAllGroups("*", DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(app) + " AND IGENABLE <> '2' ", GroupsTSql.GetGroupsByVglang(language)), "");
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ddl_group_TrainTicket.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
            }
        }
        if (!igid.Equals(""))
        {
            ddl_group_TrainTicket.SelectedValue = igid;
        }
    }

    void InitialControlsValue(bool insert)
    {
        #region update
        if (!insert)
        {
            //btn_insert_update.Text = "Đồng ý";
            ckbContinue.Visible = false;
            fields = "*";
            condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(app), ItemsTSql.GetItemsByIid(iid));
            DataTable dt = new DataTable();
            dt = GroupsItems.GetAllData(top, fields, condition, orderBy);
            lnk_delete_Image_current.Visible = true;
            ddl_group_TrainTicket.SelectedValue = dt.Rows[0]["IGID"].ToString();
            txt_title.Text = dt.Rows[0]["VITITLE"].ToString();
            txt_description.Text = dt.Rows[0]["VIDESC"].ToString();
            txt_content.Text = dt.Rows[0]["VICONTENT"].ToString();
            hdOldTrainTicket.Value = dt.Rows[0]["VICONTENT"].ToString();
            #region SEO
            textLinkRewrite.Text = dt.Rows[0]["VISEOLINK"].ToString();
            textTagTitle.Text = dt.Rows[0]["VISEOTITLE"].ToString();
            textTagKeyword.Text = dt.Rows[0]["VISEOMETAKEY"].ToString();
            textTagDescription.Text = dt.Rows[0]["VISEOMETADESC"].ToString();
            #endregion
            txtCreateDate.Text = dt.Rows[0]["DCREATEDATE"].ToString();

            #region Image
            if (!dt.Rows[0]["VIIMAGE"].ToString().Equals(""))
            {
                ltimg.Text = ImagesExtension.GetImage(pic, dt.Rows[0]["VIIMAGE"].ToString(), "", "imgItem", false, false, "", false);
                lnk_delete_Image_current.Visible = true;
            }
            else
            {
                ltimg.Visible = false;
                lnk_delete_Image_current.Visible = false;
            }
            hd_img.Value = dt.Rows[0]["VIIMAGE"].ToString();

            if (hd_img.Value.Length < 1)
                cbLayAnhTuNoiDung.Checked = true;
            else cbLayAnhTuNoiDung.Checked = false;
            #endregion
            HdIitotalview.Value = dt.Rows[0]["IITOTALVIEW"].ToString();
            #region IIENABLE
            if (dt.Rows[0]["IIENABLE"].ToString().Equals("0"))
            {
                chk_status.Checked = false;
            }
            else
            {
                chk_status.Checked = true;
            }
            #endregion

            tbPrice.Text = dt.Rows[0][ItemsColumns.FipriceColumn].ToString();
            tbPriceOld.Text = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString();

            tbKey.Text = dt.Rows[0][ItemsColumns.VikeyColumn].ToString();
            tbOrder.Text = dt.Rows[0][ItemsColumns.IiorderColumn].ToString();

            GetFilterProperties();            
            #region ThuocTinhTrainTicket-Chi thực hiện khi chức năng Quản lý thuộc tính được hiển thị
            if (TrainTicketConfig.KeyHienThiQuanLyThuocTinhTrainTicket)
            {
                string properties = "";
                condition = DataExtension.AndConditon(
                    SubitemsTSql.GetSubitemsByIid(iid),
                    SubitemsTSql.GetSubitemsByVskey(propertyModul));
                fields = SubitemsColumns.VscontentColumn;
                dt = Subitems.GetSubItems("", fields, condition, "");
                if (dt.Rows.Count > 0)
                    properties = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();                
                for (int i = 0; i < rptProperties.Items.Count; i++)
                {
                    CheckBox checkBoxProperties = (CheckBox)rptProperties.Items[i].FindControl("checkBoxProperties");                    
                    if (properties.IndexOf(parramSpitString + checkBoxProperties.ToolTip + parramSpitString) > -1)
                    {
                        checkBoxProperties.Checked = true;                        
                    }
                    else
                        checkBoxProperties.Checked = false;
                }
            }
            #endregion

            #region Nicks- Chỉ hiển thị khi chức năng add nick được hiển thị
            if (TrainTicketConfig.KeyHienThiAddNickChoTrainTicket)
            {
                string nicks = "";
                condition = DataExtension.AndConditon(
                    SubitemsTSql.GetSubitemsByIid(iid),
                    SubitemsTSql.GetSubitemsByVskey(TatThanhJsc.OtherModul.CodeApplications.SupportOnline));
                fields = SubitemsColumns.VscontentColumn;
                dt = Subitems.GetSubItems("", fields, condition, "");
                if (dt.Rows.Count > 0)
                    nicks = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
                for (int i = 0; i < rptNicks.Items.Count; i++)
                {
                    CheckBox checkBoxNicks = (CheckBox)rptNicks.Items[i].FindControl("checkBoxNicks");
                    if (nicks.IndexOf(parramSpitString + checkBoxNicks.ToolTip + parramSpitString) > -1)
                        checkBoxNicks.Checked = true;
                    else
                        checkBoxNicks.Checked = false;
                }
            }
            #endregion

            #region ThuocTinhLoc- Chỉ hiển thị khi chức năng quản lý thuộc tính lọc được hiển thị
            string filterProperties = "";
            condition = DataExtension.AndConditon(
                SubitemsTSql.GetSubitemsByIid(iid),
                SubitemsTSql.GetSubitemsByVskey(CodeApplications.TrainTicketFilterProperties));
            fields = SubitemsColumns.VscontentColumn;
            dt = Subitems.GetSubItems("", fields, condition, "");
            if (dt.Rows.Count > 0)
                filterProperties = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
            for (int i = 0; i < rptParentFilter.Items.Count; i++)
            {
                //Đánh dấu radiobuttonlist
                RadioButtonList rdblListAnswer = (RadioButtonList)rptParentFilter.Items[i].FindControl("rdblAnswer");
                if (rdblListAnswer != null)
                {
                    for (int j = 0; j < rdblListAnswer.Items.Count; j++)
                    {
                        if (filterProperties.IndexOf(parramSpitString + rdblListAnswer.Items[j].Value + parramSpitString) > -1)
                            rdblListAnswer.Items[j].Selected = true;
                        else
                            rdblListAnswer.Items[j].Selected = false;
                    }
                }

                //Đánh dấu checkboxlist
                CheckBoxList cblListAnswer = (CheckBoxList)rptParentFilter.Items[i].FindControl("cblAnswer");
                if (cblListAnswer != null)
                {
                    for (int j = 0; j < cblListAnswer.Items.Count; j++)
                    {
                        if (filterProperties.IndexOf(parramSpitString + cblListAnswer.Items[j].Value + parramSpitString) > -1)
                            cblListAnswer.Items[j].Selected = true;
                        else
                            cblListAnswer.Items[j].Selected = false;
                    }
                }
            }
            #endregion

        }
        #endregion
        #region  insert
        else
        {
            //btn_insert_update.Text = "Đồng ý";
            txtCreateDate.Text = DateTime.Now.ToString();
            GetFilterProperties();
        }
        #endregion
    }

    void ResetControls()
    {
        txt_title.Text = "";
        txt_description.Text = "";
        txt_content.Text = "";
        hdOldTrainTicket.Value = "";
        txtCreateDate.Text = DateTime.Now.ToString();
        ltimg.Text = "";
        hd_img.Value = "";        
        textLinkRewrite.Text = "";
        textTagTitle.Text = "";
        textTagKeyword.Text = "";
        textTagDescription.Text = "";

        tbPrice.Text = "";
        tbPriceOld.Text = "";
        try
        {
            tbOrder.Text = (Convert.ToInt32(tbOrder.Text) + 1).ToString();
        }
        catch { }
        txt_title.Focus();
    }

    //protected void btn_insert_update_Click(object sender, EventArgs e)
    //{
    //    #region Image
    //    string vimg = "";
    //    string vimg_thumb = "";
    //    if (flimg.PostedFile.ContentLength > 0)
    //    {
    //        string filename = flimg.FileName;
    //        string fileex = filename.Substring(filename.LastIndexOf("."));
    //        string path = Request.PhysicalApplicationPath + "/" + pic + "/";
    //        if (Images.ValidType(fileex))
    //        {
    //            string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
    //            if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
    //            string ticks = DateTime.Now.Ticks.ToString();
    //            #region Lưu ảnh đại diện theo 2 trường hợp: tạo ảnh nhỏ hoặc không.
    //            //Kiểm tra xem có tạo ảnh nhỏ hay ko
    //            //Nếu không tạo ảnh nhỏ, tên tệp lưu bình thường theo kiểu: tên_tệp.phần_mở_rộng
    //            //Nếu tạo ảnh nhỏ, tên tệp sẽ theo kiểu: tên_tệp_HasThumb.phần_mở_rộng
    //            //Khi đó tên tệp ảnh nhỏ sẽ theo kiểu:   tên_tệp_HasThumb_Thumb.phần_mở_rộng
    //            //Với cách lưu tên ảnh này, khi thực hiện lưu vào csdl chỉ cần lưu tên ảnh gốc
    //            //khi hiển thị chỉ cần dựa vào tên ảnh gốc để biết ảnh đó có ảnh nhỏ hay không, việc này được thực hiện bởi ImagesExtension.GetImage, lập trình không cần làm gì thêm.
    //            if (cbTaoAnhNho.Checked)
    //                vimg = fileNotEx + "_" + ticks + "_HasThumb" + fileex;
    //            else
    //                vimg = fileNotEx + "_" + ticks + fileex;
    //            flimg.SaveAs(path + vimg);
    //            #endregion
    //            #region Hạn chế kích thước
    //            if (cbHanCheKichThuoc.Checked)
    //                Images.ResizeImage(path + vimg, "", tbHanCheW.Text, tbHanCheH.Text);
    //            #endregion
    //            #region Đóng dấu ảnh
    //            if (cbDongDauAnh.Checked)
    //                Images.CreateWatermark(path + vimg, path + hdLogoImage.Value, hdViTriDongDau.Value, hdLeX.Value, hdLeY.Value, hdTyLe.Value, hdTrongSuot.Value);
    //            #endregion
    //            #region Tạo ảnh nhỏ: Thực hiện cuối để đảm bảo ảnh nhỏ cũng có con dấu
    //            if (cbTaoAnhNho.Checked)
    //            {
    //                vimg_thumb = fileNotEx + "_" + ticks + "_HasThumb_Thumb" + fileex;
    //                Images.ResizeImage(path + vimg, path + vimg_thumb, tbAnhNhoW.Text, tbAnhNhoH.Text);
    //            }
    //            #endregion
    //        }
    //    }
    //    #endregion
    //    #region Status
    //    string status = "0";
    //    if (chk_status.Checked == true)
    //    {
    //        status = "1";
    //    }
    //    #endregion
    //    #region Time Create Date
    //    string timeCreateDate = "";
    //    timeCreateDate = txtCreateDate.Text;
    //    #endregion
    //    #region Seo
    //    if (textLinkRewrite.Text.Trim().Equals(""))
    //    {
    //        textLinkRewrite.Text = txt_title.Text;
    //    }
    //    if (textTagTitle.Text.Trim().Equals(""))
    //    {
    //        textTagTitle.Text = txt_title.Text;
    //    }
    //    if (textTagKeyword.Text.Trim().Equals(""))
    //    {
    //        textTagKeyword.Text = txt_title.Text;
    //    }
    //    if (textTagDescription.Text.Trim().Equals(""))
    //    {
    //        textTagDescription.Text = txt_description.Text;
    //    }
    //    #endregion
    //    string newTrainTicket = ContentExtendtions.ProcessStringContent(txt_content.Text, hdOldTrainTicket.Value, pic);
    //    #region Insert
    //    if (insert)
    //    {
    //        GroupsItems.InsertItemsGroupsItems(language, app, tbKey.Text, txt_title.Text, txt_description.Text, newTrainTicket, vimg, "", "", textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", "", tbPrice.Text, tbPriceOld.Text, "", "", timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), "", ddl_group_TrainTicket.SelectedValue, timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), "", status);

    //        #region Lay ra iid cua item vua duoc luu
    //        condition = DataExtension.AndConditon(
    //            ItemsTSql.GetItemsByDicreatedate(timeCreateDate),
    //            ItemsTSql.GetItemsByViapp(app));
    //        DataTable dtInsertedItems = new DataTable();
    //        dtInsertedItems = GroupsItems.GetAllData("1", "Items.iid", condition, ItemsColumns.IidColumn + " desc");
    //        if (dtInsertedItems.Rows.Count > 0)
    //            iid = dtInsertedItems.Rows[0][ItemsColumns.IidColumn].ToString();
    //        #endregion

    //    }
    //    #endregion
    //    #region Update
    //    else
    //    {
    //        if (vimg.Equals(""))
    //        {
    //            vimg = hd_img;
    //        }
    //        else
    //        {
    //            Images.DeleteImageWhenDeleteItem(pic, hd_img);
    //        }
    //        GroupsItems.UpdateItemsGroupsItems(language, app, tbKey.Text, txt_title.Text, txt_description.Text, newTrainTicket, vimg, "", "", textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", "", tbPrice.Text, tbPriceOld.Text, "", HdIitotalview, timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), "", ddl_group_TrainTicket.SelectedValue, timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), "", status, iid);
    //    }        
    //    #endregion

    //    #region Properties-Chi thực hiện khi chức năng Quản lý thuộc tính được hiển thị
    //    if (TrainTicketConfig.KeyHienThiQuanLyThuocTinhTrainTicket)
    //    {
    //        string properties = parramSpitString;
    //        for (int i = 0; i < rptProperties.Items.Count; i++)
    //        {
    //            CheckBox checkBoxProperties = (CheckBox)rptProperties.Items[i].FindControl("checkBoxProperties");
    //            if (checkBoxProperties.Checked == true)
    //                properties += checkBoxProperties.ToolTip + parramSpitString;
    //        }

    //        condition = DataExtension.AndConditon(
    //            SubitemsTSql.GetSubitemsByIid(iid),
    //            SubitemsTSql.GetSubitemsByVskey(propertyModul));
    //        fields = DataExtension.GetListColumns(SubitemsColumns.IsidColumn, SubitemsColumns.VscontentColumn);
    //        DataTable dt = new DataTable();
    //        dt = Subitems.GetSubItems("", fields, condition, "");

    //        if (dt.Rows.Count > 0)
    //        {
    //            string isid = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();
    //            //Cap nhat
    //            Subitems.UpdateSubitems(iid, language, propertyModul, "", properties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", isid);
    //        }
    //        else
    //        {
    //            //Them moi
    //            Subitems.InsertSubitems(iid, language, propertyModul, "", properties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
    //        }
    //    }
    //    #endregion

    //    #region Nicks - Chỉ hiển thị khi chức năng add nick được hiển thị
    //    if (TrainTicketConfig.KeyHienThiAddNickChoTrainTicket)
    //    {
    //        string nicks = parramSpitString;
    //        for (int i = 0; i < rptNicks.Items.Count; i++)
    //        {
    //            CheckBox checkBoxNicks = (CheckBox)rptNicks.Items[i].FindControl("checkBoxNicks");
    //            if (checkBoxNicks.Checked == true)
    //                nicks += checkBoxNicks.ToolTip + parramSpitString;
    //        }

    //        condition = DataExtension.AndConditon(
    //            SubitemsTSql.GetSubitemsByIid(iid),
    //            SubitemsTSql.GetSubitemsByVskey(Keyword.CodeApplications.SupportOnline));
    //        fields = DataExtension.GetListColumns(SubitemsColumns.IsidColumn, SubitemsColumns.VscontentColumn);
    //        DataTable dt = new DataTable();
    //        dt = Subitems.GetSubItems("", fields, condition, "");

    //        if (dt.Rows.Count > 0)
    //        {
    //            string isid = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();
    //            //Cap nhat
    //            Subitems.UpdateSubitems(iid, language, Keyword.CodeApplications.SupportOnline, "", nicks, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", isid);
    //        }
    //        else
    //        {
    //            //Them moi
    //            Subitems.InsertSubitems(iid, language, Keyword.CodeApplications.SupportOnline, "", nicks, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
    //        }
    //    }
    //    #endregion

    //    #region FilterProperties - Chỉ hiển thị khi tính năng lọc Vé tàu được hiển thị
    //    if (TrainTicketConfig.KeyHienThiThuocTinhLocTrainTicket)
    //    {
    //        string filterProperties = parramSpitString;
    //        for (int i = 0; i < rptParentFilter.Items.Count; i++)
    //        {

    //            RadioButtonList rdblListAnswer = (RadioButtonList)rptParentFilter.Items[i].FindControl("rdblAnswer");
    //            if (rdblListAnswer != null)
    //            {
    //                if (rdblListAnswer.SelectedValue.Length > 0)
    //                    filterProperties += rdblListAnswer.SelectedValue + parramSpitString;
    //            }

    //            CheckBoxList cblListAnswer = (CheckBoxList)rptParentFilter.Items[i].FindControl("cblAnswer");
    //            if (cblListAnswer != null)
    //            {
    //                for (int j = 0; j < cblListAnswer.Items.Count; j++)
    //                {
    //                    if (cblListAnswer.Items[j].Selected == true)
    //                        filterProperties += cblListAnswer.Items[j].Value + parramSpitString;
    //                }
    //            }
    //        }

    //        condition = DataExtension.AndConditon(
    //            SubitemsTSql.GetSubitemsByIid(iid),
    //            SubitemsTSql.GetSubitemsByVskey(Keyword.CodeApplications.TrainTicketFilterProperties));
    //        fields = DataExtension.GetListColumns(SubitemsColumns.IsidColumn, SubitemsColumns.VscontentColumn);
    //        DataTable dt = new DataTable();
    //        dt = Subitems.GetSubItems("", fields, condition, "");

    //        if (dt.Rows.Count > 0)
    //        {
    //            string isid = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();
    //            //Cap nhat
    //            Subitems.UpdateSubitems(iid, language, Keyword.CodeApplications.TrainTicketFilterProperties, "", filterProperties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", isid);
    //        }
    //        else
    //        {
    //            //Them moi
    //            Subitems.InsertSubitems(iid, language, Keyword.CodeApplications.TrainTicketFilterProperties, "", filterProperties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
    //        }
    //    }
    //    #endregion

    //    #region After Insert/Update
    //    if (ckbContinue.Checked == true)
    //    {
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Đã tạo: " + txt_title.Text + "');", true);
    //        ResetControls();
    //    }
    //    else
    //        Response.Redirect(LinkRedrect());
    //    #endregion
    //}

    void WebUserControl1_btnHandler(string strValue)
    {
        #region Image
        string vimg = "";
        string vimg_thumb = "";
        string contentDetail = ContentExtendtions.ProcessStringContent(txt_content.Text, hdOldTrainTicket.Value, pic);
        if (flimg.PostedFile.ContentLength > 0)
        {
            string filename = flimg.FileName;
            string fileex = filename.Substring(filename.LastIndexOf("."));
            string path = Request.PhysicalApplicationPath + "/" + pic + "/";
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
        else
        {
            if (hd_img.Value.Length < 1 || cbLayAnhTuNoiDung.Checked)//nếu không upload ảnh và cũng không có ảnh cũ -> tìm ảnh đầu tiên trong nội dung làm ảnh đại diện
            {
                if (hd_img.Value.Length > 0)
                    TatThanhJsc.Extension.ImagesExtension.DeleteImageWhenDeleteItem(pic, hd_img.Value);

                string urlImg = ImagesExtension.GetFirstImageInContent(contentDetail);
 
                if (urlImg.Length > 0)
                {
                    string filename = urlImg;
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
                            vimg = fileNotEx + "_" + ticks + "_HasThumb";
                        else
                            vimg = fileNotEx + "_" + ticks;

                        if (ImagesExtension.SaveImageFromUrl(path + vimg, urlImg).Length > 0)
                        {
                            vimg += fileex;

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
                        else
                        {
                            vimg = "";
                        }
                        #endregion
                    }
                }
            }
        }
        #endregion
        #region Status
        string status = "0";
        if (chk_status.Checked == true)
        {
            status = "1";
        }
        #endregion
        #region Time Create Date
        string timeCreateDate = "";
        timeCreateDate = txtCreateDate.Text;
        #endregion
        #region Seo
        if (textLinkRewrite.Text.Trim().Equals(""))
        {
            textLinkRewrite.Text = txt_title.Text;
        }
        if (textTagTitle.Text.Trim().Equals(""))
        {
            textTagTitle.Text = txt_title.Text;
        }
        if (textTagKeyword.Text.Trim().Equals(""))
        {
            textTagKeyword.Text = txt_title.Text;
        }
        if (textTagDescription.Text.Trim().Equals(""))
        {
            textTagDescription.Text = txt_description.Text;
        }
        #endregion        
        #region Insert
        if (insert)
        {
            GroupsItems.InsertItemsGroupsItems(language, app, tbKey.Text, txt_title.Text, txt_description.Text, contentDetail, vimg, "", "", textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", "", tbPrice.Text, tbPriceOld.Text, "", "", timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), tbOrder.Text, ddl_group_TrainTicket.SelectedValue, timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), tbOrder.Text, status);

            #region Lay ra iid cua item vua duoc luu
            condition = DataExtension.AndConditon(
                ItemsTSql.GetItemsByDicreatedate(timeCreateDate),
                ItemsTSql.GetItemsByViapp(app));
            DataTable dtInsertedItems = new DataTable();
            dtInsertedItems = GroupsItems.GetAllData("1", "Items.iid", condition, ItemsColumns.IidColumn + " desc");
            if (dtInsertedItems.Rows.Count > 0)
                iid = dtInsertedItems.Rows[0][ItemsColumns.IidColumn].ToString();
            #endregion

        }
        #endregion
        #region Update
        else
        {
            if (vimg.Equals(""))
            {
                vimg = hd_img.Value;
            }
            else
            {
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hd_img.Value);
            }
            GroupsItems.UpdateItemsGroupsItems(language, app, tbKey.Text, txt_title.Text, txt_description.Text, contentDetail, vimg, "", "", textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", "", tbPrice.Text, tbPriceOld.Text, "", HdIitotalview.Value, timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), tbOrder.Text, ddl_group_TrainTicket.SelectedValue, timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), tbOrder.Text, status, iid);
        }
        #endregion

        #region Properties-Chi thực hiện khi chức năng Quản lý thuộc tính được hiển thị
        if (TrainTicketConfig.KeyHienThiQuanLyThuocTinhTrainTicket)
        {
            string properties = parramSpitString;
            for (int i = 0; i < rptProperties.Items.Count; i++)
            {
                CheckBox checkBoxProperties = (CheckBox)rptProperties.Items[i].FindControl("checkBoxProperties");
                if (checkBoxProperties.Checked == true)
                    properties += checkBoxProperties.ToolTip + parramSpitString;
            }

            condition = DataExtension.AndConditon(
                SubitemsTSql.GetSubitemsByIid(iid),
                SubitemsTSql.GetSubitemsByVskey(propertyModul));
            fields = DataExtension.GetListColumns(SubitemsColumns.IsidColumn, SubitemsColumns.VscontentColumn);
            DataTable dt = new DataTable();
            dt = Subitems.GetSubItems("", fields, condition, "");

            if (dt.Rows.Count > 0)
            {
                string isid = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();
                //Cap nhat
                Subitems.UpdateSubitems(iid, language, propertyModul, "", properties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", isid);
            }
            else
            {
                //Them moi
                Subitems.InsertSubitems(iid, language, propertyModul, "", properties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
            }
        }
        #endregion

        #region Nicks - Chỉ hiển thị khi chức năng add nick được hiển thị
        if (TrainTicketConfig.KeyHienThiAddNickChoTrainTicket)
        {
            string nicks = parramSpitString;
            for (int i = 0; i < rptNicks.Items.Count; i++)
            {
                CheckBox checkBoxNicks = (CheckBox)rptNicks.Items[i].FindControl("checkBoxNicks");
                if (checkBoxNicks.Checked == true)
                    nicks += checkBoxNicks.ToolTip + parramSpitString;
            }

            condition = DataExtension.AndConditon(
                SubitemsTSql.GetSubitemsByIid(iid),
                SubitemsTSql.GetSubitemsByVskey(TatThanhJsc.OtherModul.CodeApplications.SupportOnline));
            fields = DataExtension.GetListColumns(SubitemsColumns.IsidColumn, SubitemsColumns.VscontentColumn);
            DataTable dt = new DataTable();
            dt = Subitems.GetSubItems("", fields, condition, "");

            if (dt.Rows.Count > 0)
            {
                string isid = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();
                //Cap nhat
                Subitems.UpdateSubitems(iid, language, TatThanhJsc.OtherModul.CodeApplications.SupportOnline, "", nicks, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", isid);
            }
            else
            {
                //Them moi
                Subitems.InsertSubitems(iid, language, TatThanhJsc.OtherModul.CodeApplications.SupportOnline, "", nicks, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
            }
        }
        #endregion

        #region FilterProperties - Chỉ hiển thị khi tính năng lọc Vé tàu được hiển thị
        if (TrainTicketConfig.KeyHienThiThuocTinhLocTrainTicket)
        {
            string filterProperties = parramSpitString;
            for (int i = 0; i < rptParentFilter.Items.Count; i++)
            {

                RadioButtonList rdblListAnswer = (RadioButtonList)rptParentFilter.Items[i].FindControl("rdblAnswer");
                if (rdblListAnswer != null)
                {
                    if (rdblListAnswer.SelectedValue.Length > 0)
                        filterProperties += rdblListAnswer.SelectedValue + parramSpitString;
                }

                CheckBoxList cblListAnswer = (CheckBoxList)rptParentFilter.Items[i].FindControl("cblAnswer");
                if (cblListAnswer != null)
                {
                    for (int j = 0; j < cblListAnswer.Items.Count; j++)
                    {
                        if (cblListAnswer.Items[j].Selected == true)
                            filterProperties += cblListAnswer.Items[j].Value + parramSpitString;
                    }
                }
            }

            condition = DataExtension.AndConditon(
                SubitemsTSql.GetSubitemsByIid(iid),
                SubitemsTSql.GetSubitemsByVskey(CodeApplications.TrainTicketFilterProperties));
            fields = DataExtension.GetListColumns(SubitemsColumns.IsidColumn, SubitemsColumns.VscontentColumn);
            DataTable dt = new DataTable();
            dt = Subitems.GetSubItems("", fields, condition, "");

            if (dt.Rows.Count > 0)
            {
                string isid = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();
                //Cap nhat
                Subitems.UpdateSubitems(iid, language, CodeApplications.TrainTicketFilterProperties, "", filterProperties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", isid);
            }
            else
            {
                //Them moi
                Subitems.InsertSubitems(iid, language, CodeApplications.TrainTicketFilterProperties, "", filterProperties, "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
            }
        }
        #endregion

        #region After Insert/Update
        if (ckbContinue.Checked == true)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Đã tạo: " + txt_title.Text + "');", true);
            ResetControls();
        }
        //else
        //    Response.Redirect(LinkRedrect());
        #endregion
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkRedrect());
    }

    protected void lnk_delete_Image_current_Click(object sender, EventArgs e)
    {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hd_img.Value);
        ltimg.Visible = false;
        hd_img.Value = "";
    }

    protected void ddl_group_TrainTicket_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetFilterProperties();        
    }
}