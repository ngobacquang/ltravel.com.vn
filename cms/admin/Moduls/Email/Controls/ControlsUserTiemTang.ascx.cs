using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
using TatThanhJsc.MemberModul;

public partial class cms_admin_ModulMain_Email_Controls_AdmControlsUserTiemTang : System.Web.UI.UserControl
{
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  private string app = CodeApplications.MemberNewsletter;
  string sortCookiesName = "SortGroupsAcount";
  private string ArrayId = "";
  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderBy = "";

  private string p = "1";
  private string key = "";
  private string NumberShowItem = "10";


  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["p"] != null)
    {
      p = Request.QueryString["p"];
    }
    if (Request.QueryString["key"] != null)
    {
      key = Request.QueryString["key"];
    }
    if (Request.QueryString["NumberShowItem"] != null)
    {
      NumberShowItem = Request.QueryString["NumberShowItem"];
    }

    if (!IsPostBack)
    {
      GetCategories("");
    }
  }
  void GetCategories(string order)
  {
    DdlListShowItem.SelectedValue = NumberShowItem;

    fields = "*";

    condition = DataExtension.AndConditon(
        MembersTSql.GetMembersByVproperty(app),
        MembersColumns.ImemberisapprovedColumn + "<>2");
    if (txtKeySearch.Text.Length > 0 && !txtKeySearch.Text.Equals("Nhập địa chỉ email cần tìm"))
    {
      condition = DataExtension.AndConditon(condition, TatThanhJsc.TSql.SearchTSql.GetSearchMathedCondition(txtKeySearch.Text, MembersColumns.VmemberaccountColumn, MembersColumns.VmembernameColumn));
    }

    #region OrderBy
    if (order.Length > 0)
      orderBy = order;
    else
    {
      orderBy = CookieExtension.GetCookiesSort(sortCookiesName);
      if (orderBy.Length < 1)
        orderBy = MembersColumns.VmemberaccountColumn;
    }
    #endregion

    DataTable dt = new DataTable();

    DataSet ds = Members.GetMembersPaggingCondition(p, NumberShowItem, condition, orderBy);

    dt = ds.Tables[1];


    LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                  Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
                                                  LinkAdmin.UrlAdmin("", TypePage.Item,
                                                               "", key,
                                                               NumberShowItem), "currentPS", "otherPS", "firstPS",
                                                  "lastPS", "previewPS", "nextPS");

    dt = ds.Tables[0];
    rp_mn_users.DataSource = dt;
    rp_mn_users.DataBind();
  }
  protected void DdlListShowItem_SelectedIndexChanged(object sender, EventArgs e)
  {
    NumberShowItem = DdlListShowItem.SelectedValue;
    GetCategories("");
  }
  #region  rp_mn_users_ItemCommand
  protected void rp_mn_users_ItemCommand(object source, RepeaterCommandEventArgs e)
  {
    string c = e.CommandName.Trim();
    string p = e.CommandArgument.ToString().Trim();
    fields = "*";
    DataTable dt = new DataTable();
    dt = Members.GetMembersCondition("", MembersColumns.ImemberisapprovedColumn, MembersTSql.GetMembersByImid(p), "");

    switch (c)
    {
      #region Delete
      case "delete":
        Members.DeleteMembersByIMID(p);
        GetCategories("");
        break;
      #endregion
      #region Edit Status
      case "EditStatus":
        string[] fieldsEditStatus = { "iMemberIsLockedOut" };
        string[] valuesEditStatus = { "" };
        if (dt.Rows[0]["iMemberIsLockedOut"].ToString().Equals("0"))
        {
          valuesEditStatus[0] = "1";
          Members.UpdateMembersCondition(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), condition);
        }
        else
        {
          valuesEditStatus[0] = "0";
          Members.UpdateMembersCondition(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), condition);
        }
        GetCategories("");

        break;
      #endregion
      #region edit
      case "editPassword":
        Response.Redirect(LinkAdmin.GoAdminItem(CodeApplications.Member, TypePage.UpdateItem, p));
        break;
        #endregion
    }
  }
  #endregion

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
    string[] str = ArrayId.Split(Convert.ToChar(","));
    for (int i = 0; i < str.Length; i++)
    {
      Members.DeleteMembersByIMID(str[i]);
    }
    chk_list.Checked = false;
    GetCategories("");
  }

  protected void chk_list_CheckedChanged(object sender, EventArgs e)
  {
    //Đoàn sửa
    for (int i = 0; i < rp_mn_users.Items.Count; i++)
    {
      CheckBox chkDelete = (CheckBox)rp_mn_users.Items[i].FindControl(("chk_item"));
      if (chkDelete != null)
      {
        chkDelete.Checked = chk_list.Checked;
      }
    }
  }

  protected void lbtName_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(MembersColumns.VmemberaccountColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại        
    GetCategories(order);
  }
  protected void lbtStatus_Click(object sender, EventArgs e)
  {
    //Lưu vào cookies
    string order = CookieExtension.SetCookiesSort(MembersColumns.ImemberisapprovedColumn, sortCookiesName);
    //Gọi hàm lấy dữ liệu theo kiểu sắp xếp hiện tại
    GetCategories(order);
  }
  protected void txtKeySearch_TextChanged(object sender, EventArgs e)
  {
    p = "1";
    GetCategories("");
  }
}
