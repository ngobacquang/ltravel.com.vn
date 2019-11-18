using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Tour_Booking_ControlBooking : System.Web.UI.UserControl
{
    protected string app = CodeApplications.TourBooking;
    protected string appCate = CodeApplications.Tour;
    protected string pic = FolderPic.Tour;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string sortCookiesName = SortKey.SortTourItems + "Booking";
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

    protected string LayThongTinKhachHang(string info)
    {
        string s = "";

        #region Trích thông tin ra theo kiểu QueryString
        //Lấy tất cả parram được post lên từ máy khách
        var myUrl = info;
        myUrl = HttpUtility.HtmlDecode(myUrl);
        //Chuyển về kiểu QueryString
        var values = HttpUtility.ParseQueryString(myUrl);
        //Lấy ra giá trị theo tên QueryString
        //var t = values["ExpiryDate"];
        var temp = "";

        if (values["hoten"] != null)
        {
            temp = values["hoten"];
            if (temp.Length > 0)
                s += "<b>Họ tên:</b> " + temp + "<br/>";
        }

        if (values["email"] != null)
        {
            temp = values["email"];
            if (temp.Length > 0)
                s += "<b>Email:</b> " + temp + "<br/>";
        }

        if (values["phone"] != null)
        {
            temp = values["phone"];
            if (temp.Length > 0)
                s += "<b>Điện thoại:</b> " + temp + "<br/>";
        }

        if (values["address"] != null)
        {
            temp = values["address"];
            if (temp.Length > 0)
                s += "<b>Địa chỉ:</b> " + temp + "<br/>";
        }        
        #endregion

        return s;
    }

    protected string LayThongTinTour(string info)
    {
        string s = "";

        #region Trích thông tin ra theo kiểu QueryString
        //Lấy tất cả parram được post lên từ máy khách
        var myUrl = info;
        myUrl = HttpUtility.HtmlDecode(myUrl);
        //Chuyển về kiểu QueryString
        var values = HttpUtility.ParseQueryString(myUrl);
        //Lấy ra giá trị theo tên QueryString
        //var t = values["ExpiryDate"];
        var temp = "";

        if (values["adults"] != null)
        {
            temp = values["adults"];
            if (temp.Length > 0)
                s += "<b>Số người lớn:</b> " + temp + "<br/>";
        }

        if (values["children"] != null)
        {
            temp = values["children"];
            if (temp.Length > 0)
                s += "<b>Số trẻ em (6-11 tuổi):</b> " + temp + "<br/>";
        }

        if (values["infants"] != null)
        {
            temp = values["infants"];
            if (temp.Length > 0)
                s += "<b>Số em bé (0-5 tuổi):</b> " + temp + "<br/>";
        }

        if (values["priceperadult"] != null)
        {
            temp = values["priceperadult"];
            if (temp.Length > 0)
                s += "<b>Giá/1 người lớn:</b> " + temp + "<br/>";
        }

        if (values["priceperchild"] != null)
        {
            temp = values["priceperchild"];
            if (temp.Length > 0)
                s += "<b>Giá/1 trẻ em:</b> " + temp + "<br/>";
        }

        if (values["priceperinfant"] != null)
        {
            temp = values["priceperinfant"];
            if (temp.Length > 0)
                s += "<b>Giá/1 em bé:</b> " + temp + "<br/>";
        }

        if (values["departure"] != null)
        {
            temp = values["departure"];
            if (temp.Length > 0)
                s += "<b>Ngày khởi hành:</b> " + temp + "<br/>";
        }

        if (values["detail"] != null)
        {
            temp = values["detail"];
            if (temp.Length > 0)
                s += "<b>Yêu cầu khác:</b> <br/>" + temp.Replace("\n","<br/>") + "<br/>";
        }
        #endregion

        return s;
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
            return LinkAdmin.GoAdminItem(CodeApplications.Tour, "UpdateBooking", isid, NumberShowItem, p);
        }
        else
        {
            return LinkAdmin.GoAdminItem(CodeApplications.Tour, "UpdateBooking", isid);
        }
    }
    
    void GetBookings(string order)
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
            LinkAdmin.UrlAdmin(CodeApplications.Tour, TypePage.Booking,
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
        GetBookings(order);
    }

    protected void lbtStatus_Click(object sender, EventArgs e)
    {
        //Lưu vào cookies
        string order = CookieExtension.SetCookiesSort(SubitemsColumns.IsenableColumn, sortCookiesName);
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
        Response.Redirect(LinkAdmin.GoAdminCategory(CodeApplications.Tour, TypePage.Booking, ddlCateSearch.SelectedValue,
                                                    "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
    }
}