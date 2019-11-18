using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.CustomerModul;
using TatThanhJsc.TSql;

public partial class cms_admin_ModulMain_Customer_PopUp_Items_ViewComments : System.Web.UI.Page
{
    string top = "";
    string fields = "";
    string orderby = "";
    string condition = "";
    string app = CodeApplications.CustomerComment;
    string iid = "";
    string isid = "";
    string pic = FolderPic.Customer;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["iid"] != null)
            iid = Request.QueryString["iid"].ToString();
        if (Request.QueryString["isid"] != null)
            isid = Request.QueryString["isid"].ToString();
        if (!IsPostBack)
        {
            GetItemsInfo();
            GetListComments();
        }
    }
    /// <summary>
    /// Danh dau comment duoc chon de xem
    /// </summary>
    /// <param name="idOfCommnet"></param>
    /// <returns></returns>
    protected string currentCommentView(string idOfCommnet)
    {
        if (idOfCommnet == isid)
            return "currentCommnet";
        else
            return "";
    }
    #region GetItemsInfo
    void GetItemsInfo()
    {
        fields = DataExtension.GetListColumns(ItemsColumns.VititleColumn, ItemsColumns.DicreatedateColumn);
        DataTable dt = new DataTable();
        dt =TatThanhJsc.Database.Items.GetItems("", "*", ItemsTSql.GetItemsByIid(iid), "");
        #region ThongTinCoBan
        ltrHotelName.Text = @"
<div class='fwb'>
    Thông tin :
</div>
<div class='cbh20'><!----></div>
<div class='fwb'>
    " + dt.Rows[0][ItemsColumns.VititleColumn].ToString() + @"
</div>
<div class='cbh5'><!----></div>
<div style='font:11px Tahoma;color:#0e0e0e;'>
    Ngày đăng: " + ((DateTime)dt.Rows[0][ItemsColumns.DicreatedateColumn]).ToString("dd/MM/yyyy") + @" - Lượt xem: " + dt.Rows[0][ItemsColumns.IitotalviewColumn].ToString() + @"
</div>
<div class='cbh5'><!----></div>
<div style='font:12px/18px Tahoma;color:#000;'>
    " + dt.Rows[0][ItemsColumns.VicontentColumn].ToString() + @"
</div>
<div class='cbh20'><!----></div>
";
        #endregion
    }
    #endregion    
    void GetListComments()
    {
        condition = DataExtension.AndConditon
            (
            SubitemsTSql.GetSubitemsByIid(iid),
            SubitemsTSql.GetSubitemsByVskey(app)
            );
        orderby = SubitemsColumns.DscreatedateColumn+ " desc ";
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("", "*", condition, orderby);
        rptList.DataSource = dt;
        rptList.DataBind();
    }
    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        fields = "*";
        condition = SubitemsTSql.GetSubitemsByIsid(p);

        switch (c)
        {
            #region Delete
            case "delete":
                DeleteComment(p);
                GetListComments();
                break;
            #endregion
            #region Edit Enable
            case "EditEnable":
                DataTable dt = new DataTable();
                dt = Subitems.GetSubItems("", SubitemsColumns.IsenableColumn, condition, "");
                string[] fieldsEnable = { SubitemsColumns.IsenableColumn };
                string[] valuesEnable = { "" };
                if (dt.Rows[0][SubitemsColumns.IsenableColumn].ToString().Equals("0"))
                {
                    valuesEnable[0] = "1";
                    Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                else
                {
                    valuesEnable[0] = "0";
                    Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                GetListComments();
                break;
            #endregion
        }
    }

    void DeleteComment(string isid)
    {
        #region Xoá trả lời của comment
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems("", "*", DataExtension.AndConditon(SubitemsTSql.GetSubitemsByVskey(app + "Reply"), SubitemsTSql.GetSubitemsByVsurl(isid)), "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            TatThanhJsc.Extension.ImagesExtension.DeleteImageWhenDeleteItem(pic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString());
            Subitems.DeleteSubitems(dt.Rows[i][SubitemsColumns.IsidColumn].ToString());
        }
        #endregion
        Subitems.DeleteSubitems(isid);
    }

    protected void btDelete_Click(object sender, EventArgs e)
    {
        string ArrayId = "";
        for (int i = 0; i < rptList.Items.Count; i++)
        {
            CheckBox chkDelete = (CheckBox)rptList.Items[i].FindControl(("chk_item"));
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
        condition = " isid in(" + ArrayId + ") ";
        Subitems.DeleteSubitemsCondition(condition);
        chk_list.Checked = false;
        GetListComments();
    }
    protected void chk_list_CheckedChanged(object sender, EventArgs e)
    {
        if (chk_list.Checked == false)
        {
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                CheckBox chkDelete = (CheckBox)rptList.Items[i].FindControl(("chk_item"));
                if (chkDelete != null)
                    chkDelete.Checked = false;
            }
        }
        else
        {
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                CheckBox chkDelete = (CheckBox)rptList.Items[i].FindControl(("chk_item"));
                if (chkDelete != null)
                    chkDelete.Checked = true;
            }
        }
    }
}
