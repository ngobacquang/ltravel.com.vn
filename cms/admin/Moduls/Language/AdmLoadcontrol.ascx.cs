using System;

public partial class cms_admin_ModulMain_Language_AdmLoadcontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            case "national":
                phControl.Controls.Add(LoadControl("National/List.ascx"));
                break;
            case "UpdateLanguageNational":
            case "CreateLanguageNational":
                phControl.Controls.Add(LoadControl("National/ShortCut.ascx"));
                break;

            case "keyword":
                phControl.Controls.Add(LoadControl("Item/List.ascx"));
                break;
            case "UpdateLanguageItem":
            case "CreateLanguageItem":
                phControl.Controls.Add(LoadControl("Item/ShortCut.ascx"));
                break;

            case "code":
                phControl.Controls.Add(LoadControl("Key/List.ascx"));
                break;
            case "UpdateLanguageKey":
            case "CreateLanguageKey":
                phControl.Controls.Add(LoadControl("Key/ShortCut.ascx"));
                break;

            default:
                phControl.Controls.Add(LoadControl("Item/List.ascx"));
                break;
        }
    }
}
