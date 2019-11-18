using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.DestinationModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Destination_Item_ShortCutItemVideo : System.Web.UI.UserControl
{
    private string app = CodeApplications.DestinationVideo;
    private string appCate = CodeApplications.Destination;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = FolderPic.Destination;    
        
    private string iid = "";
    private string igid = "";
    private bool insert = false;
    private string suc = "";
    private string p = "";
    private string ni = "";

    string parramSpitString = ",";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
            suc = Request.QueryString["suc"];
        if(suc.Equals(TypePage.CreateItem))
            insert = true;

        if (Request.QueryString["iid"] != null)
            iid = Request.QueryString["iid"];
        if (Request.QueryString["igid"] != null)
            igid = Request.QueryString["igid"];
        if (Request.QueryString["p"] != null)
            p = Request.QueryString["p"];
        if (Request.QueryString["ni"] != null)
            ni = Request.QueryString["ni"];
        
       
        #region Gán app, pic cho user control upload ảnh đại diện
        flAnhDaiDien.App = appCate;
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
            GetParentCate();            
            InitialControlsValue(insert);                  
        }
    }

    private string LinkRedrect()
    {
        if(!ni.Equals("") && !p.Equals(""))
            return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.Destination + "&igid=" +
                   ddlParentCate.SelectedValue + "&suc=" + TypePage.Item + "&ni=" + ni + "&p=" + p + "&app=" + app;
        else
            return UrlExtension.WebisteUrl + "admin.aspx?uc=" + CodeApplications.Destination + "&igid=" +
                   ddlParentCate.SelectedValue + "&suc=" + TypePage.Item + "&app=" + app;
    }

    void GetParentCate()
    {
        DataTable dt = new DataTable();
        dt = Groups.GetAllGroups("*", DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(appCate) + " AND IGENABLE <> '2' ", GroupsTSql.GetGroupsByVglang(language)), "");
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ddlParentCate.Items.Add(new ListItem(TatThanhJsc.Extension.DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
            }
        }
        if (!igid.Equals(""))
        {
            ddlParentCate.SelectedValue = igid;
        }
    }

    void InitialControlsValue(bool insert)
    {
        #region update
        if (!insert)
        {
            LtInsertUpdate.Text = Developer.DestinationKeyword.CapNhatBaiViet;
            btOK.Text = "Đồng ý";
            ckbContinue.Visible = false;
            string fields = "*";

            string condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(appCate), ItemsTSql.GetItemsByIid(iid));


            DataTable dt = GroupsItems.GetAllData("1", fields, condition, "");

            hdGroupsItemId.Value = dt.Rows[0][GroupsItemsColumns.IgiidColumn].ToString();
            ddlParentCate.SelectedValue = dt.Rows[0]["IGID"].ToString();

            tbTitle.Text = dt.Rows[0]["VITITLE"].ToString();
            tbDesc.Text = dt.Rows[0]["VIDESC"].ToString();
            tbContent.Text = dt.Rows[0]["VICONTENT"].ToString();
            hdOldContent.Value = dt.Rows[0]["VICONTENT"].ToString();
            
            #region SEO
            tbSeoLink.Text = dt.Rows[0]["VISEOLINK"].ToString();
            tbSeoTitle.Text = dt.Rows[0]["VISEOTITLE"].ToString();
            tbSeoKeyword.Text = dt.Rows[0]["VISEOMETAKEY"].ToString();
            tbSeoDescription.Text = dt.Rows[0]["VISEOMETADESC"].ToString();
            #endregion
            tbCreateDate.Text = dt.Rows[0]["DCREATEDATE"].ToString();

            flAnhDaiDien.Load(dt.Rows[0][ItemsColumns.ViimageColumn].ToString());

            hdTotalView.Value = dt.Rows[0]["IITOTALVIEW"].ToString();
            #region IIENABLE
            if (dt.Rows[0]["IIENABLE"].ToString().Equals("0"))            
                cbStatus.Checked = false;            
            else            
                cbStatus.Checked = true;
            
            #endregion
                     
            tbOrder.Text = dt.Rows[0][ItemsColumns.IiorderColumn].ToString();

            tbYouTube.Text = dt.Rows[0][ItemsColumns.ViauthorColumn].ToString();
        }
        #endregion
        #region  insert
        else
        {
            LtInsertUpdate.Text = Developer.DestinationKeyword.ThemMoiBaiViet;
            btOK.Text = "Đồng ý";
            tbCreateDate.Text = DateTime.Now.ToString();         
            tbTitle.Focus();
        }
        #endregion
    }

    void ResetControls()
    {
        flAnhDaiDien.Reset();
        tbTitle.Text = "";
        tbDesc.Text = "";
        tbContent.Text = "";
        hdOldContent.Value = "";
        tbCreateDate.Text = DateTime.Now.ToString();
        
        hdImage.Value = "";
        hdTotalView.Value = "";

        tbSeoLink.Text = "";
        tbSeoTitle.Text = "";
        tbSeoKeyword.Text = "";
        tbSeoDescription.Text = "";
        tbYouTube.Text = "";
        try
        {
            tbOrder.Text = (Convert.ToInt32(tbOrder.Text) + 1).ToString();
        }
        catch { }
        tbTitle.Focus();
    }

    protected void btOK_Click(object sender, EventArgs e)
    {
        string contentDetail = ContentExtendtions.ProcessStringContent(tbContent.Text, hdOldContent.Value, pic);
        
        #region Status
        string status = "0";
        if (cbStatus.Checked == true)        
            status = "1";        
        #endregion
        #region Time Create Date
        string timeCreateDate = "";
        timeCreateDate = tbCreateDate.Text;
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

        string videoCode = tbYouTube.Text;//viauthor: Mã nhúng video do người dùng nhập vào
        string videoKey = TatThanhJsc.Extension.VideoExtension.GetVideoKey(videoCode);//viurl: Mã của video được tách ra từ khối mã người dùng nhập vào (chỉ chứa id của video đó, không chứa các thông tin khác -> phục vụ khi lấy ra hiển thị dễ dàng hơn)

        #region Insert
        if (insert)
        {
            string image = flAnhDaiDien.Save(false, contentDetail);
            GroupsItems.InsertItemsGroupsItems(language, app, "", tbTitle.Text, tbDesc.Text, contentDetail,
                image, videoKey, videoCode, tbSeoTitle.Text, tbSeoLink.Text, StringExtension.ReplateTitle(tbSeoLink.Text),
                tbSeoKeyword.Text, tbSeoDescription.Text, "", "", "", "", "0", "0", "", "", timeCreateDate,
                DateTime.Now.ToString(), DateTime.Now.ToString(), tbOrder.Text, ddlParentCate.SelectedValue,
                timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), tbOrder.Text, status);

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

            GroupsItems.DeleteGroupsItems(GroupsItemsTSql.GetGroupsItemsByIgiid(hdGroupsItemId.Value));
            GroupsItems.UpdateItemsGroupsItems(language, app, "", tbTitle.Text, tbDesc.Text, contentDetail,
                image, videoKey, videoCode, tbSeoTitle.Text, tbSeoLink.Text, StringExtension.ReplateTitle(tbSeoLink.Text),
                tbSeoKeyword.Text, tbSeoDescription.Text, "", "", "", "", "0", "0", "", hdTotalView.Value,
                timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(), tbOrder.Text,
                ddlParentCate.SelectedValue, timeCreateDate, DateTime.Now.ToString(), DateTime.Now.ToString(),
                tbOrder.Text, status, iid);

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

    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkRedrect());
    }
}