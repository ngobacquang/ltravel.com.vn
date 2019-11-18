<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Cruises_Leftmenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.CruisesModul" %>
<div id="Leftmenu" class="colLeft">
    <a class="head" href="admin.aspx?uc=<%= uc %>"><%= CruisesKeyword.TongQuanModul %><span><!----></span></a>

    <div class="subHead"><%= CruisesKeyword.DanhMucQuanLy %></div>
    <a class="tool tCate <%= SetCurrent(suc, TypePage.Cate) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesCate() %>"><%= CruisesKeyword.QuanLyDanhMuc %></a>
    <a class="tool tFacility <%= SetCurrent(suc, TypePage.Facility) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesFacility() %>"><%= CruisesKeyword.QuanLyDichVu %></a>
    <a class="tool tFacility <%= SetCurrent(suc, TypePage.FacilityCabin) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesFacilityCabin() %>"><%= CruisesKeyword.QuanLyDichVuCabin %></a>
    <a class="tool tProperty <%= SetCurrent(suc, TypePage.Property) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesProperty() %>"><%= CruisesKeyword.QuanLyThuocTinh %></a>
    <a class="tool tGroup <%= SetCurrent(suc, TypePage.GroupItem) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesGroupItem() %>"><%= CruisesKeyword.QuanLyNhom %></a>
    <a class="tool tItem <%= SetCurrent(suc, TypePage.Item) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesItem() %>"><%= CruisesKeyword.QuanLyDanhSach %></a>
    <div class="cb h15"><!----></div>

    <div class="subHead"><%= CruisesKeyword.CongCu %></div>
    <a class="tool tCate plus <%= SetCurrent(suc, TypePage.CreateCate) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesCateCreate() %>"><%= CruisesKeyword.ThemMoiDanhMuc %></a>
    <a class="tool tFacility plus <%= SetCurrent(suc, TypePage.CreateFacility) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesFacilityCreate() %>"><%= CruisesKeyword.ThemMoiDichVu %></a>
    <a class="tool tFacility plus <%= SetCurrent(suc, TypePage.CreateFacilityCabin) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesFacilityCabinCreate() %>"><%= CruisesKeyword.ThemMoiDichVuPhong %></a>
    <a class="tool tProperty plus <%= SetCurrent(suc, TypePage.CreateProperty) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesPropertyCreate() %>"><%= CruisesKeyword.ThemMoiThuocTinh %></a>
    <a class="tool tGroup plus <%= SetCurrent(suc, TypePage.CreateGroupItem) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesGroupItemCreate() %>"><%= CruisesKeyword.ThemMoiNhom %></a>
    <a class="tool tItem plus <%= SetCurrent(suc, TypePage.CreateItem) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesItemCreate() %>"><%= CruisesKeyword.ThemMoi %></a>
    <div class="cb h15"><!----></div>

    <div class="subHead"><%= CruisesKeyword.TinhNangKhac %></div>
    <a class="tool tConfig <%= SetCurrent(suc, TypePage.Configuration) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesConfig() %>"><%= CruisesKeyword.CauHinh %></a>
    <a class="tool tRecycle" href="javascript://"><%= CruisesKeyword.ThungRac %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleCate) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesCateRec() %>">- <%= CruisesKeyword.DanhMuc %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleFacility) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesFacilityRec() %>">- <%= CruisesKeyword.DichVu %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleFacilityCabin) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesFacilityCabinRec() %>">- <%= CruisesKeyword.DichVuCabin %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleProperty) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesPropertyRec() %>">- <%= CruisesKeyword.ThuocTinh %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleGroupItem) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesGroupItemRec() %>">- <%= CruisesKeyword.Nhom %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleItem) %>" href="<%= TatThanhJsc.CruisesModul.Link.LnkMnCruisesItemRec() %>">- <%= CruisesKeyword.DanhSach %></a>
</div>