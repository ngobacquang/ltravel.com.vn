using System;
using TatThanhJsc.Database;
using TatThanhJsc.Columns;
using TatThanhJsc.Extension;
using System.Data;
using TatThanhJsc.TSql;

public partial class cms_admin_Ajax_Items_DeleteSubItems : System.Web.UI.Page
{    
    private string isid = "";
    private string pic = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        isid = Request["isid"];
        pic = Request["pic"];
        DeleteSubItem(isid,pic);
        Response.End();
    }

    public void DeleteSubItem(string isid,string pic)
    {
        DataTable dtItem = new DataTable();
        dtItem = Subitems.GetSubItems("", "*", SubitemsTSql.GetSubitemsByIsid(isid), "");
        if (dtItem.Rows.Count > 0)
        {
            string split = TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems;
            #region Xoá trả lời của comment
            DataTable dt = new DataTable();
            dt = Subitems.GetSubItems("", "*", DataExtension.AndConditon(SubitemsTSql.GetSubitemsByVskey(dtItem.Rows[0][SubitemsColumns.VskeyColumn].ToString() + "Reply"), SubitemsTSql.GetSubitemsByVsurl(isid)), "");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                #region Xóa ảnh                               
                if (dt.Rows[i][SubitemsColumns.VsimageColumn].ToString().IndexOf(split) < 0)
                    ImagesExtension.DeleteImageWhenDeleteItem(pic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString());
                else
                {
                    foreach (string s in dt.Rows[i][SubitemsColumns.VsimageColumn].ToString().Split(new string[] { split }, StringSplitOptions.RemoveEmptyEntries))
                    {
                        ImagesExtension.DeleteImageWhenDeleteItem(pic, s);
                    }
                }
                #endregion

                Subitems.DeleteSubitems(dt.Rows[i][SubitemsColumns.IsidColumn].ToString());
            }
            #endregion

            #region Xóa ảnh            
            if (dtItem.Rows[0][SubitemsColumns.VsimageColumn].ToString().IndexOf(split) < 0)
                ImagesExtension.DeleteImageWhenDeleteItem(pic, dtItem.Rows[0][SubitemsColumns.VsimageColumn].ToString());
            else
            {
                foreach (string s in dtItem.Rows[0][SubitemsColumns.VsimageColumn].ToString().Split(new string[] { split }, StringSplitOptions.RemoveEmptyEntries))
                {
                    ImagesExtension.DeleteImageWhenDeleteItem(pic, s);
                }
            }
            #endregion
            Subitems.DeleteSubitems(isid);
        }
    }
}