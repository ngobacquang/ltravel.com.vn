using System;

public partial class cms_admin_Email_Loadcontrols : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string suc = "";
        suc = Request.QueryString["suc"];
        switch (suc)
        {
            case "listEmail":
                phControl.Controls.Add(LoadControl("Controls/ControlsEmailNhan.ascx"));
                break;
            case "rl":
                phControl.Controls.Add(LoadControl("Controls/ControlsUserTiemTang.ascx"));
                break;           
            case "rlr":
                phControl.Controls.Add(LoadControl("Recycle/RecycleUserTiemTang.ascx"));
                break;
            case "s":
                phControl.Controls.Add(LoadControl("Controls/ControlsSendEmail.ascx"));
                break;
            case "ConfigurationHidden"://Cấu hình ẩn
                phControl.Controls.Add(LoadControl("Config/ConfigHidden.ascx"));
                break;

            case "glr"://Danh mục nhận tin
                phControl.Controls.Add(LoadControl("Cate/ControlCate.ascx"));
                break;
            case "cglr"://Danh mục nhận tin
            case "uglr":
                phControl.Controls.Add(LoadControl("Cate/ShortCutCate.ascx"));
                break;
                

            default:
                phControl.Controls.Add(LoadControl("Controls/ControlsUserTiemTang.ascx"));
                break;
        }
    }
}
