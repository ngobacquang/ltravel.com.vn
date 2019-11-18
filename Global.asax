<%@ Application Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="TatThanhJsc.Database" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Import Namespace="TatThanhJsc.TSql" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        SQLDatabase.ConnectionString = System.Configuration.ConfigurationSettings.AppSettings["ConnectionString"];        
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
        
    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        //Code that runs when a new session is started
        DataTable dt = new DataTable();
        dt = Settings.GetSettingsCondition("", "*",
                                           DataExtension.AndConditon(
                                               SettingsTSql.GetSettingsByVskey(SettingsExtension.KeyTotalView),
                                               SettingsTSql.GetSettingsByVslang(TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin())), "");
        if (dt.Rows.Count > 0)
        {
            string[] fields = { "VSVALUE" };
            string[] values = { "VSVALUE + 1" };
            string condition = DataExtension.AndConditon(
                SettingsTSql.GetSettingsByVskey(SettingsExtension.KeyTotalView),
                SettingsTSql.GetSettingsByVslang(TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin()));
            Settings.UpdateSettings(DataExtension.UpdateTransfer(fields, values), condition);            
        }
        else
        {
            Settings.InsertSettings(SettingsExtension.KeyTotalView, "", "0", TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin());            
        }
    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        //ReportsDetail.UpdateReportDetaildReportDetailEndView(Character.ParamsIpView, Character.ParamsCheckView);
        OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.UpdateForUserLeave();

    }
       
</script>
