using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_Hotel_Controls_Detail : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      LoadDetail();
    }
  }
  void LoadDetail()
  {
    DataTable dt = (DataTable)Session["dataByTitle"];
    if (dt.Rows.Count > 0)
    {
      UpdateTotalView(dt.Rows[0][ItemsColumns.IidColumn].ToString());
      ltrTitle.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
     
      ltContent.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.VicontentColumn].ToString(), "", 9);

      string price = dt.Rows[0][ItemsColumns.FipriceColumn].ToString();
      string salePrice = dt.Rows[0][ItemsColumns.FisalepriceColumn].ToString();

      if (price == "0" || price == "")
      {
        price = "";
        salePrice = LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ");
      }
      else if (salePrice == "0" || salePrice == "")
      {
        salePrice = NumberExtension.FormatNumber(price) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
        price = "";
      }
      else
      {
        price = NumberExtension.FormatNumber(price) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
        salePrice = NumberExtension.FormatNumber(salePrice) + LanguageItemExtension.GetnLanguageItemTitleByName("VNĐ");
      }

      ltrSalePrice.Text = salePrice;
      ltrPrice.Text = price;


      if (ltContent.Text == "")
        ltContent.Text = "<div class='emptyresult'>" + LanguageItemExtension.GetnLanguageItemTitleByName("Nội dung bài viết đang được chúng tôi cập nhật. Cảm ơn quý khách đã quan tâm!") + "</div>";

    }
  }

  private void UpdateTotalView(string iid)
  {
    string[] fields = { "IITOTALVIEW" };
    string[] values = { "IITOTALVIEW + 1" };
    Items.UpdateItems(DataExtension.UpdateTransfer(fields, values), ItemsTSql.GetItemsByIid(iid));
  }
}