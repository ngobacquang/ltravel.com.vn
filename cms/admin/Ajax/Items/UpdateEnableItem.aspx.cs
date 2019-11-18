using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Ajax_Items_UpdateEnableItem : System.Web.UI.Page
{
  private string condition = "";
  private string data = "";
  private string iid = "";
  private string iienable = "";
  private string action = "";
  private string uc = "";

  private string nguoiduyet = "";

  protected void Page_Load(object sender, EventArgs e)
  {
    iid = Request["iid"];
    iienable = Request["iienable"];
    action = Request["action"];
    uc = Request["uc"];

    nguoiduyet = Request["nguoiduyet"];

    UpdateEnable();
    Response.End();
  }

  void UpdateEnable()
  {
    #region Update với tính năng duyệt tin
    if (action != "")
    {
      #region Cập nhật trạng thái bài viết
      string valueUpdate = "";
      if (iienable.Equals("0"))
      {
        valueUpdate = "1";
      }
      else if (iienable.Equals("1"))
      {
        valueUpdate = "0";
      }
      else
      {
        valueUpdate = iienable;
      }
      string[] fieldsDelGroup = { "IIENABLE" };
      string[] valuesDelGroup = { valueUpdate };
      condition = " IID = '" + iid + "' ";
      TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);
      #endregion

      #region Add thêm thông tin
      switch (action) {
        case "XuatBanBaiViet":
          data = StringExtension.GhepChuoi("", "");
          string[] fieldsDelGroup2 = { "VISEOMETACANONICAL" };
          string[] valuesDelGroup2 = { "''" };
          string[] fieldsDelGroup3 = { "VISEOMETALANG" };
          string[] valuesDelGroup3 = { "'" + DateTime.Now.ToString() + "'" };
          condition = " IID = '" + iid + "' ";
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup2, valuesDelGroup2), condition);
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup3, valuesDelGroup3), condition);
          break;

        case "PheDuyetBaiViet":
          data = StringExtension.GhepChuoi("", nguoiduyet);
          string[] fieldsDelGroup4 = { "VISEOMETACANONICAL" };
          string[] valuesDelGroup4 = { "N'" + data + "'" };
          string[] fieldsDelGroup5 = { "VISEOMETALANG" };
          string[] valuesDelGroup5 = { "'" + DateTime.Now.ToString() + "'" };
          condition = " IID = '" + iid + "' ";
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup4, valuesDelGroup4), condition);
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup5, valuesDelGroup5), condition);
          break;

        case "XuatBanQuangCao":
          data = StringExtension.GhepChuoi("", "");
          string[] fieldsDelGroup6 = { "VISEOMETACANONICAL" };
          string[] valuesDelGroup6 = { "''" };
          string[] fieldsDelGroup7 = { "VISEOMETALANG" };
          string[] valuesDelGroup7 = { "'" + DateTime.Now.ToString() + "'" };
          condition = " IID = '" + iid + "' ";
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup6, valuesDelGroup6), condition);
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup7, valuesDelGroup7), condition);
          break;

        case "PheDuyetQuangCao":
          data = StringExtension.GhepChuoi("", nguoiduyet);
          string[] fieldsDelGroup8 = { "VISEOMETACANONICAL" };
          string[] valuesDelGroup8 = { "N'" + data + "'" };
          string[] fieldsDelGroup9 = { "VISEOMETALANG" };
          string[] valuesDelGroup9 = { "'" + DateTime.Now.ToString() + "'" };
          condition = " IID = '" + iid + "' ";
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup8, valuesDelGroup8), condition);
          TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup9, valuesDelGroup9), condition);
          break;

      }
      #endregion
    }
    #endregion

    #region Update mặc định
    else
    {
      string valueUpdate = "";
      if (iienable.Equals("0"))
      {
        valueUpdate = "1";
      }
      else
      {
        valueUpdate = "0";
      }
      string[] fieldsDelGroup = { "IIENABLE" };
      string[] valuesDelGroup = { valueUpdate };
      condition = " IID = '" + iid + "' ";
      TatThanhJsc.Database.Items.UpdateItems(DataExtension.UpdateTransfer(fieldsDelGroup, valuesDelGroup), condition);
    }
    #endregion

    #region Logs
    string logAuthor = CookieExtension.GetCookies("LoginSetting");
    string logCreateDate = DateTime.Now.ToString();
    string title = GetTitle(iid);
    Logs.InsertLogs(logCreateDate, Request.Url.ToString(), "", title, logAuthor, "", logCreateDate + ": " + logAuthor + " thay đổi trạng thái " + title + " (id: " + iid + ")");
    #endregion
  }

  #region Logs
  private string GetTitle(string iid)
  {
    DataTable dt = new DataTable();
    dt = TatThanhJsc.Database.Items.GetItems("1", ItemsColumns.VititleColumn, ItemsTSql.GetItemsByIid(iid), "");
    if (dt.Rows.Count > 0)
      return dt.Rows[0][ItemsColumns.VititleColumn].ToString();
    return "";
  }
  #endregion
}