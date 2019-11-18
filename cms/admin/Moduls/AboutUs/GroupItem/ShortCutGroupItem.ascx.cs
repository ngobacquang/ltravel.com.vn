using Developer.Position;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.AboutUsModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_AboutUs_GroupItem_ShortCutGroupItem : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string app = CodeApplications.AboutUsGroupItem;
    private string appCate = CodeApplications.AboutUs;
    private string pic = FolderPic.AboutUs;

    private string igid = "";
    private bool insert = false;
    private string hd_insert_update = "";
    private string hd_parent = "0";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    private string typeModul = CodeApplications.AboutUs;
    private string typePage = TypePage.GroupItem;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
            hd_insert_update = Request.QueryString["suc"];
        if (Request.QueryString["igid"] != null)
            igid = Request.QueryString["igid"];
        if (Request.QueryString["hd_parent"] != null)
            hd_parent = Request.QueryString["hd_parent"];
        if (hd_insert_update.Equals(TypePage.CreateGroupItem))
            insert = true;
        
        #region Gán app, pic cho user control upload ảnh đại diện
        flAnhDaiDien.App = appCate;
        flAnhDaiDien.Pic = pic;
        #endregion
        if (!IsPostBack)
        {
            GetPosition();
            InitialControlsValue(insert);            
        }
    }

    private string LinkRedrect()
    {
        return LinkAdmin.GoAdminSubModul(typeModul, typePage, DdlPosition.SelectedValue);
    }

    void GetPosition()
    {
        AboutUsPosition listModul = new AboutUsPosition();
        DdlPosition.Items.Clear();
        for (int i = 0; i < listModul.Text.Length; i++)
        {
            DdlPosition.Items.Add(new ListItem(listModul.Text[i], listModul.Values[i]));
        }
    }

    void InitialControlsValue(bool insert)
    {
        #region update
        if (!insert)
        {
            LtInsertUpdate.Text = Developer.AboutUsKeyword.CapNhatNhomAboutUs;
            btOK.Text = "Đồng ý";
            ckbContinue.Visible = false;
            fields = "*";
            condition = GroupsTSql.GetGroupsByIgid(igid);
            DataTable dt = new DataTable();
            dt = Groups.GetGroups(top, fields, condition, orderBy);

            DdlPosition.SelectedValue = dt.Rows[0]["VGPARAMS"].ToString();
            tbTitle.Text = dt.Rows[0]["VGNAME"].ToString();

            flAnhDaiDien.Load(dt.Rows[0][GroupsColumns.VgimageColumn].ToString());

            tbOrder.Text = dt.Rows[0]["IGORDER"].ToString();
            tbDesc.Text = dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VgdescColumn].ToString();
            tbMaxItem.Text = dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.IgtotalitemsColumn].ToString();
            #region SEO
            tbSeoLink.Text = dt.Rows[0]["VGSEOLINK"].ToString();
            tbSeoTitle.Text = dt.Rows[0]["VGSEOTITLE"].ToString();
            tbSeoKeyword.Text = dt.Rows[0]["VGSEOMETAKEY"].ToString();
            tbSeoDescription.Text = dt.Rows[0]["VGSEOMETADESC"].ToString();
            #endregion

            cbStatus.Checked = dt.Rows[0]["IGENABLE"].ToString() == "1";
        }
        #endregion
        #region  insert
        else
        {
            LtInsertUpdate.Text = Developer.AboutUsKeyword.TaoNhomMoi;
            btOK.Text = "Đồng ý";
        }
        #endregion
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
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
            string image = flAnhDaiDien.Save(false, "");
            Groups.InsertGroups(language, app, "", tbTitle.Text, tbDesc.Text, "", tbSeoTitle.Text, tbSeoLink.Text, StringExtension.ReplateTitle(tbSeoLink.Text), tbSeoKeyword.Text, tbSeoDescription.Text, "", "", "", image, DdlPosition.SelectedValue, tbMaxItem.Text, tbOrder.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status);

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
            string image = flAnhDaiDien.Save(true, "");
            Groups.UpdateGroups(language, app, tbTitle.Text, tbDesc.Text, "", tbSeoTitle.Text, tbSeoLink.Text, StringExtension.ReplateTitle(tbSeoLink.Text), tbSeoKeyword.Text, tbSeoDescription.Text, "", "", "", image, DdlPosition.SelectedValue, tbMaxItem.Text, tbOrder.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status, igid);

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
        tbDesc.Text = "";
        tbSeoLink.Text = "";
        tbSeoTitle.Text = "";
        tbSeoKeyword.Text = "";
        tbSeoDescription.Text = "";
        
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