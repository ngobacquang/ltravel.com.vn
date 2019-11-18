<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Index.ascx.cs" Inherits="cms_api_New_Item_Index" %>

<asp:HiddenField ID="iid" runat="server" />
<asp:HiddenField ID="isid" runat="server" />

<asp:Panel ID="pnOtherFields" runat="server">
<%--Hiện lên khi cần dùng
    <div class="text"><div class="pt5">Tình trạng hàng</div></div>
    <div class="control">
        <asp:TextBox ID="tbTinhTrangHang" runat="server"></asp:TextBox>    
    </div>
    <div class="cbh10"><!----></div>

    <div class="text"><div class="pt5">Xếp hạng sao</div></div>
    <div class="control">
        <asp:DropDownList ID="ddlXepHangSao" runat="server">
            <asp:ListItem Text="1" Value="1"></asp:ListItem>
            <asp:ListItem Text="2" Value="2"></asp:ListItem>
            <asp:ListItem Text="3" Value="3"></asp:ListItem>
            <asp:ListItem Text="4" Value="4"></asp:ListItem>
            <asp:ListItem Text="5" Value="5"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="cbh10"><!----></div>--%>
</asp:Panel>


<%--<div class="cbh10"><!----></div>
<div style="position: absolute;bottom: 11px;left:501px"><asp:Button ID="btOK" Width="120px" runat="server" Text="Đồng ý" OnClick="btOK_Click" /></div>--%>