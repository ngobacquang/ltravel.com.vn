using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_AboutUs_Controls_Category : System.Web.UI.UserControl
{
  #region Các thông số chung
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string title = "";
  private string go = "";

  string igid = "";
  string p = "1";
  int rows = 10;
  string key = "";
  #endregion

  #region Các thông số cần chỉnh theo từng modul (AboutUs, AboutUs, AboutUs...)
  private string app = TatThanhJsc.AboutUsModul.CodeApplications.AboutUs;
  private string pic = TatThanhJsc.AboutUsModul.FolderPic.AboutUs;
  private string maxItemKey = TatThanhJsc.AboutUsModul.SettingKey.SoAboutUsTrenTrangDanhMuc;
  private string noResultText = LanguageItemExtension.GetnLanguageItemTitleByName("Nội dung các bài viết thuộc chuyên mục này sẽ được chúng tôi cập nhật sớm. Cảm ơn quý khách đã quan tâm!");
  #endregion

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["igid"] != null)
      igid = QueryStringExtension.GetQueryString("igid");

    if (Request.QueryString["go"] != null)
      go = QueryStringExtension.GetQueryString("go");

    #region title
    if (Request.QueryString["title"] != null)
    {
      title = Request.QueryString["title"];
      //Lấy igid từ session ra vì nó đã dược lưu khi xét tại Default.aspx
      if (igid.Length < 1 && Session["igid"] != null)
        igid = Session["igid"].ToString();

      if (go.Length < 1 && Session["go"] != null)
        go = Session["go"].ToString();
    }
    #endregion

    if (Request.QueryString["p"] != null)
      p = QueryStringExtension.GetQueryString("p");

    if (Request.QueryString["key"] != null)
      key = QueryStringExtension.GetQueryString("key");

    if (!IsPostBack)
    {
      GetCateInfo();
      GetList();
    }
  }

  private void GetCateInfo()
  {
    if (Session["dataByTitle_Cate"] != null)
    {
      DataTable dt = (DataTable)Session["dataByTitle_Cate"];
      if (dt.Rows.Count > 0)
      {
        ltrCateName.Text = dt.Rows[0][GroupsColumns.VgName].ToString();
        ltrCateDesc.Text = dt.Rows[0][GroupsColumns.VgDesc].ToString();
      }
    }
    else
    {
      string condition = DataExtension.AndConditon(
        GroupsTSql.GetByApp(app),
        GroupsTSql.GetByEnable("1"),
        GroupsTSql.GetByLang(lang),
        GroupsTSql.GetByParentId("0")
      );
      string fields = DataExtension.GetListColumns(GroupsColumns.VgName, GroupsColumns.VgDesc);
      string orderby = GroupsColumns.DgCreateDate + " desc";
      DataTable dt = Groups.GetGroups("1", fields, condition, orderby);
      if (dt.Rows.Count > 0)
      {
        ltrCateName.Text = dt.Rows[0][GroupsColumns.VgName].ToString();
        ltrCateDesc.Text = dt.Rows[0][GroupsColumns.VgDesc].ToString();
      }
    }
  }

  #region Get list item
  void GetList()
  {
    #region Condition, orderby
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
    #endregion

    DataTable dt = GroupsItems.GetAllData("", " * ", condition, orderby);

    #region Lấy ra danh sách bài viết
    if (dt.Rows.Count > 0)
    {
      string link = "";
      for (int i = 0; i < dt.Rows.Count; i++)
      {
        link = (UrlExtension.WebisteUrl + dt.Rows[i][ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();
        ltrList.Text += @"
        <div class='col " + (i == 0 ? "bigTwo" : i == 3 ? "bigOne" : "") + @"'>
          <div class='item " + (i == 3 ? "item-bign" : "") + @"'>
            <div class='item-img'>
              <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='imgc'>
                " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
              </a>
            </div>
            <div class='item-body'>
              <h3>
                <a href='" + link + @"' class='title item-title' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
              </h3>
            </div>
          </div>
        </div>";
      }
    }
    #endregion
  }
  #endregion
}