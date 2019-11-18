using System;
public partial class cms_admin_Moduls_DuyetTin_LoadControl : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string suc = "";
    suc = Request.QueryString["suc"];
    switch (suc)
    {
      #region Duyệt tin
      case "QuanLyBaiVietDaXuatBan":
        phControl.Controls.Add(LoadControl("Item/QuanLyBaiVietDaXuatBan.ascx"));
        break;
      case "BaiVietChoPheDuyet":
        phControl.Controls.Add(LoadControl("Item/BaiVietChoPheDuyet.ascx"));
        break;
      case "BaiVietDaDuyet":
        phControl.Controls.Add(LoadControl("Item/BaiVietDaDuyet.ascx"));
        break;  
      #endregion

      default:
        phControl.Controls.Add(LoadControl("Item/BaiVietChoPheDuyet.ascx"));
        break;
    }
  }
}