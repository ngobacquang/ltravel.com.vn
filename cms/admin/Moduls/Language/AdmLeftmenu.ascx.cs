using System;

public partial class cms_admin_ModulMain_Language_AdmLeftmenu : System.Web.UI.UserControl
{
    protected string suc = "";
    protected string uc = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uc"] != null)
        {
            uc = Request.QueryString["uc"].ToString();
        }
        if (Request.QueryString["suc"] != null)
        {
            suc = Request.QueryString["suc"].ToString();
        }

        if(!IsPostBack)
            SetEnableControls();
    }

    private void SetEnableControls()
    {
        pnQuanLyNgonNgu.Visible = pnQuanLyNgonNgu_ThemMoi.Visible = LanguageConfig.KeyHienThiQuanLyNgonNgu;

        pnQuanLyMaTuKhoa.Visible = pnQuanLyMaTuKhoa_ThemMoi.Visible = LanguageConfig.KeyHienThiQuanLyMaTuKhoa;

        pnQuanLyTuKhoa.Visible = pnQuanLyTuKhoa_ThemMoi.Visible = LanguageConfig.KeyHienThiQuanLyTuKhoa;
    }

    protected string SetSelectedCate(string Values)
    {
        if (suc.Equals(Values))
        {
            return "Selected";
        }
        else
        {
            return "";
        }
    }

    protected string SetEnableSpaceCate()
    {
        if (suc.Equals("national"))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }

    protected string SetEnableTool()
    {
        if (suc.Equals("CreateLanguageNational"))
        {
            return "InvisibleSpaceCate";
        }
        else
        {
            return "";
        }
    }

}
