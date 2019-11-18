using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.AdvertisingModul;


public partial class cms_admin_Moduls_Advertising_Loadcontrol : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string suc = "";
    suc = Request.QueryString["suc"];
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

      case "api":
        phControl.Controls.Add(LoadControl("../../../api/Advertising/LoadControls.ascx"));
        break;

      default:
        //phControl.Controls.Add(LoadControl("Index.ascx"));
        phControl.Controls.Add(LoadControl("Item/ControlItem.ascx"));
        break;
    }
  }
}