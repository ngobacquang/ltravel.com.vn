using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.OtherModul;

public partial class cms_admin_Moduls_Other_Vote_Loadcontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            #region Cate
            case TypePage.update:
            case TypePage.create:
                phControl.Controls.Add(LoadControl("Cate/ShortCut.ascx"));
                break;
            default:
            case TypePage.Cate:
                phControl.Controls.Add(LoadControl("Cate/Control.ascx"));
                break;
            #endregion
        }
    }
}