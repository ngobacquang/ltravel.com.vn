using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_CommonControls_CommonPageRoad : System.Web.UI.UserControl
{
  private string rewrite = "";
  private string apptitle = "";
  private string app = "";
  private string page = "";
  private string go = "";

  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["page"] != null)
      page = Request.QueryString["page"];

    if (Request.QueryString["go"] != null)
      go = Request.QueryString["go"];
    if (go == "" && Session["go"] != null)
      go = Session["go"].ToString();

    if (!IsPostBack)
    {
      #region Lấy thông tin tên, rewrite như Sản phẩm, san-pham. Thông tin này đã được xử lý lưu vào session tại Default.aspx
      if (Session["rewrite"] != null)
        rewrite = StringExtension.RemoveSqlInjectionChars(Session["rewrite"].ToString());

      if (Session["apptitle"] != null)
        apptitle = StringExtension.RemoveSqlInjectionChars(Session["apptitle"].ToString());

      if (Session["app"] != null)
        app = StringExtension.RemoveSqlInjectionChars(Session["app"].ToString());
      #endregion

      ltrRoad.Text = GetRoads(false);
    }
  }

  private string GetRoads(bool loadRoadDetail)
  {
    string s = "";

    #region Road trang chủ modul
    if(go == RewriteExtension.Tour)
    {
      s += "<li class='element'><a class='link' href='#!' title='" + apptitle + "'><span>" + apptitle + "</span><i class='fa fa-angle-right' aria-hidden='true'></i></a></li>";
    }
    else
    {
      if (app != "search")
      {
        s += "<li class='element'><a class='link' href='" + UrlExtension.WebisteUrl + rewrite + RewriteExtension.Extensions +
                 "' title='" + apptitle + "'><span>" + apptitle + "</span><i class='fa fa-angle-right' aria-hidden='true'></i></a></li>";
      }
      else
        s += "<li class='element'><a class='link' href='" + UrlExtension.WebisteUrl + "' title='" +
             apptitle + "'>" + apptitle + "<i class='fa fa-angle-right' aria-hidden='true'></i></a></li>";
    }

    #endregion

    if (go == RewriteExtension.AboutUs || go == RewriteExtension.CustomerReviews || go == RewriteExtension.Service)
      return s;

    #region Road danh mục
    DataTable dt = new DataTable();

    //Trường hợp vào trang chi tiết
    if (Session["igid"] != null && Session["iid"] != null && Session["dataByTitle_Cate"] != null)
      dt = (DataTable)Session["dataByTitle_Cate"];
    else
        //Trường hợp không có iid tức là đang vào trang danh mục
        if (Session["iid"] == null && Session["dataByTitle"] != null)
      dt = (DataTable)Session["dataByTitle"];

    if (dt.Rows.Count > 0)
      s += GetCateRoads(dt.Rows[0][GroupsColumns.IgparentsidColumn].ToString());
    #endregion

    #region Road chi tiết
    if (loadRoadDetail)
      if (Session["igid"] != null && Session["iid"] != null && Session["dataByTitle"] != null)
      {
        dt = (DataTable)Session["dataByTitle"];
        if (dt.Rows.Count > 0)
          s += "<li class='element'><a class='link' href='" + UrlExtension.WebisteUrl +
               dt.Rows[0][ItemsColumns.VISEOLINKSEARCHColumn].ToString().ToLower() + RewriteExtension.Extensions +
               "' title='" +
               dt.Rows[0][ItemsColumns.VititleColumn] + "'><span>" + dt.Rows[0][ItemsColumns.VititleColumn] + "</span><i class='fa fa-angle-right' aria-hidden='true'></i></a></li>";
      }
    #endregion

    return s;
  }

  private string GetCateRoads(string igParentId)
  {
    string s = "";
    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByIgenable("1"),
        GroupsTSql.GetGroupsByVgapp(app),
        GroupsTSql.GetGroupsByVglang(lang),
        "charindex(','+cast(" + GroupsColumns.IgidColumn + " as varchar)+',','" + igParentId + "')>0"//Lấy danh sách cha của cate hiện tại
        );
    string orderby = "len(" + GroupsColumns.IgparentsidColumn + ")";//Order theo chiều dài của trường danh sách cha để các cate cha hiện trước

    string fields = DataExtension.GetListColumns(GroupsColumns.VgnameColumn, GroupsColumns.VGSEOLINKSEARCHColumn);

    DataTable dt = Groups.GetGroups("", fields, condition, orderby);
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      s += "<li class='element'><a class='link' href='" + UrlExtension.WebisteUrl + dt.Rows[i][GroupsColumns.VGSEOLINKSEARCHColumn].ToString().ToLower() + RewriteExtension.Extensions + "' title='" +
       dt.Rows[i][GroupsColumns.VgnameColumn] + "'><span>" + dt.Rows[i][GroupsColumns.VgnameColumn] + "</span><i class='fa fa-angle-right' aria-hidden='true'></i></a></li>";
    }

    return s;
  }
}