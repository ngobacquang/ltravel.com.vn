<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Index.ascx.cs" Inherits="cms_api_Product_Item_Index" %>

<asp:HiddenField ID="iid" runat="server" />
<asp:HiddenField ID="isid" runat="server" />

<asp:Panel ID="pnOtherFields" runat="server" CssClass="dn">
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Quy cách") %></div></div>
    <div class="control">
        <asp:TextBox ID="txtquicach" runat="server" Width="400px"></asp:TextBox>        
    </div>
    <div class="cbh8 "><!----></div>
    <div class="text "><div class="pt5"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Màu sắc") %></div></div>
 <div class="control">
        <asp:TextBox ID="txtmausac" runat="server" Width="400px"></asp:TextBox>        
    </div>
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Kích thước") %></div></div>
    <div class="control">
        <asp:TextBox ID="txtkichthuoc" runat="server" Width="400px"></asp:TextBox>        
    </div>
     <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Xuất xứ") %></div></div>
    <div class="control">
        <asp:TextBox ID="txtxuatxu" runat="server" Width="400px"></asp:TextBox>        
    </div>
</asp:Panel>


<%--<div class="cbh10"><!----></div>
<div style="position: absolute;bottom: 11px;left:493px"><asp:Button ID="btOK" Width="120px" runat="server" Text="Đồng ý" OnClick="btOK_Click" /></div>--%>