using System;
using System.Data;
using System.Web.UI;
using TatThanhJsc.Columns;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.TSql;

public partial class cms_admin_Moduls_Email_Controls_AdmControlsSendEmail : System.Web.UI.UserControl
{
    string top = "";
    string fields = "";
    string orderby = "";
    string condition = "";
    //string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();
    string parramSplitString =TatThanhJsc.AdminModul.Keyword.ParamsSpilitItems;
    private string pic = TatThanhJsc.EmailModul.FolderPic.Email;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Gán đường dẫn cho ckeditor
        foreach (Control control in this.Controls)
        {
            if (control is CKEditor.NET.CKEditorControl)
                ((CKEditor.NET.CKEditorControl)control).FilebrowserImageBrowseUrl
                    =
                    UrlExtension.WebisteUrl + "ckeditor/ckfinder/ckfinder.aspx?type=Images&path=" + pic;
        }
        #endregion
    }
    protected void btSend_Click(object sender, EventArgs e)
    {    
            string listEmail = GetListEmail();
            string listSended = "";
            string resultInfo = "";
                  
            string mailContent = ContentExtendtions.ProcessStringContent(tbContent.Text, "", pic);

            mailContent = mailContent.Replace("src=\"/", "src=\"" + UrlExtension.WebisteUrl);
            mailContent = mailContent.Replace("src='/", "src='" + UrlExtension.WebisteUrl);   
         
            foreach (string email in listEmail.Split(new string[] { parramSplitString }, StringSplitOptions.None))
            {
                if (email.Length > 0)
                {
                    
                    resultInfo = EmailExtension.SendEmail(email, tbTieuDe.Text, mailContent);
                    if (resultInfo == "Đã gửi Email thành công")
                        listSended += email + ", ";
                }
            }            
            ltrDaGuiCho.Text = @"
<div class='khungDaGui'>
    <span class='text1'>Đã gửi email đến</span>: " + listSended + @"
</div>
";   
    }

    string GetListEmail()
    {
        string s = "";   
        #region Lấy khách hàng tiềm năng

            condition = DataExtension.AndConditon(                
                MembersTSql.GetMembersByVproperty(TatThanhJsc.MemberModul.CodeApplications.MemberNewsletter),
                MembersTSql.GetMembersByImemberisapproved("1"),
                MembersTSql.GetMembersByVmemberidentitycard("1"));
            fields = MembersColumns.VmemberemailColumn;
            DataTable dt = new DataTable();
            dt = Members.GetMembersCondition("", fields, condition, "");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                s += dt.Rows[i][MembersColumns.VmemberemailColumn] + parramSplitString;
            }
        
        #endregion
        return s;
    } 
}
