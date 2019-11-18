using System;
using TatThanhJsc.OtherModul;


public partial class cms_admin_SupportOnline_Loadcontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            #region Api
            case "api":
                phControl.Controls.Add(LoadControl("../../../api/SupportOnline/LoadControls.ascx"));
                break;
            #endregion
            #region Cate
            case TypePage.Cate:
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
            case TypePage.UpdateCate:
            case TypePage.CreateCate:
                phControl.Controls.Add(LoadControl("Cate/ShortCutCate.ascx"));
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
            #endregion

            case "ImportCategory"://Nhập tin từ tệp excel
                phControl.Controls.Add(LoadControl("ShortCut/AdmShortCutImportCategory.ascx"));
                break;  
            case "ImportItem"://Nhập tin từ tệp excel
                phControl.Controls.Add(LoadControl("ShortCut/AdmShortCutImportItem.ascx"));
                break;                                                         
            default:
                //phControl.Controls.Add(LoadControl("Index.ascx"));
                phControl.Controls.Add(LoadControl("Item/ControlItem.ascx"));
                break;
        }
    }
}
