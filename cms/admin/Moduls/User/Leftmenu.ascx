<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_ModulMain_User_AdmLeftmenu" %>
<div id="AdmUserLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>">Tổng quan modul tài khoản</a></div>
    <div class="DanhMucQuanLy">Danh mục quản lý</div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate("manager") %>">
        <div class="UserBgIconCate">&nbsp;</div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=manager">Quản lý danh sách tài khoản</a>
        <div class="cbh8"><!----></div>
    </div>
</div>