using System;
using TatThanhJsc.AboutUsModul;

public partial class cms_admin_AboutUs_Loadcontrol : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string suc = "";
    if (Request.QueryString["suc"] != null)
      suc = Request.QueryString["suc"];

    string app = "";
    if (Request.QueryString["app"] != null)
      app = Request.QueryString["app"];


    switch (suc)
    {
      #region Cate
      case TypePage.Cate:
        phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
        break;
      case TypePage.UpdateCate:
      case TypePage.CreateCate:
        phControl.Controls.Add(LoadControl("Cate/ShortCutCate.ascx"));
        break;
      case TypePage.RecycleCate:
        phControl.Controls.Add(LoadControl("Cate/RecycleCate.ascx"));
        break;
      #endregion

      #region Duyệt tin
      case "QuanLyBaiVietBiHuy":
        phControl.Controls.Add(LoadControl("Item/DuyetTin/QuanLyBaiVietBiHuy.ascx"));
        break;
      case "QuanLyBaiVietChoPheDuyet":
        phControl.Controls.Add(LoadControl("Item/DuyetTin/QuanLyBaiVietChoPheDuyet.ascx"));
        break;
      case "QuanLyBaiVietDaDuocDuyet":
        phControl.Controls.Add(LoadControl("Item/DuyetTin/QuanLyBaiVietDaDuocDuyet.ascx"));
        break;
      case "QuanLyBaiVietDaXuatBan":
        phControl.Controls.Add(LoadControl("Item/DuyetTin/QuanLyBaiVietDaXuatBan.ascx"));
        break;
      #endregion

      #region Groups
      case TypePage.GroupItem:
        phControl.Controls.Add(LoadControl("GroupItem/ControlGroupItem.ascx"));
        break;
      case TypePage.UpdateGroupItem:
      case TypePage.CreateGroupItem:
        phControl.Controls.Add(LoadControl("GroupItem/ShortCutGroupItem.ascx"));
        break;
      case TypePage.RecycleGroupItem:
        phControl.Controls.Add(LoadControl("GroupItem/RecycleGroupItem.ascx"));
        break;
      #endregion

      #region Config
      case TypePage.Configuration:
        phControl.Controls.Add(LoadControl("Config/ControlsConfig.ascx"));
        break;
      #endregion

      #region Item
      case TypePage.Item:
        phControl.Controls.Add(LoadControl("Item/ControlItem.ascx"));
        break;
      case TypePage.UpdateItem:
      case TypePage.CreateItem:
        phControl.Controls.Add(LoadControl("Item/ShortCutItem.ascx"));
        break;
      case TypePage.RecycleItem:
        phControl.Controls.Add(LoadControl("Item/RecycleItem.ascx"));
        break;
      #endregion

      default:
        phControl.Controls.Add(LoadControl("Item/ControlItem.ascx"));
        break;
    }
  }
}
