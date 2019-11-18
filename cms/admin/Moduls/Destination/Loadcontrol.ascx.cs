using System;
using TatThanhJsc.DestinationModul;

public partial class cms_admin_Destination_Loadcontrol : System.Web.UI.UserControl
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
            #region Item
            case TypePage.Item:
                switch(app)
                {
                    case CodeApplications.DestinationNews:
                        phControl.Controls.Add(LoadControl("ItemNews/ControlItem.ascx"));
                        break;
                    case CodeApplications.DestinationVideo:
                        phControl.Controls.Add(LoadControl("ItemVideo/ControlItem.ascx"));
                        break;
                    case CodeApplications.DestinationPhoto:
                        phControl.Controls.Add(LoadControl("ItemPhoto/ControlItem.ascx"));
                        break;
                }
                break;

            case TypePage.UpdateItem:
            case TypePage.CreateItem:                
                switch (app)
                {
                    case CodeApplications.DestinationNews:
                        phControl.Controls.Add(LoadControl("ItemNews/ShortCutItem.ascx"));
                        break;
                    case CodeApplications.DestinationVideo:
                        phControl.Controls.Add(LoadControl("ItemVideo/ShortCutItem.ascx"));
                        break;
                    case CodeApplications.DestinationPhoto:
                        phControl.Controls.Add(LoadControl("ItemPhoto/ShortCutItem.ascx"));
                        break;
                }
                break;
            case TypePage.RecycleItem:
                switch (app)
                {
                    case CodeApplications.DestinationNews:
                        phControl.Controls.Add(LoadControl("ItemNews/RecycleItem.ascx"));
                        break;
                    case CodeApplications.DestinationVideo:
                        phControl.Controls.Add(LoadControl("ItemVideo/RecycleItem.ascx"));
                        break;
                    case CodeApplications.DestinationPhoto:
                        phControl.Controls.Add(LoadControl("ItemPhoto/RecycleItem.ascx"));
                        break;
                }
                
                break;       
            #endregion

            #region Config
            case TypePage.Configuration:
                phControl.Controls.Add(LoadControl("Config/ControlsConfig.ascx"));
                break;          
            #endregion
      
            default:
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
        }
    }
}
