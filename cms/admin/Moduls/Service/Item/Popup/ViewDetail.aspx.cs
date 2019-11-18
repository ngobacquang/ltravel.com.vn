using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.ContactModul;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Contact_SubControls_ViewDetail : System.Web.UI.Page
{
  private string modul = CodeApplications.Contact;

  private string top = "";
  private string fields = "";
  private string condition = "";
  private string orderby = "";
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString["iid"] != null)
      LoadContactDetailContent(Request.QueryString["iid"].ToString());
    if (Request.QueryString["title"] != null)
      ltrTitle.Text = Request.QueryString["title"].ToString();

  }
  void LoadContactDetailContent(string iid)
  {
    top = "";
    fields = "*";
    condition = DataExtension.AndConditon(ItemsTSql.GetItemsByIid(iid),
      ItemsTSql.GetByApp("QLDDDV"));
    orderby = "";
    DataTable dt = TatThanhJsc.Database.GroupsItems.GetAllData(top, fields, condition, orderby);
    if (dt.Rows.Count > 0)
    {
      ltrHoten.Text = dt.Rows[0][ItemsColumns.ViauthorColumn].ToString();
      ltrDienthoai.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.ViparamsColumn].ToString(), "", 1);
      ltrEmail.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.ViparamsColumn].ToString(), "", 2);
      ltrNationality.Text = StringExtension.LayChuoi(dt.Rows[0][ItemsColumns.ViparamsColumn].ToString(), "", 3);
      ltrTieuDe.Text = dt.Rows[0][ItemsColumns.VititleColumn].ToString();
      ltrNoiDung.Text = dt.Rows[0][ItemsColumns.VicontentColumn].ToString();
      ltrGuiLuc.Text = ((DateTime)dt.Rows[0][ItemsColumns.DicreatedateColumn]).ToString("dd/MM/yyyy hh:mm:ss tt");
    }
  }
}
