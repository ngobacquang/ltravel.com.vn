using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.OtherModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Other_Vote_PopUp_AddQuestion : System.Web.UI.Page
{
    private string igid = "";
    private string title = "";

    private string app = CodeApplications.Vote;
    protected string pic = FolderPic.Vote;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["igid"] != null)
        {
            igid = QueryStringExtension.GetQueryString("igid");
        }
        if (Request.QueryString["title"] != null)
        {
            title = QueryStringExtension.GetQueryString("title");
        }
        if (!IsPostBack)
        {
            hdInsertUpdate.Value = "insert";
            LtQuestion.Text = "<div class=\"TtlQuestion\"><b>Câu hỏi:</b> " + title + "</div>";
            GetVotes();
        }
    }

    void GetVotes()
    {
        top = "";
        fields = " * ";

        condition = DataExtension.AndConditon("VGAPP = '" + app + "'", GroupsTSql.GetGroupsByVglang(language));
        orderBy = " DCREATEDATE DESC ";

        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData(top, fields, condition, orderBy);
        
        rp_mn_users.DataSource = dt;
        rp_mn_users.DataBind();
    }

    protected void rp_mn_users_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        fields = "*";
        condition = ItemsTSql.GetItemsCondition(p, app);
        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData(top, fields, condition, orderBy);
        switch (c)
        {
            #region Delete
            case "delete":
                TatThanhJsc.Database.Items.DeleteItems(ItemsTSql.GetItemsByIid(p));
                break;
            #endregion
            #region Edit Enable
            case "EditEnable":
                string[] fieldsEnable = { "IIENABLE" };
                string[] valuesEnable = { "" };
                if (dt.Rows[0]["IIENABLE"].ToString().Equals("0"))
                {
                    valuesEnable[0] = "1";
                    TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                else
                {
                    valuesEnable[0] = "0";
                    TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                GetVotes();
                break;
            #endregion
            #region Edit
            case "edit":
                pnList.Visible = false;
                pnShorcut.Visible = true;
                hdInsertUpdate.Value = "update";
                HdId.Value = dt.Rows[0]["IID"].ToString();
                TbRep.Text = dt.Rows[0]["VITITLE"].ToString();
                if (dt.Rows[0]["IIENABLE"].ToString().Equals("1"))
                {
                    cbEnable.Checked = true;
                }
                else
                {
                    cbEnable.Checked = false;
                }

                break;
            #endregion
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        pnList.Visible = false;
        pnShorcut.Visible = true;
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        string status = "0";
        if (cbEnable.Checked == true)
        {
            status = "1";
        }
        if (hdInsertUpdate.Value.Equals("insert"))
        {
            GroupsItems.InsertItemsGroupsItems(language, app, "", TbRep.Text, "",
                                               "", "", "", "", "",
                                               "", "",
                                               "", "", "", "", "", "",
                                               "0", "0", "", "", "", DateTime.Now.ToString(),
                                               DateTime.Now.ToString(), "", igid, DateTime.Now.ToString(),
                                               DateTime.Now.ToString(), DateTime.Now.ToString(), "", status);    
        }
        else
        {
            GroupsItems.UpdateItemsGroupsItems(language, app, "", TbRep.Text, "",
                                               "", "", "", "", "",
                                               "", "",
                                               "", "", "", "", "", "",
                                               "0", "0", "", "", "", DateTime.Now.ToString(),
                                               DateTime.Now.ToString(), "", igid, DateTime.Now.ToString(),
                                               DateTime.Now.ToString(), DateTime.Now.ToString(), "", status, HdId.Value);
        }
        pnList.Visible = true;
        pnShorcut.Visible = false;
        GetVotes();
    }
}