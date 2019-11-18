using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.ContactModul;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_ContactUs_Controls_Index : System.Web.UI.UserControl
{
  protected string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string app = CodeApplications.Contact;
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
      GetMapInfo();
  }

  void GetMapInfo()
  {
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByIgparentid("0")
        );
    string order = GroupsColumns.IgorderColumn;

    DataTable dt = Groups.GetGroups("", "*", condition, order);

    if (dt.Rows.Count > 0)
    {
      string content = dt.Rows[0][GroupsColumns.VgcontentColumn].ToString();
      ltrCateName.Text = dt.Rows[0][GroupsColumns.VgnameColumn].ToString();
      ltrMap.Text = dt.Rows[0][GroupsColumns.VgdescColumn].ToString();

      ddlPhongBan.Items.Clear();
      ddlPhongBan.Items.Add(new ListItem(LanguageItemExtension.GetnLanguageItemTitleByName("Sent to department"), ""));

      for (int i = 0; i < dt.Rows.Count; i++)
        ddlPhongBan.Items.Add(new ListItem(dt.Rows[i][GroupsColumns.VgName].ToString(), dt.Rows[i][GroupsColumns.IgidColumn].ToString()));

      string s = @"
      <p class='list-text'><span class='title'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Address") + @":</span> " + StringExtension.LayChuoi(content, "", 1) + @"</p>
      <p class='list-text'><span class='title'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Phone") + @": </span>" + StringExtension.LayChuoi(content, "", 2) + @"</p>
      <p class='list-text'><span class='title'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Email") + @": </span>" + StringExtension.LayChuoi(content, "", 4) + @"</p>
      <p class='list-text'><span class='title'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Website") + @": </span>" + StringExtension.LayChuoi(content, "", 7) + @"</p>";

      ltrInfo.Text = s;
    }
  }
}
