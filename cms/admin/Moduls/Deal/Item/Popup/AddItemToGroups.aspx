<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddItemToGroups.aspx.cs" Inherits="cms_admin_Deal_SubControls_AddItemToGroups" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><asp:Literal ID="LtTitlePage" runat="server"></asp:Literal></title>
    <link href="AddItemToGroups/_cs.css" rel="stylesheet" type="text/css" />
    <link href="../../../../cs/Common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="PopupAddItem">
                <asp:Literal ID="lt_cate_name" runat="server"></asp:Literal>
                <div class="cbh5"><!----></div>                
                <div class="ColDropdownList">
                    <asp:DropDownList ID="ddl_type_groupnews_show" runat="server" AutoPostBack="true" Width="250px" onselectedindexchanged="ddl_type_groupnews_show_SelectedIndexChanged"></asp:DropDownList>
                </div>                
                <div class="cbh15"><!----></div>
                <div><asp:Literal ID="LtMes" runat="server" Visible="false"></asp:Literal></div>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr valign="top">
                        <td style="width:45%">
                            <div class="TitleListBox">Các nhóm deal đã trực thuộc</div>
                            <div><asp:ListBox ID="lstadded" runat="server" Width="100%" Height="300px"></asp:ListBox></div>
                        </td>
                        <td style="width:10%" align="center">
                            <div class="pdButtonGet"><asp:Button ID="btnadd" runat="server" Text="<<" onclick="btnadd_Click"  /></div>
                            <div><asp:Button ID="btnremove" runat="server" Text=">>" onclick="btnremove_Click"  /></div>
                        </td>
                        <td style="width:45%">
                            <div class="TitleListBox">Các nhóm deal chưa trực thuộc</div>
                            <div><asp:ListBox ID="lstnotadded" runat="server" Width="100%" Height="300px" SelectionMode="Multiple"></asp:ListBox></div>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
