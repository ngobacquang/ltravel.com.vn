using System;
using System.Web;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.WebsiteModul;

public partial class upload : System.Web.UI.Page
{
    string username = "";
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
    string app = CodeApplications.WebsiteImagesOther;
    string pic = FolderPic.Website;

    protected void Page_Load(object sender, EventArgs e)
    {        
        try
        {            
            ThemAnhChoWebsite();
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

    void ThemAnhChoWebsite()
    {       
        //Lay igid
        if (Request.Params["igid"] != null)
        {
            string igid = StringExtension.RemoveSqlInjectionChars(Request.Params["igid"]);            
            // Get the data
            HttpPostedFile fileUpload = Request.Files["Filedata"];

            string fileName = fileUpload.FileName;
            string fileExtension = fileName.Substring(fileName.LastIndexOf("."));
            if (ImagesExtension.ValidType(fileExtension))
            {   
                #region Lưu ảnh đại diện theo 2 trường hợp: tạo ảnh nhỏ hoặc không.
                //Kiểm tra xem có tạo ảnh nhỏ hay ko
                //Nếu không tạo ảnh nhỏ, tên tệp lưu bình thường theo kiểu: tên_tệp.phần_mở_rộng
                //Nếu tạo ảnh nhỏ, tên tệp sẽ theo kiểu: tên_tệp_HasThumb.phần_mở_rộng
                //Khi đó tên tệp ảnh nhỏ sẽ theo kiểu:   tên_tệp_HasThumb_Thumb.phần_mở_rộng
                //Với cách lưu tên ảnh này, khi thực hiện lưu vào csdl chỉ cần lưu tên ảnh gốc
                //khi hiển thị chỉ cần dựa vào tên ảnh gốc để biết ảnh đó có ảnh nhỏ hay không, việc này được thực hiện bởi ImagesExtension.GetImage, lập trình không cần làm gì thêm.
                string ticks = DateTime.Now.Ticks.ToString();
                if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhWebsite, lang) == "1")
                    fileName = igid + "_" + ticks + "_HasThumb" + fileExtension;
                else
                    fileName = igid + "_" + ticks + fileExtension;

                string path = Request.PhysicalApplicationPath + "/" + pic + "/";
                fileUpload.SaveAs(path + fileName);
                #endregion
                #region Hạn chế kích thước
                if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhWebsite, lang) == "1")
                    ImagesExtension.ResizeImage(path + fileName, "", SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhWebsite_MaxWidth, lang), SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhWebsite_MaxHeight, lang));
                #endregion
                #region Đóng dấu ảnh
                if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite, lang) == "1")
                {
                    ImagesExtension.CreateWatermark(path + fileName, path + SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_AnhDau, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_ViTri, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_LeNgang, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_LeDoc, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_TyLe, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhWebsite_TrongSuot, lang));
                }
                #endregion
                #region Tạo ảnh nhỏ: Thực hiện cuối để đảm bảo ảnh nhỏ cũng có con dấu
                if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhWebsite, lang) == "1")
                {
                    string vimg_thumb = igid + "_" + ticks + "_HasThumb_Thumb" + fileExtension;
                    ImagesExtension.ResizeImage(path + fileName, path + vimg_thumb, SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhWebsite_MaxWidth, lang), SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhWebsite_MaxHeight, lang));

                    
                }
                #endregion
                
                
                GroupsItems.InsertItemsGroupsItems(lang, app, "", fileName, "", "", fileName, "", "", "", "", "", "", "", "", "", "", "", "0", "0", "0", "0", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", igid, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1", "1");

                //Session["CurrentUploadedFileName"] = fileName;
                Response.StatusCode = 200;
            }
        }
    }
}
