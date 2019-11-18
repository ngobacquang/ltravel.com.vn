using System;
using TatThanhJsc.CruisesModul;

public partial class cms_admin_Cruises_Loadcontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        if(Request.QueryString["suc"] != null)
            suc = Request.QueryString["suc"];

        string app = "";
        if (Request.QueryString["app"] != null)
            app = Request.QueryString["app"];


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

            #region Groups
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

            #region Facility
            case TypePage.Facility:
                phControl.Controls.Add(LoadControl("Facility/ControlFacility.ascx"));
                break;
            case TypePage.UpdateFacility:
            case TypePage.CreateFacility:
                phControl.Controls.Add(LoadControl("Facility/ShortCutFacility.ascx"));
                break;
            case TypePage.RecycleFacility:
                phControl.Controls.Add(LoadControl("Facility/RecycleFacility.ascx"));
                break;
            #endregion

            #region FacilityCabin
            case TypePage.FacilityCabin:
                phControl.Controls.Add(LoadControl("FacilityCabin/ControlFacilityCabin.ascx"));
                break;
            case TypePage.UpdateFacilityCabin:
            case TypePage.CreateFacilityCabin:
                phControl.Controls.Add(LoadControl("FacilityCabin/ShortCutFacilityCabin.ascx"));
                break;
            case TypePage.RecycleFacilityCabin:
                phControl.Controls.Add(LoadControl("FacilityCabin/RecycleFacilityCabin.ascx"));
                break;
            #endregion

            #region Property
            case TypePage.Property:
                phControl.Controls.Add(LoadControl("Property/ControlProperty.ascx"));
                break;
            case TypePage.UpdateProperty:
            case TypePage.CreateProperty:
                phControl.Controls.Add(LoadControl("Property/ShortCutProperty.ascx"));
                break;
            case TypePage.RecycleProperty:
                phControl.Controls.Add(LoadControl("Property/RecycleProperty.ascx"));
                break;
            #endregion

            #region Config
            case TypePage.Configuration:
                phControl.Controls.Add(LoadControl("Config/ControlsConfig.ascx"));
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
      
            default:
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
        }
    }
}
