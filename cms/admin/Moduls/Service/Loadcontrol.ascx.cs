using System;
using TatThanhJsc.ServiceModul;


public partial class cms_admin_Service_Loadcontrol : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string suc = "";
    suc = Request.QueryString["suc"];
    switch (suc)
    {
      #region Api
      case "api":
        phControl.Controls.Add(LoadControl("../../../api/Service/LoadControls.ascx"));
        break;
      #endregion
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
      #region Item - Comment
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
      case TypePage.Comment:
        phControl.Controls.Add(LoadControl("Item/ControlComment.ascx"));
        break;
      #endregion
      #region Property
      case TypePage.Property:
        phControl.Controls.Add(LoadControl("Property/ControlProperty.ascx"));
        break;
      case TypePage.UpdateProperty:
      case TypePage.CreateProperty:
        phControl.Controls.Add(LoadControl("Property/ShortCutProperty.ascx"));
        break;
      case TypePage.RecycleProperty:
        phControl.Controls.Add(LoadControl("Property/RecycleProperty.ascx"));
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
      #region Config
      case TypePage.Configuration:
        phControl.Controls.Add(LoadControl("Config/AdmControlsConfig.ascx"));
        break;
      #endregion
      #region GroupItem
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
      #region Report
      case TypePage.Report:
        phControl.Controls.Add(LoadControl("Report/AdmReportIndex.ascx"));
        break;
      #endregion

      case "ImportGroup"://Nhập tin từ tệp excel
        phControl.Controls.Add(LoadControl("ShortCut/AdmShortCutImportGroups.ascx"));
        break;
      case "ImportCategory"://Nhập tin từ tệp excel
        phControl.Controls.Add(LoadControl("ShortCut/AdmShortCutImportCategory.ascx"));
        break;
      case "ImportItem"://Nhập tin từ tệp excel
        phControl.Controls.Add(LoadControl("ShortCut/AdmShortCutImportItem.ascx"));
        break;

      case "QuanLyDonDatDichVu":
        phControl.Controls.Add(LoadControl("Item/QuanLyDonDatDichVu.ascx"));
        break;
      case "QuanLyDonDangKyTuVan":
        phControl.Controls.Add(LoadControl("Item/QuanLyDonDangKyTuVan.ascx"));
        break;
      default:
        //phControl.Controls.Add(LoadControl("Index.ascx"));
        //phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
        phControl.Controls.Add(LoadControl("Item/ControlItem.ascx"));
        break;
    }
  }
}
