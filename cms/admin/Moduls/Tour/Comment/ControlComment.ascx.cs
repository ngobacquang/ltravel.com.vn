using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Tour_Comment_ControlComment : System.Web.UI.UserControl
{
    protected string app = CodeApplications.TourComment;
    protected string appCate = CodeApplications.Tour;
    protected string pic = FolderPic.Tour;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string sortCookiesName = SortKey.SortTourItems;
    private string p = "1";
    private string NumberShowItem = "10";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    private string iid = "";

    private string name = "";

    private string ArrayId = "";    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["p"] != null)
            p = Request.QueryString["p"];
        if (Request.QueryString["iid"] != null)
            iid = Request.QueryString["iid"];
        
        if (Request.QueryString["name"] != null)
            name = Request.QueryString["name"];
        if (Request.QueryString["NumberShowItem"] != null)
            NumberShowItem = Request.QueryString["NumberShowItem"];

        if (!IsPostBack)
        {
            tbTitleSearch.Text = name;
            if (NumberShowItem.Length > 0)
            {
                DdlListShowItem.SelectedValue = NumberShowItem;
                DdlListShowItemTop.SelectedValue = NumberShowItem;
            }

            GetParentCate();
            GetComments("");
        }
    }

    protected string GetItemNameById(string iid)
    {
        DataTable dt = Items.GetItems("1", ItemsColumns.VititleColumn, ItemsTSql.GetById(iid), "");
        if (dt.Rows.Count > 0)
            return dt.Rows[0][ItemsColumns.VititleColumn].ToString();
        return "";
    }

    protected string LinkUpdate(string isid)
    {
        if (!NumberShowItem.Equals("") && !p.Equals(""))
        {
            return LinkAdmin.GoAdminItem(CodeApplications.Tour, "UpdateComment", isid, NumberShowItem, p);
        }
        else
        {
            return LinkAdmin.GoAdminItem(CodeApplications.Tour, "UpdateComment", isid);
        }
    }
    
    void GetComments(string order)
    {
        string condition = DataExtension.AndConditon(
            SubitemsTSql.GetByApp(app),
            SubitemsTSql.GetByLang(language),
            SubitemsColumns.IsenableColumn + "<>2"
            );
        
        if (tbTitleSearch.Text.Length > 0)
        {
            condition += " AND " + SearchTSql.GetSearchMathedCondition(tbTitleSearch.Text, SubitemsColumns.VstitleColumn, SubitemsColumns.VsemailColumn);
        }

        if (order.Length > 0)
            orderBy = order;
        else
        {
            orderBy = CookieExtension.GetCookiesSort(sortCookiesName);
            if (orderBy.Length < 1)
                orderBy = SubitemsColumns.DscreatedateColumn + " desc ";
        }

        DataSet ds = new DataSet();
        ds = Subitems.GetSubItemsPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
        DataTable dt = new DataTable();
        dt = ds.Tables[1];

        LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
            Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
            LinkAdmin.UrlAdmin(CodeApplications.Tour, TypePage.Comment,
                ddlCateSearch.SelectedValue, "",
                NumberShowItem), "currentPS", "otherPS", "firstPS",
            "lastPS", "previewPS", "nextPS");
        LtPaggingTop.Text = LtPagging.Text;
        rp_mn_users.DataSource = ds.Tables[0];
        rp_mn_users.DataBind();
    }

    void GetParentCate()
    {
        DataTable dt = new DataTable();
        fields = "*";
        condition = DataExtension.AndConditon(
            ItemsTSql.GetByLang(language),
            ItemsTSql.GetByApp(appCate),
            " IIENABLE <> 2 ");
        orderBy = ItemsColumns.VititleColumn;
        dt = Items.GetItems("",fields, condition, orderBy);

        ddlCateSearch.Items.Add(new ListItem("Chọn tour cần xem bình luận", ""));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ddlCateSearch.Items.Add(new ListItem(dt.Rows[i][ItemsColumns.VititleColumn].ToString(), dt.Rows[i][ItemsColumns.IidColumn].ToString()));
        }
        ddlCateSearch.SelectedValue = iid;
    }

    protected void lbtDate_Click(object sender, EventArgs e)
    {
        //Lưu vào cookies
        string order = CookieExtension.SetCookiesSort(SubitemsColumns.DscreatedateColumn, sortCookiesName);
        //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
        GetComments(order);
    }

    protected void lbtStatus_Click(object sender, EventArgs e)
    {
        //Lưu vào cookies
        string order = CookieExtension.SetCookiesSort(SubitemsColumns.IsenableColumn, sortCookiesName);
        //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
        GetComments(order);
    }


    protected void ltrSearch_Click(object sender, EventArgs e)
    {
        PostSearch();
    }

    protected void DdlListShowItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        PostSearch();
    }

    protected void DdlListShowItemTop_SelectedIndexChanged(object sender, EventArgs e)
    {
        DdlListShowItem.SelectedValue = DdlListShowItemTop.SelectedValue;
        PostSearch();
    }
    void PostSearch()
    {
        string key = "name=" + tbTitleSearch.Text;
        Response.Redirect(LinkAdmin.GoAdminCategory(CodeApplications.Tour, TypePage.Comment, ddlCateSearch.SelectedValue,
                                                    "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
    }
}