<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Moduls_Website_Leftmenu" %>
<%@ Import Namespace="TatThanhJsc.WebsiteModul" %>
<div id="WebsiteAdmLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="<%=Link.LnkMnWebsite() %>"><%=Developer.WebsiteKeyword.TongQuan %></a></div>
    <div class="DanhMucQuanLy"><%=Developer.WebsiteKeyword.DanhMucQuanLy %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
        <div class="PdIconInfomation"><div class="iconDanhMuc"><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnWebsiteCate() %>"><%=Developer.WebsiteKeyword.QuanLyNhomBaiViet %></a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="cbh8"><!----></div>
    <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    <div class="cbh20"><!----></div>
        
    <div class="DanhMucQuanLy"><%=Developer.WebsiteKeyword.CongCu %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableTool() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
        <div class="PdIconInfomation"><div class='iconDanhMucThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnWebsiteCateCreate() %>"><%=Developer.WebsiteKeyword.ThemMoiNhomBaiViet %></a>
        <div class="cbh0"><!----></div>
    </div>    
    
    <div class="cbh20"><!----></div>
    <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
        <div class="PdIconInfomation"><div class='iconRecycle'><!----></div></div>
        <div class="TextCateManager"><%=Developer.WebsiteKeyword.ThungRac %></div>
        <div class="cbh0"><!----></div>
    </div>    
    <div class="cbh5"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnWebsiteCateRec() %>"><%=Developer.WebsiteKeyword.NhomBaiViet %></a>
    <div class="cbh5"><!----></div>
</div>