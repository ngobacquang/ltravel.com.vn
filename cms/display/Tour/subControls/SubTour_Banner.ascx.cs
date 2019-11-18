using System;
using System.Data;
using System.Globalization;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
public partial class cms_display_Tour_subControls_SubTour_Banner : System.Web.UI.UserControl
{
  #region Các thông số chung
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string title = "";
  private string go = "";

  string igid = "";
  string iid = "";
  string page = "";
  #endregion

  #region Các thông số cần chỉnh theo từng modul (Tour, Tour, Tour...)
  private string app = TatThanhJsc.TourModul.CodeApplications.Tour;
  private string pic = TatThanhJsc.TourModul.FolderPic.Tour;
  private string maxItemKey = TatThanhJsc.TourModul.SettingKey.SoTourTrenTrangDanhMuc;
  private string noResultText = LanguageItemExtension.GetnLanguageItemTitleByName("Nội dung các bài viết thuộc chuyên mục này sẽ được chúng tôi cập nhật sớm. Cảm ơn quý khách đã quan tâm!");
  #endregion
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["igid"] != null)
      igid = QueryStringExtension.GetQueryString("igid");

    if (Request.QueryString["go"] != null)
      go = QueryStringExtension.GetQueryString("go");

    #region title
    if (Request.QueryString["title"] != null)
    {
      title = Request.QueryString["title"];
      //Lấy igid từ session ra vì nó đã dược lưu khi xét tại Default.aspx
      if (igid.Length < 1 && Session["igid"] != null)
        igid = Session["igid"].ToString();

      if (go.Length < 1 && Session["go"] != null)
        go = Session["go"].ToString();
    }
    #endregion

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

    if (!IsPostBack)
    {
      if(page != "s")
        ltrBanner.Text = GetCateInfo();
    }
  }

  private string GetCateInfo()
  {
    string s = "";
    if (Session["dataByTitle_Cate"] != null)
    {
      DataTable dt = (DataTable)Session["dataByTitle_Cate"];
      if (dt.Rows.Count > 0)
      {
        s += @"
        <div class='banner tour'>
          <div class='body'>
            <h1>
              <a href='#' class='title fSize-42 fSize-md-30 fSize-sm-26 txtCenter'>
                <span>" + (page == "d" ? "" : dt.Rows[0][GroupsColumns.VgName].ToString()) + @"</span>
              </a>
            </h1>
            <p class='text  txtCenter nb-color-m0'>" + (page == "d" ? "" : dt.Rows[0][GroupsColumns.VgDesc].ToString()) + @"</p>
          </div>
        </div>";
      }
    }
    else
    {
      string condition = DataExtension.AndConditon(
        GroupsTSql.GetByApp(app),
        GroupsTSql.GetByEnable("1"),
        GroupsTSql.GetByLang(lang),
        GroupsTSql.GetByParentId("0")
      );
      string fields = DataExtension.GetListColumns(GroupsColumns.VgName, GroupsColumns.VgDesc);
      string orderby = GroupsColumns.DgCreateDate + " desc";
      DataTable dt = Groups.GetGroups("1", fields, condition, orderby);
      if (dt.Rows.Count > 0)
      {
        s += @"
        <div class='banner tour'>
          <div class='body'>
            <h1>
              <a href='#' class='title fSize-42 fSize-md-30 fSize-sm-26 txtCenter'>
                <span>" + (page == "d" ? "" : dt.Rows[0][GroupsColumns.VgName].ToString()) + @"</span>
              </a>
            </h1>
            <p class='text  txtCenter nb-color-m0'>" + (page == "d" ? "" : dt.Rows[0][GroupsColumns.VgDesc].ToString()) + @"</p>
          </div>
        </div>";
      }
    }

    return s;
  }
}