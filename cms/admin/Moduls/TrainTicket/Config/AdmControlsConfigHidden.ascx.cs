using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TatThanhJsc;
using TatThanhJsc.Extension;
using TatThanhJsc.TrainTicketModul;
using TatThanhJsc.TSql;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;


public partial class cms_admin_TrainTicket_Controls_AdmControlsConfigurationHidden : System.Web.UI.UserControl
{
    string top = "";
    string fields = "";
    string orderby = "";
    string condition = "";
    string app = CodeApplications.TrainTicketOthersFields;
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    public static bool update = false;//Bien danh dau cap nhat hay them moi        

    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)                     
            GetList();        
    }

    protected void btInsert_Click(object sender, EventArgs e)
    {
        ltrInsertUpdate.Text = "Thêm mới trường";
        update = false;
        pnList.Visible = false;
        pnInsert.Visible = true;        
    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByVgapp(app),
            GroupsTSql.GetGroupsByVgdesc(tbKey.Text));
        if (update)
            condition = DataExtension.AndConditon(condition,GroupsColumns.IgidColumn + "<>" + hdIgid.Value);
        DataTable dt = new DataTable();
        dt = Groups.GetGroups("", GroupsColumns.IgidColumn, condition, "");
        if (dt.Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError", "alert('Mã bạn điền đã tồn tại. Vui lòng chọn mã khác.');", true);
        }
        else
        {
            if (update)
                Groups.UpdateGroups(language, app, tbName.Text, tbKey.Text, "", "", "", "", "", "", "", "", "", "", ddlTextEditor.SelectedValue, "", tbOrder.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), ddlStatus.SelectedValue, hdIgid.Value);
            else                
                Groups.InsertGroups(language, app, "0", tbName.Text, tbKey.Text, "", "", "", "", "", "", "", "", "", "", ddlTextEditor.SelectedValue, "", tbOrder.Text, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), ddlStatus.SelectedValue);
            ResetControls();
            GetList();
            pnList.Visible = true;
            pnInsert.Visible = false;
        }
    }
    void ResetControls()
    {
        tbName.Text = "";
        tbKey.Text = "";
        tbOrder.Text = "";
        hdIgid.Value = "";
    }    
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ResetControls();
        pnList.Visible = true;
        pnInsert.Visible = false;
    }
    void GetList()
    {
        condition = DataExtension.AndConditon
            (            
            GroupsTSql.GetGroupsByVglang(language),
            GroupsTSql.GetGroupsByVgapp(app)
            );
        orderby = GroupsColumns.IgorderColumn;
        DataTable dt = new DataTable();
        dt = Groups.GetGroups("", "*", condition, orderby);
        rptList.DataSource = dt;
        rptList.DataBind();
    }
    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        fields = "*";        
        condition = GroupsTSql.GetGroupsByIgid(p);
        DataTable dt = new DataTable();
        dt = Groups.GetGroups("", fields, condition, "");
        switch (c)
        {
            #region Delete
            case "delete":
                DeleteTrainTicketFields(p);
                GetList();
                break;
            #endregion
            #region Edit Enable
            case "EditEnable":                
                string[] fieldsEnable = { GroupsColumns.IgenableColumn };
                string[] valuesEnable = { "" };
                if (dt.Rows[0][GroupsColumns.IgenableColumn].ToString().Equals("0"))
                {
                    valuesEnable[0] = "1";
                    Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                else
                {
                    valuesEnable[0] = "0";
                    Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsEnable, valuesEnable), condition);
                }
                GetList();
                break;
            #endregion
            #region Edit
            case "edit":
                OpenUpdatePanel(p);
                break;
            #endregion
        }
    }

    /// <summary>
    /// Xoá tên trường và xoá dữ liệu trong subitems theo mã ứng dụng, mã trường này
    /// </summary>
    /// <param name="igid">igid của trường</param>
    void DeleteTrainTicketFields(string igid)
    {
        string condition = GroupsTSql.GetGroupsByIgid(igid);
        DataTable dt = new DataTable();
        dt = Groups.GetGroups("", GroupsColumns.VgdescColumn, condition, "");
        Subitems.DeleteSubitemsCondition(DataExtension.AndConditon(SubitemsTSql.GetSubitemsByVslang(language),SubitemsTSql.GetSubitemsByVskey(app), SubitemsTSql.GetSubitemsByVsemail(dt.Rows[0][GroupsColumns.VgdescColumn].ToString())));
        Groups.DeleteGroups(GroupsTSql.GetGroupsByIgid(igid));        
    }

    void OpenUpdatePanel(string igid)
    {
        ltrInsertUpdate.Text = "Cập nhật trường";
        hdIgid.Value = igid;
        update = true;       
        pnList.Visible = false;
        pnInsert.Visible = true;        
        condition = GroupsTSql.GetGroupsByIgid(igid);
        DataTable dt = new DataTable();
        dt = Groups.GetGroups("", "*", condition, "");
        if (dt.Rows.Count > 0)
        {           
            tbName.Text = dt.Rows[0][GroupsColumns.VgnameColumn].ToString();
            tbKey.Text = dt.Rows[0][GroupsColumns.VgdescColumn].ToString();
            tbOrder.Text = dt.Rows[0][GroupsColumns.IgorderColumn].ToString();
            ddlStatus.SelectedValue = dt.Rows[0][GroupsColumns.IgenableColumn].ToString();
            ddlTextEditor.SelectedValue = dt.Rows[0][GroupsColumns.VgparamsColumn].ToString();
        }
    }  
}

