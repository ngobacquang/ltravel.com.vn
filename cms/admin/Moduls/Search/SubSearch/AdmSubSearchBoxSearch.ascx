<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmSubSearchBoxSearch.ascx.cs" Inherits="cms_admin_Search_SubSearch_AdmSubSearchBoxSearch" %>
<div id="AdmSubSearchBoxSearch" class="dn">
    <div class="FormatBtnSearch"><asp:LinkButton ID="LbSearch" runat="server" CssClass="BtnSearch">&nbsp;</asp:LinkButton></div>
    <div class="FormatBoxDropDownListModul">
        <asp:DropDownList ID="DdlModulWebsite" runat="server" CssClass="bgDdlModul">
            <asp:ListItem Value="">--- Tất cả các modul ---</asp:ListItem>
            <asp:ListItem Value="1">Tin tức</asp:ListItem>
            <asp:ListItem Value="2">Sản phẩm</asp:ListItem>
            <asp:ListItem Value="3">Dịch vụ</asp:ListItem>
            <asp:ListItem Value="4">Thư viện hình</asp:ListItem>
            <asp:ListItem Value="5">Thư viện dữ liệu</asp:ListItem>
            <asp:ListItem Value="6">Khách hàng</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="FormatBoxKeySearch"><asp:TextBox ID="TbKeySearch" runat="server" CssClass="bgBoxKeySearch" OnLoad="SetTbKeySearch"></asp:TextBox></div>
    <div class="cbh0"><!----></div>
</div>
