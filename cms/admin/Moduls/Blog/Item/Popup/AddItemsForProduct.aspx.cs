using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

using System.Data;


public partial class cms_admin_PopUp_GroupsItems_AddItemsForProduct : System.Web.UI.Page
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    #region Params On This Page
    private string igid = "-1";
    private string igparentsid = "";
    private string Modul = "";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.QueryString["igid"].Equals(""))
        {
            igid = QueryStringExtension.GetQueryString("igid");
        }
        if (!Request.QueryString["modul"].Equals(""))
        {
            Modul = QueryStringExtension.GetQueryString("modul");
        }
        
        if (!IsPostBack)
        {
            GetDetailGroups();
            getGroups();
            GetProductGroups(ddl_groups.SelectedValue);
        }
    }

    //Lấy nhóm modul, đổ vào dropdownlist
    void getGroups()
    {
        DataTable dt = new DataTable();
        dt = Groups.GetAllGroups(" * ", DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(Modul), GroupsTSql.GetGroupsByVglang(language), "igenable <> '2'"), "");
        ddl_groups.Items.Add(new ListItem("Chọn danh mục", string.Empty));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ddl_groups.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
        }
    }

    //Lấy thông tin của nhóm modul, in ra literal
    void GetDetailGroups()
    {
        DataTable dt = new DataTable();
        fields = "*";
        condition = ItemsTSql.GetItemsByIid(igid);
        dt = TatThanhJsc.Database.Items.GetItems(top, fields, condition, orderBy);
        if (dt.Rows.Count > 0)
        {
            lt_cate_name.Text = "<div>" + dt.Rows[0]["VITITLE"] + "</div>";
        }
    }

    void GetProductGroups(string IgidInDll)
    {
        string iid_inListAdded = "";
        fields = " * ";
        condition = DataExtension.AndConditon(SubitemsTSql.GetSubitemsByIid(igid),SubitemsTSql.GetSubitemsByVskey("PIP"));
        DataTable dtProductInCate = new DataTable();
        dtProductInCate = Subitems.GetSubItems(top, fields, condition, " DSCREATEDATE DESC ");
        if (dtProductInCate.Rows.Count > 0)
        {
            for (int i = 0; i < dtProductInCate.Rows.Count; i++)
            {
                lstadded.Items.Add(new ListItem(loadDataDetail(dtProductInCate.Rows[i]["VSTITLE"].ToString()), dtProductInCate.Rows[i]["VSTITLE"].ToString()));
                iid_inListAdded += dtProductInCate.Rows[i]["VSTITLE"].ToString();
                if (i != (dtProductInCate.Rows.Count - 1))
                {
                    iid_inListAdded += ",";
                }

            }
        }

        DataTable dt = new DataTable();
        string conditionItem = "";
        conditionItem = DataExtension.AndConditon(GroupsTSql.GetGroupsByVglang(language), GroupsTSql.GetGroupsByVgapp(Modul),ItemsTSql.GetItemsByIienable("1"),ItemsTSql.GetItemsByViapp(Modul),"ITEMS.IID <> "+ igid);
        if (!iid_inListAdded.Equals(""))
        {
            conditionItem += "and ITEMS.IID not in(" + iid_inListAdded + ")";
        }

        if (!IgidInDll.Equals(""))
        {
            conditionItem += " AND " + GroupsItemsTSql.GetItemsInGroupCondition(IgidInDll, "") + " ";
        }
        conditionItem += " AND IGENABLE <> '2' AND IIENABLE <> '2' ";
        dt = GroupsItems.GetAllData("", "*", conditionItem, " IORDER ASC, DCREATEDATE DESC ");
        
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            lstnotadded.Items.Add(new ListItem(dt.Rows[i]["VITITLE"].ToString(), dt.Rows[i]["IID"].ToString()));
        }
    }

    protected void btnadd_Click(object sender, EventArgs e)
    {
        int[] iidArry = new int[lstnotadded.Rows + 1];
        iidArry = lstnotadded.GetSelectedIndices();
        if (iidArry.Length > 0)
        {
            for (int i = 0; i < iidArry.Length; i++)
            {
                Subitems.InsertSubitems(igid, language, "PIP", lstnotadded.Items[iidArry[i]].Value, "", "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");
            }
            lstnotadded.Items.Clear();
            lstadded.Items.Clear();
            GetProductGroups(ddl_groups.SelectedValue);
        }
    }

    protected void btnremove_Click(object sender, EventArgs e)
    {



             int[] iidArry = new int[lstadded.Rows + 1];
        iidArry = lstadded.GetSelectedIndices();
        if (iidArry.Length > 0)
        {
            string listIID = "";
            for (int i = 0; i < iidArry.Length; i++)
            {
                listIID += lstadded.Items[iidArry[i]].Value + ",";
            }

            listIID = listIID.Substring(0, listIID.Length - 1);
            string condition = "vskey='PIP' and iid = '" + igid + "' AND VSTITLE in (" + listIID + ") ";
            Subitems.DeleteSubitemsCondition(condition);
            lstnotadded.Items.Clear();
            lstadded.Items.Clear();
            GetProductGroups(ddl_groups.SelectedValue);
        }
    }

    protected void ddl_groups_SelectedIndexChanged(object sender, EventArgs e)
    {
        lstnotadded.Items.Clear();
        lstadded.Items.Clear();
        GetProductGroups(ddl_groups.SelectedValue);
    }

    string  loadDataDetail(string iid)
    {
        string s = "";
        condition = DataExtension.AndConditon(
            ItemsTSql.GetItemsByIid(iid)
        );
        DataTable dt = TatThanhJsc.Database.Items.GetItems("", " * ", condition, "");
        if (dt.Rows.Count > 0)
        {
            s = dt.Rows[0]["VITITLE"].ToString();
        }
        return s;
    }
}