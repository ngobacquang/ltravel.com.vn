using System;
using System.Data;
using Developer;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.FileLibraryModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_FileLibrary_Item_SubControl_SubControlItemLastest : System.Web.UI.UserControl
{    
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected string subControlsTitle =FileLibraryKeyword.FileLibrary2 + " mới cập nhật";
    private string app = CodeApplications.FileLibrary;
    private string typeModul = CodeApplications.FileLibrary;

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
            ItemsTSql.GetItemsByVilang(language));
        orderBy = GroupsItemsColumns.DupdateColumn + " desc";
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
