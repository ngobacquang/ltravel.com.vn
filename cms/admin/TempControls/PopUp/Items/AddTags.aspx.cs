using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_TempControls_PopUp_Items_AddTags : System.Web.UI.Page
{
    private string top = "", fields = "", condition = "", orderby = "";
    private string app = TatThanhJsc.OtherModul.CodeApplications.Tag;

    private string Modul = "";
    private string iid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Modul"] != null)
            Modul = Request.QueryString["Modul"];
        if (Request.QueryString["iid"] != null)
            iid = Request.QueryString["iid"];

        if (!IsPostBack)
        {
            GetListTagModul();
            GetAllTag();
            GetItemInfo();
            CheckTag();
        }
    }

    private void CheckTag()
    {
        DataTable dt = new DataTable();
        condition = DataExtension.AndConditon(GroupsItemsTSql.GetGroupsItemsByIid(iid), GroupsTSql.GetGroupsByVgapp(app));
        dt = GroupsItems.GetAllData("", "groups.igid", condition, "");

        string listIgid = ",";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            listIgid += dt.Rows[i][GroupsColumns.IgidColumn].ToString()+",";
        }

        for (int i = 0; i < cblListTag.Items.Count; i++)
        {
            if (listIgid.IndexOf("," + cblListTag.Items[i].Value + ",") > -1)
                cblListTag.Items[i].Selected = true;
            else
                cblListTag.Items[i].Selected = false;
        }
    }

    private void GetItemInfo()
    {
        ltrTenBaiViet.Text = GetItemName(iid);        
    }

    private string GetItemName(string iid)
    {
        return
            TatThanhJsc.Database.Items.GetItems("1", ItemsColumns.VititleColumn, ItemsTSql.GetItemsByIid(iid), "").Rows[
                0][ItemsColumns.VititleColumn].ToString();
    }

    private void GetListTagModul()
    {
        TagConfig tagcfg=new TagConfig();

        ddlTagModul.Items.Clear();
        for (int i = 0; i < tagcfg.Values.Length; i++)
        {
            ddlTagModul.Items.Add(new ListItem(tagcfg.Text[i],tagcfg.Values[i]));
        }
        if (Modul.Length > 0)
            ddlTagModul.SelectedValue = Modul;
    }

    private void GetAllTag()
    {
        condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByVgapp(app),
            GroupsTSql.GetGroupsByIgparentid("0"),
            GroupsTSql.GetGroupsByIgenable("1")
            );
        if (ddlTagModul.SelectedValue.Length > 0)
            condition = DataExtension.AndConditon(condition, GroupsTSql.GetGroupsByVgparams(ddlTagModul.SelectedValue));
        fields = DataExtension.GetListColumns(GroupsColumns.VgnameColumn, GroupsColumns.IgidColumn);

        orderby = GroupsColumns.VgnameColumn;

        DataTable dt=new DataTable();
        dt = Groups.GetGroups("", fields, condition, orderby);

        cblListTag.DataSource = dt;
        cblListTag.DataTextField = GroupsColumns.VgnameColumn;
        cblListTag.DataValueField = GroupsColumns.IgidColumn;
        cblListTag.DataBind();
    }
    protected void ddlTagModul_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllTag();
        CheckTag();
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        //Xoá các bản ghi trong groups_items có vgapp là TatThanhJsc.OtherModul.CodeApplications.Tag
        DataTable dt=new DataTable();
        condition = DataExtension.AndConditon(GroupsItemsTSql.GetGroupsItemsByIid(iid), GroupsTSql.GetGroupsByVgapp(app));
        dt = GroupsItems.GetAllData("", GroupsItemsColumns.IgiidColumn, condition, "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //Response.Write(dt.Rows[i][GroupsItemsColumns.IgiidColumn].ToString());
            GroupsItems.DeleteGroupsItems(GroupsItemsTSql.GetGroupsItemsByIgiid(dt.Rows[i][GroupsItemsColumns.IgiidColumn].ToString()));
        }

        //Thêm các bản ghi vào groups_items
        for (int i = 0; i < cblListTag.Items.Count; i++)
        {
            if(cblListTag.Items[i].Selected)
                GroupsItems.InsertGroupsItems(cblListTag.Items[i].Value, iid, "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(),"0");
        }

        ScriptManager.RegisterStartupScript(this,this.GetType(),"","alert('Đã lưu tag');window.close();",true);
    }
}