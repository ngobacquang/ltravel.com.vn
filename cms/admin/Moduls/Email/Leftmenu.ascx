<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Email_AdmLeftmenu" %>
<div id="AdmPageSingleContentLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>">Tổng quan trang email</a></div>
    <div class="DanhMucQuanLy">Danh mục quản lý</div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate("c") %>">
        <div class="PageSingleContentBgIconItem">&nbsp;</div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=lr">Danh sách email đã đăng ký</a>
        <div class="cbh8"><!----></div>
    </div>
    <asp:Panel ID="pnGuiEmail" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("c") %>">
        <div class="PageSingleContentBgIconItem">&nbsp;</div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=s">Gửi email</a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>
    <div class="ArroundCate<%=SetSelectedCate("c") %> dn">
        <div class="PageSingleContentBgIconItem">&nbsp;</div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=glr">Danh mục nhận email (nếu có)</a>
        <div class="cbh8"><!----></div>
    </div>
</div>