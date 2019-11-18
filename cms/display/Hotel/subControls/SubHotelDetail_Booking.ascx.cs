using System;
using System.Data;
using TatThanhJsc.Extension;
using TatThanhJsc.Columns;

public partial class cms_display_Hotel_subControls_SubHotelDetail_Booking : System.Web.UI.UserControl
{
  protected string iid = "";
  protected string hotel = "";
  protected string price = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      LoadDetail();
    }
  }
  void LoadDetail()
  {
    DataTable dt = (DataTable)Session["dataByTitle"];
    if (dt.Rows.Count > 0)
    {
      iid = dt.Rows[0][ItemsColumns.IidColumn].ToString();
      hotel = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
      price = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString() == "0" ? LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ") : NumberExtension.FormatNumber(dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString()) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
    }
  }
}