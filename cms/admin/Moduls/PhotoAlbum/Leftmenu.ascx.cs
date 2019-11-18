using System;
using TatThanhJsc.Extension;
public partial class cms_admin_PhotoAlbum_AdmLeftmenu : System.Web.UI.UserControl
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

    PhManagerApi.Controls.Add(LoadControl("../../../api/PhotoAlbum/Leftmenu.ascx"));

    if (!IsPostBack)
    {
      XuLyHienThiDuyetTin();
      SetEnableControls();
    }
  }

  void XuLyHienThiDuyetTin()
  {
    if (PhotoAlbumConfig.KeyDuyetTin)
    {
      string userRole = CookieExtension.GetCookies("RolesUser");
      #region Với tính năng duyệt tin 2 cấp (phóng viên, biên tập => trưởng ban biên tập => tổng biên tập)
      if (HorizaMenuConfig.ShowDuyetTin2)
      {
        if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
        {
          #region Với tài khoản cấp 1 (phóng viên, biên tập)
          pnQuanLyDanhMuc.Visible = false;
          pnQuanLyNhom.Visible = false;
          pnThemMoiDanhMuc.Visible = false;
          pnThemMoiNhom.Visible = false;
          pnThungRacDanhMuc.Visible = false;
          pnThungRacNhom.Visible = false;
          pnCauHinh.Visible = false;

          pnQuanLyBaiVietChoPheDuyet.Visible = true;
          pnQuanLyBaiVietDaDuocDuyet.Visible = true;
          pnQuanLyBaiVietBiHuy.Visible = true;
          #endregion
        }
        else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
        {
          #region Với tài khoản cấp 2 (trưởng ban biên tập)
          pnQuanLyBaiVietDaXuatBan.Visible = true;
          pnQuanLyBaiVietChoPheDuyet.Visible = true;
          pnQuanLyBaiVietDaDuocDuyet.Visible = true;
          pnQuanLyBaiVietBiHuy.Visible = true;
          #endregion
        }
        else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
        {
          #region Với tài khoản cấp 3 (tổng biên tập)
          pnQuanLyBaiVietDaXuatBan.Visible = true;
          #endregion
        }
      }
      #endregion
      #region Với tính năng duyệt tin 1 cấp (phóng viên, biên tập viên => tổng biên tập)
      else if (HorizaMenuConfig.ShowDuyetTin1)
      {
        if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
        {
          #region Với tài khoản cấp 2 (phóng viên, biên tập)
          pnQuanLyDanhMuc.Visible = false;
          pnQuanLyNhom.Visible = false;
          pnThemMoiDanhMuc.Visible = false;
          pnThemMoiNhom.Visible = false;
          pnThungRacDanhMuc.Visible = false;
          pnThungRacNhom.Visible = false;
          pnCauHinh.Visible = false;

          pnQuanLyBaiVietChoPheDuyet.Visible = true;
          pnQuanLyBaiVietDaDuocDuyet.Visible = true;
          pnQuanLyBaiVietBiHuy.Visible = true;
          #endregion
        }
        else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
        {
          #region Với tài khoản cấp 3 (tổng biên tập)
          pnQuanLyBaiVietDaXuatBan.Visible = true;
          #endregion
        }
      }
      #endregion
    }
  }

  /// <summary>
  /// Hiển thị hoặc ẩn các chức năng theo thiết lập trong bảng Settings
  /// </summary>
  void SetEnableControls()
  {
    //Ẩn hiện menu Quản lý thuộc tính album
    if (PhotoAlbumConfig.KeyHienThiQuanLyThuocTinhHinhAnh)
    {
      pnThuocTinhHinhAnh.Visible = true;
      pnThuocTinhHinhAnh_ThemMoi.Visible = true;
      pnThuocTinhHinhAnh_ThungRac.Visible = true;
    }
    else
    {
      pnThuocTinhHinhAnh.Visible = false;
      pnThuocTinhHinhAnh_ThemMoi.Visible = false;
      pnThuocTinhHinhAnh_ThungRac.Visible = false;
    }
    //Ẩn hiện menu Quản lý phản hồi
    if (PhotoAlbumConfig.KeyHienThiQuanLyPhanHoiHinhAnh) pnDanhSachPhanHoi.Visible = true;
    else pnDanhSachPhanHoi.Visible = false;

    //Ẩn hiện menu Thống kê báo cáo
    if (PhotoAlbumConfig.KeyHienThiThongKeBaoCaoHinhAnh) pnThongKeBaoCao.Visible = true;
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
