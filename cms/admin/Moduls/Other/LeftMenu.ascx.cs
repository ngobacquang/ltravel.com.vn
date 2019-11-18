using System;
using TatThanhJsc.OtherModul;

public partial class cms_admin_Moduls_Other_LeftMenu : System.Web.UI.UserControl
{
    protected string suc = "";
    protected string uco = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uco"] != null)
        {
            uco = Request.QueryString["uco"];
        }
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }

        PhManagerApi.Controls.Add(LoadControl("../../../api/SupportOnline/Leftmenu.ascx"));

        SetEnableModul();
    }

    private void SetEnableModul()
    {
        pnSO.Visible = HorizaMenuConfig.ShowSupportOnline;
        pnPsg.Visible = HorizaMenuConfig.ShowPsg;
        pnVote.Visible = HorizaMenuConfig.ShowVote;
        pnSiteMap.Visible = HorizaMenuConfig.ShowSiteMap;
        pnTag.Visible = HorizaMenuConfig.ShowTag;
        pnDcLink.Visible = HorizaMenuConfig.ShowDcLink;
    }

    protected string SetSelected(string ucModul)
    {
        string s = "";
        if (ucModul.Equals(uco))
        {
            s = "sl";
        }
        
        return s;
    }

    protected string SetSelectedSO(string typePage)
    {
        string s = "";
        if (uco.Equals(CodeApplications.SupportOnline) && typePage.Equals(suc))
        {
            s = "sl";
        }
        return s;
    }
}