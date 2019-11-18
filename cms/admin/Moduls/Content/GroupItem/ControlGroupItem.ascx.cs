using System;
using System.Data;
using Developer.Position;
using TatThanhJsc.AdminModul;
using TatThanhJsc.ContentModul;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Content_GroupItem_ControlGroupItem : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string Modul = CodeApplications.ContentGroupItem;
    string ModulAddItem = CodeApplications.Content;
    private string typeModul = CodeApplications.Content;
    private string typePageCreate = TypePage.CreateGroupItem;
    private string typePageUpdate = TypePage.UpdateGroupItem;

    private string link = "";

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    string TxtLevel = "";
    private string igidParent = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["hd_parent"] != null)
        {
            hd_parent.Value = Request.QueryString["hd_parent"].ToString();
        }
        else
        {
            hd_parent.Value = "0";
        }
        if (!IsPostBack)
        {
            GetAllModul();
        }
    }

    private string LinkCreateCate()
    {
        return LinkAdmin.GoAdminSubModul(typeModul, typePageCreate);
    }

    private string LinkUpdateCate(string igid, string igparentid)
    {
        if (igparentid.Equals(""))
        {
            return LinkAdmin.GoAdminCategory(typeModul, typePageUpdate, igid);
        }
        else
        {
            return LinkAdmin.GoAdminCategory(typeModul, typePageUpdate, igid, igparentid);
        }
    }

    private string LinkAddItemToGroup(string igid, string igparentsid, string title)
    {
        return UrlExtension.WebisteUrl + "cms/admin/TempControls/PopUp/GroupsItems/AddItemsForGroup.aspx?modul=" +
               ModulAddItem +
               "&igid=" + igid + "&igparentsid=" + igparentsid;
    }

    void GetAllModul()
    {
        DataTable dt = new DataTable();
        fields = " * ";
        condition = GroupsTSql.GetGroupsCondition(language, Modul, "", " IGENABLE <> '2' ");
        orderBy = " IGORDER ASC ";
        dt = Groups.GetGroups(top, fields, condition, orderBy);

        string str = "";
        string CountChild = "";
        

        if (dt.Rows.Count > 0)
        {
            str += "<div id=\"CateOrder-0\" >";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                link = LinkUpdateCate(dt.Rows[i]["IGID"].ToString(), "");
                CountChild = GroupsExtension.CountChildCategory(dt.Rows[i]["IGID"].ToString(), "");

                str += "<div id=\"Cate-" + dt.Rows[i]["IGID"].ToString() + "\">";
                str += "<div class=\"FormatCellItem\">";
                str += "<div class=\"pdCellItem\">";
                str += "<div class=\"cot1\"><input id=\"CbGroup_" + dt.Rows[i]["IGID"].ToString() + "\" type=\"checkbox\" onclick=\"CheckAllCheckBox('CbGroup_" + dt.Rows[i]["IGID"].ToString() + "',this)\" /></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot2\" align=\"left\">";
                if (!CountChild.Equals("0"))
                {
                    str += "<a id=\"showhide" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:void(0)\" class=\"IcoArrowShow0\" onclick=\"ShowHideGroup('" + dt.Rows[i]["IGID"].ToString() + "');\">&nbsp;</a>";
                }
                str += dt.Rows[i]["VGNAME"].ToString();
                str += "<div class=\"cbh0\"><!----></div>";
                str += "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot3\" align=\"center\">" + GroupsExtension.CountItemInGroups(dt.Rows[i]["IGID"].ToString()) + "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot4\" align=\"center\">" + SetPosition(dt.Rows[i]["VGPARAMS"].ToString()) + "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot5\" align=\"center\"><input id=\"TbOrder" + dt.Rows[i]["IGID"].ToString() + "\" type=\"text\" value=\"" + dt.Rows[i]["IGORDER"].ToString() + "\" class=\"TextInBox\" onchange=\"UpdateOrderGroupItem_Content('" + dt.Rows[i]["IGID"].ToString() + "','0')\" /></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot6\" align=\"center\"><a id=\"nc" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:UpdateEnableGroup('" + dt.Rows[i]["IGID"].ToString() + "')\" class=\"EnableIcon" + dt.Rows[i]["IGENABLE"].ToString() + "\">&nbsp;</a></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot7\">";
                str += "<a href=\"javascript:void(0)\" onclick=\"NewWindow_('" + LinkAddItemToGroup(dt.Rows[i]["IGID"].ToString(),dt.Rows[i]["IGPARENTSID"].ToString(), dt.Rows[i]["VGNAME"].ToString()) + "','ImageList','800','450','yes','yes')\"><span class=\"ImageFolderAddRecord\"><!----></span></a>";
                str += "&nbsp;&nbsp;&nbsp;";
                str += "<a href=\"" + link + "\"><span class='iconEdit'><!----></span></a>";
                str += "&nbsp;&nbsp;&nbsp;";
                str += "<a href=\"javascript:DeleteGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + dt.Rows[i]["VGNAME"].ToString() + "')\"><span class='iconDelete'><!----></span></a>";
                str += "</div>";
                str += "<div class=\"cbh0\"><!----></div>";
                str += "</div>";
                str += "</div>";
                igidParent = dt.Rows[i]["IGID"].ToString();
                str += "<div id=\"" + dt.Rows[i]["IGID"].ToString() + "\"  style=\"display:none\">";
                str += GetSubCate(dt.Rows[i]["IGID"].ToString());
                str += "</div>";
                if (i != dt.Rows.Count - 1)
                {
                    str += "<div class=\"PdSpaceRow\"><div class=\"SpaceRow\"><!----></div></div>";
                }
                str += "</div>";
            }
            str += "</div>";
        }
        LtCates.Text = str;
    }

    string GetSubCate(string igparentid)
    {
        top = "";
        fields = " * ";
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(Modul),
                                             GroupsTSql.GetGroupsByVglang(language),
                                             GroupsTSql.GetGroupsByIgparentid(igparentid), " IGENABLE <> '2' ");
        orderBy = " IGORDER ASC ";
        DataTable dt = new DataTable();
        dt = Groups.GetGroups(top, fields, condition, orderBy);
        string str = "";
        string CountChild = "";
        string valueCb = "";
        if (dt.Rows.Count > 0)
        {
            str += "<div id=\"CateOrder-" + igparentid + "\" >";
            TxtLevel += "...";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                link = LinkUpdateCate(dt.Rows[i]["IGID"].ToString(), igparentid);
                CountChild = GroupsExtension.CountChildCategory(dt.Rows[i]["IGID"].ToString(), "");
                if (igidParent.Equals(igparentid))
                {
                    valueCb = "";
                }
                else
                {
                    valueCb = igparentid + "_";
                }
                str += "<div id=\"Cate-" + dt.Rows[i]["IGID"].ToString() + "\" >";
                str += "<div class=\"FormatCellItemOther\">";
                str += "<div class=\"pdCellItemOther\">";
                str += "<div class=\"cot1\"><input id=\"CbGroup_" + igidParent + "_" + valueCb + dt.Rows[i]["IGID"].ToString() + "\" type=\"checkbox\" onclick=\"CheckAllCheckBox('CbGroup_" + igidParent + "_" + valueCb + dt.Rows[i]["IGID"].ToString() + "',this)\" /></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot2\" align=\"left\">";
                if (!CountChild.Equals("0"))
                {
                    str += "<a id=\"showhide" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:void(0)\" class=\"IcoArrowShow0\" onclick=\"ShowHideGroup('" + dt.Rows[i]["IGID"].ToString() + "');\">&nbsp;</a>";
                }
                str += TxtLevel + "&nbsp;" + dt.Rows[i]["VGNAME"].ToString();
                str += "<div class=\"cbh0\"><!----></div>";
                str += "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot3\" align=\"center\">" + GroupsExtension.CountItemInGroups(dt.Rows[i]["IGID"].ToString()) + "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot4\" align=\"center\">" + SetPosition(dt.Rows[i]["VGPARAMS"].ToString()) + "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot5\" align=\"center\"><input id=\"TbOrder" + dt.Rows[i]["IGID"].ToString() + "\" type=\"text\" value=\"" + dt.Rows[i]["IGORDER"].ToString() + "\" class=\"TextInBox\" onchange=\"UpdateOrderGroupItem_Content('" + dt.Rows[i]["IGID"].ToString() + "','" + igparentid + "')\" /></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot6\" align=\"center\"><a id=\"nc" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:UpdateEnableGroup('" + dt.Rows[i]["IGID"].ToString() + "')\" class=\"EnableIcon" + dt.Rows[i]["IGENABLE"].ToString() + "\">&nbsp;</a></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot7\">";
                str += "<a href=\"" + link + "\"><span class=\"ImageFolderAddRecord\"><!----></span></a>";
                str += "&nbsp;&nbsp;&nbsp;";
                str += "<a href=\"" + link + "\"><span class=\"iconEdit\"><!----></span></a>";
                str += "&nbsp;&nbsp;&nbsp;";
                str += "<a href=\"javascript:DeleteGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + dt.Rows[i]["VGNAME"].ToString() + "')\"><span class='iconDelete'><!----></span></a>";
                str += "</div>";
                str += "<div class=\"cbh0\"><!----></div>";
                str += "</div>";
                str += "</div>";

                if (i != dt.Rows.Count - 1)
                {
                    str += "<div class=\"PdSpaceRow\"><div class=\"SpaceRowOther\"><!----></div></div>";
                }
                str += "<div id=\"" + dt.Rows[i]["IGID"].ToString() + "\"  style=\"display:none\">";
                str += GetSubCate(dt.Rows[i]["IGID"].ToString());
                str += "</div>";
                str += "</div>";

            }
            str += "</div>";
            TxtLevel = "...";

        }
        return str;
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

    protected void lbtCreate_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkCreateCate());
    }

    string SetPosition(string ValuePosition)
    {
        string str = "";
        ContentPosition listModul = new ContentPosition();
        if (listModul.Text[Convert.ToInt16(ValuePosition)] != null)
        {
            str = listModul.Text[Convert.ToInt16(ValuePosition)];    
        }
        
        return str;
    }
}