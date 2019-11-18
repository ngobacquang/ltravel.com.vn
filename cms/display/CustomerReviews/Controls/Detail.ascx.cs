using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_display_CustomerReviews_Detail : System.Web.UI.UserControl
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
      ltrDate.Text = ((DateTime)dt.Rows[0][ItemsColumns.DiupdateColumn]).ToString(LanguageItemExtension.GetnLanguageItemTitleByName("dd/MM/yyyy - HH:mm tt"));
      ltrViews.Text = NumberExtension.FormatNumber(((int)dt.Rows[0][ItemsColumns.IitotalviewColumn] + 1).ToString()) + " " + LanguageItemExtension.GetnLanguageItemTitleByName("lượt xem");
      ltrAvatar.Text = ImagesExtension.GetImage(TatThanhJsc.CustomerReviewsModul.FolderPic.CustomerReviews, dt.Rows[0][ItemsColumns.ViimageColumn].ToString(), dt.Rows[0][ItemsColumns.VititleColumn].ToString(), "", true, false, "");
      ltContent.Text = dt.Rows[0][ItemsColumns.VicontentColumn].ToString();
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