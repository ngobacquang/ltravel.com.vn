using System;
using System.Data;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Extension;
using TatThanhJsc.PhotoAlbumModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_PhotoAlbum_Item_ControlComment : System.Web.UI.UserControl
{
    private string app = CodeApplications.PhotoAlbumComment;
    protected string pic = FolderPic.PhotoAlbum;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();    
    private string p = "1";
    private string NumberShowItem = "10";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    private string igid = "";

    private string conditionItems = "";
    private string key = "";
    private string SearchCondition = "";
    private string ArrayId = "";    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["p"] != null)
            p = Request.QueryString["p"];
        if (Request.QueryString["igid"] != null)
            igid = Request.QueryString["igid"];
        if (Request.QueryString["key"] != null)
            key = Request.QueryString["key"];
        if (Request.QueryString["NumberShowItem"] != null)
            NumberShowItem = Request.QueryString["NumberShowItem"].ToString();

        if (!IsPostBack)
        {
            GetComments();
        }
    }

    void GetComments()
    {
        DdlListShowItem.SelectedValue = NumberShowItem;
        condition = DataExtension.AndConditon(
            SubitemsTSql.GetSubitemsByVskey(app),
            SubitemsTSql.GetSubitemsByVslang(language));        
        orderBy = SubitemsColumns.DscreatedateColumn + " desc ";
        DataSet ds = new DataSet();
        ds = TatThanhJsc.Database.Subitems.GetSubItemsPagging(p.ToString(), NumberShowItem, condition, orderBy);
        DataTable dt = new DataTable();
        dt = ds.Tables[1];
        LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                      Convert.ToInt16(NumberShowItem), Convert.ToInt32(p),
                                                      LinkAdmin.UrlAdmin(CodeApplications.PhotoAlbum, TypePage.Comment,
                                                                   "", "",
                                                                   NumberShowItem), "currentPS", "otherPS", "firstPS",
                                                      "lastPS", "previewPS", "nextPS");
        rp_mn_users.DataSource = ds.Tables[0];
        rp_mn_users.DataBind();
    }
}