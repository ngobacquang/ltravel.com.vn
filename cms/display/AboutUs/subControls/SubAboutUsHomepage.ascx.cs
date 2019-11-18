using System;
using System.Data;
using TatThanhJsc.AdvertisingModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.TSql;
using TatThanhJsc.Extension;

public partial class cms_display_AboutUs_subControls_SubAboutUsHomepage : System.Web.UI.UserControl
{
  private string app = CodeApplications.Advertising;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string pic = FolderPic.Advertising;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      ltrAdv.Text = GetGroupsAdv("3", "");
      if (ltrAdv.Text == "")
        this.Visible = false;
    }

  }

  private string GetGroupsAdv(string position, string cssImage)
  {
    string s = "";

    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.VgdescColumn);
    string orderby = GroupsColumns.IgorderColumn;
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVgparams(position),
        GroupsTSql.GetGroupsByVglang(lang)
        );
    DataTable dt = new DataTable();
    dt = Groups.GetGroups("", fields, condition, orderby);

    if (dt.Rows.Count > 0)
    {
      s += @"
      <div class='section about-us'>
        <div class='container'>
          <div class='list'>
            <h2>
              <a href='#' class='title list-title txtCenter fSize-34 fSize-sm-26 nb-color-m1'>" + dt.Rows[0][GroupsColumns.VgnameColumn].ToString() + @"</a>
            </h2>
            <p class='list-text hed txtCenter'>" + dt.Rows[0][GroupsColumns.VgdescColumn].ToString() + @"</p>
            <div class='list-body'>
              <div class='row'>
                " + GetListAdv(dt.Rows[0][GroupsColumns.IgidColumn].ToString(), cssImage) + @"
              </div>
            </div>
          </div>
        </div>
      </div>";
    }

    return s;
  }

  private string GetListAdv(string igid, string cssImage)
  {
    string s = "";
    DataTable dt = new DataTable();

    dt = GroupsItems.GetAllData("", " * ", GroupsItemsTSql.GetItemsInGroupCondition(
        igid, ItemsTSql.GetItemsByIienable("1")),
        GroupsItemsColumns.IorderColumn);

    for (int i = 0; i < dt.Rows.Count; i++)
    {
      string target = "";
      if (dt.Rows[i]["VIPARAMS"].ToString().Equals("1"))
      {
        target = "target='_blank'";
      }

      s += @"
      <div class='col-12 col-sm-12 col-md-12 col-lg-6 col-xl-6'>
        <div class='item item-row'>
          <div class='item-img'>
            <a href='" + dt.Rows[i]["VIURL"] + "' " + target + @" class='imgc0'>
              " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
            </a>
          </div>
          <div class='item-body'>
            <h3>
              <a href='" + dt.Rows[i]["VIURL"] + "' " + target + @" class='title item-title'>" + dt.Rows[i][ItemsColumns.VititleColumn].ToString() + @"</a>
              <p class='item-text'>" + dt.Rows[i][ItemsColumns.VISEOTITLEColumn].ToString() + @"</p>
            </h3>
          </div>
        </div>
      </div>";
    }

    return s;
  }
}