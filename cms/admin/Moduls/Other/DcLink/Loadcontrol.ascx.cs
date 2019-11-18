using System;
using System.Data;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;

public partial class cms_admin_Moduls_Other_DcLink_Loadcontrol : System.Web.UI.UserControl
{
    protected int count = 0;
    private string link = "";
    private string type = "0";//0: kiểm tra link  mới, 1: kiểm tra các link đã trùng nhau
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["link"] != null)
            link = StringExtension.RemoveSqlInjectionChars(Request.QueryString["link"]);

        if (Request.QueryString["type"] != null)
            type = StringExtension.RemoveSqlInjectionChars(Request.QueryString["type"]);

        if(!IsPostBack)
        {
            if(link != "")
                tbLink.Text = link;
            if(type == "1")
            {
                rbDuplicate.Checked = true;
                rbNew.Checked = false;
            }
            else
            {
                rbNew.Checked = true;
                rbDuplicate.Checked = false;
            }


            LoadData();
        }
    }

    private void LoadData()
    {
        if(tbLink.Text != "")
            link = StringExtension.ReplateTitle(tbLink.Text);
        else
            link = "%";

        DataTable dt=new DataTable();
        if(type=="1")
            dt = Items.GetDuplicateLink(link);
        else
            dt = Items.CheckDuplicateLink(link);

        rptList.DataSource = dt;
        rptList.DataBind();
    }

    protected string GetEditLink(string id, string app, string rowType)
    {
        if(rowType == "Items")
            return "?uc=" + app + "&suc=UpdateItem&iid=" + id;

        return "?uc=" + app + "&suc=UpdateCate&igid=" + id;
    }
    protected void btCheck_Click(object sender, EventArgs e)
    {
        PostSearch();
    }

    protected void tbLink_TextChanged(object sender, EventArgs e)
    {
        PostSearch();
    }

    private void PostSearch()
    {
        Response.Redirect("admin.aspx?uc=other&uco=dclink&link=" + tbLink.Text);
    }
    
    
}