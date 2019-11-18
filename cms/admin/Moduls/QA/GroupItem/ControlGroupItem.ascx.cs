using System;
using System.Data;
using Developer.Position;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.QAModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_QA_GroupItem_ControlGroupItem : System.Web.UI.UserControl
{
  private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

  private string app = CodeApplications.QAGroupItem;
  string appAddItem = CodeApplications.QA;
  private string typeModul = CodeApplications.QA;

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
    return Link.LnkMnQAGroupItemCreate();
  }

  private string LinkUpdateCate(string igid, string igparentid)
  {
    if (igparentid.Equals(""))
    {
      return LinkAdmin.GoAdminCategory(typeModul, TypePage.UpdateGroupItem, igid);
    }
    else
    {
      return LinkAdmin.GoAdminCategory(typeModul, TypePage.UpdateGroupItem, igid, igparentid);
    }
  }
  #endregion


  private string LinkAddItemToGroup(string igid, string igparentsid, string title)
  {
    return UrlExtension.WebisteUrl + "cms/admin/TempControls/PopUp/GroupsItems/AddItemsForGroup.aspx?modul=" +
           appAddItem +
           "&igid=" + igid + "&igparentsid=" + igparentsid;
  }

  void GetCate()
  {
    DataTable dt = new DataTable();
    fields = " * ";
    condition = GroupsTSql.GetGroupsCondition(language, app, "", " IGENABLE <> '2' ");
    orderBy = " IGORDER ASC ";
    dt = Groups.GetGroups(top, fields, condition, orderBy);

    if (dt.Rows.Count > 0)
    {
      LtCates.Text += "<div id=\"CateOrder-0\" >";
      LtCates.Text += DisplayCate(dt);
      LtCates.Text += "</div>";
    }
  }

  public string GetSubCate(string igparentid)
  {
    top = "";
    fields = " * ";
    condition = DataExtension.AndConditon(GroupsTSql.GetGroupsByVgapp(app),
                                         GroupsTSql.GetGroupsByVglang(language),
                                         GroupsTSql.GetGroupsByIgparentid(igparentid), " IGENABLE <> '2' ");
    orderBy = " IGORDER ASC ";
    DataTable dt = new DataTable();
    dt = Groups.GetGroups(top, fields, condition, orderBy);
    string s = "";
    if (dt.Rows.Count > 0)
    {
      s += "<div id=\"CateOrder-" + igparentid + "\" >";
      TxtLevel += "...";
      s += DisplaySubCate(dt, igparentid);
      s += "</div>";
      TxtLevel = TxtLevel.Remove(TxtLevel.Length - "...".Length);
    }
    return s;
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

  string SetPosition(string value)
  {
    string s = "_";
    QAPosition listModul = new QAPosition();
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

  #region Hai hàm hiển thị danh sách
  public string DisplayCate(DataTable dt)
  {
    string s = "";
    string CountChild = "";
    string link = "";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
      link = LinkUpdateCate(dt.Rows[i]["IGID"].ToString(), "");
      CountChild = GroupsExtension.CountChildCategory(dt.Rows[i]["IGID"].ToString(), "");

      s += "<div id=\"Cate-" + dt.Rows[i]["IGID"].ToString() + "\">";
      s += "<div class=\"FormatCellItem\">";
      s += "<div class=\"pdCellItem\">";
      s += "<div class=\"cot1 box-cb\"><input id=\"CbGroup_" + dt.Rows[i]["IGID"].ToString() + "\" type=\"checkbox\" onclick=\"CheckAllCheckBox('CbGroup_" + dt.Rows[i]["IGID"].ToString() + "',this)\" /></div>";
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
      s += "<div class=\"cot3\" align=\"center\">" + GroupsExtension.CountItemInGroups(dt.Rows[i]["IGID"].ToString()) + "</div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot4\" align=\"center\">" + SetPosition(dt.Rows[i]["VGPARAMS"].ToString()) + "</div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot5\" align=\"center\"><input id=\"TbOrder" + dt.Rows[i]["IGID"].ToString() + "\" type=\"text\" value=\"" + dt.Rows[i]["IGORDER"].ToString() + "\" class=\"TextInBox box-stt\" onchange=\"UpdateOrderGroupItem_QA('" + dt.Rows[i]["IGID"].ToString() + "','0')\" /></div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot6\" align=\"center\"><a id=\"nc" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:UpdateEnableGroup('" + dt.Rows[i]["IGID"].ToString() + "')\" class=\"EnableIcon" + dt.Rows[i]["IGENABLE"].ToString() + "\">&nbsp;</a></div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot7 box-cc\">";
      s += "<a href=\"javascript:void(0)\" onclick=\"NewWindow_('" + LinkAddItemToGroup(dt.Rows[i]["IGID"].ToString(), dt.Rows[i]["IGPARENTSID"].ToString(), dt.Rows[i]["VGNAME"].ToString()) + "','ImageList','800','450','yes','yes')\"><span class=\"ImageFolderAddRecord\"><!----></span></a>";
      s += "&nbsp;&nbsp;&nbsp;";
      s += "<a href=\"" + link + "\"><span class='iconEdit'><!----></span></a>";
      s += "&nbsp;&nbsp;&nbsp;";
      s += "<a href=\"javascript:DeleteGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + dt.Rows[i]["VGNAME"].ToString() + "')\"><span class='iconDelete'><!----></span></a>";
      s += "</div>";
      s += "<div class=\"cbh0\"><!----></div>";
      s += "</div>";
      s += "</div>";
      igidParent = dt.Rows[i]["IGID"].ToString();
      s += "<div id=\"" + dt.Rows[i]["IGID"].ToString() + "\"  style=\"display:none\">";
      s += GetSubCate(dt.Rows[i]["IGID"].ToString());
      s += "</div>";
      if (i != dt.Rows.Count - 1)
      {
        s += "<div class=\"PdSpaceRow\"><div class=\"SpaceRow\"><!----></div></div>";
      }
      s += "</div>";
    }
    return s;
  }
  public string DisplaySubCate(DataTable dt, string igparentid)
  {
    string s = "";
    string CountChild = "";
    string valueCb = "";
    string link = "";
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
      s += "<div id=\"Cate-" + dt.Rows[i]["IGID"].ToString() + "\" >";
      s += "<div class=\"FormatCellItemOther\">";
      s += "<div class=\"pdCellItemOther\">";
      s += "<div class=\"cot1 box-cb\"><input id=\"CbGroup_" + igidParent + "_" + valueCb + dt.Rows[i]["IGID"].ToString() + "\" type=\"checkbox\" onclick=\"CheckAllCheckBox('CbGroup_" + igidParent + "_" + valueCb + dt.Rows[i]["IGID"].ToString() + "',this)\" /></div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot2\" align=\"left\">";
      if (!CountChild.Equals("0"))
      {
        s += "<a id=\"showhide" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:void(0)\" class=\"IcoArrowShow0\" onclick=\"ShowHideGroup('" + dt.Rows[i]["IGID"].ToString() + "');\">&nbsp;</a>";
      }
      s += TxtLevel + "&nbsp;" + dt.Rows[i]["VGNAME"].ToString();
      s += "<div class=\"cbh0\"><!----></div>";
      s += "</div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot3\" align=\"center\">" + GroupsExtension.CountItemInGroups(dt.Rows[i]["IGID"].ToString()) + "</div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot4\" align=\"center\">" + SetPosition(dt.Rows[i]["VGPARAMS"].ToString()) + "</div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot5\" align=\"center\"><input id=\"TbOrder" + dt.Rows[i]["IGID"].ToString() + "\" type=\"text\" value=\"" + dt.Rows[i]["IGORDER"].ToString() + "\" class=\"TextInBox box-stt\" onchange=\"UpdateOrderGroupItem_QA('" + dt.Rows[i]["IGID"].ToString() + "','" + igparentid + "')\" /></div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot6\" align=\"center\"><a id=\"nc" + dt.Rows[i]["IGID"].ToString() + "\" href=\"javascript:UpdateEnableGroup('" + dt.Rows[i]["IGID"].ToString() + "')\" class=\"EnableIcon" + dt.Rows[i]["IGENABLE"].ToString() + "\">&nbsp;</a></div>";
      s += "<div class=\"splitc\">|</div>";
      s += "<div class=\"cot7 box-cc\">";
      s += "<a href=\"javascript:void(0)\" onclick=\"NewWindow_('" + LinkAddItemToGroup(dt.Rows[i]["IGID"].ToString(), dt.Rows[i]["IGPARENTSID"].ToString(), dt.Rows[i]["VGNAME"].ToString()) + "','ImageList','800','450','yes','yes')\"><span class=\"ImageFolderAddRecord\"><!----></span></a>";
      s += "&nbsp;&nbsp;&nbsp;";
      s += "<a href=\"" + link + "\"><span class=\"iconEdit\"><!----></span></a>";
      s += "&nbsp;&nbsp;&nbsp;";
      s += "<a href=\"javascript:DeleteGroup('" + dt.Rows[i]["IGID"].ToString() + "','" + dt.Rows[i]["VGNAME"].ToString() + "')\"><span class='iconDelete'><!----></span></a>";
      s += "</div>";
      s += "<div class=\"cbh0\"><!----></div>";
      s += "</div>";
      s += "</div>";

      if (i != dt.Rows.Count - 1)
      {
        s += "<div class=\"PdSpaceRow\"><div class=\"SpaceRowOther\"><!----></div></div>";
      }
      s += "<div id=\"" + dt.Rows[i]["IGID"].ToString() + "\"  style=\"display:none\">";
      s += GetSubCate(dt.Rows[i]["IGID"].ToString());
      s += "</div>";
      s += "</div>";

    }
    return s;
  }
  #endregion
}