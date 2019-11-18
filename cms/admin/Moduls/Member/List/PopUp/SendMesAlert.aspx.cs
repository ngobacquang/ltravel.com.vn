using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TatThanhJsc.Database;
using TatThanhJsc.Extension;
using TatThanhJsc.MemberModul;
using TatThanhJsc.TSql;



public partial class cms_admin_Moduls_Member_List_PopUp_SendMesAlert : System.Web.UI.Page
{
    private string top = "";
    private string fields = "";
    private string condition = "";
    private string order = "";
    private string imid = "";
    private string lang = TatThanhJsc.LanguageModul.Cookie.GetLanguageValueAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetListMes();
        }
    }

    void GetListMes()
    {
        top = "";
        fields = " * ";
        condition = DataExtension.AndConditon(SubitemsTSql.GetSubitemsByVskey(CodeApplications.MemberNoticeBQT),
                                             SubitemsTSql.GetSubitemsByVsatuthor(imid)
                                             );
        order = " DSCREATEDATE DESC ";
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems(top, fields, condition, order);
        if (dt.Rows.Count > 0)
        {
            RpListNoticeBQT.DataSource = dt;
            RpListNoticeBQT.DataBind();
        }

    }

    protected void BtnOk_Click(object sender, EventArgs e)
    {
        if (HdInsertUpdate.Value.Equals("update"))
        {
            Subitems.UpdateSubitems(" VSTITLE = N'" + TbTtl.Text + "',VSCONTENT = N'" + TbContent.Text + "' ", " ISID = " + HdIsid.Value);    
        }
        else
        {
            Subitems.InsertSubitems("", lang, CodeApplications.MemberNoticeBQT, TbTtl.Text, TbContent.Text, "", "",
                                    imid, "", DateTime.Now.ToString(), DateTime.Now.ToString(), DateTime.Now.ToString(), "0");    
        }
        

        

        PnFormNotice.Visible = false;
        PnShow.Visible = true;
        GetListMes();
    }

    protected void LbSendNotice_Click(object sender, EventArgs e)
    {
        LtMes.Text = "<div class=\"TxtMes\">Nội dung thông báo từ Ban Quản Trị</div>";
        PnFormNotice.Visible = true;
        PnShow.Visible = false;
    }

    protected void RpListNoticeBQT_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string c = e.CommandName.Trim();
        string p = e.CommandArgument.ToString().Trim();
        top = "";
        fields = "*";
        condition = DataExtension.AndConditon(SubitemsTSql.GetSubitemsByIsid(p));
        order = "";
        DataTable dt = new DataTable();
        dt = Subitems.GetSubItems(top, fields, condition, order);

        switch (c)
        {
            case "edit":
                
                PnShow.Visible = false;
                PnFormNotice.Visible = true;
                TbTtl.Text = dt.Rows[0]["VSTITLE"].ToString();
                TbContent.Text = dt.Rows[0]["VSCONTENT"].ToString();
                HdInsertUpdate.Value = "update";
                HdIsid.Value = p;
                GetListMes();                
                break;
            case "del":
                Subitems.DeleteSubitems(p);
                GetListMes();                
                break;
        }
    }
}