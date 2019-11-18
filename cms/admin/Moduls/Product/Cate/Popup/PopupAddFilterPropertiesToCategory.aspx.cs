using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.ProductModul;
using TatThanhJsc.TSql;


public partial class cms_admin_ModulMain_Product_PopUp_Category_PopupAddFilterPropertiesToCategory : System.Web.UI.Page
{
    string igid = "";
    string top = "";
    string fields = "";
    string orderBy = "";
    string condition = "";
    string app = CodeApplications.ProductFilterProperties;
    string parramSplitString = TatThanhJsc.AdminModul.Keyword.ParamsSpilitRole;
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["igid"] != null)
            igid = QueryStringExtension.GetQueryString("igid");
        if (!IsPostBack)
        {
            GetListAdded();
            GetListNotAdded();
        }
    }

    /// <summary>
    /// Lấy danh igid các thuộc tính lọc đã được add vào danh mục (kết quả trả về dạng ,igid1,igid2,)
    /// </summary>
    /// <returns></returns>
    string GetListFilterProperties()
    {
        top = ""; fields = TatThanhJsc.Columns.GroupsColumns.VgparamsColumn + "," + TatThanhJsc.Columns.GroupsColumns.VgnameColumn;
        orderBy = "";
        condition = TatThanhJsc.TSql.GroupsTSql.GetGroupsByIgid(igid);
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Groups.GetGroups(top, fields, condition, orderBy);
        if (dt.Rows.Count > 0)
        {
            ltrCategoryName.Text = dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VgnameColumn].ToString();
            return dt.Rows[0][TatThanhJsc.Columns.GroupsColumns.VgparamsColumn].ToString();
        }
        else
        {
            ltrCategoryName.Text = "";
            return "";
        }
    }

    /// <summary>
    /// Lấy danh sách các thuộc tính đã được add
    /// </summary>
    void GetListAdded()
    {
        lstbAdded.Items.Clear();
        condition = DataExtension.AndConditon(
                    TatThanhJsc.TSql.GroupsTSql.GetGroupsByVglang(language),
                    TatThanhJsc.TSql.GroupsTSql.GetGroupsByVgapp(app),
                    GroupsColumns.IgenableColumn+"<>2",
                    "charindex('" + parramSplitString + "'+cast(" + TatThanhJsc.Columns.GroupsColumns.IgidColumn + " as varchar(10))+'" + parramSplitString + "','" + GetListFilterProperties() + "') >0");
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Groups.GetAllGroups("*", condition, "");
        for (int i = 0; i < dt.Rows.Count; i++)        
            lstbAdded.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));        
    }

    /// <summary>
    /// Lấy danh sách các thuộc tính chưa được add ( chỉ hiện ra những thuộc tính mà nó và cha nó chưa bị add)
    /// </summary>
    void GetListNotAdded()
    {
        string listFilterProperties = GetListFilterProperties(); 
        lstbNotAdded.Items.Clear();
        condition = DataExtension.AndConditon(
            TatThanhJsc.TSql.GroupsTSql.GetGroupsByVglang(language),
            TatThanhJsc.TSql.GroupsTSql.GetGroupsByVgapp(app),
            GroupsColumns.IgenableColumn + "<>2",
            "charindex('" + parramSplitString + "'+cast(" + TatThanhJsc.Columns.GroupsColumns.IgidColumn + " as varchar(10))+'" + parramSplitString + "','" + listFilterProperties + "') <1");
        
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Groups.GetAllGroups("*", condition, "");
        string parentsId = "";
        string danhDauThuocChaHopLe = "";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            //Kiểm tra, chỉ hiện ra các mục mà cha nó chưa bị add
            parentsId = dt.Rows[i][TatThanhJsc.Columns.GroupsColumns.IgparentsidColumn].ToString();
            if (!parentInListFilterproperties(parentsId, listFilterProperties))
            {
                if (ThuocTinhChaHopLe(dt.Rows[i]["IGID"].ToString()))
                    danhDauThuocChaHopLe = "+";
                else
                    danhDauThuocChaHopLe = ".";
                lstbNotAdded.Items.Add(new ListItem(danhDauThuocChaHopLe+DropDownListExtension.FormatForDdl(dt.Rows[i]["IGLEVEL"].ToString()) + dt.Rows[i]["VGNAME"].ToString(), dt.Rows[i]["IGID"].ToString()));
            }
        }
    }

    /// <summary>
    /// Kiểm tra xem igparentsid có chứa id đã bị add hay không
    /// </summary>
    /// <param name="parentsId"></param>
    /// <param name="listFilterProperties"></param>
    /// <returns></returns>
    bool parentInListFilterproperties(string parentsId, string listFilterProperties)
    {
        bool result = false;
        char[] split = { ',' };
        foreach (string parentId in parentsId.Split(split))
            if (listFilterProperties.IndexOf(parramSplitString + parentId + parramSplitString) >= 0)
                result = true;
        return result;
    }

    //Add thuộc tính vào danh mục
    protected void btAdd_Click(object sender, EventArgs e)
    {
        string listFilterProperties = GetListFilterProperties();
        if (listFilterProperties.Length < 1 || listFilterProperties == "0")
            listFilterProperties = parramSplitString;
        int[] iidArry = lstbNotAdded.GetSelectedIndices();
        if (iidArry.Length > 0)
        {
            for (int i = 0; i < iidArry.Length; i++)
            {
                if (ThuocTinhChaHopLe(lstbNotAdded.Items[iidArry[i]].Value))
                    listFilterProperties += lstbNotAdded.Items[iidArry[i]].Value + parramSplitString;
            }
            //Cap nhat lai danh sach thuoc tinh
            string[] fieldsEditStatus = { TatThanhJsc.Columns.GroupsColumns.VgparamsColumn };
            string[] valuesEditStatus = { "'" + listFilterProperties + "'" };
            if (cbApplyToSubCategory.Checked == true)
                TatThanhJsc.Database.Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), "charindex(','+cast(" +igid + " as varchar(10))+','," + TatThanhJsc.Columns.GroupsColumns.IgparentsidColumn + ") >0");
            else
                TatThanhJsc.Database.Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), TatThanhJsc.TSql.GroupsTSql.GetGroupsByIgid(igid));

            //Lấy lại danh sách các thuộc tính
            GetListAdded();
            GetListNotAdded();
        }        
    }

    /// <summary>
    /// Kiểm tra xem thuộc tính được chọn có phải là thuộc tính cha hợp lệ không (hợp lệ: có thuộc tính con, thuộc tính con đó không có con)
    /// </summary>
    /// <param name="igid">igid cần kiểm tra</param>
    /// <returns></returns>
    bool ThuocTinhChaHopLe(string igid)
    {
        condition = GroupsTSql.GetGroupsByIgid(igid);
        fields = TatThanhJsc.Columns.GroupsColumns.IgparentsidColumn;
        DataTable dt = new DataTable();
        dt = Groups.GetGroups("", fields, condition, "");
        string igCurrentIgparentIds = dt.Rows[0][GroupsColumns.IgparentsidColumn].ToString();//Lấy danh sách cha của danh mục hiện tại

        //Lấy danh sách tất cả con của danh mục hiện tại
        condition =DataExtension.AndConditon(
            "charindex(','+cast(" + igid + " as varchar(10))+','," + TatThanhJsc.Columns.GroupsColumns.IgparentsidColumn + ") >0",
            GroupsColumns.IgenableColumn+"<>2");
        dt = Groups.GetGroups("", fields, condition, "");
        string listIgparentsId = "";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            listIgparentsId += dt.Rows[i][GroupsColumns.IgparentsidColumn].ToString().Replace(igCurrentIgparentIds, "");
        }
        int soDauPhay = listIgparentsId.Split(new string[] { "," }, StringSplitOptions.None).Length;
        if (soDauPhay == dt.Rows.Count && dt.Rows.Count>1)
            return true;
        else
            return false;
    }

    //Loại bỏ thuộc tính ra khỏi danh mục
    protected void btRemove_Click(object sender, EventArgs e)
    {
        string listFilterProperties = GetListFilterProperties();
        int[] iidArry = lstbAdded.GetSelectedIndices();
        if (iidArry.Length > 0)
        {
            for (int i = 0; i < iidArry.Length; i++)
            {
                listFilterProperties = listFilterProperties.Replace(parramSplitString + lstbAdded.Items[iidArry[i]].Value + parramSplitString, parramSplitString);
            }
            //Cap nhat lai danh sach thuoc tinh
            string[] fieldsEditStatus = { TatThanhJsc.Columns.GroupsColumns.VgparamsColumn };
            string[] valuesEditStatus = { "'" + listFilterProperties + "'" };
            if (cbApplyToSubCategory.Checked == true)
                TatThanhJsc.Database.Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), "charindex(','+cast(" + igid+ " as varchar(10))+','," + TatThanhJsc.Columns.GroupsColumns.IgparentsidColumn + ") >0");
            else
                TatThanhJsc.Database.Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsEditStatus, valuesEditStatus), TatThanhJsc.TSql.GroupsTSql.GetGroupsByIgid(igid));

            //Lấy lại danh sách các thuộc tính
            GetListAdded();
            GetListNotAdded();
        }
    }
}
