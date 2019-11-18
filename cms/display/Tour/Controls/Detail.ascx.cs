using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Tour_Controls_Detail : System.Web.UI.UserControl
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
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
      UpdateTotalView(dt.Rows[0][ItemsColumns.IidColumn].ToString());

      ltrImage.Text = ImagesExtension.GetImage(TatThanhJsc.TourModul.FolderPic.Tour, dt.Rows[0][ItemsColumns.ViimageColumn].ToString(), dt.Rows[0][ItemsColumns.VititleColumn].ToString(), "", true, false, "");

      ltrTitle.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
      ltrDesc.Text = dt.Rows[0][ItemsColumns.VidescColumn].ToString();
      ltrDepartureFrom.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 1);
      ltrDepartureTime.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 5);
      ltrVehicle.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 2);
      //ltrSalePrice.Text = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString() == "0" ? LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ") : NumberExtension.FormatNumber(dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString()) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
      //ltrPrice.Text = dt.Rows[0][ItemsColumns.FipriceColumn].ToString() == "0" ? "" : NumberExtension.FormatNumber(dt.Rows[0][ItemsColumns.FipriceColumn].ToString()) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");  
      ltrVideo.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 3);
      ltrMap.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 4);


      string price = dt.Rows[0][ItemsColumns.FipriceColumn].ToString();
      string salePrice = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString();

      if (price == "0" || price == "")
      {
        price = "";
        salePrice = LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ");
      }
      else if (salePrice == "0" || salePrice == "")
      {
        salePrice = NumberExtension.FormatNumber(price) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
        price = "";
      }
      else
      {
        price = NumberExtension.FormatNumber(price) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
        salePrice = NumberExtension.FormatNumber(salePrice) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
      }

      ltrSalePrice.Text = salePrice;
      ltrPrice.Text = price;

      ltrItinerary.Text = LayLichTrinh(dt.Rows[0][ItemsColumns.IidColumn].ToString());
      ltrImages.Text = LayHinhAnh(dt.Rows[0][ItemsColumns.IidColumn].ToString());
      ltrDuration.Text = LayThoiGianTour(dt.Rows[0][ItemsColumns.ViurlColumn].ToString());
    }
  }

  string LayThoiGianTour(string igid)
  {
    string s = "";
    DataTable dt = new DataTable();
    string fields = " * ";
    string condition = DataExtension.AndConditon(
      GroupsTSql.GetByApp(TatThanhJsc.TourModul.CodeApplications.TourVehicle),
      GroupsTSql.GetGroupsByIgid(igid),
      GroupsTSql.GetByLang(lang)
    );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    dt = Groups.GetGroups("1", fields, condition, orderBy);

    if (dt.Rows.Count > 0) s = dt.Rows[0][GroupsColumns.VgName].ToString();

    return s;
  }

  string LayHinhAnh(string iid)
  {
    string s = "";

    string condition = DataExtension.AndConditon(
            SubitemsTSql.GetSubitemsByVskey(TatThanhJsc.TourModul.CodeApplications.TourPhoto),
            SubitemsTSql.GetSubitemsByIid(iid),
            SubitemsTSql.GetSubitemsByVslang(lang),
            SubitemsColumns.IsenableColumn + "<>2"
            );
    string order = "[dbo].[RemoveTextIfNotIsFloat](" + SubitemsColumns.VsatuthorColumn + ")";
    DataTable dt = Subitems.GetSubItems("", "*", condition, order);

    for(int i = 0; i < dt.Rows.Count; i++)
    {
      s += @"
      <p>
        " + ImagesExtension.GetImage(TatThanhJsc.TourModul.FolderPic.Tour, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString(), dt.Rows[i][SubitemsColumns.VsTitle].ToString(), "", true, false, "") + @"
      </p>";
    }

    return s;
  }

  string LayLichTrinh(string iid)
  {
    string s = "";

    string condition = DataExtension.AndConditon(
           SubitemsTSql.GetSubitemsByVskey(TatThanhJsc.TourModul.CodeApplications.TourItinerary),
           SubitemsTSql.GetSubitemsByIid(iid),
           SubitemsTSql.GetSubitemsByVslang(lang),
           SubitemsColumns.IsenableColumn + "<>2");

    string order = "[dbo].[RemoveTextIfNotIsFloat](" + SubitemsColumns.VsatuthorColumn + ")";
    DataTable dt = Subitems.GetSubItems("", "*", condition, order);

    for(int i = 0; i < dt.Rows.Count; i++)
    {
      s += @"
      <div class='nb-card'>
        <div class='nb-head'>
          <a href='#' class='title nb-collapse-toggle'>
            <span>" + StringExtension.LayChuoi(dt.Rows[i][SubitemsColumns.VstitleColumn].ToString(), "", 1) + @"</span> - " + StringExtension.LayChuoi(dt.Rows[i][SubitemsColumns.VstitleColumn].ToString(), "", 2) + @"
						<span class='icon-toggle'></span>
          </a>
        </div>
        <div class='nb-body'>
          <div class='wap'>
            " + dt.Rows[i][SubitemsColumns.VscontentColumn].ToString() + @"
          </div>
        </div>
      </div>";
    }
    

    return s;
  }

  private void UpdateTotalView(string iid)
  {
    string[] fields = { "IITOTALVIEW" };
    string[] values = { "IITOTALVIEW + 1" };
    Items.UpdateItems(DataExtension.UpdateTransfer(fields, values), ItemsTSql.GetItemsByIid(iid));
  }
}