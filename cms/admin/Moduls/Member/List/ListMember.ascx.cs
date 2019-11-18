using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.MemberModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Member_Control_ListMember : System.Web.UI.UserControl
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";
    private string p = "1";
    private string NumberShowItem = "10";
    private string key = "";
    private string email = "";    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["p"] != null)
            p = Request.QueryString["p"];
        if (Request.QueryString["NumberShowItem"] != null)
            NumberShowItem = Request.QueryString["NumberShowItem"].ToString();

        email = QueryStringExtension.GetQueryString("email");
        key = QueryStringExtension.GetQueryString("key");
        if (!IsPostBack)
        {
            if (!email.Equals(""))            
                tbEmail.Text = email;    
            
            if (!key.Equals(""))            
                tbKey.Text = key;

            if (NumberShowItem.Length > 0)
            {
                DdlListShowItem.SelectedValue = NumberShowItem;
                DdlListShowItemTop.SelectedValue = NumberShowItem;
            }

            GetListMembers();
        }
    }

    void GetListMembers()
    {
        condition = "";
        if (!tbEmail.Text.Equals(""))
        {
            condition = DataExtension.AndConditon(condition, SearchTSql.GetSearchMathedCondition(email,MembersColumns.vMemberEmail));
        }
        if (!tbKey.Text.Equals(""))
        {
            condition = DataExtension.AndConditon(condition, SearchTSql.GetSearchMathedCondition(tbKey.Text, MembersColumns.vMemberAccount, MembersColumns.vMemberName));
        }
        order = " dMemberCreatedate DESC ";
        DataSet ds = new DataSet();
        ds = Members.GetMembersPaggingCondition(p, DdlListShowItem.SelectedValue, condition, order);
        DataTable dt = new DataTable();
        dt = ds.Tables[0];
        RpListMembers.DataSource = dt;
        RpListMembers.DataBind();

        dt = ds.Tables[1];        
        string key= tbKey.Text+"&email=" + tbEmail.Text;

        LtPagging.Text = PagingExtension.SpilitPages(Convert.ToInt32(dt.Rows[0]["TotalRows"]),
                                                      Convert.ToInt16(DdlListShowItem.SelectedValue), Convert.ToInt32(p),
                                                      LinkAdmin.UrlAdmin(CodeApplications.Member, TypePage.Item,
                                                                   "", key,
                                                                   NumberShowItem), "currentPS", "otherPS", "firstPS",
                                                      "lastPS", "previewPS", "nextPS");
        LtPaggingTop.Text = LtPagging.Text;
    }

    protected string GetStatusMember(string iMemberIsApprovedstring,string iMemberIsLockedOut)
    {
        string s = "";
        if (iMemberIsApprovedstring.Equals("0"))
        {
            s = "Chưa kích hoạt";
        }
        else
        {
            s = "Đã kích hoạt";
            if (iMemberIsLockedOut.Equals("0"))            
                s += "<br/>Đang tạm khóa";            
            else
                s += "<br/>Đang hoạt động";            
        }
        return s;
    }

    protected void RpListMembers_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        top = "";
        fields = "*";
        condition = MembersTSql.GetMembersByImid(p);
        order = "";
        DataTable dt = new DataTable();
        dt = Members.GetMembersCondition(top, fields, condition, order);
        switch (c)
        {
            #region Delete
            case "delete":
                Members.DeleteMembersByIMID(p);
                GetListMembers();

                #region Logs
                string logAuthor = CookieExtension.GetCookies("LoginSetting");
                string logCreateDate = DateTime.Now.ToString();
                Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", dt.Rows[0][MembersColumns.vMemberAccount].ToString(), logAuthor, "", logCreateDate + ": " + logAuthor + " xóa thành viên " + dt.Rows[0][MembersColumns.vMemberAccount].ToString());
                #endregion
                break;
            #endregion
            #region Edit Status
            case "lock":
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
                GetListMembers();

                #region Logs
                logAuthor = CookieExtension.GetCookies("LoginSetting");
                logCreateDate = DateTime.Now.ToString();
                Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", dt.Rows[0][MembersColumns.vMemberAccount].ToString(), logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật trạng thái thành viên " + dt.Rows[0][MembersColumns.vMemberAccount].ToString());
                #endregion
                break;
            #endregion
            #region edit
            case "edit":
                Response.Redirect(LinkAdmin.GoAdminItem(CodeApplications.Member, TypePage.UpdateItem, p));
                break;
                #endregion
        }
    }

    protected void LbTimeRegister_Click(object sender, EventArgs e)
    {

    }

    protected void LbSearch_Click(object sender, EventArgs e)
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

    private void PostSearch()
    {
        key =tbKey.Text+ "&email=" + tbEmail.Text;
        Response.Redirect(LinkAdmin.GoAdminItem(CodeApplications.Member, TypePage.Item, "", DdlListShowItem.SelectedValue, p, key));
    }
}