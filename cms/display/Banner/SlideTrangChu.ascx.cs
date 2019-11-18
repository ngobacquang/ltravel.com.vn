using System;
using System.Data;
using TatThanhJsc.AdvertisingModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.TSql;
using TatThanhJsc.Extension;

public partial class cms_display_Banner_SlideTrangChu : System.Web.UI.UserControl
{
  private string app = CodeApplications.Advertising;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string pic = FolderPic.Advertising;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      ltrAdv.Text = GetGroupsAdv("1", "");
      if (ltrAdv.Text == "")
        this.Visible = false;
    }

  }

  private string GetGroupsAdv(string position, string cssImage)
  {
    string s = "";

    string fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn);
    string orderby = GroupsColumns.IgorderColumn;
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVgparams(position),
        GroupsTSql.GetGroupsByVglang(lang)
        );
    DataTable dt = new DataTable();
    dt = Groups.GetGroups("", fields, condition, orderby);

    for (int i = 0; i < dt.Rows.Count; i++)
    {
      s += GetListAdv(dt.Rows[i][GroupsColumns.IgidColumn].ToString(), cssImage);
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

    string href = "";
    string target = "";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      if (dt.Rows[i][ItemsColumns.VISEOLINKColumn].ToString() != "")
        href = dt.Rows[i][ItemsColumns.VISEOLINKColumn].ToString();
      else
        href = "javascript://";

      if (dt.Rows[i][ItemsColumns.ViParams].ToString() == "1")
        target = "target='_blank'";
      else
        target = "";

      s += @"
      <div class='item'>
        <div class='item-img'>
          <a href='" + href + @"' " + target + @" title='" + dt.Rows[i][ItemsColumns.ViTitle] + @"' class='imgc'>
            <img alt='" + dt.Rows[i][ItemsColumns.ViTitle] + @"' src='" + UrlExtension.WebisteUrl + pic + "/" + dt.Rows[i][ItemsColumns.ViImage] + @"' />
          </a>
        </div>
      </div>";
    }

    return s;
  }
}