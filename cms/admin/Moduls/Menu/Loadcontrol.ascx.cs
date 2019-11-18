using System;
using TatThanhJsc.MenuModul;

public partial class cms_admin_Moduls_Menu_Loadcontrol : System.Web.UI.UserControl
{
    private string uc = "";
    private string suc = "";
    private string app = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uc"] != null)
            uc = Request.QueryString["uc"];

        if (Request.QueryString["suc"] != null)
            suc = Request.QueryString["suc"];

        if (Request.QueryString["app"] != null)
            app = Request.QueryString["app"];
       
        if(app.Length<1)
        {
            app = GetFirstApp();
            Response.Redirect("admin.aspx?uc="+uc+"&app="+app+"&suc="+suc);
            return;
        }
       
        switch (suc)
        {            
            case TypePage.create:
            case TypePage.update:
                string psc = "";
                if (Request.QueryString["psc"] != null)
                    psc = Request.QueryString["psc"];
                if(psc=="1")
                    phControl.Controls.Add(LoadControl("MenuMain/ShortCutMenuMainPsg.ascx"));
                else
                    phControl.Controls.Add(LoadControl("MenuMain/ShortCutMenuMain.ascx"));
                break;
            case TypePage.recycle:
                phControl.Controls.Add(LoadControl("MenuMain/RecycleMenuMain.ascx"));
                break;
            default:
                phControl.Controls.Add(LoadControl("MenuMain/ControlMenuMain.ascx"));              
                break;
        }
    }

    private string GetFirstApp()
    {
        MenuConfig config = new MenuConfig();
        return config.Values[0];
    }
}