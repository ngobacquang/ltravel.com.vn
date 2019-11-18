using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.NewsModul;
using TatThanhJsc.TSql;


/// <summary>
/// Hướng dẫn sử dụng:
/// Dùng để thêm các trường khác vào danh mục tin tức, vd: video youtube cho danh mục, ảnh thứ hai cho một danh mục
/// Giải pháp: thêm một bản ghi vào item cho tin tức đó. Các thông số trên sẽ được lưu vào các trường trong items tùy theo cách bố trí của người lập trình. VD: viTitle - mã video...
/// Khi hiển thị: tìm bản ghi trong items theo igid và subapp. Hiển thị ra các thông tin theo cách bố trí khi lưu vào.
/// </summary>
public partial class cms_api_New_Cate_Index : System.Web.UI.UserControl
{
    #region Không cần thay đổi
    // Delegate declaration 
    public delegate void OnButtonClick(string strValue);
    // Event declaration 
    public event OnButtonClick btnHandler;

    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string suc = "";

    private string top = "", fields = "", condition = "", orderby = "";
    #endregion
  
    /// <summary>
    /// App để phân biệt bản ghi trong subitems (cần có để phân biệt với các bản khi khác cũng thuộc subitems, vd: comment, ảnh khác)
    /// </summary>
    private string subApp = "NewOthersFields";
    private string app = CodeApplications.News;

    #region Không cần thay đổi        
    protected void Page_Load(object sender, EventArgs e)
    {        
        igid.Value = QueryStringExtension.GetQueryString("igid");        
        suc = Request.QueryString["suc"];

        if (!IsPostBack)
        {
            //Chỉ thực hiện khi cập nhật và có trường khác
            if (pnOtherFields.Controls.Count > 0 && suc.Equals(TypePage.UpdateCate))
                LoadSubInfo();               
        }
    }
    #endregion

    /// <summary>
    /// Lấy thông tin của các trường khác trong item
    /// </summary>
    private void LoadSubInfo()
    {
        #region Không cần thay đổi
        DataTable dt = new DataTable();
        condition = DataExtension.AndConditon(
            GroupsTSql.GetGroupsByIgid(igid.Value),
            ItemsTSql.GetItemsByIienable("1"),
            ItemsTSql.GetItemsByViapp(subApp)
            );        

        dt = GroupsItems.GetAllData("1", "*", condition, "groups_items.igiid desc");
        #endregion        
        
        if (dt.Rows.Count>0)
        {            
            iid.Value = dt.Rows[0][ItemsColumns.IidColumn].ToString();

            //Điền dữ liệu ra các controls theo vị trí mà lập trình đã lưu vào.
            //Hiện lên khi cần dùng
            //tbYouTubeCode.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();            
        }
    }
    #region Không cần thay đổi        
    protected void btOK_Click(object sender, EventArgs e)
    {
        if (btnHandler != null)
            btnHandler(string.Empty);

        //Nếu là cập nhật
        if (suc.Equals(TypePage.UpdateCate) && iid.Value.Length>0)
        {                    
            //Cập nhật thông tin phụ vào bảng item. Các thông tin phụ được tổ chức tùy theo ý của lập trình
            UpdateSubInfo(iid.Value);            
        }
        else
        {
            //iid= Lấy ra igid vừa được thêm
            igid.Value = GetIgid();

            //Thêm thông tin phụ vào bảng item. Các thông tin phụ được tổ chức tùy theo ý của lập trình
            InsertSubInfo(igid.Value);
        }

        if (Session["CotinuteCreateCate"] != null)
        {
            if ((bool) Session["CotinuteCreateCate"])
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
                    "ThongBao(3000,'Đã tạo: " + Session["CotinuteCreateTitleCate"] + "');", true);
                return;
            }
        }
        Response.Redirect(Session["CotinuteCreateRedirectLinkCate"].ToString());
    }

    /// <summary>
    /// Cập nhật thông tin phụ vào bảng Item. Các thông tin phụ được tổ chức tùy theo ý của lập trình
    /// </summary>
    /// <param name="p"></param>
    private void UpdateSubInfo(string igid)
    {
        //Hiện lên khi cần dùng
        //Items.UpdateItems(lang, subApp, "", tbYouTubeCode.Text, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), "1", iid.Value);
    }
    #endregion
    /// <summary>
    /// Thêm thông tin phụ vào bảng Item. Các thông tin phụ được tổ chức tùy theo ý của lập trình
    /// </summary>
    /// <param name="igid"></param>
    private void InsertSubInfo(string igid)
    {     
        //Hiện lên khi cần dùng
        //GroupsItems.InsertItemsGroupsItems(lang, subApp, "", tbYouTubeCode.Text, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "", igid, DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "", "1");
    }

    #region Không cần thay đổi
    private string GetIgid()
    {
        condition = GroupsTSql.GetGroupsByVgapp(app);
        DataTable dt = new DataTable();
        dt = Groups.GetGroups("1", GroupsColumns.IgidColumn, condition, GroupsColumns.IgidColumn + " desc");
        if (dt.Rows.Count > 0)
            return dt.Rows[0][GroupsColumns.IgidColumn].ToString();
        return "";
    }
    #endregion

}