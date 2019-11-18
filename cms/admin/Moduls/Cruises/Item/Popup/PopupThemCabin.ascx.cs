using System;
using TatThanhJsc.Extension;

public partial class cms_admin_Moduls_Cruises_Item_Popup_PopupThemCabin : System.Web.UI.UserControl
{
    protected string iid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["iid"] != null)
            iid = StringExtension.RemoveSqlInjectionChars(Request.QueryString["iid"]);
        
        pnCoIid.Visible = (iid != "");
        pnKhongCoIid.Visible = (iid == "");        
    }
}