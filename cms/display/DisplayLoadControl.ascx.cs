using System;
using TatThanhJsc.Extension;

public partial class cms_display_DisplayLoadControl : System.Web.UI.UserControl
{
  string go = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["go"] != null)
      go = QueryStringExtension.GetQueryString("go");

    if (go.Length < 1 && Session["go"] != null)
      go = Session["go"].ToString();

    if (go == RewriteExtension.AboutUs)
    {
      phLoadControl.Controls.Add(LoadControl("AboutUs/Controls/LoadControl.ascx"));      
    }

    else if (go == RewriteExtension.Tour)
    {
      phLoadControl.Controls.Add(LoadControl("Tour/Controls/LoadControl.ascx"));
      SubTour_Banner.Visible = true;
    }

    else if (go == RewriteExtension.Service)
      phLoadControl.Controls.Add(LoadControl("Service/Controls/LoadControl.ascx"));

    else if (go == RewriteExtension.Hotel)
      phLoadControl.Controls.Add(LoadControl("Hotel/Controls/LoadControl.ascx"));

    else if (go == RewriteExtension.CustomerReviews)
      phLoadControl.Controls.Add(LoadControl("CustomerReviews/Controls/LoadControl.ascx"));

    else if (go == RewriteExtension.ContactUs)
      phLoadControl.Controls.Add(LoadControl("ContactUs/Controls/LoadControl.ascx"));

    else if (go == "search")
      phLoadControl.Controls.Add(LoadControl("Search/Controls/LoadControl.ascx"));
    else
    {
      phLoadControl.Controls.Add(LoadControl("HomePage/Controls/LoadControl.ascx"));
      CommonPageRoad.Visible = false;
    }
  }
}