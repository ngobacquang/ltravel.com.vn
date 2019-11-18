using System;

public partial class cms_admin_System_website_AdmLeftMenu : System.Web.UI.UserControl
{
    private string suc = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }
        if (!IsPostBack)
            ShowHidePanel();
    }

    private void ShowHidePanel()
    {
        pnEmail.Visible = HorizaMenuConfig.ShowSystemEmail;
        pnPopup.Visible = HorizaMenuConfig.ShowSystemPopup;
        pnBgSound.Visible = HorizaMenuConfig.ShowSystemBgSound;
    }

    protected string SetSelectedCate(string Values)
    {
        if (suc.Equals(Values))
        {
            return "Selected";
        }
        else
        {
            return "";
        }
    }
}
