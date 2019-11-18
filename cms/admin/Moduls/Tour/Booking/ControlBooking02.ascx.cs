using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Tour_Booking_ControlBooking02 : System.Web.UI.UserControl
{
    protected string app = CodeApplications.TourBooking+"02";
    protected string appCate = CodeApplications.Tour;
    protected string pic = FolderPic.Tour;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string sortCookiesName = SortKey.SortTourItems+"Booking02";
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
            GetBookings("");
        }
    }

    #region Trích thông tin đặt hàng
    protected string TrichThongTinDatHang(string data)
    {
        string s = "";

        DataTable dt = JsonConvert.DeserializeObject<DataTable>(data);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            s += "<b>" + dt.Rows[i]["name"] + "</b>";
            s += ExtractSubInfo((DataTable)dt.Rows[i]["data"], dt.Rows[i]["name"].ToString());
        }

        return s;
    }

    private string ExtractSubInfo(DataTable dt, string parentName)
    {
        string s = "";

        s += "<ul>";

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["type"].ToString() == "text")
            {
                s += dt.Rows[i]["name"].ToString() != parentName
                    ? "<li>" + dt.Rows[i]["name"] + ": " + dt.Rows[i]["data"] + "</li>"
                    : "<li>" + dt.Rows[i]["data"].ToString().Replace("\n", "<br/>") + "</li>";
            }
            else
            {
                if (dt.Rows[i]["type"].ToString() == "check")
                    s += dt.Rows[i]["data"].ToString() == "1"
                        ? "<li>" + dt.Rows[i]["name"] + "</li>"
                        : "";
            }           
        }

        s += "</ul>";

        return s;
    }
    #endregion

    void GetBookings(string order)
    {
        string condition = DataExtension.AndConditon(
            ItemsTSql.GetByApp(app),
            ItemsTSql.GetByLang(language),
            ItemsColumns.IienableColumn + "<>2"
            );                

        if (order.Length > 0)
            orderBy = order;
        else
        {
            orderBy = CookieExtension.GetCookiesSort(sortCookiesName);
            if (orderBy.Length < 1)
                orderBy = ItemsColumns.DicreatedateColumn + " desc ";
        }

        DataSet ds = new DataSet();
        ds = Items.GetItemsPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
        DataTable dt = new DataTable();
        dt = ds.Tables[1];

        LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
            Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
            LinkAdmin.UrlAdmin(CodeApplications.Tour, TypePage.Booking+"02",
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
        string order = CookieExtension.SetCookiesSort(ItemsColumns.DicreatedateColumn, sortCookiesName);
        //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
        GetBookings(order);
    }

    protected void lbtStatus_Click(object sender, EventArgs e)
    {
        //Lưu vào cookies
        string order = CookieExtension.SetCookiesSort(ItemsColumns.IienableColumn, sortCookiesName);
        //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
        GetBookings(order);
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
        Response.Redirect(LinkAdmin.GoAdminCategory(CodeApplications.Tour, TypePage.Booking+"02", ddlCateSearch.SelectedValue,
                                                    "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
    }
}