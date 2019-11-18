using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.OtherModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Tag_Cate_ShortCutCate : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string app = CodeApplications.Tag;
    private string pic = FolderPic.Tag;

    private string igid = "";
    private bool insert = false;
    private string hd_insert_update = "";
    private string hd_parent = "0";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
            hd_insert_update = Request.QueryString["suc"];
        if (Request.QueryString["igid"] != null)
            igid = Request.QueryString["igid"];
        if (Request.QueryString["hd_parent"] != null)
            hd_parent = Request.QueryString["hd_parent"];
        if (hd_insert_update.Equals(TypePage.create))
            insert = true;

        Index1.btnHandler += new cms_api_Tag_Cate_Index.OnButtonClick(WebUserControl1_btnHandler);

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
            LoadModul();
            GetGroupsInDdl();
            InitialControlsValue(insert);
            KhoiTaoXuLyAnh();
        }
    }

    
    /// <summary>
    /// Lấy ra danh sách modul từ TagConfig
    /// </summary>
    private void LoadModul()
    {
        ddlModul.Items.Clear();
        TagConfig tcfg=new TagConfig();
        for (int i = 0; i < tcfg.Text.Length; i++)
        {
            ddlModul.Items.Add(new ListItem(tcfg.Text[i],tcfg.Values[i]));
        }
    }
    void KhoiTaoXuLyAnh()
    {
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;
        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_AnhDau, language);
        #endregion
        hdViTriDongDau.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_ViTri, language);
        hdLeX.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_LeNgang, language);
        hdLeY.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_LeDoc, language);
        hdTyLe.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_TyLe, language);
        hdTrongSuot.Value = SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTag_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTag, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTag_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTag_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTag, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTag_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTag_MaxHeight, language);
        #endregion
    }

    private string LinkRedrect()
    {        
        return LinkAdmin.GoAdminOther(CodeApplications.other, CodeApplications.Tag, TypePage.Cate,
                              DdlGroupTag.SelectedValue, "", "", "", "");
    }

    void GetGroupsInDdl()
    {
        DataTable dt = new DataTable();
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVglang(language), GroupsTSql.GetGroupsByVgapp(app), " igenable <> '2' ");
        dt = Groups.GetAllGroups("*", condition, "");
        DdlGroupTag.Items.Clear();
        DdlGroupTag.Items.Add(new ListItem("Danh mục gốc", "0"));
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DdlGroupTag.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
            }
        }
        DdlGroupTag.SelectedValue = hd_parent;
    }

    void InitialControlsValue(bool insert)
    {
        #region update
        if (!insert)
        {
            LtInsertUpdate.Text = Developer.TagKeyword.CapNhatDanhMuc;
            btn_insert_update.Text = "Đồng ý";
            ckbContinue.Visible = false;
            fields = "*";
            condition = GroupsTSql.GetGroupsByIgid(igid);
            DataTable dt = new DataTable();
            dt = Groups.GetGroups(top, fields, condition, orderBy);

            txt_title_modul.Text = dt.Rows[0]["VGNAME"].ToString();
            ltimg.Text = ImagesExtension.GetImage(pic, dt.Rows[0]["VGIMAGE"].ToString(), "", "adm_img_product", false, false, "", false);
            if (ltimg.Text.Length > 0)
            {
                btnXoaAnhHienTai.Visible = true;
                hd_img.Value = dt.Rows[0]["VGIMAGE"].ToString();
            }
            txt_ordermodul.Text = dt.Rows[0]["IGORDER"].ToString();
            txtDesc.Text = dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VgdescColumn].ToString();
            #region SEO
            textLinkRewrite.Text = dt.Rows[0]["VGSEOLINK"].ToString();
            textTagTitle.Text = dt.Rows[0]["VGSEOTITLE"].ToString();
            textTagKeyword.Text = dt.Rows[0]["VGSEOMETAKEY"].ToString();
            textTagDescription.Text = dt.Rows[0]["VGSEOMETADESC"].ToString();
            #endregion
            if (dt.Rows[0]["IGENABLE"].ToString().Equals("0"))
            {
                chk_status.Checked = false;
            }
            else
            {
                chk_status.Checked = true;
            }

            txt_content.Text = dt.Rows[0]["VGCONTENT"].ToString();
            hdOldContent.Value = txt_content.Text;

            ddlModul.SelectedValue = dt.Rows[0][GroupsColumns.VgparamsColumn].ToString();
        }
        #endregion
        #region  insert
        else
        {
            LtInsertUpdate.Text = Developer.TagKeyword.TaoDanhMuc;
            btn_insert_update.Text = "Đồng ý";
        }
        #endregion
    }

    /*
    protected void btn_insert_update_Click(object sender, EventArgs e)
    {
        string contentDetail = ContentExtendtions.ProcessStringContent(txt_content.Text, hdOldContent.Value, pic);
        #region Image
        string vimg = "";
        string vimg_thumb = "";
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
        #endregion
        #region Status
        string status = "0";
        if (chk_status.Checked == true)
        {
            status = "1";
        }
        #endregion

        #region Seo
        if (textLinkRewrite.Text.Trim().Equals(""))
        {
            textLinkRewrite.Text = txt_title_modul.Text;
        }
        if (textTagTitle.Text.Trim().Equals(""))
        {
            textTagTitle.Text = txt_title_modul.Text;
        }
        if (textTagKeyword.Text.Trim().Equals(""))
        {
            textTagKeyword.Text = txt_title_modul.Text;
        }
        if (textTagDescription.Text.Trim().Equals(""))
        {
            textTagDescription.Text = txtDesc.Text;
        }
        #endregion

        #region Insert
        if (insert)
        {
            Groups.InsertGroups(language, app, DdlGroupTag.SelectedValue, txt_title_modul.Text, txtDesc.Text, contentDetail, textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", vimg, "", "", txt_ordermodul.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_title_modul.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới " + txt_title_modul.Text);
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
            Groups.UpdateGroups(language, app, txt_title_modul.Text, txtDesc.Text,contentDetail, textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", vimg, "", "", txt_ordermodul.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status, igid);
            if (DdlGroupTag.SelectedValue != hd_parent)
                Groups.UpdateParentOfGroups(igid, DdlGroupTag.SelectedValue);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_title_modul.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật " + txt_title_modul.Text);
            #endregion
        }
        #endregion

        #region Continue Insert
        if (ckbContinue.Checked == true)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000, 'Đã tạo: " + txt_title_modul.Text + "');", true);
            ResetControls();
            //Lấy lại danh sách danh mục
            GetGroupsInDdl();
        }
        else
            Response.Redirect(LinkRedrect());
        #endregion
    }
    */

    protected void btn_insert_update_Click(object sender, EventArgs e)
    {
        WebUserControl1_btnHandler("");
    }


    protected void WebUserControl1_btnHandler(string strValue)
    {
        string contentDetail = ContentExtendtions.ProcessStringContent(txt_content.Text, hdOldContent.Value, pic);
        #region Image
        string vimg = "";
        string vimg_thumb = "";
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
        #endregion
        #region Status
        string status = "0";
        if (chk_status.Checked == true)
        {
            status = "1";
        }
        #endregion

        #region Seo
        if (textLinkRewrite.Text.Trim().Equals(""))
        {
            textLinkRewrite.Text = txt_title_modul.Text;
        }
        if (textTagTitle.Text.Trim().Equals(""))
        {
            textTagTitle.Text = txt_title_modul.Text;
        }
        if (textTagKeyword.Text.Trim().Equals(""))
        {
            textTagKeyword.Text = txt_title_modul.Text;
        }
        if (textTagDescription.Text.Trim().Equals(""))
        {
            textTagDescription.Text = txtDesc.Text;
        }
        #endregion

        #region Insert
        if (insert)
        {
            Groups.InsertGroups(language, app, DdlGroupTag.SelectedValue, txt_title_modul.Text, txtDesc.Text, contentDetail, textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", vimg, ddlModul.SelectedValue, "", txt_ordermodul.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_title_modul.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới " + txt_title_modul.Text);
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
            Groups.UpdateGroups(language, app, txt_title_modul.Text, txtDesc.Text, contentDetail, textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", vimg, ddlModul.SelectedValue, "", txt_ordermodul.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status, igid);
            if (DdlGroupTag.SelectedValue != hd_parent)
                Groups.UpdateParentOfGroups(igid, DdlGroupTag.SelectedValue);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", txt_title_modul.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật " + txt_title_modul.Text);
            #endregion
        }
        #endregion


        #region After Insert/Update

        if (ckbContinue.Checked == true)
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
            //    "ThongBao(3000,'Đã tạo: " + txt_title.Text + "');", true);
            //Lưu vào session để gọi đến bên api
            Session["CotinuteCreateCate"] = true;
            Session["CotinuteCreateTitleCate"] = txt_title_modul.Text;
            ResetControls();
        }
        else
        {
            Session["CotinuteCreateCate"] = false;
            Session["CotinuteCreateRedirectLinkCate"] = LinkRedrect();
        }

        #endregion
    }


    void ResetControls()
    {
        txt_title_modul.Text = "";
        ltimg.Text = "";
        hd_img.Value = "";
        hd_parent = DdlGroupTag.SelectedValue;
        txtDesc.Text = "";

        textLinkRewrite.Text = "";
        textTagTitle.Text = "";
        textTagKeyword.Text = "";
        textTagDescription.Text = "";
        txt_content.Text = "";
        try
        {
            txt_ordermodul.Text = (Convert.ToInt32(txt_ordermodul.Text) + 1).ToString();
        }
        catch { }
        txt_title_modul.Focus();
    }

    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkRedrect());
    }

    protected void btnXoaAnhHienTai_Click(object sender, EventArgs e)
    {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hd_img.Value);
        hd_img.Value = ""; btnXoaAnhHienTai.Visible = false; ltimg.Text = "";
    }
}