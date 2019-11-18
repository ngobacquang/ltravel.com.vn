using System;
using System.Web.UI;
using TatThanhJsc.Extension;
using TatThanhJsc.SystemWebsiteModul;


public partial class cms_admin_System_website_Media_AdmMedia : System.Web.UI.UserControl
{
    string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueDisplay();
    string media_source;
    private string pic = FolderPic.SystemWebsite;
    string on = "1";
    string vSound = "";
    string type = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        GetContentInControl();
        if (!IsPostBack)
        {

        }
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        if (rdOn.Checked == false)
        {
            on = "0";
        }
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyNhacNenWebsite, StringExtension.GhepChuoi("", txt_source.Text, ltMediaName.Text, on), lang);

        #region Sound
        if (fuMedia.FileName.Length > 0 && fuMedia.PostedFile.ContentLength > 0)
        {
            ImagesExtension.DeleteImageWhenDeleteItem(pic, ltMediaName.Text);

            string filename = "";
            filename = System.IO.Path.GetFileName(fuMedia.PostedFile.FileName);
            string fileex = "";
            fileex = System.IO.Path.GetExtension(filename).ToLower();
            if (fileex == ".mp3" || fileex == ".wma")
            {
                string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(fuMedia.PostedFile.FileName);
                vSound = StringExtension.ReplateTitle(fileNotEx) + DateTime.Now.Ticks.ToString() + fileex;
                fuMedia.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + vSound);
            }
            TatThanhJsc.Extension.SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyNhacNenWebsite, StringExtension.GhepChuoi("", txt_source.Text, vSound, on), lang);
        }
        #endregion

        GetContentInControl();

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000,'Cập nhật thành công !');", true);        
    }

    void GetContentInControl()
    {
        txt_source.Text = StringExtension.LayChuoi(SettingsExtension.GetSettingKey(SettingsExtension.KeyNhacNenWebsite, lang), "", 1);
        media_source = StringExtension.LayChuoi(SettingsExtension.GetSettingKey(SettingsExtension.KeyNhacNenWebsite, lang), "", 1);
        ltMediaName.Text = StringExtension.LayChuoi(SettingsExtension.GetSettingKey(SettingsExtension.KeyNhacNenWebsite, lang), "", 2);
        
        if (StringExtension.LayChuoi(TatThanhJsc.Extension.SettingsExtension.GetSettingKey(SettingsExtension.KeyNhacNenWebsite, lang), "", 3).Equals("0"))
        {
            rdOff.Checked = true;
        }

        if (!ltMediaName.Text.Equals(""))
        {
            lbtDelCurrentMedia.Visible = true;
        }
        
    }
    protected void rdUp_CheckedChanged(object sender, EventArgs e)
    {
        pnUp.Visible = true;
        pnLink.Visible = false;
    }
    protected void rdLink_CheckedChanged(object sender, EventArgs e)
    {
        pnUp.Visible = false;
        pnLink.Visible = true;
    }

    protected void lbtDelCurrentMedia_Click(object sender, EventArgs e)
    {
        if (rdOn.Checked == false)
        {
            on = "0";
        }
        ImagesExtension.DeleteImageWhenDeleteItem(pic, ltMediaName.Text);
        ltMediaName.Text = "";
        SettingsExtension.SetOtherSettingKey(SettingsExtension.KeyNhacNenWebsite, StringExtension.GhepChuoi("", txt_source.Text, ltMediaName.Text, on), lang);
    }
}
