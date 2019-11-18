using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class cms_admin_ModulMain_User_AdmLoadcontrols : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            case "manager":
                phControl.Controls.Add(LoadControl("Controls/AdmControlsManagerUsers.ascx"));
                break;
            default:
                phControl.Controls.Add(LoadControl("AdmIndex.ascx"));
                break;
        }
    }
}
