using System;
using System.Data;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_FileLibrary2_Index : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadConfigs("cms/admin/Moduls/FileLibrary2/Index.ascx");
    }

    /// <summary>
    /// Lấy ra các cấu hình theo đường đẫn của control cha
    /// </summary>
    /// <param name="vsdesc">Đường dẫn của control cha, vd: cms/admin/Moduls/FileLibrary2/Index.ascx</param>
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
            list = dt.Rows[i][SettingsColumns.VsvalueColumn].ToString().Split(new string[] {split},
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
}