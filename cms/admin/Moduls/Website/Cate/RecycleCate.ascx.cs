using System;
using System.Data;
using TatThanhJsc.WebsiteModul;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

using TatThanhJsc.Database;



public partial class cms_admin_Moduls_Website_Cate_RecycleCate : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string Modul = CodeApplications.Website;
    protected string pic = FolderPic.Website;

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAllModul();
        }
    }

    void GetAllModul()
    {
        DataTable dt = new DataTable();
        fields = " * ";
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(Modul),
                                             GroupsTSql.GetGroupsByVglang(language),
                                             " IGENABLE = '2' ");
        orderBy = "";
        dt = Groups.GetAllGroups(fields, condition, orderBy);

        string str = "";

        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                str += "<div id=\"Cate-" + dt.Rows[i]["IGID"].ToString() + "\">";
                str += "<div class=\"FormatCellItem\">";
                str += "<div class=\"pdCellItem\">";
                str += "<div class=\"cot1\"><input id=\"CbGroup_" + dt.Rows[i]["IGID"].ToString() + "\" type=\"checkbox\" onclick=\"CheckAllCheckBox('CbGroup_" + dt.Rows[i]["IGID"].ToString() + "',this)\" /></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot2\" align=\"left\">";
                str += dt.Rows[i]["VGNAME"].ToString();
                str += "<div class=\"cbh0\"><!----></div>";
                str += "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot4\" align=\"left\">" + GetRoadGroup(dt.Rows[i]["IGPARENTID"].ToString(), dt.Rows[i]["VGNAME"].ToString()) + "&nbsp;</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot5\">" + dt.Rows[i]["IGORDER"].ToString() + "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot7\">";
                str += "<a href=\"javascript:RestoreGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + StatusGroupParent(dt.Rows[i]["IGPARENTID"].ToString()) + "','" + GetSubCate(dt.Rows[i]["IGID"].ToString()) + "','" + dt.Rows[i]["VGNAME"].ToString() + "')\"><span class='iconRestore'><!----></span></a>";
                str += "&nbsp;&nbsp;&nbsp;";
                str += "<a href=\"javascript:DeleteRecGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + GetSubCate(dt.Rows[i]["IGID"].ToString()) + "','" + dt.Rows[i]["VGNAME"].ToString() + "','" + pic + "')\"><span class='iconDelete'><!----></span></a>";
                str += "</div>";
                str += "<div class=\"cbh0\"><!----></div>";
                str += "</div>";
                str += "</div>";
                //igidParent = dt.Rows[i]["IGID"].ToString();
                if (i != dt.Rows.Count - 1)
                {
                    str += "<div class=\"PdSpaceRow\"><div class=\"SpaceRow\"><!----></div></div>";
                }
                str += "</div>";
            }
        }
        LtListMenus.Text = str;
    }

    string GetSubCate(string igparentid)
    {
        top = "";
        fields = " * ";
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(Modul),
                                             GroupsTSql.GetGroupsByVglang(language),
                                             GroupsTSql.GetGroupsByIgparentid(igparentid));
        orderBy = " IGORDER ASC ";
        DataTable dt = new DataTable();
        dt = Groups.GetGroups(top, fields, condition, orderBy);
        string str = "";
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                str += dt.Rows[i]["IGID"].ToString() + ",";
                if (!CountCate(dt.Rows[i]["IGID"].ToString()).Equals("0"))
                {
                    str += GetSubCate(dt.Rows[i]["IGID"].ToString()) + ",";
                }
            }

        }
        if (str.Length > 0)
        {
            str = str.Substring(0, str.Length - 1);
        }

        return str;
    }

    string CountCate(string igid)
    {
        top = "";
        fields = " * ";
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(Modul),
                                             GroupsTSql.GetGroupsByVglang(language),
                                             GroupsTSql.GetGroupsByIgparentid(igid));
        orderBy = " IGORDER ASC ";
        DataTable dt = new DataTable();
        dt = Groups.GetGroups(top, fields, condition, orderBy);
        return dt.Rows.Count.ToString();
    }

    protected string SetStyleLevel(string iglevel)
    {
        string strMainMenu = "";
        strMainMenu += "<div class='fl w25'>";
        if (iglevel.Equals("1"))
        {
            strMainMenu += "<div class='pl10 pt3'><img src='" + UrlExtension.WebisteUrl + "pic/icon/IconArrowGreenRight.png' /></div>";
        }
        else
        {
            strMainMenu += "&nbsp;...";
        }
        strMainMenu += "</div>";
        return strMainMenu;
    }

    protected string GetValueEnable(string vgparams)
    {
        return StringExtension.LayChuoi(vgparams, TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems, 1);
    }

    string GetRoadGroup(string igid, string vgCateCurrent)
    {
        string str = "";
        top = "1";
        fields = " * ";
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(Modul), GroupsTSql.GetGroupsByIgid(igid));
        orderBy = "";

        DataTable dt = new DataTable();
        dt = Groups.GetGroups("1", "*", condition, orderBy);
        if (dt.Rows.Count > 0)
        {
            if (!dt.Rows[0]["IGPARENTID"].ToString().Equals("0"))
            {
                str += GetRoadGroup(dt.Rows[0]["IGPARENTID"].ToString(), dt.Rows[0]["VGNAME"].ToString()) + " / ";
            }
            str += "" + dt.Rows[0]["VGNAME"].ToString() + " / ";
        }
        else
        {
            str = "/";
        }
        str += vgCateCurrent;
        return str;
    }

    string StatusGroupParent(string igparentid)
    {
        string str = "";
        top = " 1 ";
        fields = " * ";
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(TatThanhJsc.MenuModul.CodeApplications.MenuBottom), GroupsTSql.GetGroupsByIgid(igparentid));
        orderBy = "";

        DataTable dt = new DataTable();
        dt = Groups.GetGroups("1", "*", condition, orderBy);
        if (igparentid.Equals("0"))
        {
            str = "1";
        }
        else if (dt.Rows.Count > 0)
        {
            str = dt.Rows[0]["IGENABLE"].ToString();
        }

        return str;
    }
}