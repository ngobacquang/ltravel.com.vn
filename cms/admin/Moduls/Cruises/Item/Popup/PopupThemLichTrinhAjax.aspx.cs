﻿using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.CruisesModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Cruises_Item_Popup_PopupThemLichTrinhAjax : System.Web.UI.Page
{
    
    
    private string action = "";
    private string app = CodeApplications.CruisesItinerary;
    private string appCate = CodeApplications.Cruises;
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = FolderPic.Cruises;
    protected void Page_Load(object sender, EventArgs e)
    {
        #region Kiểm tra đăng nhập
        if (!CookieExtension.CheckValidCookies("LoginSetting"))
        {
            this.Visible = false;
            return;
        }
        #endregion

        action = Request["action"];
        if(!IsPostBack)
        {
            switch(action)
            {
                case "LayDanhSachLichTrinh":
                    LayDanhSachLichTrinh();
                    break;

                case "DeleteItinerary":
                    DeleteItinerary();
                    break;

            }
        }
    }

    private void DeleteItinerary()
    {
        string isid = "";
        if(Request["isid"] != null)
            isid = StringExtension.RemoveSqlInjectionChars(Request["isid"]);

        Subitems.UpdateSubitems(SubitemsTSql.GetSubitemsByIsenable("2"), SubitemsTSql.GetSubitemsByIsid(isid));
    }

    private void LayDanhSachLichTrinh()
    {
        string s = "";
        string iid = "";
        if(Request["iid"] != null)
            iid = StringExtension.RemoveSqlInjectionChars(Request["iid"]);

        string condition = DataExtension.AndConditon(
            SubitemsTSql.GetSubitemsByVskey(app),
            SubitemsTSql.GetSubitemsByIid(iid),
            SubitemsTSql.GetSubitemsByVslang(lang),
            SubitemsColumns.IsenableColumn + "<>2"
            );
        string order = "[dbo].[RemoveTextIfNotIsFloat]("+SubitemsColumns.VsatuthorColumn+")";
        DataTable dt = Subitems.GetSubItems("", "*", condition, order);
        if(dt.Rows.Count > 0)
        {
            s += @"
<table class='formatted'>
<tr>
    <th class='stt'>TT</th>
    <th>Hoạt động</th>
    <th>Điểm đến</th>
    <th>Bữa ăn</th>
    <th class='thuTu'>Thứ tự</th>
    <th class='trangThai'>Trạng thái</th>
    <th class='congCu'>Công cụ</th>
</tr>";
            for(int i = 0; i < dt.Rows.Count; i++)
            {
                s += @"
<tr id='row_" + dt.Rows[i][SubitemsColumns.IsidColumn] + @"'>
    <td class='tac'>" + (i + 1) + @"</td>
    <td>" +StringExtension.LayChuoi(dt.Rows[i][SubitemsColumns.VstitleColumn].ToString(),"",1)+": "+StringExtension.LayChuoi(dt.Rows[i][SubitemsColumns.VstitleColumn].ToString(),"",2)+@"<br/>
        " + ImagesExtension.GetImage(pic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString(), "", "itiImage", false, true, dt.Rows[i][SubitemsColumns.VscontentColumn].ToString()) + @"
    </td>
    <td>" + HienThiDiemDen(dt.Rows[i][SubitemsColumns.VsurlColumn].ToString()) + @"</td>
    <td>" + HienThiBuaAn(dt.Rows[i][SubitemsColumns.VsemailColumn].ToString()) + @"</td>
    <td class='tac'>" + dt.Rows[i][SubitemsColumns.VsatuthorColumn].ToString() + @"</td>
    <td class='tac'><span class='EnableIcon" + dt.Rows[i][SubitemsColumns.IsenableColumn] + @"'>&nbsp;</span></td>
    <td class='tac'>
        <a href='javascript:EditItinerary(" + dt.Rows[i][SubitemsColumns.IsidColumn] + @")' class='iconEdit'>Sửa</a>&nbsp;&nbsp;&nbsp;
        <a href='javascript:DeleteItinerary(" + dt.Rows[i][SubitemsColumns.IsidColumn] + @")' class='iconDelete'>Xóa</a>
    </td>
</tr>";
            }


s+="</table>";
        }

        Response.Write(s);
    }

    private string HienThiDiemDen(string diemDen)
    {
        string s = "";
        if (diemDen.StartsWith("text-"))
            s = diemDen.Substring("text-".Length);
        if (diemDen.StartsWith("id-"))
        {
            string listId = "," + diemDen.Substring("id-".Length) + ",";
            string condition = DataExtension.AndConditon(
                GroupsTSql.GetGroupsByVgapp(TatThanhJsc.DestinationModul.CodeApplications.Destination),
                GroupsTSql.GetGroupsByVglang(lang),
                GroupsColumns.IgenableColumn + "<>2",
                "charindex(','+cast(igid as varchar)+',','" + listId + "')>0"
                );
            string order = GroupsColumns.IgorderColumn + "," + GroupsColumns.VgnameColumn;

            DataTable dt = Groups.GetGroups("", GroupsColumns.VgnameColumn, condition, order);
            for(int i = 0; i < dt.Rows.Count; i++)
            {
                s += dt.Rows[i][GroupsColumns.VgnameColumn] + ", ";
            }
            if (s.Length > 0)
                s = s.Remove(s.Length - ", ".Length);
        }

        return s;
    }

    private string HienThiBuaAn(string listId)
    {
        string s = "";
        if(listId.IndexOf("1") > -1)
            s += "Sáng, ";

        if(listId.IndexOf("2") > -1)
            s += "Trưa, ";

        if(listId.IndexOf("3") > -1)
            s += "Tối, ";

        if(s.Length > 0)
            s = s.Remove(s.Length - ", ".Length);

        return s;
    }

}