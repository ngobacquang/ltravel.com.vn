using System;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Extension;
using TatThanhJsc.LanguageModul;
using TatThanhJsc.TSql;
using System.Data;
using TatThanhJsc.Database;
using TatThanhJsc;

public partial class cms_admin_Moduls_Language_Popup_LanguageItemsImage : System.Web.UI.Page
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";
    string iLanguageKeyId = "";
    string folderpic = FolderPic.Language;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["iLanguageKeyId"] != null)
            iLanguageKeyId = StringExtension.RemoveSqlInjectionChars(Request.QueryString["iLanguageKeyId"]);
        if (!IsPostBack)
            LoadInfo();
    }
    void LoadInfo()
    {  
        top = "1";
        fields = LanguageItemColumns.nLanguageItemParams;
        condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(iLanguageKeyId),
                                             LanguageItemTSql.GetByiLanguageNationalId(language));
        order = "";
        DataTable dt = new DataTable();
        dt = LanguageItem.GetLanguageItem(top, fields, condition, order);
        if (dt.Rows.Count > 0)
        {
            hdOldImage.Value = dt.Rows[0][LanguageItemColumns.nLanguageItemParams].ToString();
            hdUpdate.Value = "1";
            ltrImage.Text = ImagesExtension.GetImage(folderpic, hdOldImage.Value, "", "", false, false, "");
        }    
    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        #region Image
        string vimg = "";
        if (flimg.FileName.Length > 0 && flimg.PostedFile.ContentLength > 0)
        {
            string filename = "";
            filename = System.IO.Path.GetFileName(flimg.PostedFile.FileName);
            string fileex = "";

            fileex = System.IO.Path.GetExtension(filename).ToLower();
            if (fileex == ".jpg" || fileex == ".jpeg" || fileex == ".gif" || fileex == ".png" || fileex == ".bmp" || fileex == ".JPG" || fileex == ".JPEG" || fileex == ".GIF" || fileex == ".PNG" || fileex == ".BMP")
            {
                string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(flimg.PostedFile.FileName);
                vimg = StringExtension.ReplateTitle(fileNotEx) + DateTime.Now.Ticks.ToString() + fileex;
                flimg.SaveAs(Request.PhysicalApplicationPath + "/" + folderpic + "/" + vimg);
            }
        }
        #endregion
        if (hdUpdate.Value=="1")//Cập nhật
        {
            if (vimg.Length > 0)
            {
                string[] fields = { TatThanhJsc.Columns.LanguageItemColumns.nLanguageItemParams };
                string[] values = { "N'" + vimg + "'" };
                string condition = DataExtension.AndConditon(LanguageItemTSql.GetByiLanguageKeyId(iLanguageKeyId),
                                                            LanguageItemTSql.GetByiLanguageNationalId(language));
                LanguageItem.UpdateLanguageItem(DataExtension.UpdateTransfer(fields, values), condition);
                //Xoá ảnh cũ
                ImagesExtension.DeleteImageWhenDeleteItem(folderpic, hdOldImage.Value);
            }
            else
                vimg = hdOldImage.Value;
        }
        else//Thêm mới
        {
            LanguageItem.InsertLanguageItem(language, iLanguageKeyId, "", "", vimg);
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Cập nhật thành công');ChangeImage('img" + iLanguageKeyId + "','" + UrlExtension.WebisteUrl + folderpic + "/" + vimg + "');window.close();", true);
    }
}