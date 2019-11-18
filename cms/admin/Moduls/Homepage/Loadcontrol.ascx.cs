using System;

public partial class cms_admin_Homepage_Loadcontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string uc = "";
        if(Request.QueryString["uc"]!=null)
            uc = Request.QueryString["uc"].ToLower();
        switch (uc)
        {
            #region Config
            case "config":
                phControl.Controls.Add(LoadControl("Config/AdmControlsConfig.ascx"));
                break;          
            #endregion
               
            default:
                phControl.Controls.Add(LoadControl("Index.ascx"));                
                break;
        }
    }
}
