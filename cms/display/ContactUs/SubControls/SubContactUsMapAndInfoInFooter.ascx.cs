using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.ContactModul;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_ContactUs_SubControls_SubContactUsMapAndInfoInFooter : System.Web.UI.UserControl
{
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string app = CodeApplications.Contact;

  protected void Page_Load(object sender, EventArgs e)
  {
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

    DataTable dt = Groups.GetGroups("1", "*", condition, order);

    if (dt.Rows.Count > 0)
    { 
      string content = dt.Rows[0][GroupsColumns.VgcontentColumn].ToString();

      ltrInfo.Text = @"     
      <div class='body'>
        <p>
          <span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Address") + @":</span> " + StringExtension.LayChuoi(content, "", 1) + @"
        </p>
        <p>
          <span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Phone") + @":</span> " + StringExtension.LayChuoi(content, "", 2) + @"
        </p>
        <p>
          <span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Email") + @":</span> " + StringExtension.LayChuoi(content, "", 4) + @"
        </p>
        <div class='map'>
          " + dt.Rows[0][GroupsColumns.VgdescColumn].ToString() + @"
        </div>
      </div>";
    }
  }
}