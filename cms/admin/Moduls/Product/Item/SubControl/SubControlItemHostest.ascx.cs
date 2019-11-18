﻿using Developer;
using System;
using System.Data;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.ProductModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Product_Item_SubControl_SubControlItemHostest : System.Web.UI.UserControl
{    
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected string subControlsTitle =ProductKeyword.Product2+ " xem nhiều";
    private string app = CodeApplications.Product;
    private string typeModul = CodeApplications.Product;

    protected string dinhDangNgay = "dd/MM/yyyy";    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uc"] != null)
            dinhDangNgay = "dd/MM/yyyy - hh:mm:ss tt";
        if (!IsPostBack)
        {
            GetItems();
        }
    }

    private string RedirectLink(string iid)
    {        
        return LinkAdmin.GoAdminItem(typeModul, TypePage.UpdateItem, iid);
    }

    void GetItems()
    {
        top = "10";
        fields = "*";
        condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByVgapp(app) + " AND IGENABLE <> '2' AND IIENABLE <> '2' ",
            ItemsTSql.GetItemsByVilang(language),
            ItemsTSql.GetItemsByViapp(app));
        orderBy = ItemsColumns.IitotalviewColumn + " desc";
        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData(top, fields, condition, orderBy);
        if (dt.Rows.Count > 0)
        {
            RpItems.DataSource = dt;
            RpItems.DataBind();
        }
    }

    protected void lbtRefresh_Click(object sender, EventArgs e)
    {
        GetItems();
    }    
}
