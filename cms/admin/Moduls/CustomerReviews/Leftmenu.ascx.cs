using System;
using TatThanhJsc.Extension;
public partial class cms_admin_CustomerReviews_Leftmenu : System.Web.UI.UserControl
{
  protected string suc = "";
  protected string uc = "";
  protected string app = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["uc"] != null)
      uc = Request.QueryString["uc"];
    if (Request.QueryString["suc"] != null)
      suc = Request.QueryString["suc"];
    if (Request.QueryString["app"] != null)
      app = Request.QueryString["app"];

    if (!IsPostBack)
    {
      XuLyHienThiDuyetTin();
    }
  }

  void XuLyHienThiDuyetTin()
  {
    if (CustomerReviewsConfig.KeyDuyetTin)
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

  protected string SetCurrent(string suc, string val)
  {
    if (suc == val)
      return "current";
    return "";
  }
}
