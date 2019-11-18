using System;

public partial class cms_admin_Ajax_Items_DeleteListSubItems : System.Web.UI.Page
{
    cms_admin_Ajax_Items_DeleteSubItems subItemControl=new cms_admin_Ajax_Items_DeleteSubItems();
    
    private string listigid = "";
    private string pic = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        pic = Request["pic"];
        listigid = Request["listigid"];
        DeleteListSubItem();
        Response.End();
    }

    void DeleteListSubItem()
    {
        string[] arrigid = listigid.Split(Convert.ToChar(","));
        for (int i = 0; i < arrigid.Length - 1; i++)
        {
            subItemControl.DeleteSubItem(arrigid[i],pic);
        }
    }
}