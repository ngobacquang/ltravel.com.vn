﻿using System;
using System.Web;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TrainTicketModul;

public partial class upload : System.Web.UI.Page
{
    string username = "";
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
    string app = CodeApplications.TrainTicketImagesOther;
    string pic = FolderPic.TrainTicket;

    protected void Page_Load(object sender, EventArgs e)
    {        
        try
        {            
            ThemAnhChoTrainTicket();
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

    void ThemAnhChoTrainTicket()
    {       
        //Lay igid
        if (Request.Params["iid"] != null)
        {
            string iid = StringExtension.RemoveSqlInjectionChars(Request.Params["iid"]);
            string color = StringExtension.RemoveSqlInjectionChars(Request.Params["color"]);            
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
                if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTrainTicket, lang) == "1")
                    fileName = iid + "_" + ticks + "_HasThumb" + fileExtension;
                else
                    fileName = iid + "_" + ticks + fileExtension;

                string path = Request.PhysicalApplicationPath + "/" + pic + "/";
                fileUpload.SaveAs(path + fileName);
                #endregion
                #region Hạn chế kích thước
                if (SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTrainTicket, lang) == "1")
                    ImagesExtension.ResizeImage(path + fileName, "", SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTrainTicket_MaxWidth, lang), SettingsExtension.GetSettingKey(SettingKey.HanCheKichThuocAnhTrainTicket_MaxHeight, lang));
                #endregion
                #region Đóng dấu ảnh
                if (SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket, lang) == "1")
                {
                    ImagesExtension.CreateWatermark(path + fileName, path + SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_AnhDau, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_ViTri, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_LeNgang, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_LeDoc, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_TyLe, lang), SettingsExtension.GetSettingKey(SettingKey.DongDauAnhTrainTicket_TrongSuot, lang));
                }
                #endregion
                #region Tạo ảnh nhỏ: Thực hiện cuối để đảm bảo ảnh nhỏ cũng có con dấu
                if (SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTrainTicket, lang) == "1")
                {
                    string vimg_thumb = iid + "_" + ticks + "_HasThumb_Thumb" + fileExtension;
                    ImagesExtension.ResizeImage(path + fileName, path + vimg_thumb, SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTrainTicket_MaxWidth, lang), SettingsExtension.GetSettingKey(SettingKey.TaoAnhNhoChoAnhTrainTicket_MaxHeight, lang));

                    
                }
                #endregion
                

                Subitems.InsertSubitems(iid, lang, app, fileName, "", fileName, color, "1", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "1");

                //Session["CurrentUploadedFileName"] = fileName;
                Response.StatusCode = 200;
            }
        }
    }
}
