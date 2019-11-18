using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TrainTicketModul;
using TatThanhJsc.TSql;

public partial class cms_api_TrainTicket_Item_Index : System.Web.UI.UserControl
{
    // Delegate declaration 
    public delegate void OnButtonClick(string strValue);
    // Event declaration 
    public event OnButtonClick btnHandler;

    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string igid = "";
    private string iid = "";
    private string isid = "";

    private string suc = "";

    private string condition = "";


    private static string CodeApp = CodeApplications.TrainTicket;
    private string keysubitem = "KeySubItem" + CodeApp;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["iid"] != null)
        {
            iid = Request.QueryString["iid"];    
        }
        
        suc = Request.QueryString["suc"];
        if (!IsPostBack)
        {
            if (!iid.Equals(""))
            {
                GetInfoUpdate();
            }
        }
    }
    protected void btnTest_Click(object sender, EventArgs e)
    {
        if (btnHandler != null)
            btnHandler(string.Empty);


        if (suc.Equals(TypePage.UpdateItem))
        {            
            GetInfoUpdate();
            Subitems.DeleteSubitemsCondition(DataExtension.AndConditon(SubitemsTSql.GetSubitemsByIid(iid),
                                                                       SubitemsTSql.GetSubitemsByVskey(keysubitem),
                                             SubitemsTSql.GetSubitemsByVslang(lang)));
            Subitems.InsertSubitems(iid, lang, keysubitem, "", "", "", "", "", "",
                                    DateTime.Now.ToString(), "", "", "1");
        }
        else
        {
            GetIidNew();
            Subitems.InsertSubitems(iid, lang, keysubitem, "", "", "", "", "", "",
                                    "", "", "", "1");

        }
        Response.Redirect(LinkAdmin.GoAdminCategory(CodeApplications.TrainTicket, TypePage.Item, igid));
    }

    void GetIidNew()
    {
        string condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVglang(lang),
                                                    GroupsTSql.GetGroupsByVgapp(CodeApplications.TrainTicket));
        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData(" 1 ", "GROUPS.IGID, ITEMS.IID ", condition, "IID DESC");
        iid = dt.Rows[0]["IID"].ToString();
        igid = dt.Rows[0]["IGID"].ToString();
    }

    void GetInfoUpdate()
    {
        
        condition = DataExtension.AndConditon(SubitemsTSql.GetSubitemsByIid(iid),
                                             SubitemsTSql.GetSubitemsByVskey(keysubitem),
                                             SubitemsTSql.GetSubitemsByVslang(lang));
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("1", " isid, VSTITLE ", condition, "");
        if (dt.Rows.Count > 0)
        {
            isid = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();
        }
    }
}