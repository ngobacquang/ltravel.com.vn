using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.ProductModul;
using TatThanhJsc.TSql;


/// <summary>
/// Hướng dẫn sử dụng:
/// Dùng để thêm các trường khác vào chi tiết sản phẩm, vd: trạng thái hàng, số sao, xuất sứ...
/// Giải pháp: thêm một bản ghi vào subitems cho sản phẩm đó. Các thông số trên sẽ được lưu vào các trường trong subitems tùy theo cách bố trí của người lập trình. VD: vsTitle - trạng thái hàng, vsUrl - xuất sứ...
/// Khi hiển thị: tìm bản ghi trong subitems theo iid và subapp. Hiển thị ra các thông tin theo cách bố trí khi lưu vào.
/// </summary>
public partial class cms_api_Product_Item_Index : System.Web.UI.UserControl
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
    private string subApp = CodeApplications.ProductOthersFields;
    private string app = CodeApplications.Product;

    #region Không cần thay đổi        
    protected void Page_Load(object sender, EventArgs e)
    {        
        iid.Value = QueryStringExtension.GetQueryString("iid");        
        suc = Request.QueryString["suc"];

        if (!IsPostBack)
        {
            //Chỉ thực hiện khi cập nhật và có trường khác
            if (pnOtherFields.Controls.Count > 0 && suc.Equals(TypePage.UpdateItem))
                LoadSubItemInfo();               
        }
    }
    #endregion

    /// <summary>
    /// Lấy thông tin của các trường khác trong subitems
    /// </summary>
    private void LoadSubItemInfo()
    {
        #region Không cần thay đổi
        DataTable dt = new DataTable();
        condition = DataExtension.AndConditon(
            SubitemsTSql.GetSubitemsByIid(iid.Value),
            SubitemsTSql.GetSubitemsByVskey(subApp));
        dt = Subitems.GetSubItems("1", "*", condition, "isid desc");
        #endregion        
        
        if (dt.Rows.Count>0)
        {            
            isid.Value = dt.Rows[0][SubitemsColumns.IsidColumn].ToString();

            //Điền dữ liệu ra các controls theo vị trí mà lập trình đã lưu vào.
            //Hiện lên khi cần dùng

            txtquicach.Text = dt.Rows[0][SubitemsColumns.VscontentColumn].ToString();
            txtmausac.Text = dt.Rows[0][SubitemsColumns.VsimageColumn].ToString();
            txtkichthuoc.Text = dt.Rows[0][SubitemsColumns.VsemailColumn].ToString();
            txtxuatxu.Text = dt.Rows[0][SubitemsColumns.VsatuthorColumn].ToString();
        }
    }
    #region Không cần thay đổi        
    protected void btOK_Click(object sender, EventArgs e)
    {
        if (btnHandler != null)
            btnHandler(string.Empty);

        //Nếu là cập nhật
        if (suc.Equals(TypePage.UpdateItem))
        {
            //Response.Write(isid.Value + "-" + iid.Value);

            //Xóa bản ghi cũ trong subitems
            Subitems.DeleteSubitems(isid.Value);            

            //Thêm thông tin phụ vào bảng subitems. Các thông tin phụ được tổ chức tùy theo ý của lập trình
            InsertSubitem(iid.Value);            
        }
        else
        {
            //iid= Lấy ra iid vủa được thêm
            iid.Value = GetIid();

            //Thêm thông tin phụ vào bảng subitems. Các thông tin phụ được tổ chức tùy theo ý của lập trình
            InsertSubitem(iid.Value);
        }

        if (Session["CotinuteCreate"] != null)
        {
            if ((bool) Session["CotinuteCreate"])
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
                    "ThongBao(3000,'Đã tạo: " + Session["CotinuteCreateTitle"] + "');", true);
                return;
            }
        }
        Response.Redirect(Session["CotinuteCreateRedirectLink"].ToString());
    }
    #endregion
    /// <summary>
    /// Thêm thông tin phụ vào bảng subitems. Các thông tin phụ được tổ chức tùy theo ý của lập trình
    /// </summary>
    /// <param name="iid"></param>
    private void InsertSubitem(string iid)
    {     
        //Hiện lên khi cần dùng
        Subitems.InsertSubitems(iid, lang, subApp, "",txtquicach.Text,txtmausac.Text,txtkichthuoc.Text,txtxuatxu.Text, "", DateTime.Now.ToString(), "", "", "1");
    }

    #region Không cần thay đổi
    private string GetIid()
    {
        condition = ItemsTSql.GetItemsByViapp(app);
        DataTable dt = new DataTable();
        dt = GroupsItems.GetAllData("1", "Items.iid", condition, ItemsColumns.IidColumn + " desc");
        if (dt.Rows.Count > 0)
            return dt.Rows[0][ItemsColumns.IidColumn].ToString();
        return "";
    }
    #endregion

}