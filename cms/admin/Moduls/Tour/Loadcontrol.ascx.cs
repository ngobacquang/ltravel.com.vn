using System;
using TatThanhJsc.TourModul;

public partial class cms_admin_Tour_Loadcontrol : System.Web.UI.UserControl
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

            #region Vehicle
            case TypePage.Vehicle:
                phControl.Controls.Add(LoadControl("Vehicle/ControlVehicle.ascx"));
                break;
            case TypePage.UpdateVehicle:
            case TypePage.CreateVehicle:
                phControl.Controls.Add(LoadControl("Vehicle/ShortCutVehicle.ascx"));
                break;
            case TypePage.RecycleVehicle:
                phControl.Controls.Add(LoadControl("Vehicle/RecycleVehicle.ascx"));
                break;
            #endregion

            #region Service
            case TypePage.Service:
                phControl.Controls.Add(LoadControl("Service/ControlService.ascx"));
                break;
            case TypePage.UpdateService:
            case TypePage.CreateService:
                phControl.Controls.Add(LoadControl("Service/ShortCutService.ascx"));
                break;
            case TypePage.RecycleService:
                phControl.Controls.Add(LoadControl("Service/RecycleService.ascx"));
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

            #region Comment
            case TypePage.Comment:
                phControl.Controls.Add(LoadControl("Comment/ControlComment.ascx"));
                break;
            case "RecycleComment":
                phControl.Controls.Add(LoadControl("Comment/RecycleComment.ascx"));
                break;
            #endregion

            #region Booking
            case TypePage.Booking:
                phControl.Controls.Add(LoadControl("Booking/ControlBooking.ascx"));
                break;
            case "RecycleBooking":
                phControl.Controls.Add(LoadControl("Booking/RecycleBooking.ascx"));
                break;


            case TypePage.Booking+"02":
                phControl.Controls.Add(LoadControl("Booking/ControlBooking02.ascx"));
                break;
            #endregion

            default:
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
        }
    }
}
