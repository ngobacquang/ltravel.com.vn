using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.AdvertisingModul;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
using TatThanhJsc.Database;
using TatThanhJsc.Columns;

public partial class cms_admin_Moduls_Advertising_Item_ControlItem : System.Web.UI.UserControl
{
  protected string app = CodeApplications.Advertising;
  protected string pic = FolderPic.Advertising;
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string sortCookiesName = SortKey.SortAdvertisingItems;
  private string p = "1";
  private string NumberShowItem = "10";

  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";

  private string igid = "";

  private string name = "";
  private string ArrayId = "";

  protected string keyAction = "";
  protected string keyStatus = "";
  protected string titleEnable = "Thay đổi trạng thái";

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["p"] != null)
      p = Request.QueryString["p"];
    if (Request.QueryString["igid"] != null)
      igid = Request.QueryString["igid"];
    if (Request.QueryString["name"] != null)
      name = Request.QueryString["name"];
    if (Request.QueryString["NumberShowItem"] != null)
      NumberShowItem = Request.QueryString["NumberShowItem"].ToString();

    if (!IsPostBack)
    {
      tbTitleSearch.Text = name;
      if (NumberShowItem.Length > 0)
      {
        DdlListShowItem.SelectedValue = NumberShowItem;
        DdlListShowItemTop.SelectedValue = NumberShowItem;
      }

      GetQuyenDuyetTin();

      GetGroupsInDdl();
      GetNews("");
    }
  }

  void GetQuyenDuyetTin()
  {
    if (AdvertisingConfig.KeyDuyetTin)
    {
      string userRole = CookieExtension.GetCookies("RolesUser");
      #region Với tính năng duyệt tin 2 cấp (phóng viên, biên tập => trưởng ban biên tập => tổng biên tập)
      if (HorizaMenuConfig.ShowDuyetTin2)
      {
        if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap1, userRole))
        {
          #region Với tài khoản cấp 1 (phóng viên, biên tập)
          keyStatus = PhanQuyen.DuyetTin.Cap1;
          keyAction = "GuiYeuCauPheDuyetQuangCao";
          titleEnable = "Gửi yêu cầu phê duyệt";
          #endregion
        }
        else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
        {
          #region Với tài khoản cấp 2 (trưởng ban biên tập)
          keyStatus = PhanQuyen.DuyetTin.Cap2;
          keyAction = "GuiYeuCauPheDuyetQuangCao";
          titleEnable = "Gửi yêu cầu phê duyệt";
          #endregion
        }
        else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
        {
          #region Với tài khoản cấp 3 (tổng biên tập)
          keyStatus = "0";
          keyAction = "XuatBanQuangCao";
          titleEnable = "Xuất bản quảng cáo";
          #endregion
        }
      }
      #endregion
      #region Với tính năng duyệt tin 1 cấp (phóng viên, biên tập viên => tổng biên tập)
      else if (HorizaMenuConfig.ShowDuyetTin1)
      {
        if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap2, userRole))
        {
          #region Với tài khoản cấp 2 (phóng viên, biên tập)
          keyStatus = PhanQuyen.DuyetTin.Cap2;
          keyAction = "GuiYeuCauPheDuyetQuangCao";
          titleEnable = "Gửi yêu cầu phê duyệt";
          #endregion
        }
        else if (StringExtension.RoleInListRoles(PhanQuyen.DuyetTin.Cap3, userRole))
        {
          #region Với tài khoản cấp 3 (tổng biên tập)
          keyStatus = "0";
          keyAction = "XuatBanQuangCao";
          titleEnable = "Xuất bản quảng cáo";
          #endregion
        }
      }
      #endregion
    }
  }

  protected string GetImageAdv(string pic, string type, string image, string css)
  {
    string s = "";
    if (type == "1")
    {
      s = ImagesExtension.GetImage(pic, image, "", css, false, false, "");
    }
    else
    {
      s = ImagesExtension.GetImageFlash(pic, image, css, false);
    }
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

  void GetNews(string order)
  {
    DdlListShowItem.SelectedValue = NumberShowItem;
    if (!igid.Equals(""))
    {
      ddlCateSearch.SelectedValue = igid;
      condition = GroupsItemsTSql.GetItemsInGroupCondition(ddlCateSearch.SelectedValue, "");
    }
    else
    {
      condition = DataExtension.AndConditon(
          "VGAPP = '" + app + "'",
          GroupsTSql.GetGroupsByVglang(language));
    }
    #region Điều chỉnh bộ lọc với tính năng duyệt tin
    if (AdvertisingConfig.KeyDuyetTin)
    {
      if (HorizaMenuConfig.ShowDuyetTin1 || HorizaMenuConfig.ShowDuyetTin2)
      {
        string userId = CookieExtension.GetCookies("UserId");
        condition += " AND IIENABLE = '0' ";
        condition += " AND VIURL = '" + userId + "' ";
      }
    }
    else
    {
      condition += " AND IIENABLE <> '2' ";
    }
    #endregion

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
        orderBy = GroupsColumns.IgorderColumn + "," + ItemsColumns.DicreatedateColumn + " desc";
    }

    DataSet ds = new DataSet();
    ds = GroupsItems.GetAllDataPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
    DataTable dt = new DataTable();
    dt = ds.Tables[1];

    string key = "&name=" + tbTitleSearch.Text;
    LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                  Convert.ToInt16(NumberShowItem), Convert.ToInt32(p),
                                                  LinkAdmin.UrlAdmin(app, TypePage.Item,
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
    if (dt.Rows.Count > 0)
    {
      ddlCateSearch.Items.Add(new ListItem("Tất cả danh mục quảng cáo", ""));
      for (int i = 0; i < dt.Rows.Count; i++)
      {
        ddlCateSearch.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
      }
    }

    ddlCateSearch.SelectedValue = igid;
  }

  protected void lnk_delete_user_checked_Click(object sender, EventArgs e)
  {
    for (int i = 0; i <= rp_mn_users.Items.Count - 1; i++)
    {
      CheckBox chkDelete = (CheckBox)rp_mn_users.Items[i].FindControl(("chk_item"));
      if (chkDelete != null)
      {
        if (chkDelete.Checked)
        {
          ArrayId += chkDelete.ToolTip;
          ArrayId += ",";
        }
      }
      else
      {
        return;
      }
    }
    if (ArrayId.Length > 0)
    {
      ArrayId = ArrayId.Substring(0, (ArrayId.Length - 1));
    }
    else
    {
      return;
    }
    //condition = " IID in(" + ArrayId + ") ";
    //Đoàn sửa
    char[] splitItem = { ',' };
    foreach (string itemID in ArrayId.Split(splitItem, StringSplitOptions.RemoveEmptyEntries))
    {
      string[] fieldsDelItem = { "IIENABLE", ItemsColumns.DiupdateColumn };
      string[] valuesDelItem = { "2", "'" + DateTime.Now.ToString() + "'" };
      Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelItem, valuesDelItem), ItemsTSql.GetItemsByIid(itemID));
    }

    GetNews("");
  }
  protected void TextChanged(object sender, EventArgs e)
  {
    TextBox textbox = sender as TextBox;
    string[] fields = { "IORDER" };
    string[] values = { textbox.Text };
    string condition = " IGIID = '" + textbox.ToolTip + "' ";
    GroupsItems.UpdateGroupsItemsCondition(DataExtension.UpdateTransfer(fields, values), condition);
    GetNews("");
  }

  protected void rp_mn_users_ItemCommand(object source, RepeaterCommandEventArgs e)
  {
    string c = e.CommandName.Trim();
    string p = e.CommandArgument.ToString().Trim();
    fields = "*";
    condition = ItemsTSql.GetItemsCondition(p, app);

    switch (c)
    {
      #region Delete
      case "delete":
        string[] fieldsDelItem = { "IIENABLE", ItemsColumns.DiupdateColumn };
        string[] valuesDelItem = { "2", "'" + DateTime.Now.ToString() + "'" };

        Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelItem, valuesDelItem), condition);
        GetNews("");
        break;
      #endregion
      #region Edit Enable
      case "EditEnable":
        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData(top, fields, condition, orderBy);

        string[] fieldsEnable = { "IIENABLE" };
        string[] valuesEnable = { "" };
        if (dt.Rows[0]["IIENABLE"].ToString().Equals("0"))
        {
          valuesEnable[0] = "1";
          Items.UpdateItems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
        }
        else
        {
          valuesEnable[0] = "0";
          Items.UpdateItems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
        }
        GetNews("");
        break;
      #endregion
      #region Edit
      case "edit":
        Response.Redirect(LinkUpdate(p));
        break;
        #endregion
    }
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
    string key = "&name=" + tbTitleSearch.Text;
    Response.Redirect(LinkAdmin.GoAdminCategory(CodeApplications.Advertising, TypePage.Item, ddlCateSearch.SelectedValue,
                                                "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
  }
}