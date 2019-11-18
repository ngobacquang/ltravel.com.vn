using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Database;
using TatThanhJsc.ProductModul;
using TatThanhJsc.TSql;
using TatThanhJsc.Extension;

public partial class cms_admin_Moduls_Product_Color_ShortCutColor : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string app = CodeApplications.ProductColors;
    private string pic = FolderPic.Product;

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
        if (hd_insert_update.Equals(TypePage.CreateColor))
            insert = true;

        if (!IsPostBack)
        {
            GetGroupsInDdl();
            InitialControlsValue(insert);            
        }
    }    

    private string LinkRedrect()
    {
        return LinkAdmin.GoAdminSubModul(CodeApplications.Product, TypePage.Color, DdlGroupProduct.SelectedValue);
    }

    void GetGroupsInDdl()
    {
        DataTable dt = new DataTable();
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVglang(language), GroupsTSql.GetGroupsByVgapp(app), " igenable <> '2' ");
        dt = Groups.GetAllGroups("*", condition, "");
        DdlGroupProduct.Items.Clear();
        DdlGroupProduct.Items.Add(new ListItem("Danh mục gốc", "0"));
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DdlGroupProduct.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
            }
        }
        DdlGroupProduct.SelectedValue = hd_parent;
    }

    void InitialControlsValue(bool insert)
    {
        #region update
        if (!insert)
        {
            LtInsertUpdate.Text = Developer.ProductKeyword.CapNhatMau;
            btn_insert_update.Text = "Đồng ý";
            ckbContinue.Visible = false;
            fields = "*";
            condition = GroupsTSql.GetGroupsByIgid(igid);
            DataTable dt = new DataTable();
            dt = Groups.GetGroups(top, fields, condition, orderBy);

            txt_title_modul.Text = dt.Rows[0]["VGNAME"].ToString();
           
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

            tbColor.Text = dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VgparamsColumn].ToString();
        }
        #endregion
        #region  insert
        else
        {
            LtInsertUpdate.Text = Developer.ProductKeyword.TaoMauMoi;
            btn_insert_update.Text = "Đồng ý";
        }
        #endregion
    }

    protected void btn_insert_update_Click(object sender, EventArgs e)
    {        
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
        #region MaMau-vgparams
        string color = tbColor.Text;
        #endregion
        #region Insert
        if (insert)
        {
            Groups.InsertGroups(language, app, DdlGroupProduct.SelectedValue, txt_title_modul.Text, txtDesc.Text, "", textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", "", color, "", txt_ordermodul.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status);
        }
        #endregion
        #region Update
        else
        {           
            Groups.UpdateGroups(language, app, txt_title_modul.Text, txtDesc.Text, "", textTagTitle.Text, textLinkRewrite.Text, StringExtension.ReplateTitle(textLinkRewrite.Text), textTagKeyword.Text, textTagDescription.Text, "", "", "", "", color, "", txt_ordermodul.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), status, igid);
            if (DdlGroupProduct.SelectedValue != hd_parent)
                Groups.UpdateParentOfGroups(igid, DdlGroupProduct.SelectedValue);
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

    void ResetControls()
    {
        txt_title_modul.Text = "";        
        hd_img.Value = "";
        hd_parent = DdlGroupProduct.SelectedValue;
        txtDesc.Text = "";

        textLinkRewrite.Text = "";
        textTagTitle.Text = "";
        textTagKeyword.Text = "";
        textTagDescription.Text = "";

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
}