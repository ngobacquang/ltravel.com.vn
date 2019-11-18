using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Hotel_Item_Popup_PopupThemLoaiPhongAjax : System.Web.UI.Page
{    
    private string action = "";
    private string app = CodeApplications.Hotel;
    private string appCate = CodeApplications.Hotel;
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = FolderPic.Hotel;
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
                case "LayDanhSachLoaiPhong":
                    LayDanhSachLoaiPhong();
                    break;

                case "DeleteRoomType":
                    DeleteRoomType();
                    break;

            }
        }
    }

    private void DeleteRoomType()
    {
        string isid = "";
        if(Request["isid"] != null)
            isid = StringExtension.RemoveSqlInjectionChars(Request["isid"]);

        Subitems.UpdateSubitems(SubitemsTSql.GetSubitemsByIsenable("2"), SubitemsTSql.GetSubitemsByIsid(isid));
    }

    private void LayDanhSachLoaiPhong()
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
        string order = SubitemsColumns.isOrder;
        DataTable dt = Subitems.GetSubItems("", "*", condition, order);
        if(dt.Rows.Count > 0)
        {
            s += @"
<table class='formatted'>
<tr>
    <th class='stt'>TT</th>
    <th>Loại phòng</th>
    <th>Sức chứa</th>
    <th>Giá</th>
    <th class='thuTu'>Thứ tự</th>
    <th class='trangThai'>Trạng thái</th>
    <th class='congCu'>Công cụ</th>
</tr>";
            for(int i = 0; i < dt.Rows.Count; i++)
            {
                s += @"
<tr id='row_" + dt.Rows[i][SubitemsColumns.IsidColumn] + @"'>
    <td class='tac'>" + (i + 1) + @"</td>
    <td>" +dt.Rows[i][SubitemsColumns.VstitleColumn] +@"<br/>
        " + ImagesExtension.GetImage(pic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString(), "", "itiImage", false, true, dt.Rows[i][SubitemsColumns.VscontentColumn].ToString()) + @"
    </td>
    <td class='tac'>" + dt.Rows[i][SubitemsColumns.isTotalSubitem] + @"</td>
    <td class='tac'>" + PriceExtension.HienThiGia(dt.Rows[i][SubitemsColumns.fsPrice].ToString(), dt.Rows[i][SubitemsColumns.fsSalePrice].ToString()) + @"</td>
    <td class='tac'>" + dt.Rows[i][SubitemsColumns.isOrder] + @"</td>
    <td class='tac'><span class='EnableIcon" + dt.Rows[i][SubitemsColumns.IsenableColumn] + @"'>&nbsp;</span></td>
    <td class='tac'>
        <a href='javascript:EditRoomType(" + dt.Rows[i][SubitemsColumns.IsidColumn] + @")' class='iconEdit'>Sửa</a>&nbsp;&nbsp;&nbsp;
        <a href='javascript:DeleteRoomType(" + dt.Rows[i][SubitemsColumns.IsidColumn] + @")' class='iconDelete'>Xóa</a>
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