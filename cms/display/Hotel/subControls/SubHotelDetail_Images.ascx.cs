using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.HotelModul;
using TatThanhJsc.TSql;

public partial class cms_display_Hotel_subControls_SubHotelDetail_Images : System.Web.UI.UserControl
{
  private string pic = FolderPic.Hotel;
  private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      DataTable dt = (DataTable)Session["dataByTitle"];//Thông tin chi tiết về Items hoặc Groups đã được gán ở Defualt.aspx vào session
      if (dt.Rows.Count > 0)
      {
        ltrMainImages.Text = @"
        <div class='item'>
          <a href='javascript:void(0)' class='imgc'>
            " + ImagesExtension.GetImage(pic, dt.Rows[0][ItemsColumns.ViimageColumn].ToString(), dt.Rows[0][ItemsColumns.VititleColumn].ToString(), "", true, false, "", false) + @"
          </a>
        </div>";

        ltrOtherImages.Text = @"
        <div class='item'>
          <a href='javascript:void(0)' class='imgc'>
            " + ImagesExtension.GetImage(pic, dt.Rows[0][ItemsColumns.ViimageColumn].ToString(), dt.Rows[0][ItemsColumns.VititleColumn].ToString(), "", true, false, "") + @"
          </a>
        </div>";

        GetOtherImages(dt.Rows[0][ItemsColumns.IidColumn].ToString());
      }
    }
  }

  private void GetOtherImages(string iid)
  {
    string condition = DataExtension.AndConditon(
      SubitemsTSql.GetSubitemsByVskey(CodeApplications.HotelPhoto),
      SubitemsTSql.GetSubitemsByIid(iid),
      SubitemsTSql.GetSubitemsByVslang(lang),
      SubitemsColumns.IsenableColumn + "<>2"
      );
    string order = "[dbo].[RemoveTextIfNotIsFloat](" + SubitemsColumns.VsatuthorColumn + ")";
    DataTable dt = Subitems.GetSubItems("", "*", condition, order);
    if (dt.Rows.Count > 0)
    {
      for (int i = 0; i < dt.Rows.Count; i++)
      {
        ltrMainImages.Text += @"
        <div class='item'>
          <a href='javascript:void(0)' class='imgc'>
            " + ImagesExtension.GetImage(pic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString(), dt.Rows[i][SubitemsColumns.VstitleColumn].ToString(), "", true, false, "", false) + @"
          </a>
        </div>";

        ltrOtherImages.Text += @"
        <div class='item'>
          <a href='javascript:void(0)' class='imgc'>
            " + ImagesExtension.GetImage(pic, dt.Rows[i][SubitemsColumns.VsimageColumn].ToString(), dt.Rows[i][SubitemsColumns.VstitleColumn].ToString(), "", true, false, "", false) + @"
          </a>
        </div>";
      }
    }
  }
}