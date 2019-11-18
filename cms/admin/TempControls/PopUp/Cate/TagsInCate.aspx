<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TagsInCate.aspx.cs" Inherits="cms_admin_TempControls_PopUp_Cate_TagsInCate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Danh sách bài viết trong tag</title>
    <link href="TagsInCate/css.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <div id="TagsInCate">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td style="width:45%">
                        <div class="TitleListBox"><asp:Literal ID="lt_cate_name" runat="server"></asp:Literal></div>
                        <div class="cb10"><!----></div>
                        <div><asp:ListBox ID="lstadded" runat="server" Width="100%" Height="350px" SelectionMode="Multiple"></asp:ListBox></div>
                    </td>
                    <td  style="width:10%" align="center">
                        <div class="pdButtonGet"><asp:Button ID="btnadd" Width="30px" runat="server" Text="<<" onclick="btnadd_Click"  /></div>
                        <div><asp:Button ID="btnremove"  Width="30px" runat="server" Text=">>" onclick="btnremove_Click"  /></div>
                    </td>
                    <td style="width:45%">
                        <div class="ColDropdownList"><asp:DropDownList ID="ddlTagModul" runat="server" Width="230px" AutoPostBack="true" onselectedindexchanged="ddl_groups_SelectedIndexChanged"></asp:DropDownList></div>
                        <div class="cb10"><!----></div>
                        <div><asp:ListBox ID="lstnotadded" runat="server" Width="100%" Height="350px" SelectionMode="Multiple"></asp:ListBox></div>                        </td>
                </tr>
            </table>
            <div class="cb10"><!----></div>
            <div class='cRed'>Chú ý: có thể chọn nhiều mục cùng lúc bằng cách giữ phím <span class='NoteText'> Shift</span> hoặc <span class='NoteText'>Ctrl</span> khi chọn!</div>
            </div>
            </ContentTemplate>
    </asp:UpdatePanel>

    </form>
</body>
</html>
