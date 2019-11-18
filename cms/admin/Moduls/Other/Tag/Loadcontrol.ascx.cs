using System;
using TatThanhJsc.OtherModul;


public partial class cms_admin_Tag_Loadcontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            #region Api
            case "api":
                phControl.Controls.Add(LoadControl("../../../api/Other/Tag/LoadControls.ascx"));
                break;
            #endregion
            #region Cate
            case TypePage.Cate:
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
            case TypePage.update:
            case TypePage.create:
                phControl.Controls.Add(LoadControl("Cate/ShortCutCate.ascx"));
                break;
            case TypePage.RecycleCate:
                phControl.Controls.Add(LoadControl("Cate/RecycleCate.ascx"));
                break;
            #endregion                                                                       
            
            default:
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
        }
    }
}
