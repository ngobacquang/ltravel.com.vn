using System;
using System.Data;
using TatThanhJsc.AdvertisingModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.TSql;
using TatThanhJsc.Extension;

public partial class cms_display_Banner_LogoMain : System.Web.UI.UserControl
{
  private string app = CodeApplications.Advertising;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string pic = FolderPic.Advertising;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      ltrAdv.Text = GetGroupsAdv("0", "logo");
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

    for (int i = 0; i < dt.Rows.Count; i++)
    {

      //Neu quang cao co dat link thi them the <a>
      if (!dt.Rows[i]["VISEOLINK"].ToString().Equals(""))
      {
        string target = "";
        //Neu link quang cao dat mo tai trang khac
        if (dt.Rows[i]["VIPARAMS"].ToString().Equals("1"))
        {
          target = "target='_blank'";
        }
        s += "<a class='iconLogo' " + target + " title='" + dt.Rows[i]["VITITLE"] + "' href='" +
             dt.Rows[i]["VISEOLINK"] + "'>";
      }
      else
        s += "<a class='iconLogo' >";

      //Neu quang cao la hinh anh
      if (dt.Rows[i]["FISALEPRICE"].ToString().Equals("0"))
      {
        s += ImagesExtension.SetTypeImageAdvertising(
            dt.Rows[i]["FIPRICE"].ToString(),
            pic,
            dt.Rows[i]["VIIMAGE"].ToString(),
            dt.Rows[i]["VITITLE"].ToString(),
            dt.Rows[i]["VIKEY"].ToString(),
            dt.Rows[i]["VIDESC"].ToString(),
            cssImage, false);
      }
      else //Neu quang cao la flash
      {
        s += ImagesExtension.SetTypeImageAdvertising(
            dt.Rows[i]["FIPRICE"].ToString(),
            dt.Rows[i]["VIAUTHOR"].ToString(),
            "", "",
            dt.Rows[i]["VIKEY"].ToString(),
            dt.Rows[i]["VIDESC"].ToString(),
            cssImage, false);
      }



      //Neu quang cao co dat link thi them the <a>
      if (!dt.Rows[i]["VISEOLINK"].ToString().Equals(""))
      {
        s += "</a>";
      }
      else
        s += "</a>";
    }

    return s;
  }
}