using System;
using TatThanhJsc.MemberModul;


public partial class cms_admin_Moduls_Member_Leftmenu : System.Web.UI.UserControl
{
    private string suc = "";
    private const string uc = CodeApplications.Member;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }

        PhManagerApi.Controls.Add(LoadControl("../../../api/Member/Leftmenu.ascx"));
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

    protected string SetEnableSpaceCate()
    {
        if (suc.Equals("c"))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }

    protected string LinkMnList = "?uc=" + uc + "&suc=" + TypePage.Item;
    protected string LnkMnItemCreate = "?uc=" + uc + "&suc=" + TypePage.CreateItem;
}