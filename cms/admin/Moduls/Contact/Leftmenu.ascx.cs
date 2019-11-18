using System;
using TatThanhJsc.AdminModul;
using TatThanhJsc.ContactModul;


public partial class cms_admin_Moduls_ContactUs_Leftmenu : System.Web.UI.UserControl
{
    private string suc = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
            suc = Request.QueryString["suc"];
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

    protected string SetSelectedRecycleBin()
    {
        if (suc.Equals("RecycleBinMainMenu") || suc.Equals("RecycleBinTopMenu") || suc.Equals("RecycleBinBottomMenu") || suc.Equals("RecycleBinOtherMenu"))
        {
            return "Selected";
        }
        else
        {
            return "";
        }
    }

    protected string SetEnableTool()
    {
        if (suc.Equals("CreateMenuMain"))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }

    protected string SetEnableSpaceCate()
    {
        if (suc.Equals(TypePage.Cate))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }
}