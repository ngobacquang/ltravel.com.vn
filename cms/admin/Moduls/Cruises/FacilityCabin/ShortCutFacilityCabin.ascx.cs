using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.CruisesModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Cruises_FacilityCabin_ShortCutFacilityCabin : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    protected string app = CodeApplications.CruisesFacilityCabin;
    private string pic = FolderPic.Cruises;

    private string igid = "";
    private bool insert = false;
    private string suc = "";
    private string hd_parent = "0";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
            suc = Request.QueryString["suc"];
        if (suc.Equals(TypePage.CreateFacilityCabin))
            insert = true;

        if (Request.QueryString["igid"] != null)
            igid = Request.QueryString["igid"];
        if (Request.QueryString["hd_parent"] != null)
            hd_parent = Request.QueryString["hd_parent"];
        
        #region Gán app, pic cho user control upload ảnh đại diện
        flAnhDaiDien.App = CodeApplications.Cruises;
        flAnhDaiDien.Pic = pic;        
        #endregion
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
            LoadParentCate();
            InitialControlsValue(insert);            
        }
    }
    
    private string LinkRedrect()
    {
        return LinkAdmin.GoAdminSubModul(CodeApplications.Cruises, TypePage.FacilityCabin, ddlParentCate.SelectedValue);
    }

    void LoadParentCate()
    {
        DropDownListExtension.LoadParentCates(app, language, ddlParentCate);
       
        ddlParentCate.SelectedValue = hd_parent;
    }

    void InitialControlsValue(bool insert)
    {
        #region update
        if (!insert)
        {
            LtInsertUpdate.Text = Developer.CruisesKeyword.CapNhatDanhMuc;
            btOK.Text = "Đồng ý";
            ckbContinue.Visible = false;
            fields = "*";
            condition = GroupsTSql.GetGroupsByIgid(igid);
            DataTable dt = new DataTable();
            dt = Groups.GetGroups(top, fields, condition, orderBy);

            tbTitle.Text = dt.Rows[0]["VGNAME"].ToString();

            flAnhDaiDien.Load(dt.Rows[0][GroupsColumns.VgimageColumn].ToString());

            tbOrder.Text = dt.Rows[0]["IGORDER"].ToString();
            tbDesc.Text = dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VgdescColumn].ToString();

            tbDetail.Text = dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VgcontentColumn].ToString();
            hdOldContent.Value = tbDetail.Text;

            #region SEO
            tbSeoLink.Text = dt.Rows[0]["VGSEOLINK"].ToString();
            tbSeoTitle.Text = dt.Rows[0]["VGSEOTITLE"].ToString();
            tbSeoKeyword.Text = dt.Rows[0]["VGSEOMETAKEY"].ToString();
            tbSeoDescription.Text = dt.Rows[0]["VGSEOMETADESC"].ToString();
            #endregion
            if (dt.Rows[0]["IGENABLE"].ToString().Equals("0"))
            {
                cbStatus.Checked = false;
            }
            else
            {
                cbStatus.Checked = true;
            }
        }
        #endregion
        #region  insert
        else
        {
            LtInsertUpdate.Text = Developer.CruisesKeyword.TaoDanhMuc;
            btOK.Text = "Đồng ý";
            tbTitle.Focus();
        }
        #endregion
    }
   
    protected void btOK_Click(object sender, EventArgs e)
    {
        string contentDetail = ContentExtendtions.ProcessStringContent(tbDetail.Text, hdOldContent.Value, pic);
        
        #region Status
        string status = "0";
        if (cbStatus.Checked == true)
        {
            status = "1";
        }
        #endregion

        #region Seo
        if (tbSeoLink.Text.Trim().Equals(""))
        {
            tbSeoLink.Text = tbTitle.Text;
        }
        if (tbSeoTitle.Text.Trim().Equals(""))
        {
            tbSeoTitle.Text = tbTitle.Text;
        }
        if (tbSeoKeyword.Text.Trim().Equals(""))
        {
            tbSeoKeyword.Text = tbTitle.Text;
        }
        if (tbSeoDescription.Text.Trim().Equals(""))
        {
            tbSeoDescription.Text = tbDesc.Text;
        }
        #endregion

        #region Insert
        if (insert)
        {
            string image = flAnhDaiDien.Save(false, contentDetail);            

            Groups.InsertGroups(language, app, ddlParentCate.SelectedValue, tbTitle.Text, tbDesc.Text, contentDetail,
                tbSeoTitle.Text, tbSeoLink.Text, StringExtension.ReplateTitle(tbSeoLink.Text), tbSeoKeyword.Text,
                tbSeoDescription.Text, "", "", "", image, "", "", tbOrder.Text, DateTime.Now.ToString(),
                DateTime.Now.ToString(), DateTime.Now.ToString(), status);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTitle.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới " + tbTitle.Text);
            #endregion
        }
        #endregion
        #region Update
        else
        {
            string image = flAnhDaiDien.Save(true, contentDetail);            

            Groups.UpdateGroups(language, app, tbTitle.Text, tbDesc.Text, contentDetail, tbSeoTitle.Text, tbSeoLink.Text,
                StringExtension.ReplateTitle(tbSeoLink.Text), tbSeoKeyword.Text, tbSeoDescription.Text, "", "", "",
                image, "", "", tbOrder.Text, DateTime.Now.ToString(), DateTime.Now.ToString(),
                DateTime.Now.ToString(), status, igid);
            if (ddlParentCate.SelectedValue != hd_parent)
                Groups.UpdateParentOfGroups(igid, ddlParentCate.SelectedValue);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", tbTitle.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật " + tbTitle.Text);
            #endregion
        }
        #endregion

        #region After Insert/Update

        if (ckbContinue.Checked == true)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
                    "ThongBao(3000,'Đã tạo: " + tbTitle.Text + "');", true);
            ResetControls();
            LoadParentCate();
        }
        else
        {
            Response.Redirect(LinkRedrect());
        }

        #endregion
    }

    void ResetControls()
    {
        flAnhDaiDien.Reset();
        
        tbTitle.Text = "";        
        hd_parent = ddlParentCate.SelectedValue;
        tbDesc.Text = "";
        tbSeoLink.Text = "";
        tbSeoTitle.Text = "";
        tbSeoKeyword.Text = "";
        tbSeoDescription.Text = "";
        tbDetail.Text = "";
        try
        {
            tbOrder.Text = (Convert.ToInt32(tbOrder.Text) + 1).ToString();
        }
        catch { }
        tbTitle.Focus();
    }

    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkRedrect());
    }
}