using Developer;
using System;
using System.Data;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.ProductModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Product_Item_SubControl_SubControlComment : System.Web.UI.UserControl
{    
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected string subControlsTitle = "Phản hồi " + ProductKeyword.Product2 + " mới";
    private string app = CodeApplications.ProductComment;
    private string typeModul = CodeApplications.Product;


    protected void Page_Load(object sender, EventArgs e)
    {
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
           SubitemsTSql.GetSubitemsByVskey(app),
           SubitemsTSql.GetSubitemsByVslang(language));
        orderBy = SubitemsColumns.DscreatedateColumn + " desc ";
        
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems(top, fields, condition, orderBy);
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
