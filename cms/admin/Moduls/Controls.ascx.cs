using System;
using TatThanhJsc.Extension;

public partial class cms_admin_Controls : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string userRole = "";
    string uc = "";

    if (Request.QueryString["uc"] != null)
      uc = Request.QueryString["uc"];
    userRole = CookieExtension.GetCookies("RolesUser");
    TatThanhJsc.UserModul.Roles listRoles = new TatThanhJsc.UserModul.Roles();

    switch (uc)
    {
      #region System
      case TatThanhJsc.UserModul.CodeApplications.User:
        if (StringExtension.RoleInListRoles(listRoles.User, userRole) && HorizaMenuConfig.ShowUser)
          phControl.Controls.Add(LoadControl("User/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.SystemWebsiteModul.CodeApplications.Systemwebsite:
        if (StringExtension.RoleInListRoles(listRoles.Systemwebsite, userRole) &&
            HorizaMenuConfig.ShowSystemwebsite)
          phControl.Controls.Add(LoadControl("SystemWebsite/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case "Menu":
        if (StringExtension.RoleInListRoles(listRoles.Menu, userRole) && HorizaMenuConfig.ShowMenu)
          phControl.Controls.Add(LoadControl("Menu/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.ContentModul.CodeApplications.Content:
        if (StringExtension.RoleInListRoles(listRoles.Content, userRole) && HorizaMenuConfig.ShowContent)
          phControl.Controls.Add(LoadControl("Content/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.NewsModul.CodeApplications.News:
        if (StringExtension.RoleInListRoles(listRoles.New, userRole) && HorizaMenuConfig.ShowNew)
          phControl.Controls.Add(LoadControl("New/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.ProductModul.CodeApplications.Product:
        if (StringExtension.RoleInListRoles(listRoles.Product, userRole) && HorizaMenuConfig.ShowProduct)
          phControl.Controls.Add(LoadControl("Product/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.TourModul.CodeApplications.Tour:
        if (StringExtension.RoleInListRoles(listRoles.Tour, userRole) && HorizaMenuConfig.ShowTour)
          phControl.Controls.Add(LoadControl("Tour/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.CruisesModul.CodeApplications.Cruises:
        if (StringExtension.RoleInListRoles(listRoles.Cruises, userRole) && HorizaMenuConfig.ShowCruises)
          phControl.Controls.Add(LoadControl("Cruises/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.HotelModul.CodeApplications.Hotel:
        if (StringExtension.RoleInListRoles(listRoles.Hotel, userRole) && HorizaMenuConfig.ShowHotel)
          phControl.Controls.Add(LoadControl("Hotel/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.ServiceModul.CodeApplications.Service:
        if (StringExtension.RoleInListRoles(listRoles.Service, userRole) && HorizaMenuConfig.ShowService)
          phControl.Controls.Add(LoadControl("Service/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum:
        if (StringExtension.RoleInListRoles(listRoles.PhotoAlbum, userRole) && HorizaMenuConfig.ShowPhotoAlbum)
          phControl.Controls.Add(LoadControl("PhotoAlbum/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary:
        if (StringExtension.RoleInListRoles(listRoles.FileLibrary, userRole) && HorizaMenuConfig.ShowFilelibrary)
          phControl.Controls.Add(LoadControl("FileLibrary/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.VideoModul.CodeApplications.Video:
        if (StringExtension.RoleInListRoles(listRoles.Video, userRole) && HorizaMenuConfig.ShowVideo)
          phControl.Controls.Add(LoadControl("Video/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.AdvertisingModul.CodeApplications.Advertising:
        if (StringExtension.RoleInListRoles(listRoles.Advertising, userRole) && HorizaMenuConfig.ShowAdv)
          phControl.Controls.Add(LoadControl("Advertising/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.ContactModul.CodeApplications.Contact:
        if (StringExtension.RoleInListRoles(listRoles.ContactUs, userRole) && HorizaMenuConfig.ShowContact)
          phControl.Controls.Add(LoadControl("Contact/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.QAModul.CodeApplications.QA:
        if (StringExtension.RoleInListRoles(listRoles.QA, userRole) && HorizaMenuConfig.ShowQA)
          phControl.Controls.Add(LoadControl("QA/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.CustomerModul.CodeApplications.Customer:
        if (StringExtension.RoleInListRoles(listRoles.Customer, userRole) && HorizaMenuConfig.ShowCustomer)
          phControl.Controls.Add(LoadControl("Customer/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.LanguageModul.CodeApplications.Language:
        if (StringExtension.RoleInListRoles(listRoles.Language, userRole) && HorizaMenuConfig.ShowLanguage)
          phControl.Controls.Add(LoadControl("Language/AdmLoadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.MemberModul.CodeApplications.MemberNewsletter: //Gửi email định kỳ
        if (StringExtension.RoleInListRoles(listRoles.Email, userRole) &&
            HorizaMenuConfig.ShowEmail)
          phControl.Controls.Add(LoadControl("Email/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      case TatThanhJsc.MemberModul.CodeApplications.Member:
        if (StringExtension.RoleInListRoles(listRoles.Member, userRole) && HorizaMenuConfig.ShowMember)
          phControl.Controls.Add(LoadControl("Member/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.DealModul.CodeApplications.Deal:
        if (StringExtension.RoleInListRoles(listRoles.Deal, userRole) && HorizaMenuConfig.ShowDeal)
          phControl.Controls.Add(LoadControl("Deal/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case "other":
        if (StringExtension.RoleInListRoles(listRoles.Other, userRole) && HorizaMenuConfig.ShowOther)
          phControl.Controls.Add(LoadControl("Other/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.FileLibrary2Modul.CodeApplications.FileLibrary2:
        if (StringExtension.RoleInListRoles(listRoles.FileLibrary2, userRole) &&
            HorizaMenuConfig.ShowFilelibrary2)
          phControl.Controls.Add(LoadControl("FileLibrary2/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.WebsiteModul.CodeApplications.Website:
        if (StringExtension.RoleInListRoles(listRoles.Website, userRole) && HorizaMenuConfig.ShowWebsite)
          phControl.Controls.Add(LoadControl("Website/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;


      case TatThanhJsc.DestinationModul.CodeApplications.Destination:
        if (StringExtension.RoleInListRoles(listRoles.Destination, userRole) && HorizaMenuConfig.ShowDestination)
          phControl.Controls.Add(LoadControl("Destination/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews:
        if (StringExtension.RoleInListRoles(listRoles.CustomerReviews, userRole) && HorizaMenuConfig.ShowCustomerReviews)
          phControl.Controls.Add(LoadControl("CustomerReviews/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.AboutUsModul.CodeApplications.AboutUs:
        if (StringExtension.RoleInListRoles(listRoles.AboutUs, userRole) && HorizaMenuConfig.ShowAboutUs)
          phControl.Controls.Add(LoadControl("AboutUs/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case TatThanhJsc.BlogModul.CodeApplications.Blog:
        if (StringExtension.RoleInListRoles(listRoles.Blog, userRole) && HorizaMenuConfig.ShowBlog)
          phControl.Controls.Add(LoadControl("Blog/Loadcontrol.ascx"));
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;

      case "DuyetTin":
        if (HorizaMenuConfig.ShowDuyetTin2)
        {
          if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole) || StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
          {
            phControl.Controls.Add(LoadControl("DuyetTin/Loadcontrol.ascx"));
          }
          else
          {
            phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
          }
        }
        else if (HorizaMenuConfig.ShowDuyetTin1)
        {
          if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
          {
            phControl.Controls.Add(LoadControl("DuyetTin/Loadcontrol.ascx"));
          } 
          else
          {
            phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
          }
        }
        else
          phControl.Controls.Add(LoadControl("CommonControls/AdmCautionStop.ascx"));
        break;
      #endregion

      default:
        //phControl.Controls.Add(LoadControl("Homepage/Loadcontrol.ascx"));
        phControl.Controls.Add(LoadControl("AboutUs/Loadcontrol.ascx"));
        break;
    }
  }
}