using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.MenuModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Menu_MenuMain_ShortCutMenuMain : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string suc = TypePage.create;
    private string app = "";
    private string uc = "";

    private string pic = FolderPic.Menu;        

    private string igid = "";
    private bool insert = false;    
    string hd_insert_update = "";
    string hd_parent = "0";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        app = Request.QueryString["app"];
        uc = Request.QueryString["uc"];

             
        if (Request.QueryString["igid"] != null)        
            igid = Request.QueryString["igid"];        
        if (Request.QueryString["hd_parent"] != null)        
            hd_parent = Request.QueryString["hd_parent"];

        if (Request.QueryString["suc"] != null)
            hd_insert_update = Request.QueryString["suc"];   
        if (hd_insert_update.Equals(suc))        
            insert = true;        

        if (!IsPostBack)
        {
            GetParrentCategories();
            InitialControlsValue();
            GetItemInDdlModul();
        }
    }

    string LinkRedirect()
    {
        return UrlExtension.WebisteUrl + "admin.aspx?uc=" + uc + "&app=" + app + "&hd_parent=" + hd_parent;
    }

    void GetParrentCategories()
    {
        DataTable dt = new DataTable();
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVglang(language), GroupsTSql.GetGroupsByVgapp(app), " igenable <> '2' ");
        dt = Groups.GetAllGroups("*", condition, "");
        ddlParrentCategories.Items.Clear();
        ddlParrentCategories.Items.Add(new ListItem("Danh mục gốc", "0"));
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ddlParrentCategories.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
            }
        }
        ddlParrentCategories.SelectedValue = hd_parent;
    }

    private void InitialControlsValue()
    {
        #region insert
        if (insert)
        {
            lt_insert_update.Text = "<div class='fwb pb8'>Thêm mới menu</div>";
            btOK.Text = "Đồng ý";
            pnTiepTucMenu.Visible = true;
            tbTitle.Focus();
        }
        #endregion
        #region update
        else
        {
            DataTable dt = new DataTable();
            fields = "*";
            condition = GroupsTSql.GetGroupsByIgid(igid);
            dt = Groups.GetGroups(top, fields, condition, orderBy);
            string vgParam = dt.Rows[0]["VGPARAMS"].ToString();

            ddlNewTabOption.SelectedValue = StringExtension.LayChuoi(vgParam, TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 2);
            
            lt_insert_update.Text = "<div class='fwb pb8'>Cập nhật menu</div>";
            btOK.Text = "Cập nhật";
            tbTitle.Text = dt.Rows[0]["VGNAME"].ToString();
            hdTotalItem.Value = dt.Rows[0]["IGTOTALITEMS"].ToString();
            tbUrl.Text = dt.Rows[0]["VGDESC"].ToString();
            tbOrder.Text = dt.Rows[0]["IGORDER"].ToString();
            #region Image
            string image1 = StringExtension.LayChuoi(dt.Rows[0]["VGIMAGE"].ToString(), TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 2);
            string image2 = StringExtension.LayChuoi(dt.Rows[0]["VGIMAGE"].ToString(), TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 3);
            ltimg.Text = ImagesExtension.GetImage(pic, image1, "", "adm_img_product", false, false, "");
            if (ltimg.Text.Length > 0)
            {
                btnXoaAnhHienTai.Visible = true;
                hdImg.Value = image1;
            }
            ltimg2.Text = ImagesExtension.GetImage(pic, image2, "", "adm_img_product", false, false, "");
            if (ltimg2.Text.Length > 0)
            {
                btnXoaAnhHienTai2.Visible = true;
                hdImg2.Value = image2;
            }
            #endregion
            #region SEO
            tbLinkRewrite.Text = dt.Rows[0]["VGSEOLINK"].ToString();
            tbTagTitle.Text = dt.Rows[0]["VGSEOTITLE"].ToString();
            tbTagKeyword.Text = dt.Rows[0]["VGSEOMETAKEY"].ToString();
            tbTagDescription.Text = dt.Rows[0]["VGSEOMETADESC"].ToString();
            #endregion
            #region IGENABLE
            if (dt.Rows[0]["IGENABLE"].ToString().Equals("0"))
            {
                cbStatus.Checked = false;
            }
            else
            {
                cbStatus.Checked = true;
            }
            #endregion
            pnTiepTucMenu.Visible = false;
        }
        #endregion
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        #region Vgparams: là menu(0) hay trang nội dung (1) - Mở ra trang mới(1) hay không(0) - Mô tả menu - Đơn cấp(0) hay đa cấp(1) - Tiêu đề bài viết nếu menu là trang nội dung
        string vgparams = StringExtension.GhepChuoi(TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, "0", ddlNewTabOption.SelectedValue);
        #endregion
        #region Image
        string vImg = "";
        if (flimg.FileName.Length > 0 && flimg.PostedFile.ContentLength > 0)
        {
            string filename = flimg.FileName;
            string fileex = filename.Substring(filename.LastIndexOf("."));
            if (ImagesExtension.ValidType(fileex))
            {
                string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(flimg.PostedFile.FileName);
                if (fileNotEx.Length > 10)
                    fileNotEx = fileNotEx.Remove(10);
                vImg = StringExtension.ReplateTitle(fileNotEx) + DateTime.Now.Ticks.ToString() + fileex;
                flimg.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + vImg);
            }
        }
        #endregion
        #region ImageHover
        string vImgHover = "";
        if (flimgHover.FileName.Length > 0 && flimgHover.PostedFile.ContentLength > 0)
        {
            string filename = flimgHover.FileName;
            string fileex = filename.Substring(filename.LastIndexOf("."));
            if (ImagesExtension.ValidType(fileex))
            {
                string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(flimgHover.PostedFile.FileName);
                if (fileNotEx.Length > 10)
                    fileNotEx = fileNotEx.Remove(10);
                vImgHover = fileNotEx + DateTime.Now.Ticks.ToString() + fileex;
                flimgHover.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + vImgHover);
            }
        }
        #endregion
        #region Status
        string status = "0";
        if (cbStatus.Checked == true)
        {
            status = "1";
        }
        #endregion
        #region Seo
        string sSeo = "";
        if (tbLinkRewrite.Text.Equals(""))
        {
            tbLinkRewrite.Text = tbTagTitle.Text;
        }
        if (tbTagTitle.Text.Equals(""))
        {
            tbTagTitle.Text = tbTagTitle.Text;
        }

        #endregion
        #region Insert
        if (insert)
        {
            string[] image = { "", vImg, vImgHover };
            string imageInsert = StringExtension.GhepChuoi(TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, image);
            Groups.InsertGroups(language, app, ddlParrentCategories.SelectedValue, tbTitle.Text, tbUrl.Text, "", tbTagTitle.Text, tbLinkRewrite.Text, StringExtension.ReplateTitle(tbLinkRewrite.Text), tbTagKeyword.Text, tbTagDescription.Text, "", "", "", imageInsert, vgparams, "0", tbOrder.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status);

            if (pnTiepTucMenu.Visible)
            {
                if (cbContinue.Checked)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000, 'Đã tạo: " + tbTitle.Text + "');", true);
                    ResetMenuControls();
                }
                else
                {
                    #region After Insert/Update
                    ResetMenuControls();
                    Response.Redirect(LinkRedirect());
                    #endregion
                }
            }
            else
            {
                #region After Insert/Update
                ResetMenuControls();
                Response.Redirect(LinkRedirect());
                #endregion
            }
        }
        #endregion
        #region Update
        else
        {
            if (vImg.Equals(""))
                vImg = hdImg.Value;
            else
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImg.Value);

            if (vImgHover.Equals(""))
                vImgHover = hdImg2.Value;
            else
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImg2.Value);

            string[] image = { "", vImg, vImgHover };
            string imageInsert = StringExtension.GhepChuoi(TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, image);
            Groups.UpdateGroups(language, app, tbTitle.Text, tbUrl.Text, "", tbTagTitle.Text, tbLinkRewrite.Text, StringExtension.ReplateTitle(tbLinkRewrite.Text), tbTagKeyword.Text, tbTagDescription.Text, "", "", "", imageInsert, vgparams, hdTotalItem.Value, tbOrder.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status, igid);

            if (ddlParrentCategories.SelectedValue != hd_parent)
                Groups.UpdateParentOfGroups(igid, ddlParrentCategories.SelectedValue);
            #region After Insert/Update
            ResetMenuControls();
            Response.Redirect(LinkRedirect());
            #endregion
        }
        #endregion

    }

    private void ResetMenuControls()
    {
        try
        {
            tbOrder.Text = (int.Parse(tbOrder.Text) + 1).ToString();
        }
        catch { }
        tbLinkRewrite.Text = "";
        tbTagTitle.Text = "";
        tbTagKeyword.Text = "";
        tbTagDescription.Text = "";
        hd_parent = "";
        hdTotalItem.Value = "";
        ltimg.Text = "";
        ltimg2.Text = "";      
        btnXoaAnhHienTai.Visible = false;      
        btnXoaAnhHienTai2.Visible = false;  
        hdImg.Value = "";
        hdImg2.Value = "";
        tbTitle.Text = "";
        tbTitle.Focus();
        tbUrl.Text = "";
    }

    protected void btCancel_Click(object sender, EventArgs e)
    {        
        Response.Redirect(LinkRedirect());
    }    

    protected void btnXoaAnhHienTai2_Click(object sender, EventArgs e)
    {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImg2.Value);
        hdImg2.Value = ""; btnXoaAnhHienTai2.Visible = false; ltimg2.Text = "";
    }

    protected void btnXoaAnhHienTai_Click(object sender, EventArgs e)
    {
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImg.Value);
        hdImg.Value = ""; btnXoaAnhHienTai.Visible = false; ltimg.Text = "";
    }

    private void GetItemInDdlModul()
    {
        MenuConfig listModul = new MenuConfig();
        ddlModul.Items.Clear();
        for (int i = 0; i < listModul.TextModul.Length; i++)
        {
            ddlModul.Items.Add(new ListItem(listModul.TextModul[i], listModul.ValuesModul[i] + "__" + listModul.AppsModul[i]));
        }
    }

    protected void ddlModul_SelectedIndexChanged(object sender, EventArgs e)
    {
        tbUrl.Text = ddlModul.SelectedValue.Substring(0, ddlModul.SelectedValue.IndexOf("__"));
        tbTitle.Text = ddlModul.SelectedItem.Text;
        tbUrl.CssClass = "active";
        tbTitle.CssClass = "active";

        string app = ddlModul.SelectedValue.Substring(ddlModul.SelectedValue.IndexOf("__") + "__".Length);

        DataTable dt=new DataTable();
        dt = Groups.GetAllGroups(
                " * ", 
                DataExtension.AndConditon(
                    GroupsTSql.GetGroupsByVglang(language),
                    GroupsTSql.GetGroupsByVgapp(app),
                    GroupsColumns.IgenableColumn + " <> 2 "),
                "");

        ddlModulCate.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddlModulCate.Items.Add(new ListItem("Chọn danh mục", ""));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ddlModulCate.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
            }
        }
    }

    protected void ddlModulCate_SelectedIndexChanged(object sender, EventArgs e)
    {
        string go = ddlModul.SelectedValue.Substring(0, ddlModul.SelectedValue.IndexOf("__"));
        if (ddlModul.SelectedValue.Equals("?go=" + RewriteExtension.MenuContent + ""))
        {
            tbUrl.Text = go + "&igid=" + ddlModulCate.SelectedValue;
        }
        else
        {
            tbUrl.Text = go + "&page=" + TatThanhJsc.ProductModul.TypePage.Cate + "&igid=" + ddlModulCate.SelectedValue;
        }

        tbTitle.Text = ddlModulCate.SelectedItem.Text.Trim('.');

        tbUrl.CssClass = "active";
        tbTitle.CssClass = "active";
    }
}