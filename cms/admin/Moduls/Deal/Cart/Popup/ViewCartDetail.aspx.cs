using System;
using System.Data;
using System.Web;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc;
using TatThanhJsc.TSql;
using TatThanhJsc.Extension;

public partial class cms_admin_Deal_ShowDealControl_ViewCart : System.Web.UI.Page
{
    private string iid = "";

    private string app =TatThanhJsc.DealModul.CodeApplications.DealCart; 
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    protected int sott = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        iid =QueryStringExtension.GetQueryString("iid");
        if (!IsPostBack)
        {            
            GetCartDetails(iid);
        }
    }

    void GetCartDetails(string iid)
    {
        DataTable dt = new DataTable();
        condition = DataExtension.AndConditon(
            ItemsTSql.GetItemsByViapp(app),
            ItemsTSql.GetItemsByIid(iid)
            );
        dt = TatThanhJsc.Database.Items.GetItems("1", "*", condition, "");
        if (dt.Rows.Count > 0)
        {
            ltrMaDonHang.Text = dt.Rows[0][ItemsColumns.VikeyColumn].ToString();
            ltrThongTinKhachHang.Text = LayThongTinKhachHang(dt.Rows[0][ItemsColumns.VicontentColumn].ToString());
            double phiVanChuyen = 0;
            double tongTienHang = 0;
            try
            {
                phiVanChuyen = double.Parse(dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString());
            }
            catch { }
            try
            {
                tongTienHang = double.Parse(dt.Rows[0][ItemsColumns.FipriceColumn].ToString());
            }
            catch{}
            tongTienHang += phiVanChuyen;
            ltrTotalPrice.Text = NumberExtension.FormatNumber(tongTienHang.ToString());
            ltrReadPrice.Text = NumberExtension.ReadNumber(tongTienHang.ToString());

            GetList(iid);
        }
    }
    protected string ThanhTien(string soLuong,string donGia)
    {        
        double soluong = 0;
        double dongia = 0;
        try
        {
            soluong = double.Parse(soLuong);
        }
        catch
        {
        }
        try
        {
            dongia = double.Parse(donGia);
        }
        catch
        {
        }
        dongia *= soluong;

        return NumberExtension.FormatNumber(dongia.ToString());
    }
    void GetList(string iid)
    {
        DataTable dt=new DataTable();

        condition = DataExtension.AndConditon(
            SubitemsTSql.GetSubitemsByIid(iid),
            SubitemsTSql.GetSubitemsByVskey(app)
            );
        orderBy = SubitemsColumns.VstitleColumn;
        dt = Subitems.GetSubItems("", "*", condition, orderBy);
        rptList.DataSource = dt;
        rptList.DataBind();
    }

    #region Lấy các thông tin liên quan
    /// <summary>
    /// Có thể chỉnh sửa để thành hình thức thanh toán: offline, online qua paypal ...
    /// </summary>
    /// <param name="type"></param>
    /// <returns></returns>
    protected string LayHinhThucMua(string type)
    {
        if (type == "1")
            return "<span class='maunoibat'>Trực tuyến</span>";
        return "Tới mua tại của hàng";
    }

    protected string LayTrangThaiThanhToan(string status)
    {
        if (status == "1")
            return "<span class='maunoibat'>Hoàn thành</span>";
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
}
