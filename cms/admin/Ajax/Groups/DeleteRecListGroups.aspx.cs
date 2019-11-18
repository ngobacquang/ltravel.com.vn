using System;

public partial class cms_admin_Ajax_Groups_DeleteRecListGroup : System.Web.UI.Page
{
    cms_admin_Ajax_Groups_DeleteRecGroup cateControls = new cms_admin_Ajax_Groups_DeleteRecGroup();
    
    private string listigid = "";
    private string pic = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        pic = Request["pic"];
        listigid = Request["listigid"];
        DeleteRecListGroup();
        Response.End();
    }

    void DeleteRecListGroup()
    {
        string[] arrigid = listigid.Split(Convert.ToChar(","));
        for (int j = 0; j < arrigid.Length - 1; j++)
        {
            cateControls.DeleteCate(arrigid[j],pic);           
        }
    }
}