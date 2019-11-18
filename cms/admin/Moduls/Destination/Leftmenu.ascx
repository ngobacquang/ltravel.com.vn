<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Destination_Leftmenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.DestinationModul" %>
<div id="Leftmenu" class="colLeft">
    <a class="head" href="admin.aspx?uc=<%= uc %>"><%= DestinationKeyword.TongQuanModul %><span><!----></span></a>

    <div class="subHead"><%= DestinationKeyword.DanhMucQuanLy %></div>
    <a class="tool tCate <%= SetCurrent(suc, TypePage.Cate) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationCate() %>"><%= DestinationKeyword.QuanLyDanhMuc %></a>
    <a class="tool tItem <%= SetCurrent(suc + "&app=" + app, TypePage.Item + "&app=" + CodeApplications.DestinationNews) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItem() + "&app=" + CodeApplications.DestinationNews %>"><%= DestinationKeyword.QuanLyDanhSachNews %></a>
    <a class="tool tVideo <%= SetCurrent(suc + "&app=" + app, TypePage.Item + "&app=" + CodeApplications.DestinationVideo) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItem() + "&app=" + CodeApplications.DestinationVideo %>"><%= DestinationKeyword.QuanLyDanhSachVideo %></a>
    <a class="tool tPhoto <%= SetCurrent(suc + "&app=" + app, TypePage.Item + "&app=" + CodeApplications.DestinationPhoto) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItem() + "&app=" + CodeApplications.DestinationPhoto %>"><%= DestinationKeyword.QuanLyDanhSachPhoto %></a>
    <div class="cb h15"><!----></div>

    <div class="subHead"><%= DestinationKeyword.CongCu %></div>
    <a class="tool tCate plus <%= SetCurrent(suc, TypePage.CreateCate) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationCateCreate() %>"><%= DestinationKeyword.ThemMoiDanhMuc %></a>
    <a class="tool tItem plus <%= SetCurrent(suc + "&app=" + app, TypePage.CreateItem + "&app=" + CodeApplications.DestinationNews) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItemCreate() + "&app=" + CodeApplications.DestinationNews %>"><%= DestinationKeyword.ThemMoiNews %></a>
    <a class="tool tVideo plus <%= SetCurrent(suc + "&app=" + app, TypePage.CreateItem + "&app=" + CodeApplications.DestinationVideo) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItemCreate() + "&app=" + CodeApplications.DestinationVideo %>"><%= DestinationKeyword.ThemMoiVideo %></a>
    <a class="tool tPhoto plus <%= SetCurrent(suc + "&app=" + app, TypePage.CreateItem + "&app=" + CodeApplications.DestinationPhoto) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItemCreate() + "&app=" + CodeApplications.DestinationPhoto %>"><%= DestinationKeyword.ThemMoiPhoto %></a>
    <div class="cb h15"><!----></div>

    <div class="subHead"><%= DestinationKeyword.TinhNangKhac %></div>
    <a class="tool tConfig <%= SetCurrent(suc, TypePage.Configuration) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationConfig() %>"><%= DestinationKeyword.CauHinh %></a>
    <a class="tool tRecycle" href="javascript://"><%= DestinationKeyword.ThungRac %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleCate) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationCateRec() %>">- <%= DestinationKeyword.DanhMuc %></a>
    <a class="subtool <%= SetCurrent(suc + "&app=" + app, TypePage.RecycleItem + "&app=" + CodeApplications.DestinationNews) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItemRec() + "&app=" + CodeApplications.DestinationNews %>">- <%= DestinationKeyword.DanhSachNews %></a>
    <a class="subtool <%= SetCurrent(suc + "&app=" + app, TypePage.RecycleItem + "&app=" + CodeApplications.DestinationVideo) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItemRec() + "&app=" + CodeApplications.DestinationVideo %>">- <%= DestinationKeyword.DanhSachVideo %></a>
    <a class="subtool <%= SetCurrent(suc + "&app=" + app, TypePage.RecycleItem + "&app=" + CodeApplications.DestinationPhoto) %>" href="<%= TatThanhJsc.DestinationModul.Link.LnkMnDestinationItemRec() + "&app=" + CodeApplications.DestinationPhoto %>">- <%= DestinationKeyword.DanhSachPhoto %></a>
</div>