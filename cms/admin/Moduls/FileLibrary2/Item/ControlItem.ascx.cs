using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.FileLibrary2Modul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_FileLibrary2_Item_ControlItem : System.Web.UI.UserControl
{
    protected string app = CodeApplications.FileLibrary2;
    protected string pic = FolderPic.FileLibrary2;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string sortCookiesName = SortKey.SortFileLibrary2Items;
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
            GetFileLibrary2("");
        }
    }

    protected string LinkUpdate(string iid)
    {
        if (!NumberShowItem.Equals("") && !p.Equals(""))
        {
            return LinkAdmin.GoAdminItem(CodeApplications.FileLibrary2, TypePage.UpdateItem, iid, NumberShowItem, p);
        }
        else
        {
            return LinkAdmin.GoAdminItem(CodeApplications.FileLibrary2, TypePage.UpdateItem, iid);
        }
    }

    protected string LinkCreate()
    {
        string igidUpdate = "";
        if (!ddlCateSearch.SelectedValue.Equals(""))
        {
            igidUpdate = ddlCateSearch.SelectedValue;
        }
        return LinkAdmin.GoAdminCategory(CodeApplications.FileLibrary2, TypePage.CreateItem, igidUpdate);
    }

    void GetFileLibrary2(string order)
    {
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
        condition += " AND IIENABLE <> '2' ";
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
                orderBy = " DCREATEDATE DESC ";
        }

        DataSet ds = new DataSet();
        ds = GroupsItems.GetAllDataPagging(p, DdlListShowItem.SelectedValue, condition, orderBy);
        DataTable dt = new DataTable();
        dt = ds.Tables[1];

        string key = tbKeySearch.Text + "&name=" + tbTitleSearch.Text;
        LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                      Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
                                                      LinkAdmin.UrlAdmin(CodeApplications.FileLibrary2, TypePage.Item,
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

        ddlCateSearch.Items.Add(new ListItem(Developer.FileLibrary2Keyword.TatCaDanhMuc, ""));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ddlCateSearch.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
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

        GetFileLibrary2("");
    }
    protected void TextChanged(object sender, EventArgs e)
    {
        TextBox textbox = sender as TextBox;
        string[] fields = { "IORDER" };
        string[] values = { textbox.Text };
        string condition = " IGIID = '" + textbox.ToolTip + "' ";
        GroupsItems.UpdateGroupsItemsCondition(DataExtension.UpdateTransfer(fields, values), condition);
        GetFileLibrary2("");
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
                GetFileLibrary2("");
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
                GetFileLibrary2("");
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
        GetFileLibrary2(order);
    }
    protected void lbtDate_Click(object sender, EventArgs e)
    {
        //Lưu vào cookies
        string order = CookieExtension.SetCookiesSort(ItemsColumns.DicreatedateColumn, sortCookiesName);
        //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
        GetFileLibrary2(order);
    }
    protected void lbtView_Click(object sender, EventArgs e)
    {
        //Lưu vào cookies
        string order = CookieExtension.SetCookiesSort(ItemsColumns.IitotalviewColumn, sortCookiesName);
        //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
        GetFileLibrary2(order);
    }
    protected void lbtStatus_Click(object sender, EventArgs e)
    {
        //Lưu vào cookies
        string order = CookieExtension.SetCookiesSort(ItemsColumns.IienableColumn, sortCookiesName);
        //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
        GetFileLibrary2(order);
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
        Response.Redirect(LinkAdmin.GoAdminCategory(CodeApplications.FileLibrary2, TypePage.Item, ddlCateSearch.SelectedValue,
                                                    "&NumberShowItem=" + DdlListShowItem.SelectedValue, "1", key));
    }
}