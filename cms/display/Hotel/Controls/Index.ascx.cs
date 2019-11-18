using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;

public partial class cms_display_Hotel_Controls_Index : System.Web.UI.UserControl
{

  #region Các thông số cần chỉnh theo từng modul (Hotel, Hotel, Hotel...)
  private string app = CodeApplications.Hotel;
  protected string rewrite = RewriteExtension.Hotel;
  private string pic = FolderPic.Hotel;
  private string maxItemKey = SettingKey.SoHotelTrenTrangChu;
  #endregion

  #region Các thông số chung
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  protected string title = "";
  string igid = "";
  string p = "1";
  int rows = 6;
  string key = "";
  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["igid"] != null)
      igid = QueryStringExtension.GetQueryString("igid");
    #region title
    if (Request.QueryString["title"] != null)
    {
      title = Request.QueryString["title"];

      //Lấy igid từ session ra vì nó đã dược lưu khi xét tại Default.aspx
      if (igid.Length < 1 && Session["igid"] != null)
        igid = Session["igid"].ToString();
    }
    #endregion

    if (Request.QueryString["p"] != null)
      p = QueryStringExtension.GetQueryString("p");

    if (Request.QueryString["key"] != null)
      key = QueryStringExtension.GetQueryString("key");

    if (!IsPostBack)
    {
      ltrList.Text = GetCate();
    }
  }


  string GetCate()
  {
    string s = "";

    #region Condition, orderby, fields
    string condition = "";

    if (igid != "")
      condition = GroupsTSql.GetGroupsByIgid(igid);
    else
      condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByIgparentid("0"),
          GroupsTSql.GetGroupsByVgapp(app));
    condition = DataExtension.AndConditon(
        condition,
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByIgenable("1"));

    string orderby = GroupsColumns.IgorderColumn + "," + GroupsColumns.DgcreatedateColumn + " desc ";

    try
    {
      rows = int.Parse(SettingsExtension.GetSettingKey(maxItemKey, lang));
    }
    catch { }

    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.VGSEOLINKSEARCHColumn, GroupsColumns.VgdescColumn);
    #endregion

    DataTable dt = Groups.GetGroups("", fields, condition, orderby);

    string link = "";
    string list = "";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      link =
          (UrlExtension.WebisteUrl + dt.Rows[i][GroupsColumns.VGSEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();

      list = GetList(dt.Rows[i][GroupsColumns.IgidColumn].ToString(), rows.ToString());
      if (list.Length > 0)
        s += @"     
        <div class='section tag-service'>
          <div class='container'>
            <div class='list'>
              <h2>
                <a href='" + link + @"' class='title list-title txtCenter fSize-34 fSize-sm-26 nb-color-m1' title='" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"'>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</a>
              </h2>
              <p class='list-text hed txtCenter'>" + dt.Rows[i][GroupsColumns.VgdescColumn] + @"</p>
              <div class='list-body'>
                " + list + @"
              </div>
            </div>
          </div>
        </div>";
    }
    return s;
  }
  string GetList(string igid, string top)
  {
    string s = "";

    #region Condition, orderby, fields
    string condition = "";

    if (igid != "")
      condition = GroupsItemsTSql.GetItemsInGroupCondition(igid, "");
    else
      condition = GroupsTSql.GetGroupsByVgapp(app);
    condition = DataExtension.AndConditon(
        condition,
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByIgenable("1"),
        ItemsTSql.GetItemsByIienable("1"),
        ItemsTSql.GetItemsByViapp(app));

    if (key.Length > 0)
      condition = DataExtension.AndConditon(condition, SearchTSql.GetSearchMathedCondition(key, ItemsColumns.VititleColumn, ItemsColumns.VikeyColumn, ItemsColumns.FipriceColumn, ItemsColumns.FisalepriceColumn));

    string orderby = ItemsColumns.IiorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc ";

    string fields = DataExtension.GetListColumns(ItemsColumns.VititleColumn,
        ItemsColumns.ViimageColumn, ItemsColumns.VISEOLINKSEARCHColumn, ItemsColumns.VidescColumn, ItemsColumns.DiCreateDate, ItemsColumns.IiTotalView, ItemsColumns.FipriceColumn, ItemsColumns.FisalepriceColumn, ItemsColumns.VicontentColumn);
    #endregion

    DataTable dt = GroupsItems.GetAllData(top, fields, condition, orderby);

    #region Lấy ra danh sách bài viết
    if (dt.Rows.Count > 0)
    {
      string link = "";
      string bigPost = "", smallPost = "";
      string price = "", salePrice = "";
      int point = dt.Rows.Count - 4;
      
      if (point < 1) point = 1;

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

        if (i < point) {
          bigPost += @"     
          <div class='blog'>
            <div class='item item-row'>
              <div class='item-img'>
                <a href='" + link + @"' class='imgc'>
                  " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
                </a>
              </div>
              <div class='item-body'>
                <h3>
                  <a href='" + link + @"' class='title item-title fSize-20'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
                </h3>
                <div class='item-text'>
                  " + StringExtension.LayChuoi(dt.Rows[i][ItemsColumns.VicontentColumn].ToString(), "", 1) + @"
                </div>
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
        else
        {
          smallPost += @"
          <div class='col-12 col-sm-12 col-md-6 col-lg-6 col-xl-3'>
            <div class='item item-post'>
              <div class='item-img'>
                <a href='" + link + @"' class='imgc'>
                  " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
                </a>
              </div>
              <div class='item-body'>
                <h3>
                  <a href='" + link + @"' class='title item-title'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
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

      s = @"        
      <div class='sublist sublist-1'>
        <div class='sublist-body'>
          <div class='slick-slider' data-slick='{'slidesToShow': 1, 'slidesToScroll': 1, 'autoplay': false, 'dots': false, 'arrows':true}'>
          " + bigPost + @"
          </div>
        </div>
      </div>
      <div class='sublist sublist-2'>
        <div class='sublist-body'>
          <div class='row'>
          " + smallPost + @"
          </div>
        </div>
      </div>";
    }
    #endregion

    return s;
  }
}