using System;
using TatThanhJsc.AdminModul;
using TatThanhJsc.Extension;
using TatThanhJsc.OtherModul;

public partial class cms_admin_Moduls_Other_Loadcontrol : System.Web.UI.UserControl
{
    private string uco = "";
    private string suc = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string userRole = "";
        
        if (Request.QueryString["uco"] != null)
            uco = Request.QueryString["uco"];
        if (Request.QueryString["suc"] != null)
            suc = Request.QueryString["suc"];
        

        userRole = CookieExtension.GetCookies("RolesUser");
        TatThanhJsc.UserModul.Roles listRoles = new TatThanhJsc.UserModul.Roles();

        SetRoad();

        switch (uco)
        {
            case CodeApplications.PageSingleContent:
                if (StringExtension.RoleInListRoles(listRoles.PageSingleContent, userRole))
                    phControl.Controls.Add(LoadControl("Psg/Loadcontrol.ascx"));
                else
                    phControl.Controls.Add(LoadControl("CommonControls/CautionStop.ascx"));
                break;
            case CodeApplications.SiteMap:
                if (StringExtension.RoleInListRoles(listRoles.SiteMap, userRole))
                    phControl.Controls.Add(LoadControl("SiteMap/Loadcontrol.ascx"));
                else
                    phControl.Controls.Add(LoadControl("CommonControls/CautionStop.ascx"));
                break;
            case CodeApplications.SupportOnline:
                if (StringExtension.RoleInListRoles(listRoles.SupportOnline, userRole))
                    phControl.Controls.Add(LoadControl("SupportOnline/Loadcontrol.ascx"));
                else
                    phControl.Controls.Add(LoadControl("CommonControls/CautionStop.ascx"));
                break;
            case CodeApplications.Vote:
                if (StringExtension.RoleInListRoles(listRoles.Vote, userRole))
                    phControl.Controls.Add(LoadControl("Vote/Loadcontrol.ascx"));
                else
                    phControl.Controls.Add(LoadControl("CommonControls/CautionStop.ascx"));
                break;


            case CodeApplications.Tag:
                if (StringExtension.RoleInListRoles(listRoles.Tag, userRole))
                    phControl.Controls.Add(LoadControl("Tag/Loadcontrol.ascx"));
                else
                    phControl.Controls.Add(LoadControl("CommonControls/CautionStop.ascx"));
                break;

            case "dclink":                
                    phControl.Controls.Add(LoadControl("DcLink/Loadcontrol.ascx"));                
                break;

            default:
                    phControl.Controls.Add(LoadControl("Index.ascx"));
                break;
        }
    }

    void SetRoad()
    {
        LtRoad.Text = "<a class=\"TextRoad\">Bạn đang ở:&nbsp;</a>";
        LtRoad.Text += "<a title=\"Trang chủ\" class=\"TextRoad\" href=\"admin.aspx\">Trang chủ</a>";
        LtRoad.Text += "<a title=\"Tính năng khác\" class=\"TextRoad arrow\" href=\"" +
                       LinkAdmin.GoAdminModul(CodeApplications.other) + "\">Tính năng khác</a>";
        if (uco.Equals(CodeApplications.SupportOnline))
        {
            LtRoad.Text += "<a title=\"Tính năng khác\" class=\"TextRoad arrow\" href=\"#\">Hỗ trợ trực tuyến</a>";
            if (suc.Equals(TypePage.Cate))
            {
                LtRoad.Text += "<a title=\"Tính năng khác\" class=\"TextRoad arrow\" href=\"#\">Quản lý danh mục hỗ trợ</a>";
            }
            else if (suc.Equals(TypePage.CreateCate))
            {
                LtRoad.Text += "<a title=\"Tạo danh mục hỗ trợ mới\" class=\"TextRoad arrow\" href=\"#\">Tạo danh mục hỗ trợ mới</a>";
            }
            else if (suc.Equals(TypePage.Item))
            {
                LtRoad.Text += "<a title=\"Quản lý danh sách hỗ trợ\" class=\"TextRoad arrow\" href=\"#\">Quản lý danh sách hỗ trợ</a>";
            }
            else if (suc.Equals(TypePage.CreateItem))
            {
                LtRoad.Text += "<a title=\"Tạo nick hỗ trợ mới\" class=\"TextRoad arrow\" href=\"#\">Tạo nick hỗ trợ mới</a>";
            }           
        }
        else if (uco.Equals(CodeApplications.PageSingleContent))
        {
            LtRoad.Text += "<a title=\"Trang nội dung\" class=\"TextRoad arrow\" href=\"#\">Trang nội dung</a>";
            if (suc.Equals(TypePage.create))
            {
                LtRoad.Text += "<a title=\"Trang nội dung\" class=\"TextRoad arrow\" href=\"#\">Tạo bài viết mới</a>";
            }
            if (suc.Equals(TypePage.update))
            {
                LtRoad.Text += "<a title=\"Cập nhật thông tin bài viết\" class=\"TextRoad arrow\" href=\"#\">Cập nhật thông tin bài viết</a>";
            }
        }
        else if (uco.Equals(CodeApplications.Vote))
        {
            LtRoad.Text += "<a title=\"Bình chọn trực tuyến\" class=\"TextRoad arrow\" href=\"#\">Bình chọn trực tuyến</a>";
            if (suc.Equals(TypePage.create))
            {
                LtRoad.Text += "<a title=\"Tạo câu hỏi mới\" class=\"TextRoad arrow\" href=\"#\">Tạo câu hỏi mới</a>";
            }
            if (suc.Equals(TypePage.update))
            {
                LtRoad.Text += "<a title=\"Cập nhật câu hỏi\" class=\"TextRoad arrow\" href=\"#\">Cập nhật câu hỏi</a>";
            }
        }
        else if (uco.Equals(CodeApplications.SiteMap))
        {
            LtRoad.Text += "<a title=\"Sơ đồ website\" class=\"TextRoad arrow\" href=\"#\">Sơ đồ website</a>";
            if (suc.Equals(TypePage.create))
            {
                LtRoad.Text += "<a title=\"Thêm mới sơ đồ website\" class=\"TextRoad arrow\" href=\"#\">Thêm mới sơ đồ website</a>";
            }
            if (suc.Equals(TypePage.update))
            {
                LtRoad.Text += "<a title=\"Cập nhật sơ đồ website\" class=\"TextRoad arrow\" href=\"#\">Cập nhật sơ đồ website</a>";
            }
        }
        LtRoad.Text += "<div class=\"cbh0\"><!----></div>";
    }
}