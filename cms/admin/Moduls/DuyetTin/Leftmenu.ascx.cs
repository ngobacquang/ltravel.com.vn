using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Extension;
using TatThanhJsc.Database;
using TatThanhJsc.Columns;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_DuyetTin_Leftmenu : System.Web.UI.UserControl
{
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  protected string suc = "";
  protected string uc = "";

  private string modul = "";
  private string DateFrom = "";
  private string DateTo = "";
  private string title = "";
  private string user = "";

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["modul"] != null)
      modul = Request.QueryString["modul"];
    if (Request.QueryString["DateFrom"] != null)
      DateFrom = Request.QueryString["DateFrom"];
    if (Request.QueryString["DateTo"] != null)
      DateTo = Request.QueryString["DateTo"];
    if (Request.QueryString["title"] != null)
      title = Request.QueryString["title"];
    if (Request.QueryString["user"] != null)
      user = Request.QueryString["user"];

    if (Request.QueryString["uc"] != null)
      uc = Request.QueryString["uc"];
    if (Request.QueryString["suc"] != null)
      suc = Request.QueryString["suc"];

    GetModul();
    GetUser();
    GetTotalPost();
    InitForm();
  }

  void GetTotalPost()
  {
    string condition = DataExtension.AndConditon(
        DataExtension.OrConditon(
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.AboutUsModul.CodeApplications.AboutUs),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.AdvertisingModul.CodeApplications.Advertising),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ProductModul.CodeApplications.Product),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.DealModul.CodeApplications.Deal),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.ServiceModul.CodeApplications.Service),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.NewsModul.CodeApplications.News),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.VideoModul.CodeApplications.Video),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.QAModul.CodeApplications.QA),
        GroupsTSql.GetGroupsByVgapp(TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews)
        ),
        GroupsTSql.GetGroupsByVglang(language));

    #region Hiển thị bài đã duyệt theo trạng thái phân quyền
    string userRole = CookieExtension.GetCookies("RolesUser");
    if (HorizaMenuConfig.ShowDuyetTin2)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
      {
        #region Với tài khoản cấp 2 (trưởng ban biên tập)
        condition += " AND IIENABLE = '" + PhanQuyen.DuyetTin.Cap1 + "' ";
        #endregion
      }
      else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
      {
        #region Với tài khoản cấp 3 (tổng biên tập)
        condition += " AND IIENABLE = '" + PhanQuyen.DuyetTin.Cap2 + "' ";
        #endregion
      }
    }
    else if (HorizaMenuConfig.ShowDuyetTin1)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
      {
        #region Với tài khoản cấp 3 (tổng biên tập)
        condition += " AND IIENABLE = '" + PhanQuyen.DuyetTin.Cap2 + "' ";
        #endregion
      }
    }
    #endregion

    string orderBy = " DCREATEDATE DESC ";
    DataTable dt = GroupsItems.GetAllData("", "*", condition, orderBy);
    if(dt.Rows.Count > 0)
      totalPost.Text = " (" + dt.Rows.Count + ")";
  }

  void InitForm()
  {
    if (!title.Equals(""))
      tbTitleSearch.Text = title;

    if (!DateFrom.Equals(""))
      tbDateFrom.Text = DateFrom;

    if (!DateTo.Equals(""))
      tbDateTo.Text = DateTo;
  }

  void GetModul()
  {
    ddlModuleSearch.Items.Add(new ListItem("Tất cả", ""));
    ddlModuleSearch.Items.Add(new ListItem(Developer.AboutUsKeyword.AboutUs, TatThanhJsc.AboutUsModul.CodeApplications.AboutUs));
    ddlModuleSearch.Items.Add(new ListItem(Developer.AdvertisingKeyword.Advertising, TatThanhJsc.AdvertisingModul.CodeApplications.Advertising));
    ddlModuleSearch.Items.Add(new ListItem(Developer.ProductKeyword.Product, TatThanhJsc.ProductModul.CodeApplications.Product));
    ddlModuleSearch.Items.Add(new ListItem(Developer.DealKeyword.Deal, TatThanhJsc.DealModul.CodeApplications.Deal));
    ddlModuleSearch.Items.Add(new ListItem(Developer.FileLibraryKeyword.FileLibrary, TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary));
    ddlModuleSearch.Items.Add(new ListItem(Developer.ServiceKeyword.Service, TatThanhJsc.ServiceModul.CodeApplications.Service));
    ddlModuleSearch.Items.Add(new ListItem(Developer.NewKeyword.New, TatThanhJsc.NewsModul.CodeApplications.News));
    ddlModuleSearch.Items.Add(new ListItem(Developer.PhotoAlbumKeyword.PhotoAlbum, TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum));
    ddlModuleSearch.Items.Add(new ListItem(Developer.VideoKeyword.Video, TatThanhJsc.VideoModul.CodeApplications.Video));
    ddlModuleSearch.Items.Add(new ListItem(Developer.QAKeyword.QA, TatThanhJsc.QAModul.CodeApplications.QA));
    ddlModuleSearch.Items.Add(new ListItem(Developer.CustomerReviewsKeyword.CustomerReviews, TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews));

    if (!modul.Equals(""))
      ddlModuleSearch.SelectedValue = modul;
  }

  void GetUser()
  {
    ddlUserSearch.Items.Add(new ListItem("Tất cả", ""));
    string role = LayRole();
    DataTable dt = RewriteExtension.GetUserByRole(role);

    if(dt.Rows.Count > 0)
    {
      for(int i = 0; i < dt.Rows.Count; i++)
      {
        string username = dt.Rows[i][UsersColumns.UserfirstnameColumn] + " " + dt.Rows[i][UsersColumns.UserlastnameColumn];
        string idUser = dt.Rows[i][UsersColumns.UseridColumn].ToString();
        ddlUserSearch.Items.Add(new ListItem(username, idUser));
      }
    }

    if (!user.Equals(""))
      ddlUserSearch.SelectedValue = user;
  }

  string LayRole()
  {
    string s = "";
    string userRole = CookieExtension.GetCookies("RolesUser");
    if (HorizaMenuConfig.ShowDuyetTin2)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
        s = PhanQuyen.DuyetTin.Cap1;
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
        s = PhanQuyen.DuyetTin.Cap2;
    }
    else if (HorizaMenuConfig.ShowDuyetTin1)
    {
      if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
        s = PhanQuyen.DuyetTin.Cap2;
    }

    return s;
  }

  protected string SetSelectedCate(string Values)
  {
    if (suc.Equals(Values))
    {
      return "Selected";
    }
    else
    {
      return "";
    }
  }

  void PostSearch()
  {
    string key = "modul=" + ddlModuleSearch.SelectedValue + "&user=" + ddlUserSearch.SelectedValue + "&title=" + tbTitleSearch.Text + "&DateFrom=" + tbDateFrom.Text + "&DateTo=" + tbDateTo.Text;
    Response.Redirect(UrlExtension.WebisteUrl + "/admin.aspx?uc=DuyetTin&suc=" + suc + "&p=1&NumberShowItem=10&" + key);
  }

  protected void ltrSearch_Click(object sender, EventArgs e)
  {
    PostSearch();
  }
}