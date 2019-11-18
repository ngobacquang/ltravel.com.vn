using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Ajax_Items_DeleteRecItem : System.Web.UI.Page
{
    cms_admin_Ajax_Items_DeleteSubItems subItemControl = new cms_admin_Ajax_Items_DeleteSubItems();

    private string iid = "";
    private string pic = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        pic = Request["pic"];
        iid = Request["iid"];
        DeleteRecItem(iid,pic);
        Response.End();
    }

    public void DeleteRecItem(string iid,string pic)
    {
        #region Xóa ảnh items
        DataTable dt = new DataTable();
        dt = TatThanhJsc.Database.Items.GetItems("", ItemsColumns.ViimageColumn, ItemsTSql.GetItemsByIid(iid), "");

        string split = TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i][ItemsColumns.ViimageColumn].ToString().IndexOf(split) < 0)
            {
                ImagesExtension.DeleteImageWhenDeleteItem(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString());
                ImagesExtension.DeleteImageWhenDeleteItem(pic, dt.Rows[i][ItemsColumns.ViimageColumn].ToString().Replace("_HasThumb.", "_HasThumb_Thumb."));
            }
            else
            {
                foreach (
                    string s in
                        dt.Rows[i][ItemsColumns.ViimageColumn].ToString()
                            .Split(new string[] {split}, StringSplitOptions.RemoveEmptyEntries))
                {
                    ImagesExtension.DeleteImageWhenDeleteItem(pic, s);
                    ImagesExtension.DeleteImageWhenDeleteItem(pic, s.Replace("_HasThumb.", "_HasThumb_Thumb."));
                }
            }
        }
        #endregion

        DeleteSubItems(iid, pic);

        GroupsItems.DeleteItemsGroupsItemsByIid(iid);
    }

    private void DeleteSubItems(string iid, string pic)
    {
        DataTable dt=new DataTable();
        dt = Subitems.GetSubItems("", SubitemsColumns.IsidColumn, SubitemsTSql.GetSubitemsByIid(iid), "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            subItemControl.DeleteSubItem(dt.Rows[i][SubitemsColumns.IsidColumn].ToString(), pic);
        }
    }
}