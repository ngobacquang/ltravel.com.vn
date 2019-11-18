using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Tour_subControls_SubTourDetail_Booking : System.Web.UI.UserControl
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  protected string GetIid = "";
  protected string ToTalPrice = "";
  protected string ToTalPriceOrigin = "";

  protected string GiaNguoiLon = "";
  protected string GiaTreViThanhNien = "";
  protected string GiaTreEm = "";
  protected string GiaEmBe = "";
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
      GetIid = dt.Rows[0][ItemsColumns.IidColumn].ToString();
      ltrTitle.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();

      ToTalPriceOrigin = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString() == "0" ? dt.Rows[0][ItemsColumns.FipriceColumn].ToString() == "0" ? LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ") : dt.Rows[0][ItemsColumns.FipriceColumn].ToString() : dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString();

      if (ToTalPriceOrigin != LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ"))    
      {
        ToTalPrice = NumberExtension.FormatNumber(ToTalPriceOrigin);
        ltrSubPrice.Text = LanguageItemExtension.GetnLanguageItemTitleByName("VND");
      }
      else
        ToTalPrice = LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ");

      GiaNguoiLon = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 1);
      GiaTreViThanhNien = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 2);
      GiaTreEm = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 3);
      GiaEmBe = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VISEOMETACANONICALColumn].ToString(), "", 4);

      LayIgid(dt.Rows[0][ItemsColumns.IidColumn].ToString());
    }
  }

  void LayIgid(string iid)
  {
    DataTable dt = GroupsItems.GetAllData("", " * ", GroupsItemsTSql.GetByIid(iid), ItemsColumns.IiorderColumn + " desc ");
    if (dt.Rows.Count > 0)
      LayDanhSachTour(dt.Rows[0][GroupsColumns.IgidColumn].ToString(), iid);
  }

  void LayDanhSachTour(string igid, string iid)
  {
    string condition = DataExtension.AndConditon(
          GroupsItemsTSql.GetItemsInGroupCondition(igid, ""),
          GroupsTSql.GetGroupsByVglang(lang),
          GroupsTSql.GetGroupsByIgenable("1"),
          ItemsTSql.GetItemsByIienable("1"),
          ItemsTSql.GetItemsByViapp(TatThanhJsc.TourModul.CodeApplications.Tour));

    string orderby = ItemsColumns.IiorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc ";

    DataTable dt = GroupsItems.GetAllData("", " * ", condition, orderby);

    for(int i = 0; i < dt.Rows.Count; i++)
    {
      ddlChuyenDi.Items.Add(new ListItem(dt.Rows[i][ItemsColumns.VititleColumn].ToString(), dt.Rows[i][ItemsColumns.IidColumn].ToString()));
    }

    ddlChuyenDi.SelectedValue = iid;
  }
}