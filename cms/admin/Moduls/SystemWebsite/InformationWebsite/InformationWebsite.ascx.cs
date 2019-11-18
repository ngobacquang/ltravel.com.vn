using System;
using System.Web.UI;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.SystemWebsiteModul;

public partial class cms_admin_System_website_InformationWebsite_AdmInformationWebsite : System.Web.UI.UserControl
{
    string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    string pic = FolderPic.SystemWebsite;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Gán đường dẫn cho ckeditor
        foreach (Control control in this.Controls)
        {
            if (control is CKEditor.NET.CKEditorControl)
                ((CKEditor.NET.CKEditorControl)control).FilebrowserImageBrowseUrl
                    =
                    UrlExtension.WebisteUrl + "ckeditor/ckfinder/ckfinder.aspx?type=Images&path=" + pic;
        }
        #endregion
        if (!IsPostBack)
        {
            ShowHidePanel();
            GetContentInControl();
        }
    }
    private void ShowHidePanel()
    {
        pnSocialLink.Visible = HorizaMenuConfig.ShowSocialLink;
        pnYouTubeCode.Visible = HorizaMenuConfig.ShowYoutubeCode;        
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        #region Image
        string vimg = "";
        if (flimg.FileName.Length > 0 && flimg.PostedFile.ContentLength > 0)
        {
            string filename = "";
            filename = System.IO.Path.GetFileName(flimg.PostedFile.FileName);
            string fileex = "";

            fileex = System.IO.Path.GetExtension(filename).ToLower();
            if (fileex == ".jpg" || fileex == ".gif" || fileex == ".png" || fileex == ".bmp")
            {
                string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(flimg.PostedFile.FileName);
                vimg = StringExtension.ReplateTitle(fileNotEx) + DateTime.Now.Ticks.ToString() + fileex;
                flimg.SaveAs(Request.PhysicalApplicationPath + "/" + FolderPic.SystemWebsite + "/" + vimg);
            }
        }
        #endregion
        if (vimg.Equals(""))
        {
            vimg = hd_img.Value;
        }
        if (!vimg.Equals(hd_img.Value))
        {
            ImagesExtension.DeleteImageWhenDeleteItem(pic, hd_img.Value);
        }      
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyLogoAdminWebsite,vimg,language);


        #region Image Map
        string vImageMap = "";
        if (FlMap.FileName.Length > 0 && FlMap.PostedFile.ContentLength > 0)
        {
            string filename = "";
            filename = System.IO.Path.GetFileName(FlMap.PostedFile.FileName);
            string fileex = "";
            fileex = System.IO.Path.GetExtension(filename).ToLower();
            if (fileex == ".ico")
            {
                string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(FlMap.PostedFile.FileName);
                vImageMap = fileNotEx + DateTime.Now.Ticks.ToString() + fileex;
                FlMap.SaveAs(Request.PhysicalApplicationPath + "/" + FolderPic.SystemWebsite + "/" + vImageMap);
            }
        }
        #endregion

        if (vImageMap.Equals(""))
        {
            vImageMap = HdImageMap.Value;
        }
        if (!vImageMap.Equals(HdImageMap.Value))
        {
            ImagesExtension.DeleteImageWhenDeleteItem(pic, HdImageMap.Value);
        }
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyFavicon, vImageMap, language);


        #region Image share
        string vimgFacebook = "";
        if (flimgFacebook.FileName.Length > 0 && flimgFacebook.PostedFile.ContentLength > 0)
        {
            string filename = "";
            filename = System.IO.Path.GetFileName(flimgFacebook.PostedFile.FileName);
            string fileex = "";

            fileex = System.IO.Path.GetExtension(filename).ToLower();
            if (fileex == ".jpg" || fileex == ".gif" || fileex == ".png" || fileex == ".bmp")
            {
                string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(flimgFacebook.PostedFile.FileName);
                vimgFacebook = StringExtension.ReplateTitle(fileNotEx) + DateTime.Now.Ticks.ToString() + fileex;
                flimgFacebook.SaveAs(Request.PhysicalApplicationPath + "/" + FolderPic.SystemWebsite + "/" + vimgFacebook);
            }
        }
        #endregion
        if (vimgFacebook.Equals(""))
        {
            vimgFacebook = hd_imgFacebook.Value;
        }
        if (!vimgFacebook.Equals(hd_imgFacebook.Value))
        {
            ImagesExtension.DeleteImageWhenDeleteItem(pic, HdImageMap.Value);
        }
        SettingsExtension.SetOtherSettingKey("LogoShareHomepage", vimgFacebook, language);


        string content1 = ContentExtendtions.ProcessStringContent(txt_content_footer.Text, hdOldValue.Value, pic);
        string contenttop = ContentExtendtions.ProcessStringContent(txt_content_footer_top.Text, hdOldValueTop.Value, pic);

        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyContentFooterWebsite, content1, language);
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyContentFooterWebsite+"Top", contenttop, language);

        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyPhoneContact, TextPhoneContact.Text, language);
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyHotLine, TextHotLine.Text, language);
        SettingsExtension.SetOtherSettingKey("KeyContactEmail", tbEmail.Text, language);

        SettingsExtension.SetOtherSettingKey("YoutubeVideo", tbYoutubeVideo.Text, language);
        SettingsExtension.SetOtherSettingKey("KeyLinkFanPageFaceBook", tbKeyLinkFanPageFaceBook.Text, language);
        SettingsExtension.SetOtherSettingKey("KeyLinkFanPageGPlus", tbKeyLinkFanPageGPlus.Text, language);
        SettingsExtension.SetOtherSettingKey("KeyLinkFanPageTwitter", tbKeyLinkFanPageTwitter.Text, language);

    SettingsExtension.SetOtherSettingKey("KeyTripadvisor", tbTripadvisor.Text, language);

        SettingsExtension.SetOtherSettingKey("KeyCurrency", ddlCurrency.SelectedValue, language);

        GetContentInControl();

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", "Thông tin chung", logAuthor,
            "",
            logCreateDate + ": " + logAuthor + " cập nhật thông tin hệ thống (Thông tin chung)");

        #endregion
    }

    void GetContentInControl()
    {
        hd_img.Value = SettingsExtension.GetSettingKey(SettingsExtension.KeyLogoAdminWebsite, language);
        ltimg.Text = "<div class='pb10'><img src='" + FolderPic.SystemWebsite + "/" + hd_img.Value + "' class='iconadm' /></div>";

        HdImageMap.Value = SettingsExtension.GetSettingKey(SettingsExtension.KeyFavicon, language);
        ltMap.Text = "<div class='pb10'><img src='" + FolderPic.SystemWebsite + "/" + HdImageMap.Value + "' class='iconfavi' /></div>";

        hd_imgFacebook.Value = SettingsExtension.GetSettingKey("LogoShareHomepage", language);
        ltrimgFacebook.Text = "<div class='pb10'><img src='" + FolderPic.SystemWebsite + "/" + hd_imgFacebook.Value + "' class='iconadm' /></div>";

        txt_content_footer.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentFooterWebsite, language);
        hdOldValue.Value = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentFooterWebsite, language);

        txt_content_footer_top.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentFooterWebsite+"Top", language);
        hdOldValueTop.Value = SettingsExtension.GetSettingKey(SettingsExtension.KeyContentFooterWebsite+"Top", language);

        TextPhoneContact.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyPhoneContact, language);

        TextHotLine.Text = SettingsExtension.GetSettingKey(SettingsExtension.KeyHotLine, language);
        tbEmail.Text = SettingsExtension.GetSettingKey("KeyContactEmail", language);
        

        tbYoutubeVideo.Text = SettingsExtension.GetSettingKey("YoutubeVideo", language);
        tbKeyLinkFanPageFaceBook.Text = SettingsExtension.GetSettingKey("KeyLinkFanPageFaceBook", language);
        tbKeyLinkFanPageGPlus.Text = SettingsExtension.GetSettingKey("KeyLinkFanPageGPlus", language);
        tbKeyLinkFanPageTwitter.Text = SettingsExtension.GetSettingKey("KeyLinkFanPageTwitter", language);

        ddlCurrency.SelectedValue = SettingsExtension.GetSettingKey("KeyCurrency", language);

        tbTripadvisor.Text = SettingsExtension.GetSettingKey("KeyTripadvisor", language);
  }

    
}
