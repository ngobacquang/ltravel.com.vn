using System;


public partial class cms_admin_CommonControls_AdmRoad : System.Web.UI.UserControl
{
    private string uc = "";
    private string suc = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uc"] != null)
        {
            uc = Request.QueryString["uc"];    
        }
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }
        if (!IsPostBack)
        {
            GetRoadCurrent();
        }
    }
    
    void GetRoadCurrent()
    {
        string str = "";
        str += "<div class='fr'><a href='admin.aspx' class='TextRoad' title='Trang chủ'>&nbsp;&nbsp;Trang chủ</a></div>";
        str += "<div class='fr'>Bạn đang ở: </div>";
        str += "<div class='cbh0'><!----></div>";
        LtRoad.Text = str;
    }
}
