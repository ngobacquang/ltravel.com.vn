using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Tour_Controls_Category : System.Web.UI.UserControl
{
  #region Các thông số chung
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
  private string title = "";
  private string go = "";

  string igid = "";
  string p = "1";
  int rows = 10;
  string key = "";

  string igidFirst = "";
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

    if (Request.QueryString["p"] != null)
      p = QueryStringExtension.GetQueryString("p");

    if (Request.QueryString["key"] != null)
      key = QueryStringExtension.GetQueryString("key");

    if (!IsPostBack)
    {
      GetCateInfo();
      GetList();     
      ltrText.Text = SettingsExtension.GetSettingKey("NoiDungCuoiTrangDanhSachTour", lang);
    }
  }

  private void GetCateInfo()
  {
    if (Session["dataByTitle_Cate"] != null)
    {
      DataTable dt = (DataTable)Session["dataByTitle_Cate"];
      if (dt.Rows.Count > 0)
      {
        ltrCateName.Text = dt.Rows[0][GroupsColumns.VgName].ToString();
        ltrCateDesc.Text = dt.Rows[0][GroupsColumns.VgDesc].ToString();
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
      string fields = DataExtension.GetListColumns(GroupsColumns.VgName, GroupsColumns.VgDesc, GroupsColumns.IgidColumn);
      string orderby = GroupsColumns.DgCreateDate + " desc";
      DataTable dt = Groups.GetGroups("1", fields, condition, orderby);
      if (dt.Rows.Count > 0)
      {
        igidFirst = dt.Rows[0][GroupsColumns.IgidColumn].ToString();
        ltrCateName.Text = dt.Rows[0][GroupsColumns.VgName].ToString();
        ltrCateDesc.Text = dt.Rows[0][GroupsColumns.VgDesc].ToString();
      }
    }
  }

  #region Get list item
  void GetList()
  {
    #region Condition, orderby
    string condition = "";

    if (igid != "")
      condition = GroupsItemsTSql.GetItemsInGroupCondition(igid, "");
    else
      condition = GroupsTSql.GetGroupsByIgid(igidFirst);

    condition = DataExtension.AndConditon(
        condition,
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByIgenable("1"),
        ItemsTSql.GetItemsByIienable("1"),
        ItemsTSql.GetItemsByViapp(app));

    if (key.Length > 0)
      condition = DataExtension.AndConditon(condition, SearchTSql.GetSearchMathedCondition(key, ItemsColumns.VititleColumn, ItemsColumns.VikeyColumn, ItemsColumns.FipriceColumn, ItemsColumns.FisalepriceColumn));

    string orderby = ItemsColumns.IiorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc ";

    try
    {
      rows = int.Parse(SettingsExtension.GetSettingKey(maxItemKey, lang));
    }
    catch { }
    #endregion

    DataSet ds = GroupsItems.GetAllDataPagging(p, rows.ToString(), condition, orderby);
    if (ds.Tables.Count > 0)
    {
      DataTable dt = ds.Tables[0];
      DataTable dtPager = ds.Tables[1];

      #region Lấy ra danh sách bài viết
      if (dt.Rows.Count > 0)
      {
        string link = "";
        string price = "", salePrice = "";
        string time = "";
        int point = 2;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
          link = (UrlExtension.WebisteUrl + dt.Rows[i][ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();
          price = dt.Rows[i][ItemsColumns.FipriceColumn].ToString();
          salePrice = dt.Rows[i][ItemsColumns.FisalepriceColumn].ToString();

          if (price == "0" || price == "")
          {
            price = "";
            salePrice = LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ");
          }
          else if (salePrice == "0" || salePrice == "")
          {
            salePrice = NumberExtension.FormatNumber(price) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
            price = "";
          }
          else
          {
            price = NumberExtension.FormatNumber(price) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
            salePrice = NumberExtension.FormatNumber(salePrice) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
          }

          time = LayThoiGianTour(dt.Rows[i][ItemsColumns.ViurlColumn].ToString());

          if (i < point)
          {
            ltrList1.Text += @"
          <div class='item item-post item-big'>
            <div class='item-img'>
              <a href='" + link + @"' class='imgc' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"'>
                " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
              </a>
              <div class='item-date'>
                <div>
                  <i class='fa fa-calendar' aria-hidden='true'></i><span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Time") + @": " + time + @"</span>
                </div>
                <div>
                  <i class='fa fa-plane' aria-hidden='true'></i><span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Departure") + @": " + dt.Rows[i][ItemsColumns.VISEOMETAPARAMSColumn] + @"</span>
                </div>
              </div>
            </div>
            <div class='item-body'>
              <h3>
                <a href='" + link + @"' class='title item-title' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
              </h3>
              <p class='item-text'>" + dt.Rows[i][ItemsColumns.VidescColumn].ToString() + @"</p>
              <div class='item-price'>
                <span class='real'>" + salePrice + @"</span>
                <span class='throught'>" + price + @"</span>
              </div>
              <a href='" + link + @"' class='link item-link' title='" + LanguageItemExtension.GetnLanguageItemTitleByName("More") + @"'>" + LanguageItemExtension.GetnLanguageItemTitleByName("More") + @" <i class='fa fa-angle-right' aria-hidden='true'></i>
              </a>
            </div>
          </div>";
          }
          else
          {
            ltrList2.Text += @"
          <div class='col'>
            <div class='item item-post'>
              <div class='item-img'>
                <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='imgc'>
                  " + ImagesExtension.GetImage(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
                </a>
                <div class='item-date'>
                  <div>
                    <i class='fa fa-calendar' aria-hidden='true'></i><span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Time") + @": " + time + @"</span>
                  </div>
                  <div>
                    <i class='fa fa-plane' aria-hidden='true'></i><span>" + LanguageItemExtension.GetnLanguageItemTitleByName("Departure") + @": " + dt.Rows[i][ItemsColumns.VISEOMETAPARAMSColumn] + @"</span>
                  </div>
                </div>
              </div>
              <div class='item-body'>
                <h3>
                  <a href='" + link + @"' class='title item-title' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"'>" + dt.Rows[i][ItemsColumns.VititleColumn] + @"</a>
                </h3>
                <div class='item-price'>
                  <span class='real'>" + salePrice + @"</span>
                  <span class='throught'>" + price + @"</span>
                </div>
                <a href='" + link + @"' class='link item-link' title='" + LanguageItemExtension.GetnLanguageItemTitleByName("More") + @"'>" + LanguageItemExtension.GetnLanguageItemTitleByName("More") + @" <i class='fa fa-angle-right' aria-hidden='true'></i>
                </a>
              </div>
            </div>
          </div>";
          }
        }
      }
      #endregion

      #region Xuất ra phân trang
      if (dtPager.Rows.Count > 0 && dt.Rows.Count > 0)
      {

        string split = PagingExtension.SpilitPages(int.Parse(dtPager.Rows[0]["TotalRows"].ToString()), rows, int.Parse(p), "", "hientai", "trangkhac", "dau", "cuoi", "truoc", "sau");
        if (split.Length > 0)
        {
          int totalPage = 0;
          try
          {
            double totalrow = double.Parse(dtPager.Rows[0]["TotalRows"].ToString());

            totalPage = (int)(totalrow / rows);
            if (totalPage < (totalrow / rows)) totalPage++;
          }
          catch { }

          ltrPaging.Text +=
              PagingExtension02.XuLyPhanTrang(split, dtPager.Rows[0]["TotalRows"].ToString(),
                  (title != "" ? title : go), LanguageItemExtension.GetnLanguageItemTitleByName("Trang đầu"),
                  LanguageItemExtension.GetnLanguageItemTitleByName("Trang cuối"),
                  LanguageItemExtension.GetnLanguageItemTitleByName("Trước"),
                  LanguageItemExtension.GetnLanguageItemTitleByName("Sau"));
        }
        else
        {
          if (dt.Rows.Count < 1)
          {
            ltrNoResult.Text += "<div class='emptyresult'>" + LanguageItemExtension.GetnLanguageItemTitleByName(noResultText) + "</div>";
            pnInfo.Visible = false;
          }
        }
      }
      else
      {
        ltrNoResult.Text += "<div class='emptyresult'>" + LanguageItemExtension.GetnLanguageItemTitleByName(noResultText) + "</div>";
        pnInfo.Visible = false;
      }
      #endregion
    }  
  }
  #endregion

  string LayThoiGianTour(string igid)
  { 
    string s = "";
    DataTable dt = new DataTable();
    string fields = " * ";
    string condition = DataExtension.AndConditon(
      GroupsTSql.GetByApp(TatThanhJsc.TourModul.CodeApplications.TourVehicle),
      GroupsTSql.GetGroupsByIgid(igid),
      GroupsTSql.GetByLang(lang)
    );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    dt = Groups.GetGroups("1", fields, condition, orderBy);

    if (dt.Rows.Count > 0) s = dt.Rows[0][GroupsColumns.VgName].ToString();

    return s;
  }
}