using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.LanguageModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Language_National_ShortCut : System.Web.UI.UserControl
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";

    private string pic = FolderPic.Language;
    private string suc = "";
    private bool HdInsertUpdate;
    private string iLanguageNationalId = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"];
        }
        if (Request.QueryString["iLanguageNationalId"] != null)
        {
            iLanguageNationalId = Request.QueryString["iLanguageNationalId"];
        }
        if (suc.Equals("CreateLanguageNational"))
        {
            HdInsertUpdate = true;
        }
        if (!IsPostBack)
        {
            LtInsertUpdate.Text = "Thêm mới ngôn ngữ";
            InitialControlsValue();
        }
    }

    void InitialControlsValue()
    {
        if (HdInsertUpdate == false)
        {
            LtInsertUpdate.Text = "Cập nhật thông tin ngôn ngữ";
            top = "1";
            fields = "*";
            condition = LanguageNationalTSql.GetByiLanguageNationalId(iLanguageNationalId);
            order = "";
            DataTable dt = new DataTable();
            dt = LanguageNational.GetLanguageNational(top, fields, condition, order);
            TbNameNational.Text = dt.Rows[0]["nLanguageNationalName"].ToString();
            ltimg.Text = ImagesExtension.GetImage(pic, dt.Rows[0]["nLanguageNationalFlag"].ToString(), "", "", false, false, "");
            if (!dt.Rows[0]["nLanguageNationalFlag"].ToString().Equals(""))
            {
                LbDelFlagCurrent.Visible = true;
            }
            HdFlagNational.Value = dt.Rows[0]["nLanguageNationalFlag"].ToString();
            TbOrder.Text = dt.Rows[0]["nLanguageNationalDesc"].ToString();
            if (dt.Rows[0]["iLanguageNationalEnable"].ToString().Equals("0"))
            {
                ChkStatus.Checked = false;
            }
            else
            {
                ChkStatus.Checked = true;
            }
            pnTiepTuc.Visible = false;
        }
        else
        {
            LtInsertUpdate.Text = "Thêm mới ngôn ngữ website";
            pnTiepTuc.Visible = true;
        }
    }

    protected void BtnOk_Click(object sender, EventArgs e)
    {

        #region Image
        string vimg = "";
        if (flimg.FileName.Length > 0 && flimg.PostedFile.ContentLength > 0)
        {
            string filename = "";
            filename = System.IO.Path.GetFileName(flimg.PostedFile.FileName);
            string fileex = "";
            fileex = System.IO.Path.GetExtension(filename).ToLower();
            string fileNotEx = System.IO.Path.GetFileNameWithoutExtension(flimg.PostedFile.FileName);
            if (fileNotEx.Length > 10)
                fileNotEx = fileNotEx.Remove(10);
            vimg = StringExtension.ReplateTitle(fileNotEx) + DateTime.Now.Ticks.ToString() + fileex;
            flimg.SaveAs(Request.PhysicalApplicationPath + "/" + pic + "/" + vimg);
        }
        #endregion
        #region Status
        string status = "0";
        if (ChkStatus.Checked == true)
        {
            status = "1";
        }
        #endregion
        if (HdInsertUpdate == true)
        {
            LanguageNational.InsertLanguageNational(TbNameNational.Text, vimg, TbOrder.Text, status);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", TbNameNational.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " tạo mới ngôn ngữ " + TbNameNational.Text);
            #endregion
        }
        else
        {
            if (vimg.Equals(""))
            {
                vimg = HdFlagNational.Value;
            }
            else
            {
                ImagesExtension.DeleteImageWhenDeleteItem(pic, HdFlagNational.Value);
            }
            LanguageNational.UpdateLanguageNational(iLanguageNationalId, TbNameNational.Text, vimg, TbOrder.Text, status);

            #region Logs
            string logAuthor = CookieExtension.GetCookies("LoginSetting");
            string logCreateDate = DateTime.Now.ToString();
            Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", TbNameNational.Text, logAuthor, "", logCreateDate + ": " + logAuthor + " cập nhật ngôn ngữ " + TbNameNational.Text);
            #endregion
        }
        if (pnTiepTuc.Visible)
        {
            if (ckTiepTuc.Checked)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "ThongBao(3000, 'Đã tạo: " + TbNameNational.Text + "');", true);
                TbNameNational.Text = "";
                TbOrder.Text = "";
            }
            else
                Response.Redirect(LinkAdmin.GoAdminSubModul(CodeApplications.Language, "national"));
        }
        else
            Response.Redirect(LinkAdmin.GoAdminSubModul(CodeApplications.Language, "national"));
    }

    protected void BtnReset_Click(object sender, EventArgs e)
    {
        TbNameNational.Text = "";
        TbOrder.Text = "";
        ChkStatus.Checked = false;
    }

    protected void LbDelFlagCurrent_Click(object sender, EventArgs e)
    {
        string[] fields = { "nLanguageNationalFlag" };
        string[] values = { "''" };
        string condition = LanguageNationalTSql.GetByiLanguageNationalId(iLanguageNationalId);
        LanguageNational.UpdateLanguageNational(DataExtension.UpdateTransfer(fields, values), condition);
        ImagesExtension.DeleteImageWhenDeleteItem(pic, HdFlagNational.Value);
    }
}