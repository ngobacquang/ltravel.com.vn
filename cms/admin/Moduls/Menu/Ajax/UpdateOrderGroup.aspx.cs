using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
using TatThanhJsc.MenuModul;

public partial class cms_admin_Ajax_Groups_UpdateOrderGroup : System.Web.UI.Page
{
    
    private string igid = "";
    private string igorder = "";

    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();    

    private string top = "";
    private string fields = "";
    private string condition = "";
    private string orderBy = "";

    string TxtLevel = "";
    private string igidParent = "";
    private string igparentidCurrent = "";
    private string app = "";
    //private string typePageCreate = TypePage.CreateMenuBottom;
    //private string typePageUpdate = TypePage.UpdateMenuBottom;
    //private string linkCreate = "";
    private string linkUpdate = "";
    private string uc = "Menu";

    protected void Page_Load(object sender, EventArgs e)
    {
        igid = Request["igid"];
        igorder = Request["igorder"];
        igparentidCurrent = Request["igparentid"];
        app = Request["app"];

        UpdateOrder();

        Response.Write(GetAllModul());
        Response.End();
    }


    void UpdateOrder()
    {
        string[] fieldsDelGroup = { "IGORDER"};
        string[] valuesDelGroup = { igorder};
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByIgid(igid));
        Groups.UpdateGroupsCondition(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);
    }

    string GetAllModul()
    {
        string str = "";
        if (igparentidCurrent.Equals("0"))
        {
            DataTable dt = new DataTable();
            fields = "*";
            condition = GroupsTSql.GetGroupsCondition(language, app, "", " IGENABLE <> '2' ");
            orderBy = " IGORDER ASC ";
            dt = Groups.GetGroups(top, fields, condition, orderBy);

            
            string CountChild = "";

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //linkUpdate = Link.GoAdminCategory(TypeModul.Menu, typePageUpdate, dt.Rows[i]["IGID"].ToString());
                    linkUpdate = "?uc=" + uc + "&app=" + app + "&suc=" + TypePage.update + "&igid=" + dt.Rows[i]["IGID"].ToString();

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
                    str += "<div class=\"cot3\"><div class=\"EnableIcon" + GetValueEnable(dt.Rows[i]["VGPARAMS"].ToString()) + "\"><!----></div></div>";
                    str += "<div class=\"splitc\">|</div>";
                    str += "<div class=\"cot4\">" + GroupsExtension.CountChildCategory(dt.Rows[i]["IGID"].ToString(), "") + "</div>";
                    str += "<div class=\"splitc\">|</div>";
                    str += "<div class=\"cot5\"><input id=\"TbOrder" + dt.Rows[i]["IGID"].ToString() + "\" type=\"text\" value=\"" + dt.Rows[i]["IGORDER"].ToString() + "\" class=\"TextInBox\" onchange=\"UpdateOrderGroup('" + dt.Rows[i]["IGID"].ToString() + "','0','"+app+"')\" /></div>";
                    str += "<div class=\"splitc\">|</div>";
                    str += "<div class=\"cot6\"><a id=\"nc" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:UpdateEnableGroup('" + dt.Rows[i]["IGID"].ToString() + "')\" class=\"EnableIcon" + dt.Rows[i]["IGENABLE"].ToString() + "\">&nbsp;</a></div>";
                    str += "<div class=\"splitc\">|</div>";
                    str += "<div class=\"cot7\">";
                    str += "<a href=\"" + linkUpdate + "&psc=" + GetValueEnable(dt.Rows[i]["VGPARAMS"].ToString()) + "\"><span class='iconEdit'><!----></span></a>";
                    str += "&nbsp;&nbsp;&nbsp;";
                    str += "<a href=\"javascript:DeleteGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + dt.Rows[i]["VGNAME"].ToString() + "')\"><span class='iconDelete'><!----></span></a>";
                    str += "</div>";
                    str += "<div class=\"cbh0\"><!----></div>";
                    str += "</div>";
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
                }
            }    
        }
        else
        {
            str = GetSubCate(igparentidCurrent);
        }
        
        return str;
    }

    string GetSubCate(string igparentid)
    {
        
        top = "";
        fields = " * ";
        condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(app),
                                             GroupsTSql.GetGroupsByVglang(language),
                                             GroupsTSql.GetGroupsByIgparentid(igparentid), " IGENABLE <> '2' ");
        orderBy = " IGORDER ASC ";
        DataTable dt = new DataTable();
        dt = Groups.GetGroups(top, fields, condition, orderBy);
        string str = "";
        string linkUpdate = "";
        string CountChild = "";
        string valueCb = "";
        if (dt.Rows.Count > 0)
        {
            str += "<div id=\"CateOrder-" + igparentid + "\" >";
            TxtLevel += "...";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //linkUpdate = Link.GoAdminCategory(TypeModul.Menu, TypePage.UpdateCate, dt.Rows[i]["IGID"].ToString(), igparentid);
                linkUpdate = "?uc=" + uc + "&app=" + app + "&suc=" + TypePage.update + "&igid=" + dt.Rows[i]["IGID"].ToString();

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
                str += "<div class=\"cot3\"><div class=\"EnableIcon" + GetValueEnable(dt.Rows[i]["VGPARAMS"].ToString()) + "\"><!----></div></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot4\">" + CountChild + "</div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot5\"><input id=\"TbOrder" + dt.Rows[i]["IGID"].ToString() + "\" type=\"text\" value=\"" + dt.Rows[i]["IGORDER"].ToString() + "\" class=\"TextInBox\" onchange=\"UpdateOrderGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + dt.Rows[i]["IGPARENTID"].ToString() + "','"+app+"')\" /></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot6\"><a id=\"nc" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:UpdateEnableGroup('" + dt.Rows[i]["IGID"].ToString() + "')\" class=\"EnableIcon" + dt.Rows[i]["IGENABLE"].ToString() + "\">&nbsp;</a></div>";
                str += "<div class=\"splitc\">|</div>";
                str += "<div class=\"cot7\">";
                str += "<a href=\"" + linkUpdate + "&psc=" + GetValueEnable(dt.Rows[i]["VGPARAMS"].ToString()) + "\"><span class='iconEdit'><!----></span></a>";
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
}