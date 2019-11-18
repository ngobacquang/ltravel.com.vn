using System;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;

public partial class cms_admin_Ajax_Items_UpdateEnableSubItems : System.Web.UI.Page
{
    private string condition = "";
    private string isid = "";
    private string isenable = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        isid = Request["isid"];
        isenable = Request["isenable"];

        UpdateEnable();
        Response.End();
    }

    void UpdateEnable()
    {
        string valueUpdate = "";
        if (isenable.Equals("0"))
        {
            valueUpdate = "1";
        }
        else
        {
            valueUpdate = "0";
        }
        string[] fieldsDelGroup = { "ISENABLE"};
        string[] valuesDelGroup = { valueUpdate};
        condition = " ISID = '" + isid + "' ";
        Subitems.UpdateSubitems(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);
    }
}