<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Hotel_Leftmenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.HotelModul" %>
<style>.dn {display:none!important}</style>
<div id="Leftmenu" class="colLeft">
    <a class="head" href="admin.aspx?uc=<%= uc %>"><%= HotelKeyword.TongQuanModul %><span><!----></span></a>

    <div class="subHead"><%= HotelKeyword.DanhMucQuanLy %></div>
    <a class="tool tCate <%= SetCurrent(suc, TypePage.Cate) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelCate() %>"><%= HotelKeyword.QuanLyDanhMuc %></a>
    <a class="tool dn tFacility <%= SetCurrent(suc, TypePage.Facility) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelFacility() %>"><%= HotelKeyword.QuanLyDichVu %></a>
    <a class="tool dn tFacility <%= SetCurrent(suc, TypePage.FacilityRoom) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelFacilityRoom() %>"><%= HotelKeyword.QuanLyDichVuPhong %></a>
    <a class="tool dn tProperty <%= SetCurrent(suc, TypePage.Property) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelProperty() %>"><%= HotelKeyword.QuanLyThuocTinh %></a>
    <a class="tool tGroup <%= SetCurrent(suc, TypePage.GroupItem) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelGroupItem() %>"><%= HotelKeyword.QuanLyNhom %></a>
    <a class="tool tItem <%= SetCurrent(suc, TypePage.Item) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelItem() %>"><%= HotelKeyword.QuanLyDanhSach %></a>
    <a class="tool tBooking <%= SetCurrent(suc, TypePage.Booking) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelBooking() %>"><%= HotelKeyword.QuanLyDonHang %></a>

    <div class="cb h15"><!----></div>

    <div class="subHead"><%= HotelKeyword.CongCu %></div>
    <a class="tool tCate plus <%= SetCurrent(suc, TypePage.CreateCate) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelCateCreate() %>"><%= HotelKeyword.ThemMoiDanhMuc %></a>
    <a class="tool dn tFacility plus <%= SetCurrent(suc, TypePage.CreateFacility) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelFacilityCreate() %>"><%= HotelKeyword.ThemMoiDichVu %></a>
    <a class="tool dn tFacility plus <%= SetCurrent(suc, TypePage.CreateFacilityRoom) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelFacilityRoomCreate() %>"><%= HotelKeyword.ThemMoiDichVuPhong %></a>
    <a class="tool dn tProperty plus <%= SetCurrent(suc, TypePage.CreateProperty) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelPropertyCreate() %>"><%= HotelKeyword.ThemMoiThuocTinh %></a>
    <a class="tool tGroup plus <%= SetCurrent(suc, TypePage.CreateGroupItem) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelGroupItemCreate() %>"><%= HotelKeyword.ThemMoiNhom %></a>
    <a class="tool tItem plus <%= SetCurrent(suc, TypePage.CreateItem) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelItemCreate() %>"><%= HotelKeyword.ThemMoi %></a>
    <div class="cb h15"><!----></div>

    <div class="subHead"><%= HotelKeyword.TinhNangKhac %></div>
    <a class="tool tConfig <%= SetCurrent(suc, TypePage.Configuration) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelConfig() %>"><%= HotelKeyword.CauHinh %></a>
    <a class="tool tRecycle" href="javascript://"><%= HotelKeyword.ThungRac %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleCate) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelCateRec() %>">- <%= HotelKeyword.DanhMuc %></a>
    <a class="subtool dn <%= SetCurrent(suc, TypePage.RecycleFacility) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelFacilityRec() %>">- <%= HotelKeyword.DichVu %></a>
    <a class="subtool dn <%= SetCurrent(suc, TypePage.RecycleFacilityRoom) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelFacilityRoomRec() %>">- <%= HotelKeyword.DichVuPhong %></a>
    <a class="subtool dn <%= SetCurrent(suc, TypePage.RecycleProperty) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelPropertyRec() %>">- <%= HotelKeyword.ThuocTinh %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleGroupItem) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelGroupItemRec() %>">- <%= HotelKeyword.Nhom %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleItem) %>" href="<%= TatThanhJsc.HotelModul.Link.LnkMnHotelItemRec() %>">- <%= HotelKeyword.DanhSach %></a>
</div>