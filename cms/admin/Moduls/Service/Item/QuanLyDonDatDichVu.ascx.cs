using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.ServiceModul;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
using TatThanhJsc.Database;
using TatThanhJsc.Columns;

public partial class cms_admin_Moduls_Service_Item_QuanLyDonDatDichVu : System.Web.UI.UserControl
{
  private string app = CodeApplications.Service;
  protected string pic = FolderPic.Service;
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string sortCookiesName = SortKey.SortServiceItems;
  private string p = "1";
  private string NumberShowItem = "10";

  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";

  private string igid = "";

  private string key = "";
  private string name = "";
  private string ArrayId = "";

  private string strdisplay = "Nhập từ khóa tìm kiếm";

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["p"] != null)
      p = Request.QueryString["p"];
    if (Request.QueryString["igid"] != null)
      igid = Request.QueryString["igid"];
    if (Request.QueryString["key"] != null)
      key = Request.QueryString["key"];
    if (Request.QueryString["name"] != null)
      name = Request.QueryString["name"];
    if (Request.QueryString["NumberShowItem"] != null)
      NumberShowItem = Request.QueryString["NumberShowItem"].ToString();

    if (!IsPostBack)
    {
      if (NumberShowItem.Length > 0)
      {
        DdlListShowItem.SelectedValue = NumberShowItem;
        DdlListShowItemTop.SelectedValue = NumberShowItem;
      }

      GetNews("");
    }
  }

  protected string LinkUpdate(string iid)
  {
    if (!NumberShowItem.Equals("") && !p.Equals(""))
    {
      return LinkAdmin.GoAdminItem(app, "QuanLyDonDatDichVu", iid, NumberShowItem, p);
    }
    else
    {
      return LinkAdmin.GoAdminItem(app, "QuanLyDonDatDichVu", iid);
    }
  }

  private string LinkCreate()
  {
    string igidUpdate = "";
    return LinkAdmin.GoAdminCategory(app, "QuanLyDonDatDichVu", igidUpdate);
  }

  void GetNews(string order)
  {
    DdlListShowItem.SelectedValue = NumberShowItem;

    condition = DataExtension.AndConditon(
          "VIAPP = 'QLDDDV'",
          ItemsTSql.GetByLang(language));

    condition += " AND IIENABLE <> '2' ";

    if (tbKeySearch.Text.Length > 0)
    {
      condition += " AND " + SearchTSql.GetSearchMathedCondition(tbKeySearch.Text, ItemsColumns.ViauthorColumn);
    }
    if (tbTitleSearch.Text.Length > 0)
    {
      condition += " AND " + SearchTSql.GetSearchMathedCondition(tbTitleSearch.Text, ItemsColumns.VititleColumn);
    }
    if (order.Length > 0)
      orderBy = order;
    else
    {
      orderBy = CookieExtension.GetCookiesSort(sortCookiesName);
      if (orderBy.Length < 1)
        orderBy = " DCREATEDATE DESC ";
    }

    DataSet ds = new DataSet();
    ds = GroupsItems.GetAllDataPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
    DataTable dt = new DataTable();
    dt = ds.Tables[1];

    string key = tbKeySearch.Text + "&name=" + tbTitleSearch.Text;
    LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                  Convert.ToInt16(NumberShowItem), Convert.ToInt32(p),
                                                  LinkAdmin.UrlAdmin(CodeApplications.Service, "QuanLyDonDatDichVu",
                                                               "", key,
                                                               NumberShowItem), "currentPS", "otherPS", "firstPS",
                                                  "lastPS", "previewPS", "nextPS");
    LtPaggingTop.Text = LtPagging.Text;
    rp_mn_users.DataSource = ds.Tables[0];
    rp_mn_users.DataBind();
  }

  protected void rp_mn_users_ItemCommand(object source, RepeaterCommandEventArgs e)
  {
  }

  protected void lbtName_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.VititleColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại        
    GetNews(order);
  }
  protected void lbtDate_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.DicreatedateColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNews(order);
  }
  protected void lbtView_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.IitotalviewColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNews(order);
  }
  protected void lbtStatus_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.IienableColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNews(order);
  }

  protected void ltrSearch_Click(object sender, EventArgs e)
  {
    PostSearch();
  }

  protected void DdlListShowItem_SelectedIndexChanged(object sender, EventArgs e)
  {
    PostSearch();
  }

  protected void DdlListShowItemTop_SelectedIndexChanged(object sender, EventArgs e)
  {
    DdlListShowItem.SelectedValue = DdlListShowItemTop.SelectedValue;
    PostSearch();
  }
  void PostSearch()
  {
    string key = tbKeySearch.Text + "&name=" + tbTitleSearch.Text;
    Response.Redirect(LinkAdmin.GoAdminCategory(app, "QuanLyDonDatDichVu", "",
                                                "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
  }
}