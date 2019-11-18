using System;

public partial class cms_admin_Ajax_Items_DeleteRecListItems : System.Web.UI.Page
{
    cms_admin_Ajax_Items_DeleteRecItem itemControls=new cms_admin_Ajax_Items_DeleteRecItem();

    private string listigid = "";
    private string pic = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        listigid = Request["listigid"];
        pic = Request["pic"];

        DeleteRecListGroup();
        Response.End();
    }

    void DeleteRecListGroup()
    {
        string[] arrigid = listigid.Split(Convert.ToChar(","));
        for (int i = 0; i < arrigid.Length - 1; i++)
        {            
            itemControls.DeleteRecItem(arrigid[i],pic);
        }
    }
}