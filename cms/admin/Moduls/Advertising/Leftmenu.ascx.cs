using System;
using TatThanhJsc.Extension;
using TatThanhJsc.AdvertisingModul;

public partial class cms_admin_Moduls_Advertising_Leftmenu : System.Web.UI.UserControl
{
  private string suc = "";
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
    PhManagerApi.Controls.Add(LoadControl("../../../api/Advertising/Leftmenu.ascx"));

    if (!IsPostBack)
    {
      XuLyHienThiDuyetTin();
    }
  }

  void XuLyHienThiDuyetTin()
  {
    if (AdvertisingConfig.KeyDuyetTin)
    {
      string userRole = CookieExtension.GetCookies("RolesUser");
      #region Với tính năng duyệt tin 2 cấp (phóng viên, biên tập => trưởng ban biên tập => tổng biên tập)
      if (HorizaMenuConfig.ShowDuyetTin2)
      {
        if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
        {
          #region Với tài khoản cấp 1 (phóng viên, biên tập)
          pnQuanLyDanhMuc.Visible = false;
          pnThemMoiDanhMuc.Visible = false;
          pnThungRacDanhMuc.Visible = false;

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
          pnThemMoiDanhMuc.Visible = false;
          pnThungRacDanhMuc.Visible = false;

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
    if (suc.Equals("RecycleBinMainMenu") || suc.Equals("RecycleBinTopMenu") || suc.Equals("RecycleBinBottomMenu") || suc.Equals("RecycleBinOtherMenu"))
    {
      return "Selected";
    }
    else
    {
      return "";
    }
  }

  protected string SetEnableTool()
  {
    if (suc.Equals("CreateMenuMain"))
    {
      return "InvisibleSpaceCate";
    }
    else
    {
      return "";
    }
  }

  protected string SetEnableSpaceCate()
  {
    if (suc.Equals(TypePage.Cate))
    {
      return "InvisibleSpaceCate";
    }
    else
    {
      return "";
    }
  }
}