using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
public partial class cms_display_AboutUs_subControls_AboutUsOtherItem : System.Web.UI.UserControl

{
  string igid = "";
  string iid = "";

  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  int rows = 6;

  private string maxItemKey = TatThanhJsc.AboutUsModul.SettingKey.SoAboutUsKhacTrenMotTrang;
  string app = TatThanhJsc.AboutUsModul.CodeApplications.AboutUs;
  private string pic = TatThanhJsc.AboutUsModul.FolderPic.AboutUs;

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
        ItemsColumns.VISEOLINKSEARCHColumn, ItemsColumns.DicreatedateColumn, ItemsColumns.ViImage, ItemsColumns.VidescColumn);

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
            <h3><a href='" + link + @"' class='title item-title' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a></h3>
          </div>
        </div>";
      }
    }
    return s;
  }
}
