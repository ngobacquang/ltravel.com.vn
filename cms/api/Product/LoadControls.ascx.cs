using System;

public partial class cms_api_Product_LoadControls : System.Web.UI.UserControl
{
    private string modul = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["modul"] != null)
        {
            modul = Request.QueryString["modul"];
        }
    }
}