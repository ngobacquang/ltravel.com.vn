using System;
using System.Data;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.ProductModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Product_Cate_Popup_ChangePriceItems : System.Web.UI.Page
{
    string igid = "";
    string top = "";
    string fields = "";
    string orderBy = "";
    string condition = "";
    string app = CodeApplications.Product;
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["igid"] != null)
            igid = QueryStringExtension.GetQueryString("igid");
        if (!IsPostBack)
        {
            GetDetail();
        }
    }

    private void GetDetail()
    {
        DataTable dt = Groups.GetGroups("1", GroupsColumns.VgnameColumn, GroupsTSql.GetGroupsByIgid(igid), "");
        if (dt.Rows.Count > 0)
        {
            ltName1.Text = ltName2.Text = dt.Rows[0][GroupsColumns.VgnameColumn].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(txtNum.Text) > 0)
        {
            btnSubmitAll.Enabled = true;
        }
        else {
            btnSubmitAll.Enabled = false;
        }
        rpPrice.DataSource = new int[Convert.ToInt32(txtNum.Text)];
        rpPrice.DataBind();
    }


    protected void btnSubmitAll_Click(object sender, EventArgs e)
    {
        if(rpPrice.Items.Count==0) return;
        string text = "",listSIZE="";

        foreach (RepeaterItem item in rpPrice.Items)
        {
            TextBox title = (TextBox)item.FindControl("txtTitle");
            if (title.Text != "")
            {
                text = title.Text;
                listSIZE += text + ";";
            }
        }
        
          TatThanhJsc.Database.Groups.UpdateGroupsCondition(GroupsColumns.VGSEOMETACANONICALColumn + "=N'" + listSIZE + "'", "IGID = '" + igid + "'");

        //string condition = DataExtension.AndConditon(
        //    GroupsTSql.GetGroupsByVgapp(app),
        //    ItemsTSql.GetItemsByIienable("1"),
        //    ItemsTSql.GetItemsByViapp(app),
        //    ItemsTSql.GetItemsByVilang(language),
        //    GroupsItemsTSql.GetItemsInGroupCondition(igid,"")
        //    );
        //DataTable dt = GroupsItems.GetAllData("", "ITEMS.IID", condition, fields);
        //if(dt.Rows.Count>0){
        //    string id = "0";
        //    foreach (DataRow item in dt.Rows)
        //    {
        //        id += ","+item[ItemsColumns.IidColumn];
        //    }

        //    TatThanhJsc.Database.Items.UpdateItems(
        //    ItemsColumns.ViurlColumn + "=N'" + text + "'," +
        //    ItemsColumns.FipriceColumn + "=N'" + pri + "'," +
        //    ItemsColumns.FisalepriceColumn + "=N'" + priold + "'," +
        //    ItemsColumns.ViauthorColumn + "=N'" + pritt + "'," +
        //    ItemsColumns.VISEOMETAPARAMSColumn + "=N'" + oldpricnt + "'," +
        //    ItemsColumns.ViparamsColumn + "=N'" + pricnt + "'"
        //    , "IID in ("+id+")");
        //}

        btnSubmitAll.Enabled = false;
        ltResult.Text = "<font style='color:blue'>Cập nhật thành công</span>";
    }
}