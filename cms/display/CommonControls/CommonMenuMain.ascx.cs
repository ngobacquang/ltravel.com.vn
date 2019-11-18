using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_CommonControls_CommonMenuMain : System.Web.UI.UserControl
{
  string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  string app = TatThanhJsc.MenuModul.CodeApplications.MenuMain;
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
      ltrList.Text = LoadMenu();
  }

  protected string LoadMenu()
  {
    string top = "";
    string field = "*";
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByIgparentid("0"),
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVglang(lang));

    string orderby = GroupsColumns.IgorderColumn;
    DataTable dt = Groups.GetGroups(top, field, condition, orderby);
    string s = "";

    if (dt.Rows.Count > 0)
    {
      string link = "";
      string subMenus = "";
      for (int i = 0; i < dt.Rows.Count; i++)
      {
        link = RewriteExtension.GetLinkMenu(dt.Rows[i][GroupsColumns.VgdescColumn].ToString());

        subMenus = LoadChildMenu(dt.Rows[i][GroupsColumns.IgidColumn].ToString(),
            dt.Rows[i][GroupsColumns.VgdescColumn].ToString(), "", "1");

        s += @"
        <li class='litop item " + (subMenus != "" ? "nb-dropdown" : "") + @"'>
          <a class='item-link' href='" + link + @"' " + MenuExtension.GetTarget(dt.Rows[i][GroupsColumns.VgparamsColumn].ToString()) + @" title='" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"'>
            <span>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</span>
          </a>
          " + subMenus + @"
        </li>";
      }
    }
    return s;
  }
  protected string LoadChildMenu(string igParentId, string vgdesc, string rewrite, string layMenuConTheoDanhMuc)
  {
    string top = "";
    string field = "*";
    string orderby = GroupsColumns.IgorderColumn;
    string condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByIgenable("1"),
            GroupsTSql.GetGroupsByVglang(lang));

    #region Xét điều kiện lấy các danh mục con nếu menu trỏ đến trang chủ của các modul        

    if (layMenuConTheoDanhMuc == "1")
    {
      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.News)
      {
        rewrite = RewriteExtension.News;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.NewsModul.CodeApplications.News),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Product)
      {
        rewrite = RewriteExtension.Product;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ProductModul.CodeApplications.Product),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      //else
      //    if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Service)
      //{
      //  rewrite = RewriteExtension.Service;
      //  condition = DataExtension.AndConditon(condition,
      //      GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ServiceModul.CodeApplications.Service),
      //      GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      //}
      else
              if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Video)
      {
        rewrite = RewriteExtension.Video;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.VideoModul.CodeApplications.Video),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));

      }
      else
                  if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.PhotoAlbum)
      {
        rewrite = RewriteExtension.PhotoAlbum;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.FileLibrary)
      {
        rewrite = RewriteExtension.FileLibrary;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                          if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.QA)
      {
        rewrite = RewriteExtension.QA;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.QAModul.CodeApplications.QA),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                              if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Customer)
      {
        rewrite = RewriteExtension.Customer;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.CustomerModul.CodeApplications.Customer),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                                  if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Hotel)
      {
        rewrite = RewriteExtension.Hotel;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.HotelModul.CodeApplications.Hotel),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                                      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Tour)
      {
        rewrite = RewriteExtension.Tour;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.TourModul.CodeApplications.Tour),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      //else
  //if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.AboutUs)
  //    {
  //        rewrite = RewriteExtension.AboutUs;
  //        condition = DataExtension.AndConditon(condition,
  //            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.AboutUsModul.CodeApplications.AboutUs),
  //            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
  //    }
  //else
  //if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.CustomerReviews)
  //    {
  //      rewrite = RewriteExtension.CustomerReviews;
  //      condition = DataExtension.AndConditon(condition,
  //          GroupsTSql.GetGroupsByVgapp(TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews),
  //          GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
  //    }
      else
      {
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByIgparentid(igParentId));
      }
    }
    else
    {
      condition = DataExtension.AndConditon(condition,
          GroupsTSql.GetGroupsByIgparentid(igParentId));
    }

    #endregion

    DataTable dt = Groups.GetGroups(top, field, condition, orderby);
    string s = "";
    if (dt.Rows.Count > 0)
    {
      string link = "";
      s += @"
      <i class='fa fa-angle-down' aria-hidden='true'></i>
      <div class='sub-menu-1'>
        <ul class='sublist'>";
      for (int i = 0; i < dt.Rows.Count; i++)
      {
        if (rewrite.Length < 1)
          link = RewriteExtension.GetLinkMenu(dt.Rows[i][GroupsColumns.VgdescColumn].ToString());
        else
          link = (UrlExtension.WebisteUrl + dt.Rows[i][GroupsColumns.VGSEOLINKSEARCHColumn] +
               RewriteExtension.Extensions).ToLower();

        s += @"
        <li class='sub-item'>
          <a class='subitem-link' href='" + link + "' " + MenuExtension.GetTarget(dt.Rows[i][GroupsColumns.VgparamsColumn].ToString()) + @" title='" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"'>
            <i class='fa fa-angle-right' aria-hidden='true'></i>
            <span>" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</span>
          </a>
        </li>";
      }
      s += "</ul></div>";
    }
    return s;
  }

  protected string LoadChildMenu02(string igParentId, string vgdesc, string rewrite, string layMenuConTheoDanhMuc)
  {
    string top = "";
    string field = "*";
    string orderby = GroupsColumns.IgorderColumn;
    string condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByIgenable("1"),
            GroupsTSql.GetGroupsByVglang(lang));

    #region Xét điều kiện lấy các danh mục con nếu menu trỏ đến trang chủ của các modul        

    if (layMenuConTheoDanhMuc == "1")
    {
      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.News)
      {
        rewrite = RewriteExtension.News;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.NewsModul.CodeApplications.News),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Product)
      {
        rewrite = RewriteExtension.Product;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ProductModul.CodeApplications.Product),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
          if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Service)
      {
        rewrite = RewriteExtension.Service;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ServiceModul.CodeApplications.Service),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
              if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Video)
      {
        rewrite = RewriteExtension.Video;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.VideoModul.CodeApplications.Video),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));

      }
      else
                  if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.PhotoAlbum)
      {
        rewrite = RewriteExtension.PhotoAlbum;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.FileLibrary)
      {
        rewrite = RewriteExtension.FileLibrary;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                          if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.QA)
      {
        rewrite = RewriteExtension.QA;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.QAModul.CodeApplications.QA),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                              if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Customer)
      {
        rewrite = RewriteExtension.Customer;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.CustomerModul.CodeApplications.Customer),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                                  if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Hotel)
      {
        rewrite = RewriteExtension.Hotel;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.HotelModul.CodeApplications.Hotel),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
                                      if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.Tour)
      {
        rewrite = RewriteExtension.Tour;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.TourModul.CodeApplications.Tour),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
  //if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.AboutUs)
  //    {
  //        rewrite = RewriteExtension.AboutUs;
  //        condition = DataExtension.AndConditon(condition,
  //            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.AboutUsModul.CodeApplications.AboutUs),
  //            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
  //    }
  //    else
  if (MenuExtension.GetQueryString(vgdesc, "go") == RewriteExtension.CustomerReviews)
      {
        rewrite = RewriteExtension.CustomerReviews;
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByVgapp(TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews),
            GroupsTSql.GetGroupsByIgparentid(MenuExtension.GetIgidInVgdesc(vgdesc)));
      }
      else
      {
        condition = DataExtension.AndConditon(condition,
            GroupsTSql.GetGroupsByIgparentid(igParentId));
      }
    }
    else
    {
      condition = DataExtension.AndConditon(condition,
          GroupsTSql.GetGroupsByIgparentid(igParentId));
    }

    #endregion

    DataTable dt = Groups.GetGroups(top, field, condition, orderby);
    string s = "";
    if (dt.Rows.Count > 0)
    {
      string link = "";
      s += "<div class='item'>";
      for (int i = 0; i < dt.Rows.Count; i++)
      {
        if (rewrite.Length < 1)
          link = RewriteExtension.GetLinkMenu(dt.Rows[i][GroupsColumns.VgdescColumn].ToString());
        else
          link =
              (UrlExtension.WebisteUrl + dt.Rows[i][GroupsColumns.VGSEOLINKSEARCHColumn] +
               RewriteExtension.Extensions).ToLower();

        s += @"
<a class='name' title='" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"' href='" + link + "' " + MenuExtension.GetTarget(dt.Rows[i][GroupsColumns.VgparamsColumn].ToString()) + @">" + dt.Rows[i][GroupsColumns.VgnameColumn] + @"</a>";
      }
      s += "</div>";
    }
    return s;
  }
}