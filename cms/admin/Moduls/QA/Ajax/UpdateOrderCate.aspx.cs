﻿using System;
using System.Data;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.QAModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Ajax_Groups_QA_UpdateOrderCate : System.Web.UI.Page
{
    cms_admin_Moduls_QA_Cate_ControlCate cateControls=new cms_admin_Moduls_QA_Cate_ControlCate();    

    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string app = CodeApplications.QA;

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

    string GetCate()
    {
        string s = "";
        if (igparentidCurrent.Equals("0"))
        {
            DataTable dt = new DataTable();
            fields = "*";
            condition = GroupsTSql.GetGroupsCondition(lang, app, "", " IGENABLE <> '2' ");
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