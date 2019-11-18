using System;
using System.Web;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.FileLibrary2Modul;

public partial class upload : System.Web.UI.Page
{
    string username = "";
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
    string app = CodeApplications.FileLibrary2EmmbedFilesOther;
    string pic = FolderPic.FileLibrary2;

    protected void Page_Load(object sender, EventArgs e)
    {        
        try
        {            
            ThemAnhChoHinhAnh();
        }
        catch
        {
            // If any kind of error occurs return a 500 Internal Server error
            Response.StatusCode = 500;
            Response.Write("An error occured");
            Response.End();
        }
        finally
        {
            // Clean up			     
            Response.End();
        }
	}

    void ThemAnhChoHinhAnh()
    {       
        //Lay igid
        if (Request.Params["iid"] != null)
        {
            string iid = StringExtension.RemoveSqlInjectionChars(Request.Params["iid"]);                 
            // Get the data
            HttpPostedFile fileUpload = Request.Files["Filedata"];



            
            string file = "";
            string fileLink = "";
            if (fileUpload.ContentLength > 0)
            {
                string filename = fileUpload.FileName;
                string fileex = filename.Substring(filename.LastIndexOf("."));
                string path = Request.PhysicalApplicationPath + "/" + pic + "/";

                string fileNotEx = StringExtension.ReplateTitle(filename.Remove(filename.LastIndexOf(".") - 1));
                if (fileNotEx.Length > 9) fileNotEx = fileNotEx.Remove(9);
                string ticks = DateTime.Now.Ticks.ToString();
                #region Lưu tệp đính kèm
                file = fileNotEx + "_" + ticks + fileex;

                fileUpload.SaveAs(path + file);
                #endregion
            }

            string vscontent = StringExtension.GhepChuoi("", file, fileLink);

            Subitems.InsertSubitems(iid, lang, app, fileUpload.FileName.Remove(fileUpload.FileName.LastIndexOf(".")), vscontent, "", "", "1", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");

            //Session["CurrentUploadedFileName"] = fileName;
            Response.StatusCode = 200;
        }
    }
}
