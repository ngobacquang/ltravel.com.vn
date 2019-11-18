using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.FileLibraryModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_FileLibrary_Item_DuyetTin_QuanLyBaiVietDaXuatBan : System.Web.UI.UserControl
{
  protected string app = CodeApplications.FileLibrary;
  protected string pic = FolderPic.FileLibrary;
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string sortCookiesName = " VISEOMETALANG desc ";
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
      tbKeySearch.Text = key;
      tbTitleSearch.Text = name;
      if (NumberShowItem.Length > 0)
      {
        DdlListShowItem.SelectedValue = NumberShowItem;
        DdlListShowItemTop.SelectedValue = NumberShowItem;
      }

      GetGroupsInDdl();
      GetNew("");
    }
  }

  protected string LayInfoNguoiDang(string iid)
  {
    string s = "";
    DataTable dt = new DataTable();
    dt = Users.GetUsersByUserId(iid);

    if (dt.Rows.Count > 0)
      s = dt.Rows[0]["UserFirstName"].ToString() + " " + dt.Rows[0]["UserLastName"].ToString();

    return s;
  }

  protected string LinkUpdate(string iid)
  {
    if (!NumberShowItem.Equals("") && !p.Equals(""))
    {
      return LinkAdmin.GoAdminItem(app, TypePage.UpdateItem, iid, NumberShowItem, p);
    }
    else
    {
      return LinkAdmin.GoAdminItem(app, TypePage.UpdateItem, iid);
    }
  }

  protected string LinkCreate()
  {
    string igidUpdate = "";
    if (!ddlCateSearch.SelectedValue.Equals(""))
    {
      igidUpdate = ddlCateSearch.SelectedValue;
    }
    return LinkAdmin.GoAdminCategory(app, TypePage.CreateItem, igidUpdate);
  }

  void GetNew(string order)
  {
    if (!igid.Equals(""))
    {
      ddlCateSearch.SelectedValue = igid;
      condition = GroupsItemsTSql.GetItemsInGroupCondition(ddlCateSearch.SelectedValue, ItemsTSql.GetItemsByViapp(app));
    }
    else
    {
      condition = DataExtension.AndConditon(
          "VGAPP = '" + app + "'",
          GroupsTSql.GetGroupsByVglang(language));
    }

    condition += " AND IIENABLE = '1' ";

    if (tbKeySearch.Text.Length > 0)
    {
      condition += " AND " + SearchTSql.GetSearchMathedCondition(tbKeySearch.Text, ItemsColumns.VikeyColumn);
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
        orderBy = " VISEOMETALANG desc ";
    }

    DataSet ds = new DataSet();
    ds = GroupsItems.GetAllDataPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
    DataTable dt = new DataTable();
    dt = ds.Tables[1];

    string key = tbKeySearch.Text + "&name=" + tbTitleSearch.Text;
    LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                  Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
                                                  LinkAdmin.UrlAdmin(app, "QuanLyBaiVietDaXuatBan",
                                                               ddlCateSearch.SelectedValue, key,
                                                               NumberShowItem), "currentPS", "otherPS", "firstPS",
                                                  "lastPS", "previewPS", "nextPS");
    LtPaggingTop.Text = LtPagging.Text;
    rp_mn_users.DataSource = ds.Tables[0];
    rp_mn_users.DataBind();
  }

  void GetGroupsInDdl()
  {
    DataTable dt = new DataTable();
    fields = "*";
    condition = DataExtension.AndConditon(
        GroupsTSql.GetGroupsByVglang(language),
        GroupsTSql.GetGroupsByVgapp(app),
        " IGENABLE <> 2 ");
    orderBy = "";
    dt = Groups.GetAllGroups(fields, condition, orderBy);

    ddlCateSearch.Items.Add(new ListItem(Developer.NewKeyword.TatCaDanhMuc, ""));
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      ddlCateSearch.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
    }
    ddlCateSearch.SelectedValue = igid;
  }

  protected void rp_mn_users_ItemCommand(object source, RepeaterCommandEventArgs e)
  {
  }


  protected void lbtName_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.VititleColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại        
    GetNew(order);
  }

  /// ////////////////////////////////////////////////////
  protected void lbtDate_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.VISEOMETALANGColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNew(order);
  }
  protected void lbtView_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(ItemsColumns.IitotalviewColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetNew(order);
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
    Response.Redirect(LinkAdmin.GoAdminCategory(app, "QuanLyBaiVietDaXuatBan", ddlCateSearch.SelectedValue,
                                                "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
  }
}