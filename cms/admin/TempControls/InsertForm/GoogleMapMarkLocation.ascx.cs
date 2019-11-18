using System;

public partial class cms_admin_TempControls_InsertForm_GoogleMapMarkLocation : System.Web.UI.UserControl
{
    protected string lat = "";
    protected string lng = "";
    protected string infoWindow = "";

    /*
     Hướng dẫn sử dụng
    ============Gọi hàm để hiện thị thông tin khi update danh mục, sản phẩm=============
    GoogleMapMarkLocation.Load(viDo, kinhDo, diaChi);
    
    
    ============Lấy thông tin để insert, update vào database
    GoogleMapMarkLocation.ViDo, GoogleMapMarkLocation.KinhDo
    
    
    ============Gọi hàm reset sau khi insert xong
    GoogleMapMarkLocation.Reset();
     */

    #region Tên hiển thị control
    /// <summary>
    /// Tên hiển thị
    /// </summary>
    public string Text { set { ltrText.Text = value; } }
    #endregion

    public string ViDo
    {
        get {return tbViDo.Text;}
        set
        {
            tbViDo.Text = value;
            lat = value;
        }
    }
    public string KinhDo
    {
        get { return tbKinhDo.Text; }
        set
        {
            tbKinhDo.Text = value;
            lng = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(ltrText.Text == "")
            ltrText.Text = "Địa chỉ trên Google maps";
    }
    #region Phương thức điền thông tin ra bản đồ
    public void Load(string viDo, string kinhDo, string diaChi)
    {
        tbViDo.Text = viDo;
        tbKinhDo.Text = kinhDo;

        lat = tbViDo.Text;
        lng = tbKinhDo.Text;
        infoWindow = diaChi;
    }
    #endregion
    

    #region Phương thức reset sau khi tạo xong
    /// <summary>
    /// Phương thức reset sau khi tạo xong
    /// </summary>
    public void Reset()
    {
        tbKinhDo.Text = "";
        tbViDo.Text = "";
    }
    #endregion
}