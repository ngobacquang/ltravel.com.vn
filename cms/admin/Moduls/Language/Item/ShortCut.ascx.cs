using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;

public partial class cms_admin_Moduls_Language_Item_ShortCut : System.Web.UI.UserControl
{
    private string top = "";
    private string fields = "*";
    private string condition = "";
    private string orderby = "";
    private string app = TatThanhJsc.LanguageModul.CodeApplications.Language;
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    private string LinkRedrect()
    {
        return UrlExtension.WebisteUrl + "admin.aspx?uc=" + app + "&suc=code";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
    }


    protected void btCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(LinkRedrect());
    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        //Dựa vào kết quả trả về để đưa ra thông báo
        /*
         * 0: Nhập dữ liệu thành công, không xuất hiện lỗi
         * 1: Nhập dữ liệu thất bại, hãy chọn tệp Excel(*.xls)
         * 2: Nhập dữ liệu thất bại, lỗi định dạng (Xem chú ý: "lỗi định dạng")
         */
        switch (ImportExcel())
        {
            case 0:
                ScriptManager.RegisterStartupScript(btOK, btOK.GetType(), "results", "alert('Nhập dữ liệu thành công!');location.href='" + LinkRedrect() + "';", true);
                break;
            case 1:
                ScriptManager.RegisterStartupScript(btOK, btOK.GetType(), "results", "alert('Nhập dữ liệu thất bại! Hãy chọn đúng tệp Excel(*.xls).');", true);
                break;
            case 2:
                ScriptManager.RegisterStartupScript(btOK, btOK.GetType(), "results", "alert('Nhập dữ liệu thất bại! Lỗi định dạng (Xem chú ý: lỗi định dạng).');", true);
                break;
            default:
                ScriptManager.RegisterStartupScript(btOK, btOK.GetType(), "results", "alert('Nhập dữ liệu thất bại! Bạn vui lòng thử lại.');", true);
                break;
        }

        #region Logs
        string logAuthor = CookieExtension.GetCookies("LoginSetting");
        string logCreateDate = DateTime.Now.ToString();
        Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", "", logAuthor, "", logCreateDate + ": " + logAuthor + " nhập từ khóa từ tệp excel ");
        #endregion
    }
    protected void OnExport()
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        //Dat lai ten cho cac cot
        dt.Columns.Add("Mã từ khoá(không trùng nhau, không bỏ trống)");
        dt.Columns.Add("Mô tả");

        ds.Tables.Add(dt.Copy());
        DownloadExcelFile1.DSSource = ds;
    }
    int ImportExcel()
    {
        if (fuExcel.FileName.Length > 3)
        {
            if (fuExcel.FileName.Substring(fuExcel.FileName.Length - 3, 3) == "xls")
            {
                try
                {
                    //Nhập dữ liệu từ file excel vào dataset
                    DataSet ds = new DataSet();
                    ds = ExcelExtension.ImportExcelXLS(fuExcel.PostedFile, true);

                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        //Thêm thông tin vào csdl
                        // ds.Tables[0].Rows[i][].ToString()
                        if (ds.Tables[0].Rows[i][0].ToString().Length > 0)
                            LanguageKey.InsertLanguageKeyProc(ds.Tables[0].Rows[i][0].ToString(), ds.Tables[0].Rows[i][1].ToString());
                    }
                    return 0;
                }
                catch
                {
                    return 2;
                }
            }
            else return 1;
        }
        else
        {
            return 1;
        }
    }   
}