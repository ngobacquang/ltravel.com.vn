using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.NewsModul;
using TatThanhJsc.TSql;

public partial class cms_admin_TempControls_PopUp_Items_CopyItemFromOtherSite : System.Web.UI.Page
{
    private string top = "", fields = "", condition = "", orderby = "";

    string userRole = CookieExtension.GetCookies("RolesUser");
    TatThanhJsc.UserModul.Roles listRoles = new TatThanhJsc.UserModul.Roles();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (StringExtension.RoleInListRoles(listRoles.CopyItem, userRole) && HorizaMenuConfig.ShowCopyItem)
        {
            pnContent.Visible = true;
            pnStop.Visible = false;
        }


        if (!IsPostBack)
        {
            if (CookieExtension.GetCookies("UserName") == "admin")
                pnLoginOtherSite.Visible = true;
            LoadDefaultData();
        }
    }

    private void LoadDefaultData()
    {
        CopyItemConfig copyItemConfig=new CopyItemConfig();
        #region Lấy danh sách web
        ddlWebSource.Items.Clear();

        ddlWebToLogin.Items.Clear();
        for (int i = 0; i < copyItemConfig.TextListWebsite.Length; i++)
        {
            ddlWebSource.Items.Add(new ListItem(copyItemConfig.TextListWebsite[i],copyItemConfig.ValuesListWebsite[i]));

            ddlWebToLogin.Items.Add(new ListItem(copyItemConfig.TextListWebsite[i], copyItemConfig.ValuesListWebsite[i]));
        }
        #endregion

        #region Lấy danh sách modul
        ddlModulSource.Items.Clear();
        ddlModulDest.Items.Clear();

        for (int i = 0; i < copyItemConfig.TextModul.Length; i++)
        {
            ddlModulSource.Items.Add(new ListItem(copyItemConfig.TextModul[i],copyItemConfig.ValuesModul[i]));

            ddlModulDest.Items.Add(new ListItem(copyItemConfig.TextModul[i], copyItemConfig.ValuesModul[i]));
        }
        #endregion

        #region Lấy ngôn ngữ

        LoadSourceLanguage();
        LoadDestLanguage();
        #endregion


        #region Lấy danh mục

        LoadSourceCate();
        LoadDestCate();

        #endregion

        #region Lấy danh sách

        LoadList();

        #endregion
    }

    #region Lấy danh sách
    private void LoadList()
    {
        lbListItem.Items.Clear();
        DataTable dt = new DataTable();

        
        if (ddlCateSource.SelectedValue.Length > 0)
        {            
            condition = DataExtension.AndConditon(
                GroupsItemsTSql.GetItemsInGroupCondition(ddlCateSource.SelectedValue, ItemsTSql.GetItemsByIienable("1"),ddlWebSource.SelectedValue),
                ItemsTSql.GetItemsByViapp(ddlModulSource.SelectedValue)
                );            
            
            dt = GroupsItems.GetAllData("", "*", condition, ItemsColumns.VititleColumn,ddlWebSource.SelectedValue);
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            lbListItem.Items.Add(new ListItem(dt.Rows[i][ItemsColumns.VititleColumn].ToString(), dt.Rows[i][ItemsColumns.IidColumn].ToString()));
        }
    }
    #endregion
    
    #region Lấy danh mục
    private void LoadSourceCate()
    {
        ddlCateSource.Items.Clear();

        condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByIgenable("1"),
            GroupsTSql.GetGroupsByVglang(ddlLanguageSource.SelectedValue),
            GroupsTSql.GetGroupsByVgapp(ddlModulSource.SelectedValue)
            );
        DataTable dt=new DataTable();

        fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn,GroupsColumns.IglevelColumn);

        dt = Groups.GetAllGroups(fields, condition, "",ddlWebSource.SelectedValue);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ddlCateSource.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i][GroupsColumns.IglevelColumn].ToString())+ dt.Rows[i][GroupsColumns.VgnameColumn].ToString(),dt.Rows[i][GroupsColumns.IgidColumn].ToString()));
        }
    }

    private void LoadDestCate()
    {
        ddlCateDest.Items.Clear();

        condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByIgenable("1"),
            GroupsTSql.GetGroupsByVglang(ddlLanguageDest.SelectedValue),
            GroupsTSql.GetGroupsByVgapp(ddlModulDest.SelectedValue)
            );
        DataTable dt = new DataTable();

        fields = DataExtension.GetListColumns(GroupsColumns.IgidColumn, GroupsColumns.VgnameColumn, GroupsColumns.IglevelColumn);

        dt = Groups.GetAllGroups(fields, condition, "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ddlCateDest.Items.Add(new ListItem(DropDownListExtension.FormatForDdl(dt.Rows[i][GroupsColumns.IglevelColumn].ToString()) + dt.Rows[i][GroupsColumns.VgnameColumn].ToString(), dt.Rows[i][GroupsColumns.IgidColumn].ToString()));
        }
    }
    #endregion


    #region Lấy ngôn ngữ
    private void LoadSourceLanguage()
    {
        ddlLanguageSource.Items.Clear();

        condition = LanguageNationalTSql.GetByiLanguageNationalEnable("1");
        orderby = LanguageNationalColumns.iLanguageNationalId;

        DataTable dt = new DataTable();
        dt = LanguageNational.GetLanguageNational("", "*", condition, orderby, ddlWebSource.SelectedValue);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ddlLanguageSource.Items.Add(new ListItem(dt.Rows[i][LanguageNationalColumns.nLanguageNationalName].ToString(), dt.Rows[i][LanguageNationalColumns.iLanguageNationalId].ToString()));
        }
    }

    private void LoadDestLanguage()
    {
        ddlLanguageDest.Items.Clear();

        condition = LanguageNationalTSql.GetByiLanguageNationalEnable("1");
        orderby = LanguageNationalColumns.iLanguageNationalId;

        DataTable dt = new DataTable();
        dt = LanguageNational.GetLanguageNational("", "*", condition, orderby,
            ConfigurationManager.AppSettings["WebName"]);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ddlLanguageDest.Items.Add(new ListItem(dt.Rows[i][LanguageNationalColumns.nLanguageNationalName].ToString(), dt.Rows[i][LanguageNationalColumns.iLanguageNationalId].ToString()));
        }
    }
    #endregion

    protected void ddlWebSource_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSourceLanguage();
        LoadSourceCate();
        LoadList();
    }
    protected void ddlLanguageSource_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSourceCate();
        LoadList();
    }
    protected void ddlModulSource_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSourceCate();
        LoadList();
    }
    
    protected void ddlCateSource_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadList();
    }

    protected void ddlModulDest_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadDestCate();
    }
    protected void ddlLanguageDest_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadDestCate();
    }
    protected void btNext_Click(object sender, EventArgs e)
    {
        //UrlExtension.WebisteUrl + LinkAdmin.GoAdminItem(ddlModulDest.SelectedValue, TypePage.UpdateItem,lbListItem.SelectedValue)+"&amp;copy=1&amp;igid="+ddlCateDest.SelectedValue

        TatThanhJsc.LanguageModul.Cookie.SetLanguageValueAdmin(ddlLanguageDest.SelectedValue);

        if(lbListItem.SelectedValue.Length>0 && ddlCateDest.SelectedValue.Length>0)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "window.innerWidth =1000;window.innerHeight = 100;window.screenX = screen.width;window.screenY = screen.height;alwaysLowered = true; window.opener.location='" + UrlExtension.WebisteUrl + LinkAdmin.GoAdminItem(ddlModulDest.SelectedValue, TypePage.UpdateItem, lbListItem.SelectedValue) + "&copy=1&igid=" + ddlCateDest.SelectedValue + "';", true);            
            //Response.Redirect(UrlExtension.WebisteUrl + LinkAdmin.GoAdminItem(ddlModulDest.SelectedValue, TypePage.UpdateItem, lbListItem.SelectedValue) + "&amp;copy=1&amp;igid=" + ddlCateDest.SelectedValue);
        else
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('Vui lòng tích chọn một tin. Và chọn danh mục muốn sao chép tới.');", true);
        
    }
    protected void btLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect(FormatLink(ddlWebToLogin.SelectedItem.Text,false) + "/admin.aspx?login=1&username=admin&password=" + CookieExtension.GetCookies("UserPassword"));
    }

    /// <summary>
    /// Định dạng link
    /// </summary>
    /// <param name="link"></param>
    /// <param name="displayLink">true: trả về link để hiển thị dạng www..., false: trả về link web dạng: http://...</param>
    /// <returns></returns>
    private string FormatLink(string link, bool displayLink)
    {
        link = link.ToLower();
        if (link.StartsWith("www."))
            link = link.Substring(4);
        if (!link.StartsWith("http"))
            link = "http://" + link;

        string textLink = link.Replace("http://", "").Replace("https://", "");
        if (!textLink.StartsWith("www."))
            textLink = "www." + textLink;

        if (displayLink) return textLink;
        return link;
    }
}