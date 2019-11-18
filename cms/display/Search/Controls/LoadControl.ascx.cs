using System;

public partial class cms_display_Search_Controls_LoadControl : System.Web.UI.UserControl
{
  string igid = "";
  string iid = "";
  string page = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["page"] != null) page = Request.QueryString["page"];
    #region title
    if (Request.QueryString["title"] != null)
    {
      if (igid.Length < 1 && Session["igid"] != null) igid = Session["igid"].ToString();
      if (iid.Length < 1 && Session["iid"] != null) iid = Session["iid"].ToString();
      if (page.Length < 1)
      {
        if (igid.Length > 0 && iid.Length < 1) page = "c";
        else page = "d";
      }
    }
    #endregion
    Session["page"] = page;
    switch (page)
    {
      case "d":
        plLoadControl.Controls.Add(LoadControl("Index.ascx"));
        break;
      case "c":
        plLoadControl.Controls.Add(LoadControl("Index.ascx"));
        break;
      default:
        plLoadControl.Controls.Add(LoadControl("Index.ascx"));
        break;
    }
  }
}