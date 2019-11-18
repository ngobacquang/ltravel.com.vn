using System;
using System.Data;
using System.Web.UI.WebControls;
using Developer.Position;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.ServiceModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Service_SubControls_AddItemToGroups : System.Web.UI.Page
{
    #region Params On This Page
    private string app = CodeApplications.ServiceGroupItem;
    private string iid = "-1";
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    ServicePosition listModul = new ServicePosition();
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.QueryString["iid"].Equals(""))
        {
            iid = QueryStringExtension.GetQueryString("iid");
        }
        if (!IsPostBack)
        {
            LtMes.Visible = false;
            GetTitleItem();
            AddItemsInDll();
            GetGroupsService();
        }
    }

    void GetTitleItem()
    {
        fields = TatThanhJsc.Extension.DataExtension.GetListColumns(TatThanhJsc.Columns.ItemsColumns.VititleColumn, TatThanhJsc.Columns.ItemsColumns.DicreatedateColumn);
        condition = ItemsTSql.GetItemsByIid(iid);
        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData(top, fields, condition, orderBy);
        if (dt.Rows.Count > 0)
        {
            LtTitlePage.Text = dt.Rows[0]["VITITLE"].ToString();
            lt_cate_name.Text =@"
<div class='TitleItem'>Tên dịch vụ: " + dt.Rows[0]["VITITLE"].ToString() + @"</div>
<div>Ngày đăng: " +TatThanhJsc.Extension.TimeExtension.FormatTime(dt.Rows[0][TatThanhJsc.Columns.ItemsColumns.DicreatedateColumn],"dd/MM/yyyy") + @"</div>";
        }
    }

    void AddItemsInDll()
    {
        ddl_type_groupnew_show.Items.Add(new ListItem(" Chọn vị trí nhóm", ""));

        ddl_type_groupnew_show.Items.Clear();
        for (int i = 0; i < listModul.Text.Length; i++)
        {
            ddl_type_groupnew_show.Items.Add(new ListItem(listModul.Text[i], listModul.Values[i]));
        }
    }

    void GetGroupsService()
    {
        fields = " * ";
        string conditionItem = "";
        conditionItem =TatThanhJsc.Extension.DataExtension.AndConditon(GroupsTSql.GetGroupsByVglang(language), GroupsTSql.GetGroupsByVgapp(app));
        if (!ddl_type_groupnew_show.SelectedValue.Equals(""))
        {
            conditionItem += " AND VGPARAMS = " + ddl_type_groupnew_show.SelectedValue;
        }
        DataTable dt_Groups = new DataTable();
        dt_Groups = Groups.GetAllGroups(fields, conditionItem, "");
        if (dt_Groups.Rows.Count > 0)
        {
            for (int i = 0; i < dt_Groups.Rows.Count; i++)
            {
                condition = GroupsItemsTSql.GetItemsInGroupCondition(dt_Groups.Rows[i]["IGID"].ToString(), " [GROUPS_ITEMS].IID = '" + iid + "' ");
                DataTable dt = new DataTable();
                dt = GroupsItems.GetAllData(top, fields, condition, orderBy);
                if (dt.Rows.Count > 0)
                {
                    lstadded.Items.Add(new ListItem(dt_Groups.Rows[i]["VGNAME"].ToString(), dt_Groups.Rows[i]["IGID"].ToString()));    
                }
                else
                {
                    lstnotadded.Items.Add(new ListItem(dt_Groups.Rows[i]["VGNAME"].ToString(), dt_Groups.Rows[i]["IGID"].ToString()));
                }
            }
        }
    }

    protected void btnadd_Click(object sender, EventArgs e)
    {
        if (lstadded.SelectedValue.Equals(""))
        {
            LtMes.Visible = false;
            GroupsItems.InsertGroupsItems(lstnotadded.SelectedValue, iid, "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "");
            lstnotadded.Items.Clear();
            lstadded.Items.Clear();
            GetGroupsService();
        }
        else
        {
            LtMes.Visible = true;
            LtMes.Text = "<div class='MesText'>Dịch vụ đã trong nhóm <b>" + GroupsExtension.GetNameCategoryById(lstadded.SelectedValue) + "</b></div>";
            return;
        }
    }

    protected void btnremove_Click(object sender, EventArgs e)
    {
        if (lstnotadded.SelectedValue.Equals(""))
        {
            LtMes.Visible = false;
            condition = " IGID = " + lstadded.SelectedValue + " AND IID = " + iid + " ";
            GroupsItems.DeleteGroupsItems(condition);
            lstnotadded.Items.Clear();
            lstadded.Items.Clear();
            GetGroupsService();
        }
        else
        {
            LtMes.Visible = true;
            LtMes.Text = "<div class='MesText'>Dịch vụ này chưa trong nhóm <b>" + GroupsExtension.GetNameCategoryById(lstnotadded.SelectedValue) + "</b></div>";
            return;
        }
    }

    protected void ddl_type_groupnew_show_SelectedIndexChanged(object sender, EventArgs e)
    {
        lstnotadded.Items.Clear();
        lstadded.Items.Clear();
        GetGroupsService();
    }
}
