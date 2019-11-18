using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;
using TatThanhJsc.TSql;

public partial class cms_display_Search_subControls_SubSearchHomepage : System.Web.UI.UserControl
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if(!IsPostBack)
    {
      LayDiemDen();
      LayThoiGian();
    }
  }

  void LayDiemDen()
  {
    DataTable dt = new DataTable();
    fields = " * ";
    condition = GroupsTSql.GetGroupsCondition(lang, CodeApplications.TourVehicle, "", " IGENABLE <> '2' ");
    orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    dt = Groups.GetGroups(top, fields, condition, orderBy);

    ddlThoiGian.Items.Clear();
    ddlThoiGian.Items.Add(new ListItem(LanguageItemExtension.GetnLanguageItemTitleByName("All duration"), ""));

    for(int i = 0; i < dt.Rows.Count; i++)
    {
      ddlThoiGian.Items.Add(new ListItem(dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), dt.Rows[i][GroupsColumns.IgidColumn].ToString()));
    }
  }

  void LayThoiGian()
  {
    DataTable dt = new DataTable();
    fields = " * ";
    condition = GroupsTSql.GetGroupsCondition(lang, CodeApplications.TourProperty, "", " IGENABLE <> '2' ");
    orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    dt = Groups.GetGroups(top, fields, condition, orderBy);

    ddlDiemDen.Items.Clear();
    ddlDiemDen.Items.Add(new ListItem(LanguageItemExtension.GetnLanguageItemTitleByName("Enter destination, City"), ""));

    for (int i = 0; i < dt.Rows.Count; i++)
    {
      ddlDiemDen.Items.Add(new ListItem(dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), dt.Rows[i][GroupsColumns.IgidColumn].ToString()));
    }
  }
}