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

public partial class cms_admin_System_website_AdmLoadControls : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            case "optimize":
                phControl.Controls.Add(LoadControl("OptimizeWebsite/OptimizeWebsite.ascx"));
                break;
            case "email":
                phControl.Controls.Add(LoadControl("EmailWebsite/EmailWebsite.ascx"));
                break;
            case "information":
                phControl.Controls.Add(LoadControl("InformationWebsite/InformationWebsite.ascx"));
                break;
            case "popup"://Thông tin popup
                phControl.Controls.Add(LoadControl("Popup/Popup.ascx"));
                break;
            case "media"://Thông tin Media(Quản lý nhạc nền website v.v..)
                phControl.Controls.Add(LoadControl("Media/Media.ascx"));
                break;
            case "ConfigurationHidden"://Cấu hình ẩn
                phControl.Controls.Add(LoadControl("Config/ConfigHidden.ascx"));
                break;
            case "systemConfig"://Cấu hình
                phControl.Controls.Add(LoadControl("Config/SystemConfig.ascx"));
                break;
            case "logs"://Logs
                phControl.Controls.Add(LoadControl("Logs/Logs.ascx"));
                break;  
            default:
                phControl.Controls.Add(LoadControl("Index.ascx"));
                break;
        }
    }
}
