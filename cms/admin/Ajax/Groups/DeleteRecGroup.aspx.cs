using System;
using System.Data;
using TatThanhJsc.Database;
using TatThanhJsc.Columns;
using TatThanhJsc.Extension;

public partial class cms_admin_Ajax_Groups_DeleteRecGroup : System.Web.UI.Page
{
    private string condition = "";
    private string igid = "";
    private string pic = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        igid = Request["igid"];
        pic = Request["pic"];

        DeleteCate(igid, pic);
        Response.End();
    }

    public void DeleteCate(string igid,string pic)
    {
        condition = " CHARINDEX('," + igid + ",',IGPARENTSID) > 0 ";
        #region Xóa ảnh
        DataTable dt=new DataTable();
        dt = Groups.GetGroups("",GroupsColumns.VgimageColumn, condition, "");
        
        string split = TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i][GroupsColumns.VgimageColumn].ToString().IndexOf(split)<0)
                ImagesExtension.DeleteImageWhenDeleteItem(pic,dt.Rows[i][GroupsColumns.VgimageColumn].ToString());
            else
            {
                foreach (string s in dt.Rows[i][GroupsColumns.VgimageColumn].ToString().Split(new string[]{split},StringSplitOptions.RemoveEmptyEntries))
                {
                    ImagesExtension.DeleteImageWhenDeleteItem(pic, s);
                }
            }
        }
        #endregion        
        Groups.DeleteGroups(condition);
    }
}