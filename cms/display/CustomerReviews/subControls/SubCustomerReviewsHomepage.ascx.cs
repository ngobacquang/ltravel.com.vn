using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.CustomerReviewsModul;
using TatThanhJsc.TSql;


public partial class cms_display_CustomerReviews_subControls_SubCustomerReviewsHomepage : System.Web.UI.UserControl

{
  private string app = CodeApplications.CustomerReviews;
  private string appGroup = CodeApplications.CustomerReviewsGroupItem;
  private string pic = FolderPic.CustomerReviews;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string rewrite = RewriteExtension.CustomerReviews;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      ltrGroups.Text = GetGroups("0");
      if (ltrGroups.Text == "")
        this.Visible = false;
    }
  }

  /// <summary>
  /// Lấy danh sách các nhóm
  /// </summary>
  /// <returns></returns>
  private string GetGroups(string position)
  {
    string s = "";

    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVgapp(appGroup),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByVgparams(position)
        );

    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn,
        GroupsColumns.VGSEOLINKSEARCHColumn, GroupsColumns.IgtotalitemsColumn, GroupsColumns.VgdescColumn);

    DataTable dt = Groups.GetGroups("", fields, condition, GroupsColumns.IgorderColumn);
    string list = "";
    string link = "";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      list = GetList(dt.Rows[i][GroupsColumns.IgidColumn].ToString(),
          dt.Rows[i][GroupsColumns.IgtotalitemsColumn].ToString());

      if (list.Length < 1)
        list = GetLastest(dt.Rows[i][GroupsColumns.IgtotalitemsColumn].ToString());
      
        link = UrlExtension.WebisteUrl + rewrite + RewriteExtension.Extensions;

      s += @"
      <div class='section stlast customer_say'>
        <div class='container'>
          <div class='list'>
            <h2>
              <a href='" + link + @"' class='title list-title txtCenter fSize-34 nb-color-m1' title='" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"'>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</a>
            </h2>
            <p class='list-text hed txtCenter'>" + dt.Rows[i][GroupsColumns.VgdescColumn] + @"</p>
            <div class='list-body'>
              <div class='slick-slider' data-slick='{""slidesToShow"": 3, ""slidesToScroll"": 1, ""autoplay"": true, ""dots"": false, ""arrows"":true, ""responsive"": [{""breakpoint"":1025,""settings"":{""slidesToShow"": 2}},{""breakpoint"":768,""settings"": {""slidesToShow"": 1}}]}'>
                " + list + @" 
              </div>
            </div>
          </div>
        </div>
      </div>";
    }

    return s;
  }

  /// <summary>
  /// Lấy danh sách tin mới nhất
  /// </summary>
  /// <param name="maxRow"></param>
  /// <returns></returns>

  private string GetLastest(string maxRow)
  {
    string condition = DataExtension.AndConditon(
        ItemsTSql.GetItemsByIienable("1"),
        ItemsTSql.GetItemsByViapp(app),
        ItemsTSql.GetItemsByVilang(lang),
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVglang(lang)
        );

    string orderby = ItemsColumns.IiorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc ";

    DataTable dt = GroupsItems.GetAllData(maxRow, "*", condition, orderby);
    return BindItemsToHTML(dt);
  }

  /// <summary>
  /// Lấy danh sách tin trong một nhóm
  /// </summary>
  /// <param name="igid"></param>
  /// <param name="maxRow"></param>
  /// <returns></returns>
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

  /// <summary>
  /// Hiện thị danh sách tin ra html
  /// </summary>
  /// <param name="dt"></param>
  /// <returns></returns>
  private string BindItemsToHTML(DataTable dt)
  {
    string s = "";
    string link = "";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      link = (UrlExtension.WebisteUrl + dt.Rows[i][ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();

      s += @"
      <div class='item'>
        <div class='item-img'>
          <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='imgc'>
            " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"                
          </a>
        </div>
        <div class='item-body'>
          <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='title item-title customer-name'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
          <p class='item-text'>
            " + dt.Rows[i][ItemsColumns.ViDesc] + @"
          </p>
        </div>
      </div>";
    }
    return s;
  }
}