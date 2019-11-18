using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class cms_admin_Search_SubSearch_AdmSubSearchBoxSearch : System.Web.UI.UserControl
{
    private string strdisplayName = "Nhâp từ khóa tìm kiếm";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SetTbKeySearch(object sender, System.EventArgs e)
    {
        TbKeySearch.Text = strdisplayName;
        ((TextBox)sender).Attributes["onfocus"] = "if (this.value=='" + strdisplayName + "') this.value='';";
        ((TextBox)sender).Attributes["onblur"] = "if (this.value=='') this.value='" + strdisplayName + "';";
    }
}
