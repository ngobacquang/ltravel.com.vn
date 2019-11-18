using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;


public partial class cms_admin_TempControls_PopUp_Cate_TagsInCate : System.Web.UI.Page
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    #region Params On This Page
    private string igid = "-1";
    private string Modul = "";
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["igid"]!=null)        
            igid = QueryStringExtension.GetQueryString("igid");

        if (Request.QueryString["Modul"] != null)
            Modul = Request.QueryString["Modul"];
        
        if (!IsPostBack)
        {
            GetDetailGroups();
            GetAllModul();
            GetListItem(ddlTagModul.SelectedValue);
        }
    }

    //Lấy nhóm modul, đổ vào dropdownlist
    void GetAllModul()
    {
        TagConfig tagcfg = new TagConfig();

        ddlTagModul.Items.Clear();
        for (int i = 0; i < tagcfg.Values.Length; i++)
        {
            ddlTagModul.Items.Add(new ListItem(tagcfg.Text[i], tagcfg.Values[i]));
        }        

        if (Modul.Length > 0)
            ddlTagModul.SelectedValue = Modul;
    }

    //Lấy thông tin của nhóm modul, in ra literal
    void GetDetailGroups()
    {
        DataTable dt = new DataTable();
        fields = "*";
        condition = GroupsTSql.GetGroupsByIgid(igid);
        dt = Groups.GetGroups(top, fields, condition, orderBy);
        if (dt.Rows.Count > 0)
        {
            lt_cate_name.Text = "<div>" + dt.Rows[0]["VGNAME"] + "</div>";
        }
    }

    void GetListItem(string Modul)
    {
        string iid_inListAdded = "";
        fields = " * ";
        condition = GroupsItemsTSql.GetGroupsItemsByIgid(igid);
        DataTable dtProductInCate = new DataTable();
        dtProductInCate = GroupsItems.GetAllData(top, fields, condition, " IORDER ASC, DCREATEDATE DESC ");
        if (dtProductInCate.Rows.Count > 0)
        {
            for (int i = 0; i < dtProductInCate.Rows.Count; i++)
            {
                lstadded.Items.Add(new ListItem(dtProductInCate.Rows[i]["VITITLE"].ToString(), dtProductInCate.Rows[i]["IID"].ToString()));
                iid_inListAdded += dtProductInCate.Rows[i]["IID"].ToString();
                if (i != (dtProductInCate.Rows.Count - 1))
                {
                    iid_inListAdded += ",";
                }

            }
        }

        DataTable dt = new DataTable();
        
        condition = GroupsTSql.GetGroupsByVglang(language);
        if (Modul.Length > 0)
            condition = DataExtension.AndConditon(condition, GroupsTSql.GetGroupsByVgapp(Modul),
                ItemsTSql.GetItemsByViapp(Modul));

        if (!iid_inListAdded.Equals(""))
        {
            condition += "and ITEMS.IID not in(" + iid_inListAdded + ")";
        }

        condition += " AND IGENABLE <> '2' AND IIENABLE <> '2' ";
        dt = GroupsItems.GetAllData("", "*", condition, " IORDER ASC, DCREATEDATE DESC ");
        
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
                GroupsItems.InsertGroupsItems(igid, lstnotadded.Items[iidArry[i]].Value, "", DateTime.Now.ToString(),
                                              DateTime.Now.ToString(), DateTime.Now.ToString(), "");
            }
            lstnotadded.Items.Clear();
            lstadded.Items.Clear();
            GetListItem(ddlTagModul.SelectedValue);
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
            condition = "IGID = '" + igid + "' AND IID in (" + listIID + ") ";

            GroupsItems.DeleteGroupsItems(condition);
            lstnotadded.Items.Clear();
            lstadded.Items.Clear();
            GetListItem(ddlTagModul.SelectedValue);
        }
    }

    protected void ddl_groups_SelectedIndexChanged(object sender, EventArgs e)
    {
        lstnotadded.Items.Clear();
        lstadded.Items.Clear();
        GetListItem(ddlTagModul.SelectedValue);
    }
}