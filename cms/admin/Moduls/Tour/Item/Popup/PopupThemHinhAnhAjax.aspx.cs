using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TourModul;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Tour_Item_Popup_PopupThemHinhAnhAjax : System.Web.UI.Page
{
    
    
    private string action = "";
    private string app = CodeApplications.TourPhoto;
    private string appCate = CodeApplications.Tour;
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    private string pic = FolderPic.Tour;
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
                case "LayDanhSachHinhAnh":
                    LayDanhSachHinhAnh();
                    break;

                case "DeletePhoto":
                    DeletePhoto();
                    break;

            }
        }
    }

    private void DeletePhoto()
    {
        string isid = "";
        if(Request["isid"] != null)
            isid = StringExtension.RemoveSqlInjectionChars(Request["isid"]);

        Subitems.UpdateSubitems(SubitemsTSql.GetSubitemsByIsenable("2"), SubitemsTSql.GetSubitemsByIsid(isid));
    }

    private void LayDanhSachHinhAnh()
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
    <th>Hình ảnh</th>    
    <th class='thuTu'>Thứ tự</th>
    <th class='trangThai'>Trạng thái</th>
    <th class='congCu'>Công cụ</th>
</tr>";
            for(int i = 0; i < dt.Rows.Count; i++)
            {
                s += @"
<tr id='row_" + dt.Rows[i][SubitemsColumns.IsidColumn] + @"'>
    <td class='tac'>" + (i + 1) + @"</td>
    <td>
        " + ImagesExtension.GetImage(pic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString(), "", "itiImage", false, true, dt.Rows[i][SubitemsColumns.VscontentColumn].ToString()) + @"&nbsp;" + dt.Rows[i][SubitemsColumns.VstitleColumn] + @"
    </td>    
    <td class='tac'>" + dt.Rows[i][SubitemsColumns.VsatuthorColumn].ToString() + @"</td>
    <td class='tac'><span class='EnableIcon" + dt.Rows[i][SubitemsColumns.IsenableColumn] + @"'>&nbsp;</span></td>
    <td class='tac'>
        <a href='javascript:EditPhoto(" + dt.Rows[i][SubitemsColumns.IsidColumn] + @")' class='iconEdit'>Sửa</a>&nbsp;&nbsp;&nbsp;
        <a href='javascript:DeletePhoto(" + dt.Rows[i][SubitemsColumns.IsidColumn] + @")' class='iconDelete'>Xóa</a>
    </td>
</tr>";
            }


s+="</table>";
        }

        Response.Write(s);
    }

}