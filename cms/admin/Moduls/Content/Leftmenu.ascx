<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Moduls_Content_Leftmenu" %>
<%@ Import Namespace="TatThanhJsc.ContentModul" %>
<div id="ContentAdmLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="<%=Link.LnkMnContent() %>">Tổng quan trang nội dung</a></div>
    <div class="DanhMucQuanLy">Danh mục quản lý</div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
        <div class="PdIconInfomation"><div class="iconDanhMuc"><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnContentCate() %>">Quản lý nhóm bài viết</a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
        <div class="PdIconInfomation"><div class='iconDanhSach'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnContentItem() %>">Quản lý danh sách bài viết</a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.GroupItem) %>">
        <div class="PdIconInfomation"><div class='iconDanhSach'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnContentGroupItem() %>">Quản lý vị trí bài viết</a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="cbh8"><!----></div>
    <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    <div class="cbh20"><!----></div>
        
    <div class="DanhMucQuanLy">Công cụ</div>
    <div class="PdSpaceCate"><div class='<%=SetEnableTool() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
        <div class="PdIconInfomation"><div class='iconDanhMucThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnContentCateCreate() %>">Thêm mới nhóm bài viết</a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
        <div class="PdIconInfomation"><div class='iconDanhSachThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnContentItemCreate() %>">Thêm mới nhóm bài viết</a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
        <div class="PdIconInfomation"><div class='iconDanhSachThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnContentGroupItemCreate() %>">Thêm mới vị trí bài viết</a>
        <div class="cbh0"><!----></div>
    </div>
    
    <div class="cbh20"><!----></div>
    <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
        <div class="PdIconInfomation"><div class='iconRecycle'><!----></div></div>
        <div class="TextCateManager">Thùng rác</div>
        <div class="cbh0"><!----></div>
    </div>    
    <div class="cbh5"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager" href="<%=Link.LnkMnContentCateRec() %>">Nhóm bài viết</a>
    <div class="cbh5"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager" href="<%=Link.LnkMnContentItemRec() %>">Danh sách bài viết</a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager" href="<%=Link.LnkMnContentGroupItemRec() %>">Vị trí bài viết</a>
    <div class="cbh0"><!----></div>
        
</div>