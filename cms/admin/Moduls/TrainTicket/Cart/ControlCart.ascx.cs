using System;
using System.Data;
using System.Web;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Extension;
using TatThanhJsc.TrainTicketModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_TrainTicket_Item_ControlCart : System.Web.UI.UserControl
{
    private string app = CodeApplications.TrainTicketCart;
    protected string pic = FolderPic.TrainTicket;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();    
    private string p = "1";
    private string NumberShowItem = "10";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";
  

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["p"] != null)
            p = Request.QueryString["p"];             

        if (!IsPostBack)
        {
            GetList();
        }
    }

    #region Lấy các thông tin liên quan    
    /// <summary>
    /// Có thể chỉnh sửa để thành hình thức thanh toán: offline, online qua paypal ...
    /// </summary>
    /// <param name="type"></param>
    /// <returns></returns>
    protected string LayHinhThucMua(string type)
    {
        if (type == "0")
            return "Tới mua tại của hàng";
        return "<span class='maunoibat'>" + type + "</span>";
    }

    protected string LayTrangThaiThanhToan(string status)
    {
        if (status == "1")
            return "<span class='maunoibat'>Hoàn thành</span>";
        else
            if (status == "-1")
                return "<span class='maunoibat1'>Đã huỷ</span>";
        return "Chưa hoàn thành";
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

        if (values["gioitinh"] != null)
        {
            temp = values["gioitinh"];
            if (temp.Length > 0)
                s += "<b>Giới tính:</b> " + LayGioiTinh(temp) + "<br/>";
        }

        if (values["diachinhanhang"] != null)
        {
            temp = values["diachinhanhang"];
            if (temp.Length > 0)
                s += "<b>Địa chỉ nhận hàng:</b> " + temp + "<br/>";
        }

        if (values["thanhpho"] != null)
        {
            temp = values["thanhpho"];
            if (temp.Length > 0)
                s += "<b>Thành phố:</b> " + temp + "<br/>";
        }

        if (values["quanhuyen"] != null)
        {
            temp = values["quanhuyen"];
            if (temp.Length > 0)
                s += "<b>Quận huyện:</b> " + temp + "<br/>";
        }

        if (values["email"] != null)
        {
            temp = values["email"];
            if (temp.Length > 0)
                s += "<b>Email:</b> " + temp + "<br/>";
        }

        if (values["sodienthoai"] != null)
        {
            temp = values["sodienthoai"];
            if (temp.Length > 0)
                s += "<b>Số điện thoại:</b> " + temp + "<br/>";
        }

        if (values["yeucaukhac"] != null)
        {
            temp = values["yeucaukhac"];
            if (temp.Length > 0)
                s += "<b>Yêu cầu khác:</b> " + temp + "<br/>";
        }
        #endregion

        return s;
    }
    string LayGioiTinh(string status)
    {
        if (status == "1")
            return "Nam";
        return "Nữ";
    }
    #endregion

    #region Lấy danh sách
    void GetList()
    {
        condition = DataExtension.AndConditon(
            ItemsTSql.GetItemsByViapp(app),
            ItemsColumns.IienableColumn + "<>2",
            ItemsTSql.GetItemsByVilang(language)
            );

        orderBy = ItemsColumns.IienableColumn + "," + ItemsColumns.DicreatedateColumn + " desc";
        DataSet ds = new DataSet();
        ds = TatThanhJsc.Database.Items.GetItemsPagging(p, NumberShowItem, condition, orderBy);
        DataTable dt = new DataTable();
        dt = ds.Tables[1];
        LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                      Convert.ToInt16(NumberShowItem), Convert.ToInt32(p),
                                                      LinkAdmin.UrlAdmin(CodeApplications.TrainTicket, TypePage.Cart,
                                                                   "", "",
                                                                   NumberShowItem), "currentPS", "otherPS", "firstPS",
                                                      "lastPS", "previewPS", "nextPS");
        rp_mn_users.DataSource = ds.Tables[0];
        rp_mn_users.DataBind();
    }
    #endregion
}