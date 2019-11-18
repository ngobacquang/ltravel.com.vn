using System;

public partial class cms_admin_Hotel_Leftmenu : System.Web.UI.UserControl
{    
    protected string suc = "";
    protected string uc = "";
    protected string app = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["uc"] != null)
            uc = Request.QueryString["uc"];     
        if (Request.QueryString["suc"] != null)        
            suc = Request.QueryString["suc"];
        if (Request.QueryString["app"] != null)
            app = Request.QueryString["app"];
    }

    protected string SetCurrent(string suc, string val)
    {
        if(suc == val)
            return "current";
        return "";
    }
}
