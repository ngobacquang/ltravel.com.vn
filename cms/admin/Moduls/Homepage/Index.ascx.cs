using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;
//using am.Charts;

public partial class cms_admin_Moduls_Homepage_Index : System.Web.UI.UserControl
{
    private string language = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    #region Report
    protected Double TotolViewNew = 0;
    protected Double TotolViewProduct = 0;
    protected Double TotolViewService = 0;
    protected Double TotolViewQa = 0;
    protected Double TotolViewCustomer = 0;
    protected Double TotolViewAdvertising = 0;
    protected Double TotolViewPhotolAlbum = 0;
    protected Double TotolViewFileLibrary = 0;
    protected Double TotolViewVideo = 0;

    protected Double TotolNumberNew = 0;
    protected Double TotolNumberProduct = 0;
    protected Double TotolNumberService = 0;
    protected Double TotolNumberQa = 0;
    protected Double TotolNumberCustomer = 0;
    protected Double TotolNumberAdvertising = 0;
    protected Double TotolNumberPhotolAlbum = 0;
    protected Double TotolNumberFileLibrary = 0;
    protected Double TotolNumberVideo = 0;
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadConfigs("cms/admin/Moduls/Homepage/Index.ascx");
        if (!IsPostBack)
        {
            ReportItemsWebsite();
        }
    }
    void ReportItemsWebsite()
    {
        #region Report New
        DataTable DtNew = new DataTable();
        DtNew = Items.GetItems("", "IITOTALVIEW",ItemsTSql.GetItemsCondition("", TatThanhJsc.NewsModul.CodeApplications.News), "");
        if (DtNew.Rows.Count > 0)
        {
            TotolNumberNew = DtNew.Rows.Count;
            for (int i = 0; i < DtNew.Rows.Count; i++)
            {
                TotolViewNew = TotolViewNew + Convert.ToDouble(DtNew.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        #region Report Product
        DataTable DtProduct = new DataTable();
        DtProduct = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.ProductModul.CodeApplications.Product), "");
        if (DtProduct.Rows.Count > 0)
        {
            TotolNumberProduct = DtProduct.Rows.Count;
            for (int i = 0; i < DtProduct.Rows.Count; i++)
            {
                TotolViewProduct = TotolViewProduct + Convert.ToDouble(DtProduct.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        #region Report Service
        DataTable DtService = new DataTable();
        DtService = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.ServiceModul.CodeApplications.Service), "");
        if (DtService.Rows.Count > 0)
        {
            TotolNumberService = DtService.Rows.Count;
            for (int i = 0; i < DtService.Rows.Count; i++)
            {
                TotolViewService = TotolViewService + Convert.ToDouble(DtService.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        #region Report QA
        DataTable DtQa = new DataTable();
        DtQa = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.QAModul.CodeApplications.QA), "");
        if (DtQa.Rows.Count > 0)
        {
            TotolNumberQa = DtQa.Rows.Count;
            for (int i = 0; i < DtQa.Rows.Count; i++)
            {
                TotolViewQa = TotolViewQa + Convert.ToDouble(DtQa.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        #region Report Customer
        DataTable DtCustomer = new DataTable();
        DtCustomer = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.CustomerModul.CodeApplications.Customer), "");
        if (DtCustomer.Rows.Count > 0)
        {
            TotolNumberCustomer = DtCustomer.Rows.Count;
            for (int i = 0; i < DtCustomer.Rows.Count; i++)
            {
                TotolViewCustomer = TotolViewCustomer + Convert.ToDouble(DtCustomer.Rows[i]["IITOTALVIEW"]);
            }
        }
#endregion

        #region Report Adv
        DataTable DtAdvertising = new DataTable();
        DtAdvertising = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.AdvertisingModul.CodeApplications.Advertising), "");
        if (DtAdvertising.Rows.Count > 0)
        {
            TotolNumberAdvertising = DtAdvertising.Rows.Count;
            for (int i = 0; i < DtAdvertising.Rows.Count; i++)
            {
                TotolViewAdvertising = TotolViewAdvertising + Convert.ToDouble(DtAdvertising.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        #region Report PhotoAlbum
        DataTable DtPhotolAlbum = new DataTable();
        DtPhotolAlbum = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum), "");
        if (DtPhotolAlbum.Rows.Count > 0)
        {
            TotolNumberPhotolAlbum = DtPhotolAlbum.Rows.Count;
            for (int i = 0; i < DtPhotolAlbum.Rows.Count; i++)
            {
                TotolViewPhotolAlbum = TotolViewPhotolAlbum + Convert.ToDouble(DtPhotolAlbum.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        #region Report FileLibrary
        DataTable DtFileLibrary = new DataTable();
        DtFileLibrary = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary), "");
        if (DtFileLibrary.Rows.Count > 0)
        {
            TotolNumberFileLibrary = DtFileLibrary.Rows.Count;
            for (int i = 0; i < DtFileLibrary.Rows.Count; i++)
            {
                TotolViewFileLibrary = TotolViewFileLibrary + Convert.ToDouble(DtFileLibrary.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        #region Report Video
        DataTable DtVideo = new DataTable();
        DtVideo = Items.GetItems("", "IITOTALVIEW", ItemsTSql.GetItemsCondition("", TatThanhJsc.VideoModul.CodeApplications.Video), "");
        if (DtVideo.Rows.Count > 0)
        {
            TotolNumberVideo = DtVideo.Rows.Count;
            for (int i = 0; i < DtVideo.Rows.Count; i++)
            {
                TotolViewVideo = TotolViewVideo + Convert.ToDouble(DtVideo.Rows[i]["IITOTALVIEW"]);
            }
        }
        #endregion

        LtScriptChartTotalItem.Text = @"
            var chartData1 = [{
            country1: 'Tin tức:',
            value: " + TotolNumberNew + @"
        }, {
            country1: 'Sản phẩm:',
            value: " + TotolNumberProduct + @"
        }, {
            country1: 'Dịch vụ:',
            value: " + TotolNumberService + @"
        }, {
            country1:  'Thư viện ảnh:',
            value: " + TotolNumberPhotolAlbum + @"
        }, {
            country1: 'Thư viện dữ liệu:',
            value: " + TotolNumberFileLibrary + @"
        }, {
            country1: 'Quảng cáo:',
            value: " + TotolNumberAdvertising + @"
        }];
";

        LtScriptChart.Text = @"
            var chartData = [{
            country: 'Tin tức:',
            value: " + TotolViewNew + @"
        }, {
            country: 'Sản phẩm:',
            value: " + TotolViewProduct + @"
        }, {
            country: 'Dịch vụ:',
            value: " + TotolViewService + @"
        }, {
            country:  'Thư viện ảnh:',
            value: " + TotolViewPhotolAlbum + @"
        }, {
            country: 'Thư viện dữ liệu:',
            value: " + TotolViewFileLibrary + @"
        }, {
            country: 'Quảng cáo:',
            value: " + TotolViewAdvertising + @"
        }];
";
    }

    protected string SetDisplay(bool show)
    {
        if (show)
            return "display:block";
        return "display:none";
    }

    #region Cấu hình
    /// <summary>
    /// Lấy ra các cấu hình theo đường đẫn của control cha
    /// </summary>
    /// <param name="vsdesc">Đường dẫn của control cha, vd: cms/admin/Moduls/New/Index.ascx</param>
    private void LoadConfigs(string vsdesc)
    {
        string split = "->";
        DataTable dt = new DataTable();
        dt = Settings.GetSettingsCondition("", SettingsColumns.VsvalueColumn, SettingsTSql.GetSettingsByVsdesc(vsdesc),
                                           SettingsColumns.VsvalueColumn);

        string child = "";
        string status = "";
        string[] list = new string[4];

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            list = dt.Rows[i][SettingsColumns.VsvalueColumn].ToString().Split(new string[] { split },
                                                                              StringSplitOptions.None);
            child = list[2];
            status = list[3];
            if (status == "1")
                try
                {                    
                    plLoadControls.Controls.Add(LoadControl("~/" + child));
                }
                catch (Exception)
                {                                        
                }                
        }
    }
    #endregion

}