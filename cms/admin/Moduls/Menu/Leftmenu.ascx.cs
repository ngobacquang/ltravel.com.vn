using System;
using TatThanhJsc.MenuModul;

public partial class cms_admin_Moduls_Menu_Leftmenu : System.Web.UI.UserControl
{
    private string uc = "";
    private string suc = "";
    private string app = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uc"] != null)
            uc = Request.QueryString["uc"];

        if (Request.QueryString["suc"] != null)
            suc = Request.QueryString["suc"];

        if (Request.QueryString["app"] != null)
            app = Request.QueryString["app"];

        InitListMenu();
    }

    private void InitListMenu()
    {
        MenuConfig config=new MenuConfig();

        ltrControl.Text = "";
        ltrShortCut.Text = "";
        ltrRec.Text = "";

        for (int i = 0; i < config.Text.Length; i++)
        {           
            ltrControl.Text += @"
    <div class='ArroundCate"+SetSelectedCate(config.Values[i],"")+@"'>
        <div class='PdIconInfomation'><div class='iconMenuChinh'><!----></div></div>    
        <a class='TextCateManager' href='?uc=" + uc + "&app=" + config.Values[i] + "'>" + Developer.MenuKeyword.QuanLy + " " + config.Text[i] + @"</a>
        <div class='cbh8'><!----></div>
    </div> ";

            ltrShortCut.Text += @"
    <div class='ArroundCate" + SetSelectedCate(config.Values[i], TypePage.create) + @"'>
        <div class='PdIconInfomation'><div class='iconThemMoi_MenuChinh'><!----></div></div>
        <a class='TextCateManager' href='?uc=" + uc + "&suc="+TypePage.create+"&app=" + config.Values[i] + "'>" + Developer.MenuKeyword.ThemMoi + " " + config.Text[i] + @"</a>
        <div class='cbh0'><!----></div>
    </div>";

            ltrRec.Text += @"
    <div class='PdSubIconRecycleBin'>-</div>
    <a class='TextCateManager " + SetSelectedCate(config.Values[i], TypePage.recycle) + @"' href='?uc=" + uc + "&suc=" + TypePage.recycle + "&app=" + config.Values[i] + "'>" + config.Text[i] + @"</a>
    <div class='cbh0'><!----></div>";
        }        
    }

    protected string SetSelectedCate(string currentApp,string currentSuc)
    {
        if (app==currentApp && suc==currentSuc)        
            return "Selected";        
        else        
            return "";        
    }
}