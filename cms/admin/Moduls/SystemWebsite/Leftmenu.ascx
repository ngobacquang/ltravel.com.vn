<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_System_website_AdmLeftMenu" %>
<%@ Import Namespace="TatThanhJsc.SystemWebsiteModul" %>
<div id="AdmLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=CodeApplications.Systemwebsite %>">Tổng quan hệ thống</a></div>
    <div class="DanhMucQuanLy">Danh mục quản lý</div>
    <div class="PdIconInfomation"><div class="SpaceCate"><!----></div></div>
    <div class="cbh8"><!----></div>
    <div class="ArroundCate<%=SetSelectedCate("information") %>">
    <div class="PdIconInfomation"><div class="InfoIcon">&nbsp;</div></div>
    <a class="TextCateManager" href="?uc=<%=CodeApplications.Systemwebsite %>&suc=information">Quản lý thông tin website</a>
    <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate("optimize") %>">
    <div class="PdIconInfomation"><div class="SeoIcon">&nbsp;</div></div>
    <a class="TextCateManager" href="?uc=<%=CodeApplications.Systemwebsite %>&suc=optimize">Quản lý tối ưu website</a>
    <div class="cbh8"><!----></div>
    </div>
    
    <asp:Panel ID="pnEmail" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("email") %>">
    <div class="PdIconInfomation"><div class="EmailIcon">&nbsp;</div></div>
    <a class="TextCateManager" href="?uc=<%=CodeApplications.Systemwebsite %>&suc=email">Quản lý email hệ thống</a>
    <div class="cbh8"><!----></div>
    </div>      
    </asp:Panel>

    <asp:Panel ID="pnPopup" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("popup") %>">
    <div class="PdIconInfomation"><div class="PopupIcon">&nbsp;</div></div>
    <a class="TextCateManager" href="?uc=<%=CodeApplications.Systemwebsite %>&suc=popup">Thông tin Popup</a>
    <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>
    
    <asp:Panel ID="pnBgSound" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("media") %>">
    <div class="PdIconInfomation"><div class="MediaIcon">&nbsp;</div></div>
    <a class="TextCateManager" href="?uc=<%=CodeApplications.Systemwebsite %>&suc=media">Quản lý nhạc nền</a>
    <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>

    <div class="ArroundCate<%=SetSelectedCate("systemConfig") %>">
    <div class="PdIconInfomation"><div class="SettingIcon">&nbsp;</div></div>
    <a class="TextCateManager" href="?uc=<%=CodeApplications.Systemwebsite %>&suc=systemConfig">Cấu hình hệ thống</a>
    <div class="cbh8"><!----></div>
    </div>
    
    <div class="ArroundCate<%=SetSelectedCate("logs") %>">
    <div class="PdIconInfomation"><div class="LogsIcon">&nbsp;</div></div>
    <a class="TextCateManager" href="?uc=<%=CodeApplications.Systemwebsite %>&suc=logs">Logs</a>
    <div class="cbh8"><!----></div>
    </div>
</div>