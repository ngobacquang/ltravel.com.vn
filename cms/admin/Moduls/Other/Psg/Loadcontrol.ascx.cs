using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.OtherModul;

public partial class cms_admin_Moduls_Other_Psg_Loadcontrol : System.Web.UI.UserControl
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
                phControl.Controls.Add(LoadControl("ShortCut.ascx"));
                break;
            default:
            case TypePage.Index:
                phControl.Controls.Add(LoadControl("Control.ascx"));
                break;
            #endregion
        }
    }
}