using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;
using TatThanhJsc.TSql;


public partial class cms_display_Tour_subControls_SubTourHomepage : System.Web.UI.UserControl
{
  private string app = CodeApplications.Tour;
  private string appGroup = CodeApplications.TourGroupItem;
  private string pic = FolderPic.Tour;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string rewrite = RewriteExtension.Tour;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      ltrGroups.Text = GetGroups("0");
      if (ltrGroups.Text == "")
        this.Visible = false;
    }
  }

  private string GetGroups(string position)
  {
    string s = "";

    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVgapp(appGroup),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByVgparams(position)
        );

    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.IgtotalitemsColumn, GroupsColumns.VGSEOMETACANONICALColumn);
    
    DataTable dt = Groups.GetGroups("", fields, condition, GroupsColumns.IgorderColumn);

    string list = "";
    string cate = "";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      list = GetList(dt.Rows[i][GroupsColumns.IgidColumn].ToString(),
          dt.Rows[i][GroupsColumns.IgtotalitemsColumn].ToString());
      
      if(list.Length < 1)
        list = GetList(dt.Rows[i][GroupsColumns.VGSEOMETACANONICALColumn].ToString(),
          dt.Rows[i][GroupsColumns.IgtotalitemsColumn].ToString());

      cate = GetCate(dt.Rows[i][GroupsColumns.VGSEOMETACANONICALColumn].ToString());

      s += @"
      <div class='section " + (i % 2 == 0 ? "stfirst" : "") + @" tour-cat'>
        <div class='container'>
          <div class='list'>
            <h2>
              <a href='" + UrlExtension.WebisteUrl + StringExtension.LayChuoi(cate, "", 3) + RewriteExtension.Extensions + @"' class='title list-title txtCenter fSize-34 fSize-sm-26 nb-color-m1' title='" + StringExtension.LayChuoi(cate, "", 1) + @"'><span>" + StringExtension.LayChuoi(cate, "", 1) + @"</span></a>
            </h2>
            <p class='list-text hed txtCenter'>" + StringExtension.LayChuoi(cate, "", 2) + @"</p>
            <div class='list-body'>
              <div class='wap clearfix'>
                " + list + @"
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class='container'>
        <hr>
      </div>";
    }

    return s;
  }

  private string GetCate(string igid)
  {
    string s = "";

    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByIgid(igid)
    );

    string fields = DataExtension.GetListColumns(GroupsColumns.VgnameColumn, GroupsColumns.VgdescColumn, GroupsColumns.VGSEOLINKSEARCHColumn);
    string orderby = GroupsColumns.IgOrder + " desc ";

    DataTable dt = Groups.GetGroups("1", fields, condition, orderby);

    if (dt.Rows.Count > 0)
      s = StringExtension.GhepChuoi("", dt.Rows[0][GroupsColumns.VgnameColumn].ToString(), dt.Rows[0][GroupsColumns.VgdescColumn].ToString(), dt.Rows[0][GroupsColumns.VGSEOLINKSEARCHColumn].ToString());

    return s;
  }

  private string GetList(string igid, string maxRow)
  {
    string condition = DataExtension.AndConditon(
        ItemsTSql.GetItemsByIienable("1"),
        ItemsTSql.GetItemsByViapp(app),
        ItemsTSql.GetItemsByVilang(lang),
        GroupsItemsTSql.GetItemsInGroupCondition(igid, "")
        );

    string orderby = ItemsColumns.IiorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc ";

    DataTable dt = GroupsItems.GetAllData(maxRow, "*", condition, orderby);
    return BindItemsToHTML(dt);
  }

  private string BindItemsToHTML(DataTable dt)
  {
    string s = "";
    if (dt.Rows.Count > 0)
    {
      string link = "";
      string price = "", salePrice = "";
      string time = "";
      int point = dt.Rows.Count - 4;

      if (point < 1) point = 1;

      string layout1 = "";
      string layout2 = "";

      for(int i = 0; i < dt.Rows.Count; i++)
      {
        link = (UrlExtension.WebisteUrl + dt.Rows[i][ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();
        price = dt.Rows[i][ItemsColumns.FipriceColumn].ToString();
        salePrice = dt.Rows[i][ItemsColumns.FisalepriceColumn].ToString();

        if(price == "0" || price == "")
        {
          price = "";
          salePrice = LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ");
        }
        else if(salePrice == "0" || salePrice == "")
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
          
        if(i < point)
        {
          layout1 += @"
          <div class='blog'>
            <div class='item item-post item-big'>
              <div class='item-img'>
                <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='imgc'>
                  " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
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
                  <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='title item-title'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
                </h3>
                <p class='item-text'>" + dt.Rows[i][ItemsColumns.VidescColumn] + @"</p>
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
          layout2 += @"
          <div class='colBlog'>
            <div class='item item-post'>
              <div class='item-img'>
                <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='imgc'>
                  " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
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

      s = @"
      <div class='colBlog colDouble'>
        <div class='slick-slider' data-slick='{""slidesToShow"": 1, ""slidesToScroll"": 1, ""autoplay"": false, ""dots"": false, ""arrows"":true, ""responsive"": [{""breakpoint"":1025,""settings"": ""unslick""}]}'>
          " + layout1 + @"
        </div>
      </div>
      " + layout2 + @"";
    }
    return s;
  }

  string LayThoiGianTour(string igid)
  {
    string s = "";
    DataTable dt = new DataTable();
    string fields = " * ";
    string condition = DataExtension.AndConditon(
      GroupsTSql.GetByApp(CodeApplications.TourVehicle),
      GroupsTSql.GetGroupsByIgid(igid),
      GroupsTSql.GetByLang(lang)
    );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    dt = Groups.GetGroups("1", fields, condition, orderBy);

    if (dt.Rows.Count > 0) s = dt.Rows[0][GroupsColumns.VgName].ToString();

    return s;
  }
}