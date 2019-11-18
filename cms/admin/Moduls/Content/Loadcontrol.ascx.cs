using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.ContentModul;


public partial class cms_admin_Moduls_Content_Loadcontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            #region Cate
            case TypePage.Cate:
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
            case TypePage.UpdateCate:
            case TypePage.CreateCate:
                phControl.Controls.Add(LoadControl("Cate/ShortCutCate.ascx"));
                break;
            case TypePage.RecycleCate:
                phControl.Controls.Add(LoadControl("Cate/RecycleCate.ascx"));
                break;
            #endregion

            #region Item
            case TypePage.Item:
                phControl.Controls.Add(LoadControl("Item/ControlItem.ascx"));
                break;
            case TypePage.UpdateItem:
            case TypePage.CreateItem:
                phControl.Controls.Add(LoadControl("Item/ShortCutItem.ascx"));
                break;
            case TypePage.RecycleItem:
                phControl.Controls.Add(LoadControl("Item/RecycleItem.ascx"));
                break;
            #endregion

            #region GroupItem
            case TypePage.GroupItem:
                phControl.Controls.Add(LoadControl("GroupItem/ControlGroupItem.ascx"));
                break;
            case TypePage.UpdateGroupItem:
            case TypePage.CreateGroupItem:
                phControl.Controls.Add(LoadControl("GroupItem/ShortCutGroupItem.ascx"));
                break;
            case TypePage.RecycleGroupItem:
                phControl.Controls.Add(LoadControl("GroupItem/RecycleGroupItem.ascx"));
                break;
            #endregion

            case "api":
                phControl.Controls.Add(LoadControl("../../../api/Content/LoadControls.ascx"));
                break;

            default:
                //phControl.Controls.Add(LoadControl("Index.ascx"));
                phControl.Controls.Add(LoadControl("Item/ControlItem.ascx"));
                break;
        }
    }
}