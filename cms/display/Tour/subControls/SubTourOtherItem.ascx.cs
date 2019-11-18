using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
public partial class cms_display_Tour_subControls_SubTourOtherItem : System.Web.UI.UserControl

{
  string igid = "";
  string iid = "";

  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  int rows = 6;

  private string maxItemKey = TatThanhJsc.TourModul.SettingKey.SoTourKhacTrenMotTrang;
  string app = TatThanhJsc.TourModul.CodeApplications.Tour;
  private string pic = TatThanhJsc.TourModul.FolderPic.Tour;

  public string MaxItemKey { set { maxItemKey = value; } }
  public string App { set { app = value; } }
  public string Pic { set { pic = value; } }


  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["igid"] != null)
      igid = StringExtension.RemoveSqlInjectionChars(Request.QueryString["igid"]);
    if (Request.QueryString["iid"] != null)
      iid = StringExtension.RemoveSqlInjectionChars(Request.QueryString["iid"]);
    if (Request.QueryString["title"] != null)
    {
      if (igid.Length < 1 && Session["igid"] != null)
        igid = Session["igid"].ToString();
      if (iid.Length < 1 && Session["iid"] != null)
        iid = Session["iid"].ToString();
    }

    if (!IsPostBack)
    {
      ltrList.Text = GetList();
      if (ltrList.Text == "")
        this.Visible = false;
    }
  }
  string GetList()
  {
    string s = "";

    string condition = GroupsTSql.GetGroupsByVgapp(app);
    if (igid != "")
      condition = GroupsItemsTSql.GetItemsInGroupCondition(igid, "");

    condition = DataExtension.AndConditon(condition,
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByIgenable("1"),
        ItemsTSql.GetItemsByIienable("1"),
        ItemsTSql.GetItemsByViapp(app));
    if (iid != "")
      condition += " and ITEMS.IID<> " + iid + " ";

    string fields = DataExtension.GetListColumns(ItemsColumns.VititleColumn, ItemsColumns.IitotalviewColumn,
        ItemsColumns.VISEOLINKSEARCHColumn, ItemsColumns.DicreatedateColumn, ItemsColumns.ViImage, ItemsColumns.VidescColumn, ItemsColumns.FipriceColumn, ItemsColumns.FisalepriceColumn, ItemsColumns.ViurlColumn, ItemsColumns.VISEOMETAPARAMSColumn);

    string orderby = ItemsColumns.IiorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc ";

    try
    {
      rows = int.Parse(SettingsExtension.GetSettingKey(maxItemKey, lang));
    }
    catch { }

    DataTable dt = new DataTable();
    dt = GroupsItems.GetAllData(rows.ToString(), fields, condition, orderby);
    if (dt.Rows.Count > 0)
    {
      string link = "";
      string price = "", salePrice = "";
      string time = "";

      for (int i = 0; i < dt.Rows.Count; i++)
      {
        link = (UrlExtension.WebisteUrl + dt.Rows[i][ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();
        price = dt.Rows[i][ItemsColumns.FipriceColumn].ToString();
        salePrice = dt.Rows[i][ItemsColumns.FisalepriceColumn].ToString();

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

        time = LayThoiGianTour(dt.Rows[i][ItemsColumns.ViurlColumn].ToString());

        s += @"
        <div class='blog'>
          <div class='item item-post'>
            <div class='item-img'>
              <a href='" + link + @"' class='imgc'>
                " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViImage].ToString(), dt.Rows[0][ItemsColumns.ViTitle].ToString(), "", true, false, "") + @"
              </a>
              <div class='item-date'>
                <div>
                  <i class='fa fa-calendar' aria-hidden='true'></i><span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Time") + @": " + time + @"</span>
                </div>
                <div>
                  <i class='fa fa-plane' aria-hidden='true'></i><span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Departure") + @": " + dt.Rows[i][ItemsColumns.VISEOMETAPARAMSColumn] + @"</span>
                </div>
              </div>
            </div>
            <div class='item-body'>
              <h3>
                <a href='" + link + @"' class='title item-title' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
              </h3>
              <div class='item-price'>
                <span class='real'>" + salePrice + @"</span>
                <span class='throught'>" + price + @"</span>
              </div>
              <a href='" + link + @"' class='link item-link' title='" + LanguageItemExtension.GetnLanguageItemTitleByName("More") + @"'>" + LanguageItemExtension.GetnLanguageItemTitleByName("More") + @" <i class='fa fa-angle-right' aria-hidden='true'></i>
              </a>
            </div>
          </div>
        </div>";
      }
    }
    return s;
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
}
