using System;

public partial class cms_admin_TrainTicket_AdmLeftmenu : System.Web.UI.UserControl
{    
    protected string suc = "";
    protected string uc = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uc"] != null)
        {
            uc = Request.QueryString["uc"];
        }
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }

        PhManagerApi.Controls.Add(LoadControl("../../../api/TrainTicket/Leftmenu.ascx"));

        if (!IsPostBack)
            SetEnableControls();
    }

    /// <summary>
    /// Hiển thị hoặc ẩn các chức năng theo thiết lập trong bảng Settings
    /// </summary>
    void SetEnableControls()
    {
        //Ẩn hiện menu Quản lý thuộc tính tin tức
        if (TrainTicketConfig.KeyHienThiQuanLyThuocTinhTrainTicket)
        {
            pnThuocTinhTrainTicket.Visible = true;
            pnThuocTinhTrainTicket_ThemMoi.Visible = true;
            pnThuocTinhTrainTicket_ThungRac.Visible = true;
        }
        else
        {
            pnThuocTinhTrainTicket.Visible = false;
            pnThuocTinhTrainTicket_ThemMoi.Visible = false;
            pnThuocTinhTrainTicket_ThungRac.Visible = false;
        }
        //Ẩn hiện menu Quản lý thuộc tính lọc Vé tàu
        if (TrainTicketConfig.KeyHienThiThuocTinhLocTrainTicket)
        {
            pnThuocTinhLocTrainTicket.Visible = true;
            pnThuocTinhLocTrainTicket_ThemMoi.Visible = true;
            pnThuocTinhLocTrainTicket_ThungRac.Visible = true;
        }
        else
        {
            pnThuocTinhLocTrainTicket.Visible = false;
            pnThuocTinhLocTrainTicket_ThemMoi.Visible = false;
            pnThuocTinhLocTrainTicket_ThungRac.Visible = false;
        }
        //Ẩn hiện menu Quản lý màu Vé tàu
        if (TrainTicketConfig.KeyHienThiNhieuAnhTrainTicketTheoMau)
        {
            PnColor.Visible = true;
            PnColor_ThemMoi.Visible = true;
            PnColor_ThungRac.Visible = true;
        }
        else
        {
            PnColor.Visible = false;
            PnColor_ThemMoi.Visible = false;
            PnColor_ThungRac.Visible = false;
        }

        //Ẩn hiện menu Nhà cung cấp
        if (TrainTicketConfig.KeyHienThiHangSanXuat)
        {
            PnProvider.Visible = true;
            pnProvider_ThemMoi.Visible = true;
            pnProvider_ThungRac.Visible = true;
        }
        else
        {
            PnProvider.Visible = false;
            pnProvider_ThemMoi.Visible = false;
            pnProvider_ThungRac.Visible = false;
        }

        //Ẩn hiện menu Quản lý phản hồi
        if (TrainTicketConfig.KeyHienThiQuanLyPhanHoiTrainTicket) pnDanhSachPhanHoi.Visible = true;
        else pnDanhSachPhanHoi.Visible = false;

        //Ẩn hiện menu Thống kê báo cáo
        if (TrainTicketConfig.KeyHienThiThongKeBaoCaoTrainTicket) pnThongKeBaoCao.Visible = true;
        else pnThongKeBaoCao.Visible = false;
    }

    protected string SetSelectedCate(string Values)
    {
        if (suc.Equals(Values))
        {
            return "Selected";
        }
        else
        {
            return "";
        }
    }

    protected string SetSelectedRecycleBin()
    {
        if (suc.Equals("RecycleCategory") || suc.Equals("RecycleItem") || suc.Equals("RecycleGroup"))
        {
            return "Selected";
        }
        else
        {
            return "";
        }
    }

    protected string SetEnableSpaceCate()
    {
        if (suc.Equals("c"))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }

    protected string SetEnableTool()
    {
        if (suc.Equals("CreateCategory"))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }

    protected string SetCustomizeOther()
    {
        if (suc.Equals("Report"))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }
}
