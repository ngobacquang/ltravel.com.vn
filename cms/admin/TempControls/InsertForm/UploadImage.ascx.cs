using System;
using TatThanhJsc.Extension;

public partial class cms_admin_TempControls_InsertForm_UploadImage : System.Web.UI.UserControl
{
    /*
     Hướng dẫn sử dụng
    ============Tại PageLoad gọi===========================
    #region Gán app, pic cho user control upload ảnh đại diện
    flAnhDaiDien.App = app;
    flAnhDaiDien.Pic = pic;
    #endregion
    
    
    ============Gọi hàm để hiện thị ảnh khi update danh mục, sản phẩm=============
    flAnhDaiDien.Load(dt.Rows[0][GroupsColumns.VgimageColumn].ToString());
    
    
    ============Gọi hàm lúc click nút insert, update để lưu và lấy ra tên ảnh được lưu. contentDetail là nội dung để nếu cần sẽ lấy ảnh đầu tiên trong đó làm ảnh đại diện
    Insert: string image = flAnhDaiDien.Save(false, contentDetail);
    Update: string image = flAnhDaiDien.Save(true, contentDetail);
    
    
    ============Gọi hàm reset sau khi insert xong
    flAnhDaiDien.Reset();
     */

    #region Các thuộc tính được truyền vào từ ngoài
    #region Tên hiển thị control
    /// <summary>
    /// Tên hiển thị
    /// </summary>
    public string Text { set {ltrText.Text = value;} }
    #endregion

    #region App - xác định dùng cho modul nào để tự động lấy thư mục pic, lấy setting
    private string app = "";
    /// <summary>
    /// App - xác định dùng cho modul nào để tự động lấy thư mục pic, lấy setting, ví dụ: TatThanh.ProductModul.CodeApplication.Product. Cần gán ngay tại Page_Load
    /// Hiện đang có cho các modul sau: 
    /// Contact
    /// Content
    /// Customer
    /// Deal
    /// Destination
    /// FileLibrary
    /// FileLibrary2
    /// Forum
    /// Hotel
    /// Member
    /// News
    /// PhotoAlbum
    /// PhotoAlbumMember
    /// Product
    /// QA
    /// Service
    /// Tour
    /// TrainTicket
    /// Video
    /// Website
    /// </summary>
    public string App { set { this.app = value; } }
    #endregion

    #region Pic
    private string pic = "";
    /// <summary>
    ///  Cần gán ngay tại Page_Load
    /// </summary>
    public string Pic { set {this.pic = value;} }
    #endregion

    #region Ảnh cũ - hdImage.Value
    public string HdImage { set { hdImage.Value = value; } }
    #endregion

    #region Hiển thị nút lấy ảnh đầu từ nội dung
    private bool layAnhTuNoiDung = true;
    /// <summary>
    /// Có hiện checkbox lấy ảnh từ nội dung hay không
    /// </summary>
    public bool LayAnhTuNoiDung
    {
        set
        {
            layAnhTuNoiDung = value;
            cbLayAnhTuNoiDung.Visible = value;
        }
    }
    #endregion
    #endregion


    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    #region Các control lưu trữ giá trị tạm thời theo từng modul
    string dongDauAnh = "";
    string dongDauAnh_AnhDau = "";
    string dongDauAnh_ViTri = "";
    string dongDauAnh_LeNgang = "";
    string dongDauAnh_LeDoc = "";
    string dongDauAnh_TyLe = "";
    string dongDauAnh_TrongSuot = "";
    string hanCheKichThuocAnh = "";
    string hanCheKichThuocAnh_MaxWidth = "";
    string hanCheKichThuocAnh_MaxHeight = "";
    string taoAnhNhoChoAnh = "";
    string taoAnhNhoChoAnh_MaxWidth = "";
    string taoAnhNhoChoAnh_MaxHeight = "";
    #endregion
        
    protected void Page_Load(object sender, EventArgs e)
    {
        #region Kiểm tra xem pic, app đã được gán chưa
        if(app == "" || pic == "")        
            throw new Exception("Chưa khởi tạo App, Pic. Vui lòng xem hướng dẫn tại control TempControls\\InsertForm\\UploadImage");
        #endregion

        SetPropertiesByModul();
        if(!IsPostBack)
        {            
            KhoiTaoXuLyAnh();
        }
    }

    #region Gán pic, các cấu hình ảnh theo modul
     private void SetPropertiesByModul()
    {

        switch(app)
        {
            case TatThanhJsc.AboutUsModul.CodeApplications.AboutUs:
                pic = TatThanhJsc.AboutUsModul.FolderPic.AboutUs;

                dongDauAnh = TatThanhJsc.AboutUsModul.SettingKey.DongDauAnhAboutUs;
                dongDauAnh_AnhDau = TatThanhJsc.AboutUsModul.SettingKey.DongDauAnhAboutUs_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.AboutUsModul.SettingKey.DongDauAnhAboutUs_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.AboutUsModul.SettingKey.DongDauAnhAboutUs_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.AboutUsModul.SettingKey.DongDauAnhAboutUs_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.AboutUsModul.SettingKey.DongDauAnhAboutUs_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.AboutUsModul.SettingKey.DongDauAnhAboutUs_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.AboutUsModul.SettingKey.HanCheKichThuocAnhAboutUs;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.AboutUsModul.SettingKey.HanCheKichThuocAnhAboutUs_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.AboutUsModul.SettingKey.HanCheKichThuocAnhAboutUs_MaxHeight;
                taoAnhNhoChoAnh = TatThanhJsc.AboutUsModul.SettingKey.TaoAnhNhoChoAnhAboutUs;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.AboutUsModul.SettingKey.TaoAnhNhoChoAnhAboutUs_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.AboutUsModul.SettingKey.TaoAnhNhoChoAnhAboutUs_MaxHeight;
                break;


            case TatThanhJsc.ContactModul.CodeApplications.Contact:
                pic = TatThanhJsc.ContactModul.FolderPic.Contact;

                dongDauAnh = TatThanhJsc.ContactModul.SettingKey.DongDauAnhContact;
                dongDauAnh_AnhDau = TatThanhJsc.ContactModul.SettingKey.DongDauAnhContact_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.ContactModul.SettingKey.DongDauAnhContact_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.ContactModul.SettingKey.DongDauAnhContact_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.ContactModul.SettingKey.DongDauAnhContact_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.ContactModul.SettingKey.DongDauAnhContact_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.ContactModul.SettingKey.DongDauAnhContact_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.ContactModul.SettingKey.HanCheKichThuocAnhContact;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.ContactModul.SettingKey.HanCheKichThuocAnhContact_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.ContactModul.SettingKey.HanCheKichThuocAnhContact_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.ContactModul.SettingKey.TaoAnhNhoChoAnhContact;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.ContactModul.SettingKey.TaoAnhNhoChoAnhContact_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.ContactModul.SettingKey.TaoAnhNhoChoAnhContact_MaxHeight;
                break;

            case TatThanhJsc.ContentModul.CodeApplications.Content:
                pic = TatThanhJsc.ContentModul.FolderPic.Content;

                dongDauAnh = TatThanhJsc.ContentModul.SettingKey.DongDauAnhContent;
                dongDauAnh_AnhDau = TatThanhJsc.ContentModul.SettingKey.DongDauAnhContent_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.ContentModul.SettingKey.DongDauAnhContent_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.ContentModul.SettingKey.DongDauAnhContent_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.ContentModul.SettingKey.DongDauAnhContent_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.ContentModul.SettingKey.DongDauAnhContent_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.ContentModul.SettingKey.DongDauAnhContent_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.ContentModul.SettingKey.HanCheKichThuocAnhContent;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.ContentModul.SettingKey.HanCheKichThuocAnhContent_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.ContentModul.SettingKey.HanCheKichThuocAnhContent_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.ContentModul.SettingKey.TaoAnhNhoChoAnhContent;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.ContentModul.SettingKey.TaoAnhNhoChoAnhContent_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.ContentModul.SettingKey.TaoAnhNhoChoAnhContent_MaxHeight;
                break;

            case TatThanhJsc.CustomerModul.CodeApplications.Customer:
                pic = TatThanhJsc.CustomerModul.FolderPic.Customer;

                dongDauAnh = TatThanhJsc.CustomerModul.SettingKey.DongDauAnhCustomer;
                dongDauAnh_AnhDau = TatThanhJsc.CustomerModul.SettingKey.DongDauAnhCustomer_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.CustomerModul.SettingKey.DongDauAnhCustomer_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.CustomerModul.SettingKey.DongDauAnhCustomer_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.CustomerModul.SettingKey.DongDauAnhCustomer_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.CustomerModul.SettingKey.DongDauAnhCustomer_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.CustomerModul.SettingKey.DongDauAnhCustomer_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.CustomerModul.SettingKey.HanCheKichThuocAnhCustomer;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.CustomerModul.SettingKey.HanCheKichThuocAnhCustomer_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.CustomerModul.SettingKey.HanCheKichThuocAnhCustomer_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.CustomerModul.SettingKey.TaoAnhNhoChoAnhCustomer;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.CustomerModul.SettingKey.TaoAnhNhoChoAnhCustomer_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.CustomerModul.SettingKey.TaoAnhNhoChoAnhCustomer_MaxHeight;
                break;


            case TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews:
                pic = TatThanhJsc.CustomerReviewsModul.FolderPic.CustomerReviews;

                dongDauAnh = TatThanhJsc.CustomerReviewsModul.SettingKey.DongDauAnhCustomerReviews;
                dongDauAnh_AnhDau = TatThanhJsc.CustomerReviewsModul.SettingKey.DongDauAnhCustomerReviews_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.CustomerReviewsModul.SettingKey.DongDauAnhCustomerReviews_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.CustomerReviewsModul.SettingKey.DongDauAnhCustomerReviews_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.CustomerReviewsModul.SettingKey.DongDauAnhCustomerReviews_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.CustomerReviewsModul.SettingKey.DongDauAnhCustomerReviews_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.CustomerReviewsModul.SettingKey.DongDauAnhCustomerReviews_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.CustomerReviewsModul.SettingKey.HanCheKichThuocAnhCustomerReviews;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.CustomerReviewsModul.SettingKey.HanCheKichThuocAnhCustomerReviews_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.CustomerReviewsModul.SettingKey.HanCheKichThuocAnhCustomerReviews_MaxHeight;
                taoAnhNhoChoAnh = TatThanhJsc.CustomerReviewsModul.SettingKey.TaoAnhNhoChoAnhCustomerReviews;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.CustomerReviewsModul.SettingKey.TaoAnhNhoChoAnhCustomerReviews_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.CustomerReviewsModul.SettingKey.TaoAnhNhoChoAnhCustomerReviews_MaxHeight;
                break;

            case TatThanhJsc.CruisesModul.CodeApplications.Cruises:
                pic = TatThanhJsc.CruisesModul.FolderPic.Cruises;

                dongDauAnh = TatThanhJsc.CruisesModul.SettingKey.DongDauAnhCruises;
                dongDauAnh_AnhDau = TatThanhJsc.CruisesModul.SettingKey.DongDauAnhCruises_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.CruisesModul.SettingKey.DongDauAnhCruises_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.CruisesModul.SettingKey.DongDauAnhCruises_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.CruisesModul.SettingKey.DongDauAnhCruises_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.CruisesModul.SettingKey.DongDauAnhCruises_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.CruisesModul.SettingKey.DongDauAnhCruises_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.CruisesModul.SettingKey.HanCheKichThuocAnhCruises;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.CruisesModul.SettingKey.HanCheKichThuocAnhCruises_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.CruisesModul.SettingKey.HanCheKichThuocAnhCruises_MaxHeight;
                taoAnhNhoChoAnh = TatThanhJsc.CruisesModul.SettingKey.TaoAnhNhoChoAnhCruises;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.CruisesModul.SettingKey.TaoAnhNhoChoAnhCruises_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.CruisesModul.SettingKey.TaoAnhNhoChoAnhCruises_MaxHeight;
                break;

            case TatThanhJsc.DealModul.CodeApplications.Deal:
                pic = TatThanhJsc.DealModul.FolderPic.Deal;

                dongDauAnh = TatThanhJsc.DealModul.SettingKey.DongDauAnhDeal;
                dongDauAnh_AnhDau = TatThanhJsc.DealModul.SettingKey.DongDauAnhDeal_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.DealModul.SettingKey.DongDauAnhDeal_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.DealModul.SettingKey.DongDauAnhDeal_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.DealModul.SettingKey.DongDauAnhDeal_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.DealModul.SettingKey.DongDauAnhDeal_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.DealModul.SettingKey.DongDauAnhDeal_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.DealModul.SettingKey.HanCheKichThuocAnhDeal;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.DealModul.SettingKey.HanCheKichThuocAnhDeal_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.DealModul.SettingKey.HanCheKichThuocAnhDeal_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.DealModul.SettingKey.TaoAnhNhoChoAnhDeal;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.DealModul.SettingKey.TaoAnhNhoChoAnhDeal_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.DealModul.SettingKey.TaoAnhNhoChoAnhDeal_MaxHeight;
                break;

            case TatThanhJsc.DestinationModul.CodeApplications.Destination:
                pic = TatThanhJsc.DestinationModul.FolderPic.Destination;

                dongDauAnh = TatThanhJsc.DestinationModul.SettingKey.DongDauAnhDestination;
                dongDauAnh_AnhDau = TatThanhJsc.DestinationModul.SettingKey.DongDauAnhDestination_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.DestinationModul.SettingKey.DongDauAnhDestination_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.DestinationModul.SettingKey.DongDauAnhDestination_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.DestinationModul.SettingKey.DongDauAnhDestination_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.DestinationModul.SettingKey.DongDauAnhDestination_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.DestinationModul.SettingKey.DongDauAnhDestination_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.DestinationModul.SettingKey.HanCheKichThuocAnhDestination;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.DestinationModul.SettingKey.HanCheKichThuocAnhDestination_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.DestinationModul.SettingKey.HanCheKichThuocAnhDestination_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.DestinationModul.SettingKey.TaoAnhNhoChoAnhDestination;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.DestinationModul.SettingKey.TaoAnhNhoChoAnhDestination_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.DestinationModul.SettingKey.TaoAnhNhoChoAnhDestination_MaxHeight;
                break;

            case TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary:
                pic = TatThanhJsc.FileLibraryModul.FolderPic.FileLibrary;

                dongDauAnh = TatThanhJsc.FileLibraryModul.SettingKey.DongDauAnhFileLibrary;
                dongDauAnh_AnhDau = TatThanhJsc.FileLibraryModul.SettingKey.DongDauAnhFileLibrary_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.FileLibraryModul.SettingKey.DongDauAnhFileLibrary_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.FileLibraryModul.SettingKey.DongDauAnhFileLibrary_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.FileLibraryModul.SettingKey.DongDauAnhFileLibrary_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.FileLibraryModul.SettingKey.DongDauAnhFileLibrary_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.FileLibraryModul.SettingKey.DongDauAnhFileLibrary_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.FileLibraryModul.SettingKey.HanCheKichThuocAnhFileLibrary;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.FileLibraryModul.SettingKey.HanCheKichThuocAnhFileLibrary_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.FileLibraryModul.SettingKey.HanCheKichThuocAnhFileLibrary_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.FileLibraryModul.SettingKey.TaoAnhNhoChoAnhFileLibrary;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.FileLibraryModul.SettingKey.TaoAnhNhoChoAnhFileLibrary_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.FileLibraryModul.SettingKey.TaoAnhNhoChoAnhFileLibrary_MaxHeight;
                break;

            case TatThanhJsc.FileLibrary2Modul.CodeApplications.FileLibrary2:
                pic = TatThanhJsc.FileLibrary2Modul.FolderPic.FileLibrary2;

                dongDauAnh = TatThanhJsc.FileLibrary2Modul.SettingKey.DongDauAnhFileLibrary2;
                dongDauAnh_AnhDau = TatThanhJsc.FileLibrary2Modul.SettingKey.DongDauAnhFileLibrary2_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.FileLibrary2Modul.SettingKey.DongDauAnhFileLibrary2_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.FileLibrary2Modul.SettingKey.DongDauAnhFileLibrary2_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.FileLibrary2Modul.SettingKey.DongDauAnhFileLibrary2_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.FileLibrary2Modul.SettingKey.DongDauAnhFileLibrary2_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.FileLibrary2Modul.SettingKey.DongDauAnhFileLibrary2_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.FileLibrary2Modul.SettingKey.HanCheKichThuocAnhFileLibrary2;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.FileLibrary2Modul.SettingKey.HanCheKichThuocAnhFileLibrary2_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.FileLibrary2Modul.SettingKey.HanCheKichThuocAnhFileLibrary2_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.FileLibrary2Modul.SettingKey.TaoAnhNhoChoAnhFileLibrary2;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.FileLibrary2Modul.SettingKey.TaoAnhNhoChoAnhFileLibrary2_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.FileLibrary2Modul.SettingKey.TaoAnhNhoChoAnhFileLibrary2_MaxHeight;
                break;

            case TatThanhJsc.ForumModul.CodeApplications.Forum:
                pic = TatThanhJsc.ForumModul.FolderPic.Forum;

                dongDauAnh = TatThanhJsc.ForumModul.SettingKey.DongDauAnhForum;
                dongDauAnh_AnhDau = TatThanhJsc.ForumModul.SettingKey.DongDauAnhForum_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.ForumModul.SettingKey.DongDauAnhForum_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.ForumModul.SettingKey.DongDauAnhForum_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.ForumModul.SettingKey.DongDauAnhForum_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.ForumModul.SettingKey.DongDauAnhForum_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.ForumModul.SettingKey.DongDauAnhForum_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.ForumModul.SettingKey.HanCheKichThuocAnhForum;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.ForumModul.SettingKey.HanCheKichThuocAnhForum_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.ForumModul.SettingKey.HanCheKichThuocAnhForum_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.ForumModul.SettingKey.TaoAnhNhoChoAnhForum;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.ForumModul.SettingKey.TaoAnhNhoChoAnhForum_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.ForumModul.SettingKey.TaoAnhNhoChoAnhForum_MaxHeight;
                break;

            case TatThanhJsc.HotelModul.CodeApplications.Hotel:
                pic = TatThanhJsc.HotelModul.FolderPic.Hotel;

                dongDauAnh = TatThanhJsc.HotelModul.SettingKey.DongDauAnhHotel;
                dongDauAnh_AnhDau = TatThanhJsc.HotelModul.SettingKey.DongDauAnhHotel_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.HotelModul.SettingKey.DongDauAnhHotel_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.HotelModul.SettingKey.DongDauAnhHotel_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.HotelModul.SettingKey.DongDauAnhHotel_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.HotelModul.SettingKey.DongDauAnhHotel_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.HotelModul.SettingKey.DongDauAnhHotel_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.HotelModul.SettingKey.HanCheKichThuocAnhHotel;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.HotelModul.SettingKey.HanCheKichThuocAnhHotel_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.HotelModul.SettingKey.HanCheKichThuocAnhHotel_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.HotelModul.SettingKey.TaoAnhNhoChoAnhHotel;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.HotelModul.SettingKey.TaoAnhNhoChoAnhHotel_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.HotelModul.SettingKey.TaoAnhNhoChoAnhHotel_MaxHeight;
                break;

            case TatThanhJsc.MemberModul.CodeApplications.Member:
                pic = TatThanhJsc.MemberModul.FolderPic.Member;

                dongDauAnh = TatThanhJsc.MemberModul.SettingKey.DongDauAnhMember;
                dongDauAnh_AnhDau = TatThanhJsc.MemberModul.SettingKey.DongDauAnhMember_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.MemberModul.SettingKey.DongDauAnhMember_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.MemberModul.SettingKey.DongDauAnhMember_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.MemberModul.SettingKey.DongDauAnhMember_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.MemberModul.SettingKey.DongDauAnhMember_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.MemberModul.SettingKey.DongDauAnhMember_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.MemberModul.SettingKey.HanCheKichThuocAnhMember;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.MemberModul.SettingKey.HanCheKichThuocAnhMember_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.MemberModul.SettingKey.HanCheKichThuocAnhMember_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.MemberModul.SettingKey.TaoAnhNhoChoAnhMember;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.MemberModul.SettingKey.TaoAnhNhoChoAnhMember_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.MemberModul.SettingKey.TaoAnhNhoChoAnhMember_MaxHeight;
                break;

            case TatThanhJsc.NewsModul.CodeApplications.News:
                pic = TatThanhJsc.NewsModul.FolderPic.News;

                dongDauAnh = TatThanhJsc.NewsModul.SettingKey.DongDauAnhNews;
                dongDauAnh_AnhDau = TatThanhJsc.NewsModul.SettingKey.DongDauAnhNews_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.NewsModul.SettingKey.DongDauAnhNews_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.NewsModul.SettingKey.DongDauAnhNews_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.NewsModul.SettingKey.DongDauAnhNews_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.NewsModul.SettingKey.DongDauAnhNews_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.NewsModul.SettingKey.DongDauAnhNews_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.NewsModul.SettingKey.HanCheKichThuocAnhNews;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.NewsModul.SettingKey.HanCheKichThuocAnhNews_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.NewsModul.SettingKey.HanCheKichThuocAnhNews_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.NewsModul.SettingKey.TaoAnhNhoChoAnhNews;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.NewsModul.SettingKey.TaoAnhNhoChoAnhNews_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.NewsModul.SettingKey.TaoAnhNhoChoAnhNews_MaxHeight;
                break;

            case TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum:
                pic = TatThanhJsc.PhotoAlbumModul.FolderPic.PhotoAlbum;

                dongDauAnh = TatThanhJsc.PhotoAlbumModul.SettingKey.DongDauAnhPhotoAlbum;
                dongDauAnh_AnhDau = TatThanhJsc.PhotoAlbumModul.SettingKey.DongDauAnhPhotoAlbum_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.PhotoAlbumModul.SettingKey.DongDauAnhPhotoAlbum_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.PhotoAlbumModul.SettingKey.DongDauAnhPhotoAlbum_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.PhotoAlbumModul.SettingKey.DongDauAnhPhotoAlbum_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.PhotoAlbumModul.SettingKey.DongDauAnhPhotoAlbum_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.PhotoAlbumModul.SettingKey.DongDauAnhPhotoAlbum_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.PhotoAlbumModul.SettingKey.HanCheKichThuocAnhPhotoAlbum;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.PhotoAlbumModul.SettingKey.HanCheKichThuocAnhPhotoAlbum_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.PhotoAlbumModul.SettingKey.HanCheKichThuocAnhPhotoAlbum_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.PhotoAlbumModul.SettingKey.TaoAnhNhoChoAnhPhotoAlbum;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.PhotoAlbumModul.SettingKey.TaoAnhNhoChoAnhPhotoAlbum_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.PhotoAlbumModul.SettingKey.TaoAnhNhoChoAnhPhotoAlbum_MaxHeight;
                break;

            case TatThanhJsc.PhotoAlbumMemberModul.CodeApplications.PhotoAlbumMember:
                pic = TatThanhJsc.PhotoAlbumMemberModul.FolderPic.PhotoAlbumMember;

                dongDauAnh = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.DongDauAnhPhotoAlbumMember;
                dongDauAnh_AnhDau = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.DongDauAnhPhotoAlbumMember_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.DongDauAnhPhotoAlbumMember_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.DongDauAnhPhotoAlbumMember_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.DongDauAnhPhotoAlbumMember_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.DongDauAnhPhotoAlbumMember_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.DongDauAnhPhotoAlbumMember_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.HanCheKichThuocAnhPhotoAlbumMember;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.HanCheKichThuocAnhPhotoAlbumMember_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.HanCheKichThuocAnhPhotoAlbumMember_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.TaoAnhNhoChoAnhPhotoAlbumMember;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.TaoAnhNhoChoAnhPhotoAlbumMember_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.PhotoAlbumMemberModul.SettingKey.TaoAnhNhoChoAnhPhotoAlbumMember_MaxHeight;
                break;

            case TatThanhJsc.ProductModul.CodeApplications.Product:
                pic = TatThanhJsc.ProductModul.FolderPic.Product;

                dongDauAnh = TatThanhJsc.ProductModul.SettingKey.DongDauAnhProduct;
                dongDauAnh_AnhDau = TatThanhJsc.ProductModul.SettingKey.DongDauAnhProduct_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.ProductModul.SettingKey.DongDauAnhProduct_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.ProductModul.SettingKey.DongDauAnhProduct_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.ProductModul.SettingKey.DongDauAnhProduct_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.ProductModul.SettingKey.DongDauAnhProduct_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.ProductModul.SettingKey.DongDauAnhProduct_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.ProductModul.SettingKey.HanCheKichThuocAnhProduct;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.ProductModul.SettingKey.HanCheKichThuocAnhProduct_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.ProductModul.SettingKey.HanCheKichThuocAnhProduct_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.ProductModul.SettingKey.TaoAnhNhoChoAnhProduct;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.ProductModul.SettingKey.TaoAnhNhoChoAnhProduct_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.ProductModul.SettingKey.TaoAnhNhoChoAnhProduct_MaxHeight;
                break;

            case TatThanhJsc.QAModul.CodeApplications.QA:
                pic = TatThanhJsc.QAModul.FolderPic.QA;

                dongDauAnh = TatThanhJsc.QAModul.SettingKey.DongDauAnhQA;
                dongDauAnh_AnhDau = TatThanhJsc.QAModul.SettingKey.DongDauAnhQA_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.QAModul.SettingKey.DongDauAnhQA_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.QAModul.SettingKey.DongDauAnhQA_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.QAModul.SettingKey.DongDauAnhQA_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.QAModul.SettingKey.DongDauAnhQA_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.QAModul.SettingKey.DongDauAnhQA_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.QAModul.SettingKey.HanCheKichThuocAnhQA;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.QAModul.SettingKey.HanCheKichThuocAnhQA_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.QAModul.SettingKey.HanCheKichThuocAnhQA_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.QAModul.SettingKey.TaoAnhNhoChoAnhQA;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.QAModul.SettingKey.TaoAnhNhoChoAnhQA_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.QAModul.SettingKey.TaoAnhNhoChoAnhQA_MaxHeight;
                break;

            case TatThanhJsc.ServiceModul.CodeApplications.Service:
                pic = TatThanhJsc.ServiceModul.FolderPic.Service;

                dongDauAnh = TatThanhJsc.ServiceModul.SettingKey.DongDauAnhService;
                dongDauAnh_AnhDau = TatThanhJsc.ServiceModul.SettingKey.DongDauAnhService_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.ServiceModul.SettingKey.DongDauAnhService_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.ServiceModul.SettingKey.DongDauAnhService_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.ServiceModul.SettingKey.DongDauAnhService_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.ServiceModul.SettingKey.DongDauAnhService_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.ServiceModul.SettingKey.DongDauAnhService_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.ServiceModul.SettingKey.HanCheKichThuocAnhService;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.ServiceModul.SettingKey.HanCheKichThuocAnhService_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.ServiceModul.SettingKey.HanCheKichThuocAnhService_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.ServiceModul.SettingKey.TaoAnhNhoChoAnhService;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.ServiceModul.SettingKey.TaoAnhNhoChoAnhService_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.ServiceModul.SettingKey.TaoAnhNhoChoAnhService_MaxHeight;
                break;

            case TatThanhJsc.TourModul.CodeApplications.Tour:
                pic = TatThanhJsc.TourModul.FolderPic.Tour;

                dongDauAnh = TatThanhJsc.TourModul.SettingKey.DongDauAnhTour;
                dongDauAnh_AnhDau = TatThanhJsc.TourModul.SettingKey.DongDauAnhTour_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.TourModul.SettingKey.DongDauAnhTour_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.TourModul.SettingKey.DongDauAnhTour_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.TourModul.SettingKey.DongDauAnhTour_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.TourModul.SettingKey.DongDauAnhTour_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.TourModul.SettingKey.DongDauAnhTour_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.TourModul.SettingKey.HanCheKichThuocAnhTour;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.TourModul.SettingKey.HanCheKichThuocAnhTour_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.TourModul.SettingKey.HanCheKichThuocAnhTour_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.TourModul.SettingKey.TaoAnhNhoChoAnhTour;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.TourModul.SettingKey.TaoAnhNhoChoAnhTour_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.TourModul.SettingKey.TaoAnhNhoChoAnhTour_MaxHeight;
                break;

            case TatThanhJsc.TrainTicketModul.CodeApplications.TrainTicket:
                pic = TatThanhJsc.TrainTicketModul.FolderPic.TrainTicket;

                dongDauAnh = TatThanhJsc.TrainTicketModul.SettingKey.DongDauAnhTrainTicket;
                dongDauAnh_AnhDau = TatThanhJsc.TrainTicketModul.SettingKey.DongDauAnhTrainTicket_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.TrainTicketModul.SettingKey.DongDauAnhTrainTicket_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.TrainTicketModul.SettingKey.DongDauAnhTrainTicket_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.TrainTicketModul.SettingKey.DongDauAnhTrainTicket_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.TrainTicketModul.SettingKey.DongDauAnhTrainTicket_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.TrainTicketModul.SettingKey.DongDauAnhTrainTicket_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.TrainTicketModul.SettingKey.HanCheKichThuocAnhTrainTicket;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.TrainTicketModul.SettingKey.HanCheKichThuocAnhTrainTicket_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.TrainTicketModul.SettingKey.HanCheKichThuocAnhTrainTicket_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.TrainTicketModul.SettingKey.TaoAnhNhoChoAnhTrainTicket;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.TrainTicketModul.SettingKey.TaoAnhNhoChoAnhTrainTicket_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.TrainTicketModul.SettingKey.TaoAnhNhoChoAnhTrainTicket_MaxHeight;
                break;

            case TatThanhJsc.VideoModul.CodeApplications.Video:
                pic = TatThanhJsc.VideoModul.FolderPic.Video;

                dongDauAnh = TatThanhJsc.VideoModul.SettingKey.DongDauAnhVideo;
                dongDauAnh_AnhDau = TatThanhJsc.VideoModul.SettingKey.DongDauAnhVideo_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.VideoModul.SettingKey.DongDauAnhVideo_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.VideoModul.SettingKey.DongDauAnhVideo_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.VideoModul.SettingKey.DongDauAnhVideo_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.VideoModul.SettingKey.DongDauAnhVideo_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.VideoModul.SettingKey.DongDauAnhVideo_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.VideoModul.SettingKey.HanCheKichThuocAnhVideo;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.VideoModul.SettingKey.HanCheKichThuocAnhVideo_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.VideoModul.SettingKey.HanCheKichThuocAnhVideo_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.VideoModul.SettingKey.TaoAnhNhoChoAnhVideo;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.VideoModul.SettingKey.TaoAnhNhoChoAnhVideo_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.VideoModul.SettingKey.TaoAnhNhoChoAnhVideo_MaxHeight;
                break;

            case TatThanhJsc.WebsiteModul.CodeApplications.Website:
                pic = TatThanhJsc.WebsiteModul.FolderPic.Website;

                dongDauAnh = TatThanhJsc.WebsiteModul.SettingKey.DongDauAnhWebsite;
                dongDauAnh_AnhDau = TatThanhJsc.WebsiteModul.SettingKey.DongDauAnhWebsite_AnhDau;
                dongDauAnh_ViTri = TatThanhJsc.WebsiteModul.SettingKey.DongDauAnhWebsite_ViTri;
                dongDauAnh_LeNgang = TatThanhJsc.WebsiteModul.SettingKey.DongDauAnhWebsite_LeNgang;
                dongDauAnh_LeDoc = TatThanhJsc.WebsiteModul.SettingKey.DongDauAnhWebsite_LeDoc;
                dongDauAnh_TyLe = TatThanhJsc.WebsiteModul.SettingKey.DongDauAnhWebsite_TyLe;
                dongDauAnh_TrongSuot = TatThanhJsc.WebsiteModul.SettingKey.DongDauAnhWebsite_TrongSuot;
                hanCheKichThuocAnh = TatThanhJsc.WebsiteModul.SettingKey.HanCheKichThuocAnhWebsite;
                hanCheKichThuocAnh_MaxHeight = TatThanhJsc.WebsiteModul.SettingKey.HanCheKichThuocAnhWebsite_MaxWidth;
                hanCheKichThuocAnh_MaxWidth = TatThanhJsc.WebsiteModul.SettingKey.HanCheKichThuocAnhWebsite_MaxHeight;                
                taoAnhNhoChoAnh = TatThanhJsc.WebsiteModul.SettingKey.TaoAnhNhoChoAnhWebsite;
                taoAnhNhoChoAnh_MaxWidth = TatThanhJsc.WebsiteModul.SettingKey.TaoAnhNhoChoAnhWebsite_MaxWidth;
                taoAnhNhoChoAnh_MaxHeight = TatThanhJsc.WebsiteModul.SettingKey.TaoAnhNhoChoAnhWebsite_MaxHeight;
                break;
        }
    }
    #endregion

    #region Khởi tạo xử lý ảnh
    void KhoiTaoXuLyAnh()
    {
        #region Đóng dấu ảnh
        if (SettingsExtension.GetSettingKey(dongDauAnh, language) == "1")
            cbDongDauAnh.Checked = true;
        else
            cbDongDauAnh.Checked = false;
        #region Ảnh làm dấu
        hdLogoImage.Value = SettingsExtension.GetSettingKey(dongDauAnh_AnhDau, language);
        #endregion
        hdViTriDongDau.Value = SettingsExtension.GetSettingKey(dongDauAnh_ViTri, language);
        hdLeX.Value = SettingsExtension.GetSettingKey(dongDauAnh_LeNgang, language);
        hdLeY.Value = SettingsExtension.GetSettingKey(dongDauAnh_LeDoc, language);
        hdTyLe.Value = SettingsExtension.GetSettingKey(dongDauAnh_TyLe, language);
        hdTrongSuot.Value = SettingsExtension.GetSettingKey(dongDauAnh_TrongSuot, language);
        #endregion

        #region Hạn chế kích thước ảnh đại diện
        if (SettingsExtension.GetSettingKey(hanCheKichThuocAnh, language) == "1")
            cbHanCheKichThuoc.Checked = true;
        else
            cbHanCheKichThuoc.Checked = false;

        tbHanCheW.Text = SettingsExtension.GetSettingKey(hanCheKichThuocAnh_MaxWidth, language);
        tbHanCheH.Text = SettingsExtension.GetSettingKey(hanCheKichThuocAnh_MaxHeight, language);
        #endregion

        #region Tạo ảnh nhỏ cho ảnh đại diện
        if (SettingsExtension.GetSettingKey(taoAnhNhoChoAnh, language) == "1")
            cbTaoAnhNho.Checked = true;
        else
            cbTaoAnhNho.Checked = false;

        tbAnhNhoW.Text = SettingsExtension.GetSettingKey(taoAnhNhoChoAnh_MaxWidth, language);
        tbAnhNhoH.Text = SettingsExtension.GetSettingKey(taoAnhNhoChoAnh_MaxHeight, language);
        #endregion
    }
    #endregion    

    #region Phương thức lưu ảnh, cần gọi khi insert, update
    /// <summary>
    /// Phương thức lưu ảnh khi insert, update
    /// </summary>
    /// <param name="update">True: đang ở hành động update</param>
    /// <param name="contentDetail">Nội dung để tìm ảnh đầu làm ảnh đại diện</param>
    /// <returns></returns>
    public string Save(bool update, string contentDetail)
    {
        #region Image
        string vimg = "";
        string vimg_thumb = "";
        if (flimg.Visible)
        {
            if (flimg.PostedFile.ContentLength > 0)
            {
                string filename = flimg.FileName;
                string fileex = filename.Substring(filename.LastIndexOf("."));
                string path = Request.PhysicalApplicationPath + "/" + pic + "/";
                if (TatThanhJsc.Extension.ImagesExtension.ValidType(fileex))
                {
                    string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
                    if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
                    string ticks = DateTime.Now.Ticks.ToString();
                    #region Lưu ảnh đại diện theo 2 trường hợp: tạo ảnh nhỏ hoặc không.
                    //Kiểm tra xem có tạo ảnh nhỏ hay ko
                    //Nếu không tạo ảnh nhỏ, tên tệp lưu bình thường theo kiểu: tên_tệp.phần_mở_rộng
                    //Nếu tạo ảnh nhỏ, tên tệp sẽ theo kiểu: tên_tệp_HasThumb.phần_mở_rộng
                    //Khi đó tên tệp ảnh nhỏ sẽ theo kiểu:   tên_tệp_HasThumb_Thumb.phần_mở_rộng
                    //Với cách lưu tên ảnh này, khi thực hiện lưu vào csdl chỉ cần lưu tên ảnh gốc
                    //khi hiển thị chỉ cần dựa vào tên ảnh gốc để biết ảnh đó có ảnh nhỏ hay không, việc này được thực hiện bởi TatThanhJsc.Extension.ImagesExtension.GetImage, lập trình không cần làm gì thêm.
                    if (cbTaoAnhNho.Checked)
                        vimg = fileNotEx + "_" + ticks + "_HasThumb" + fileex;
                    else
                        vimg = fileNotEx + "_" + ticks + fileex;
                    flimg.SaveAs(path + vimg);
                    #endregion
                    #region Hạn chế kích thước
                    if (cbHanCheKichThuoc.Checked)
                        ImagesExtension.ResizeImage(path + vimg, "", tbHanCheW.Text, tbHanCheH.Text);
                    #endregion
                    #region Đóng dấu ảnh
                    if (cbDongDauAnh.Checked)
                        ImagesExtension.CreateWatermark(path + vimg, path + hdLogoImage.Value, hdViTriDongDau.Value, hdLeX.Value, hdLeY.Value, hdTyLe.Value, hdTrongSuot.Value);
                    #endregion
                    #region Tạo ảnh nhỏ: Thực hiện cuối để đảm bảo ảnh nhỏ cũng có con dấu
                    if (cbTaoAnhNho.Checked)
                    {
                        vimg_thumb = fileNotEx + "_" + ticks + "_HasThumb_Thumb" + fileex;
                        ImagesExtension.ResizeImage(path + vimg, path + vimg_thumb, tbAnhNhoW.Text, tbAnhNhoH.Text);
                    }
                    #endregion
                }
            }
            else
            {
                if (cbLayAnhTuNoiDung.Visible)
                {
                    if (hdImage.Value.Length < 1 || cbLayAnhTuNoiDung.Checked)
                    //nếu không upload ảnh và cũng không có ảnh cũ -> tìm ảnh đầu tiên trong nội dung làm ảnh đại diện
                    {
                        if (hdImage.Value.Length > 0)
                            ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImage.Value);

                        string urlImg = ImagesExtension.GetFirstImageInContent(contentDetail);

                        if (urlImg.Length > 0)
                        {
                            string filename = urlImg;
                            string fileex = filename.Substring(filename.LastIndexOf("."));
                            string path = Request.PhysicalApplicationPath + "/" + pic + "/";
                            if (TatThanhJsc.Extension.ImagesExtension.ValidType(fileex))
                            {
                                string fileNotEx =
                                    StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
                                if (fileNotEx.Length > 9)
                                    fileNotEx = fileNotEx.Remove(9);
                                string ticks = DateTime.Now.Ticks.ToString();

                                #region Lưu ảnh đại diện theo 2 trường hợp: tạo ảnh nhỏ hoặc không.
                                //Kiểm tra xem có tạo ảnh nhỏ hay ko
                                //Nếu không tạo ảnh nhỏ, tên tệp lưu bình thường theo kiểu: tên_tệp.phần_mở_rộng
                                //Nếu tạo ảnh nhỏ, tên tệp sẽ theo kiểu: tên_tệp_HasThumb.phần_mở_rộng
                                //Khi đó tên tệp ảnh nhỏ sẽ theo kiểu:   tên_tệp_HasThumb_Thumb.phần_mở_rộng
                                //Với cách lưu tên ảnh này, khi thực hiện lưu vào csdl chỉ cần lưu tên ảnh gốc
                                //khi hiển thị chỉ cần dựa vào tên ảnh gốc để biết ảnh đó có ảnh nhỏ hay không, việc này được thực hiện bởi TatThanhJsc.Extension.ImagesExtension.GetImage, lập trình không cần làm gì thêm.
                                if (cbTaoAnhNho.Checked)
                                    vimg = fileNotEx + "_" + ticks + "_HasThumb";
                                else
                                    vimg = fileNotEx + "_" + ticks;

                                if (ImagesExtension.SaveImageFromUrl(path + vimg, urlImg).Length > 0)
                                {
                                    vimg += fileex;

                                    #region Hạn chế kích thước
                                    if (cbHanCheKichThuoc.Checked)
                                        ImagesExtension.ResizeImage(path + vimg, "", tbHanCheW.Text, tbHanCheH.Text);
                                    #endregion

                                    #region Đóng dấu ảnh
                                    if (cbDongDauAnh.Checked)
                                        ImagesExtension.CreateWatermark(path + vimg, path + hdLogoImage.Value,
                                            hdViTriDongDau.Value, hdLeX.Value, hdLeY.Value, hdTyLe.Value, hdTrongSuot.Value);
                                    #endregion

                                    #region Tạo ảnh nhỏ: Thực hiện cuối để đảm bảo ảnh nhỏ cũng có con dấu
                                    if (cbTaoAnhNho.Checked)
                                    {
                                        vimg_thumb = fileNotEx + "_" + ticks + "_HasThumb_Thumb" + fileex;
                                        ImagesExtension.ResizeImage(path + vimg, path + vimg_thumb, tbAnhNhoW.Text,
                                            tbAnhNhoH.Text);
                                    }
                                    #endregion


                                }
                                else
                                {
                                    vimg = "";
                                }
                                #endregion
                            }
                        }
                    }
                }
            }
        }
        #endregion

        if(update)
        {
            if (vimg=="")            
                vimg = hdImage.Value;            
            else            
                ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImage.Value);            
        }

        return vimg;
    }
    #endregion

    #region Phương thức load ra ảnh khi hiển thị thông tin cập nhật
    /// <summary>
    /// Phương thức load ra thông tin ảnh khi cập nhật
    /// </summary>
    /// <param name="imageName">Tên ảnh, thường là giá trị trường vgImage hoặc viImage</param>
    public void Load(string imageName)
    {        
        ltimg.Text = ImagesExtension.GetImage(pic, imageName, "", "", false, false, "", false);
        if (ltimg.Text.Length > 0)
        {
            btnXoaAnhHienTai.Visible = true;
            hdImage.Value = imageName;
        }

        if(cbLayAnhTuNoiDung.Visible)
        {
            if(imageName != "")
                cbLayAnhTuNoiDung.Checked = false;
            else
                cbLayAnhTuNoiDung.Checked = true;
        }
    }
    #endregion

    #region Phương thức reset sau khi tạo xong
    /// <summary>
    /// Phương thức reset sau khi tạo xong
    /// </summary>
    public void Reset()
    {
        ltimg.Text = "";
        hdImage.Value = "";
    }
    #endregion

    #region Sự kiện chạy khi click nút xóa ảnh
    protected void btnXoaAnhHienTai_Click(object sender, EventArgs e)
    {        
        ImagesExtension.DeleteImageWhenDeleteItem(pic, hdImage.Value);        
        hdImage.Value = "";
        btnXoaAnhHienTai.Visible = false;
        ltimg.Text = "";
    }
    #endregion
}