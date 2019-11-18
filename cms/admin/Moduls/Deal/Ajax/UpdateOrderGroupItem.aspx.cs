using System;
using System.Data;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.DealModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Deal_Ajax_UpdateOrderGroupItem_Deal : System.Web.UI.Page
{
    cms_admin_Moduls_Deal_GroupItem_ControlGroupItem cateControls=new cms_admin_Moduls_Deal_GroupItem_ControlGroupItem();

    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string Modul = CodeApplications.DealGroupItem;

    string ModulAddItem = CodeApplications.Deal;
    private string igid = "";
    private string igorder = "";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    private string igparentidCurrent = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        igid = Request["igid"];
        igorder = Request["igorder"];
        igparentidCurrent = Request["igparentid"];

        UpdateOrder();

        Response.Write(GetCate());
        Response.End();
    }

    void UpdateOrder()
    {
        string[] fieldsDelGroup = { "IGORDER" };
        string[] valuesDelGroup = { igorder };
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByIgid(igid));
        Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);
    }

    private string LinkAddItemToGroup(string igid, string igparentsid, string title)
    {
        return UrlExtension.WebisteUrl + "cms/admin/TempControls/PopUp/GroupsItems/AddItemsForGroup.aspx?modul=" + ModulAddItem +
               "&igid=" + igid + "&igparentsid=" + igparentsid + "&title=" + title;
    }

    string GetCate()
    {
        string s = "";
        if (igparentidCurrent.Equals("0"))
        {
            DataTable dt = new DataTable();
            fields = "*";
            condition = GroupsTSql.GetGroupsCondition(language, Modul, "", " IGENABLE <> '2' ");
            orderBy = " IGORDER ASC ";
            dt = Groups.GetGroups(top, fields, condition, orderBy);

            if (dt.Rows.Count > 0)
                s += cateControls.DisplayCate(dt);
        }
        else
        {
            s = cateControls.GetSubCate(igparentidCurrent);
        }
        return s;
    }
}