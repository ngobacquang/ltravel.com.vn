using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.MemberModul;


public partial class cms_admin_Moduls_Member_Loadcontrol : System.Web.UI.UserControl
{
    private string suc = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }
        switch (suc)
        {
            case TypePage.Item:
                phControl.Controls.Add(LoadControl("List/ListMember.ascx"));
                break;
            case TypePage.CreateItem:
            case TypePage.UpdateItem:
                phControl.Controls.Add(LoadControl("List/ShortcutMember.ascx"));
                break;

            #region Config
            case TypePage.Configuration:
                phControl.Controls.Add(LoadControl("Config/AdmControlsConfig.ascx"));
                break;
            #endregion

            case "api":
                phControl.Controls.Add(LoadControl("../../../api/Member/LoadControls.ascx"));
                break;

            default:
                phControl.Controls.Add(LoadControl("List/ListMember.ascx"));
                break;
        }
    }


}