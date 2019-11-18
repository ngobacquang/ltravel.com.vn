using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;


public partial class cms_display_Hotel_subControls_SubHotelHomepage : System.Web.UI.UserControl

{
  private string app = CodeApplications.Hotel;
  private string appGroup = CodeApplications.HotelGroupItem;
  private string pic = FolderPic.Hotel;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string rewrite = RewriteExtension.Hotel;

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
        GroupsColumns.VGSEOLINKSEARCHColumn, GroupsColumns.IgtotalitemsColumn, GroupsColumns.VgdescColumn, GroupsColumns.VgimageColumn, GroupsColumns.VGSEOMETACANONICALColumn);

    DataTable dt = Groups.GetGroups("", fields, condition, GroupsColumns.IgorderColumn);
    string link = "";
    string linkCate = "";

    if(dt.Rows.Count > 0)
    {
      link = UrlExtension.WebisteUrl + rewrite + RewriteExtension.Extensions;
      s += @"
      <div class='section facilities'>
        <div class='container'>
          <div class='list'>
            <h2>
              <a href='" + link + @"' class='title list-title txtCenter fSize-34 fSize-sm-26 nb-color-m1'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Accommodation facilities") + @"</a>
            </h2>
            <p class='list-text hed txtCenter'>" + LanguageItemExtension.GetnLanguageItemTitleByName("If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long") + @"</p>
            <div class='list-body clearfix'>";

      for (int i = 0; i < dt.Rows.Count; i++)
      {
        linkCate = LayLinkCate(dt.Rows[i][GroupsColumns.VGSEOMETACANONICALColumn].ToString());

        s += @"
              <div class='col " + (i == 0 ? "bigTwo" : i == 3 ? "bigOne" : "") + @"'>
                <div class='item " + (i == 3 ? "item-bign" : "") + @"'>
                  <div class='item-img'>
                    <a href='" + linkCate + @"' title='" + dt.Rows[i][GroupsColumns.VgnameColumn].ToString() + @"' class='imgc'>
                      " + ImagesExtension.GetImage(pic, dt.Rows[i][GroupsColumns.VgimageColumn].ToString(), dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), "", true, false, "") + @"
                    </a>
                  </div>
                  <div class='item-body'>
                    <h3>
                      <a href='" + linkCate + @"' class='title item-title' title='" + dt.Rows[i][GroupsColumns.VgnameColumn].ToString() + @"'>" + dt.Rows[i][GroupsColumns.VgnameColumn].ToString() + @"</a>
                    </h3>
                  </div>
                </div>
              </div>";
      }

      s += @"
            </div>
          </div>
        </div>
      </div>";
    }

    return s;
  }

  string LayLinkCate(string igid)
  {
    string s = "";
    string condition = DataExtension.AndConditon(
      GroupsTSql.GetByApp(app),
      GroupsTSql.GetById(igid),
      GroupsTSql.GetByLang(lang)
    );
    string fields = DataExtension.GetListColumns(GroupsColumns.VGSEOLINKSEARCHColumn);

    DataTable dt = Groups.GetGroups("1", fields, condition, GroupsColumns.DgCreateDate + " desc");

    if (dt.Rows.Count > 0)
      s = (UrlExtension.WebisteUrl + dt.Rows[0][GroupsColumns.VGSEOLINKSEARCHColumn].ToString() + RewriteExtension.Extensions).ToLower();

    return s;
  }
}