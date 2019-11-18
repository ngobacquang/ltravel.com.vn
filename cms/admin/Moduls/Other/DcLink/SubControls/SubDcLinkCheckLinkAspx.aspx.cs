using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Extension;

public partial class cms_admin_Moduls_Other_DcLink_SubControls_SubDcLinkCheckLinkAspx : System.Web.UI.Page
{
    private string link = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["link"] != null)
            link = StringExtension.RemoveSqlInjectionChars(Request.QueryString["link"]);
   
        LoadData();        
    }

    private void LoadData()
    {
        link = StringExtension.ReplateTitle(link);
        DataTable dt = TatThanhJsc.Database.Items.GetDuplicateLink(link);
        Response.Write(dt.Rows.Count);
    }
}