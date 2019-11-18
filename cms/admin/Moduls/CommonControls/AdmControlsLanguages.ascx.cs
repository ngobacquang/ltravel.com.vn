using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Columns;
using System.Data;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;


public partial class cms_admin_Moduls_CommonControls_AdmControlsLanguages : System.Web.UI.UserControl
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            GetListLanguageNationals();
    }
    void GetListLanguageNationals()
    {
        top = "";
        fields = "*";
        condition = TatThanhJsc.TSql.LanguageNationalTSql.GetByiLanguageNationalEnable("1");
        order = LanguageNationalColumns.nLanguageNationalDesc + " desc";
        DataTable dt = new DataTable();
        dt = LanguageNational.GetLanguageNational(top, fields, condition, order);
        rptList.DataSource = dt;
        rptList.DataBind();
    }
    protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        switch (c)
        {            
            case "select":
                SetCookiesLanguage(p);
                              
                Response.Redirect(Request.Url.ToString());
                break;
        }
    }
    /// <summary>
    /// Lưu giá trị ngôn ngữ vào cookies
    /// </summary>
    /// <param name="languageId">id của ngôn ngữ</param>
    void SetCookiesLanguage(string languageId)
    {
        TatThanhJsc.LanguageModul.Cookie.SetLanguageValueAdmin(languageId);     
    }

    protected string SetCurrentLanguage(string languageId)
    {
        if (languageId == TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin())
            return "Current";
        else
            return "";
    }
}
