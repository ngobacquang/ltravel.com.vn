<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Moduls_Member_Leftmenu" %>
<%@ Import Namespace="TatThanhJsc.MemberModul" %>

<div id="MemberLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="#">Tổng quan modul thành viên</a></div>
    <div class="DanhMucQuanLy">Danh mục quản lý</div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
        <div class="PdIconInfomation"><div class="iconDanhSach"><!----></div></div>
        <a class="TextCateManager" href="<%=LinkMnList %>">Quản lý danh sách thành viên</a>
        <div class="cbh8"><!----></div>
    </div>
    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
        <div class="PdIconInfomation"><div class="iconDanhSach"><!----></div></div>
        <a class="TextCateManager" href="<%=LnkMnItemCreate %>">Thêm mới thành viên</a>
        <div class="cbh8"><!----></div>
    </div>
    
    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.NewKeyword.TinhNangKhac %></div>
    <div class="PdSpaceCate"><div><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
        <div class="PdIconInfomation"><a href="#"><div class='iconConfig'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnMemberConfig() %>">Cấu hình</a>
        <div class="cbh0"><!----></div>
    </div>
    
    <div class="cbh8"><!----></div>
    <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    <div class="cbh20"><!----></div>
</div>