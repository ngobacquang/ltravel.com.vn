using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Search_Controls_Index : System.Web.UI.UserControl
{
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();

  protected string title = "";
  string igid = "";
  string p = "1";
  int rows = 20;

  string diemden = "";
  string thoigian = "";

  protected void Page_Load(object sender, EventArgs e)
  {

    if (Request.QueryString["p"] != null)
      p = QueryStringExtension.GetQueryString("p");

    if (Request.QueryString["diemden"] != null)
      diemden = QueryStringExtension.GetQueryString("diemden");

    if (Request.QueryString["thoigian"] != null)
      thoigian = QueryStringExtension.GetQueryString("thoigian");

    if (!IsPostBack)
    {
      ltrList.Text = GetList();
    }
  }

  string GetList()
  {
    string s = "";

    string condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.TourModul.CodeApplications.Tour),
        GroupsTSql.GetGroupsByVglang(lang),
        GroupsTSql.GetGroupsByIgenable("1"),
        ItemsTSql.GetItemsByIienable("1"));

    if (diemden.Length > 0)
    {
      condition += " AND VIAUTHOR = '" + diemden + "' ";
      ltrDiemDen.Text = LanguageItemExtension.GetnLanguageItemTitleByName("tới địa điểm ") + "<strong>" + LayDiemDen(diemden) + "</strong>";
    }

    if (thoigian.Length > 0)
    {
      condition += " AND VIURL = '" + thoigian + "' ";
      ltrThoiGian.Text = LanguageItemExtension.GetnLanguageItemTitleByName("với thời lượng ") + "<strong>" + LayThoiGianTour(thoigian) + "</strong>";
    }

    string orderby = ItemsColumns.DicreatedateColumn + " desc ";


    DataSet ds = GroupsItems.GetAllDataPagging(p, rows.ToString(), condition, orderby);

    ltrTotalResult.Text = NumberExtension.FormatNumber(ds.Tables[1].Rows[0]["TotalRows"].ToString());
    if (ds.Tables.Count > 0)
    {
      DataTable dt = ds.Tables[0];
      DataTable dtPager = ds.Tables[1];
      if (dtPager.Rows.Count > 0 && dt.Rows.Count > 0)
      {

        string split = PagingExtension.SpilitPages(int.Parse(dtPager.Rows[0]["TotalRows"].ToString()), rows, int.Parse(p), "?go=search&diemden=" + diemden + "&thoigian=" + thoigian, "hientai", "trangkhac", "dau", "cuoi", "truoc", "sau");
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
          ltrPagging.Text = split;
        }
        else
        {
          if (dt.Rows.Count < 1)
            ltrPagging.Text = "";
          else
            ltrPagging.Text = "";
        }
      }
      else
      {
        ltrPagging.Text = "";
      }
      if (dt.Rows.Count > 0)
      {
        string link = "";
        string price = "", salePrice = "";
        string time = "";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
          link = (UrlExtension.WebisteUrl + dt.Rows[i][ItemsColumns.VISEOLINKSEARCHColumn] + RewriteExtension.Extensions).ToLower();
          price = dt.Rows[i][ItemsColumns.FipriceColumn].ToString() == "0" ? "" : NumberExtension.FormatNumber(dt.Rows[i][ItemsColumns.FipriceColumn].ToString()) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
          salePrice = dt.Rows[i][ItemsColumns.FisalepriceColumn].ToString() == "0" ? LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ") : NumberExtension.FormatNumber(dt.Rows[i][ItemsColumns.FisalepriceColumn].ToString()) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");

          time = LayThoiGianTour(dt.Rows[i][ItemsColumns.ViurlColumn].ToString());
          s += @"
          <div class='col'>
            <div class='item item-post'>
              <div class='item-img'>
                <a href='" + link + @"' title='" + dt.Rows[i][ItemsColumns.VititleColumn] + @"' class='imgc'>
                  " + ImagesExtension.GetImage(TatThanhJsc.TourModul.FolderPic.Tour, dt.Rows[i][ItemsColumns.ViimageColumn].ToString(), dt.Rows[i][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
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

    return s;
  }

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

  string LayDiemDen(string igid)
  {
    string s = "";
    DataTable dt = new DataTable();
    string fields = " * ";
    string condition = DataExtension.AndConditon(
      GroupsTSql.GetByApp(TatThanhJsc.TourModul.CodeApplications.TourProperty),
      GroupsTSql.GetGroupsByIgid(igid),
      GroupsTSql.GetByLang(lang)
    );
    string orderBy = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;
    dt = Groups.GetGroups("1", fields, condition, orderBy);

    if (dt.Rows.Count > 0) s = dt.Rows[0][GroupsColumns.VgName].ToString();

    return s;
  }
}