using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Service_subControls_SubServiceDetail_Order : System.Web.UI.UserControl
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay(); 
  private string app = TatThanhJsc.ServiceModul.CodeApplications.Service;
  string igid = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["igid"] != null)
      igid = QueryStringExtension.GetQueryString("igid");

    if (!IsPostBack)
    {
      GetList();
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

    string orderby = ItemsColumns.IiorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc ";
    #endregion

    DataTable dt = GroupsItems.GetAllData("", " * ", condition, orderby);

    if (dt.Rows.Count > 0)
    {
      ddlService2.Items.Clear();
      for (int i = 0; i < dt.Rows.Count; i++)
        ddlService2.Items.Add(new ListItem(dt.Rows[i][ItemsColumns.VititleColumn].ToString(), dt.Rows[i][ItemsColumns.IidColumn].ToString()));
    }
  }
  #endregion
}