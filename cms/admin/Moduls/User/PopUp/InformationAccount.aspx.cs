using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using TatThanhJsc.Extension;


public partial class cms_admin_ModulMain_User_PopUp_InformationAccount : System.Web.UI.Page
{
    private string iuserid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["iuserid"] != null)
        {
            iuserid = QueryStringExtension.GetQueryString("iuserid");
        }
        if (!IsPostBack)
        {
            GetInfoUser();
        }
    }

    void GetInfoUser()
    {
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Users.GetUsersByUserId(iuserid);
        rp_information_user.DataSource = dt;
        rp_information_user.DataBind();
        rp_information_user.EnableViewState = false;
    }
}
