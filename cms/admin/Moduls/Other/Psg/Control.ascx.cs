using System;
using System.Data;
using Developer.Position;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.OtherModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Other_Psg_Control : System.Web.UI.UserControl
{
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string app = CodeApplications.PageSingleContent;

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    string TxtLevel = "";
    private string igidParent = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["hd_parent"] != null)
            hd_parent.Value = Request.QueryString["hd_parent"].ToString();
        else
            hd_parent.Value = "0";

        if (!IsPostBack)
        {
            GetCate();
        }
    }

    #region LinkCreate&Update
    protected string LinkCreateCate()
    {
        return Link.LnkMnPsgCreate();
    }

    private string LinkUpdateCate(string igid)
    {
        return LinkAdmin.GoAdminOther(CodeApplications.other, app, TypePage.update,igid, "", "", "", "");
    }
    #endregion


    void GetCate()
    {
        DataTable dt = new DataTable();
        fields = " * ";
        condition = GroupsTSql.GetGroupsCondition(lang, app, "", " IGENABLE <> '2' ");
        orderBy = " IGORDER ASC ";
        dt = Groups.GetGroups(top, fields, condition, orderBy);

        LtCates.Text = "";
        if (dt.Rows.Count > 0)
        {
            LtCates.Text += "<div id=\"CateOrder-0\" >";
            LtCates.Text += DisplayCate(dt);
            LtCates.Text += "</div>";
        }
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
        return StringExtension.LayChuoi(vgparams,Keyword.ParamsSpilitItems, 1);
    }

    #region Hai hàm hiển thị danh sách
    public string DisplayCate(DataTable dt)
    {
        string s = "";
        string CountChild = "";
        string link = "";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            link = LinkUpdateCate(dt.Rows[i]["IGID"].ToString());
            CountChild = GroupsExtension.CountChildCategory(dt.Rows[i]["IGID"].ToString(), "");

            s += "<div id=\"Cate-" + dt.Rows[i]["IGID"].ToString() + "\">";
            s += "<div class=\"FormatCellItem\">";
            s += "<div class=\"pdCellItem\">";
            s += "<div class=\"cot1\"><input id=\"CbGroup_" + dt.Rows[i]["IGID"].ToString() + "\" type=\"checkbox\" onclick=\"CheckAllCheckBox('CbGroup_" + dt.Rows[i]["IGID"].ToString() + "',this)\" /></div>";
            s += "<div class=\"splitc\">|</div>";
            s += "<div class=\"cot2\" align=\"left\">";
            if (!CountChild.Equals("0"))
            {
                s += "<a id=\"showhide" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:void(0)\" class=\"IcoArrowShow0\" onclick=\"ShowHideGroup('" + dt.Rows[i]["IGID"].ToString() + "');\">&nbsp;</a>";
            }
            s += dt.Rows[i]["VGNAME"].ToString();
            s += "<div class=\"cbh0\"><!----></div>";
            s += "</div>";
            s += "<div class=\"splitc\">|</div>";
            s += "<div class=\"cot3\" align=\"center\">" + SetPosition(dt.Rows[i]["VGPARAMS"].ToString()) + "</div>";
            s += "<div class=\"splitc\">|</div>";
            s += "<div class=\"cot4\" align=\"center\">" + dt.Rows[i][GroupsColumns.IgtotalitemsColumn].ToString() + "</div>";
            s += "<div class=\"splitc\">|</div>";
            s += "<div class=\"cot5\" align=\"center\"><input id=\"TbOrder" + dt.Rows[i]["IGID"].ToString() + "\" type=\"text\" value=\"" + dt.Rows[i]["IGORDER"].ToString() + "\" class=\"TextInBox\" onchange=\"UpdateOrderCate_New('" + dt.Rows[i]["IGID"].ToString() + "','0')\" /></div>";
            s += "<div class=\"splitc\">|</div>";
            s += "<div class=\"cot6\" align=\"center\"><a id=\"nc" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:UpdateEnableGroup('" + dt.Rows[i]["IGID"].ToString() + "')\" class=\"EnableIcon" + dt.Rows[i]["IGENABLE"].ToString() + "\">&nbsp;</a></div>";
            s += "<div class=\"splitc\">|</div>";
            s += "<div class=\"cot7\">";
            s += "<a href=\"" + link + "\"><span class='iconEdit'><!----></span></a>";
            s += "&nbsp;&nbsp;&nbsp;";
            s += "<a href=\"javascript:DeleteRecGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + dt.Rows[i]["VGNAME"].ToString() + "')\"><span class='iconDelete'><!----></span></a>";
            s += "</div>";
            s += "<div class=\"cbh0\"><!----></div>";
            s += "</div>";
            s += "</div>";
            igidParent = dt.Rows[i]["IGID"].ToString();
            
            if (i != dt.Rows.Count - 1)
            {
                s += "<div class=\"PdSpaceRow\"><div class=\"SpaceRow\"><!----></div></div>";
            }
            s += "</div>";
        }

        return s;
    }
    #endregion

    string SetPosition(string value)
    {
        string s = "_";
        PsgPosition listModul = new PsgPosition();
        for (int i = 0; i < listModul.Values.Length; i++)
        {
            if (listModul.Values[i] == value)
            {
                s = listModul.Text[i];
                break;
            }
        }
        return s;
    }
}