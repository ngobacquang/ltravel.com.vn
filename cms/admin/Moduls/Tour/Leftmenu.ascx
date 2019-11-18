<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Tour_Leftmenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.TourModul" %>
<div id="Leftmenu" class="colLeft">
    <a class="head" href="admin.aspx?uc=<%= uc %>"><%= TourKeyword.TongQuanModul %><span><!----></span></a>

    <div class="subHead"><%= TourKeyword.DanhMucQuanLy %></div>
    <a class="tool tCate <%= SetCurrent(suc, TypePage.Cate) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourCate() %>"><%= TourKeyword.QuanLyDanhMuc %></a>
    <a class="tool tProperty <%= SetCurrent(suc, TypePage.Vehicle) %> <%=SetEnableClass(TourConfig.HienThiQuanLyPhuongTien) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourVehicle() %>"><%= TourKeyword.QuanLyPhuongTien %></a>
    <a class="tool tService <%= SetCurrent(suc, TypePage.Service) %> <%=SetEnableClass(TourConfig.HienThiQuanLyDichVuPhu) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourService() %>"><%= TourKeyword.QuanLyDichVu %></a>
    <a class="tool tVehicle <%= SetCurrent(suc, TypePage.Property) %> <%=SetEnableClass(TourConfig.HienThiQuanLyThuocTinh) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourProperty() %>"><%= TourKeyword.QuanLyThuocTinh %></a>
    <a class="tool tGroup <%= SetCurrent(suc, TypePage.GroupItem) %> <%=SetEnableClass(TourConfig.HienThiQuanLyNhom) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourGroupItem() %>"><%= TourKeyword.QuanLyNhom %></a>
    <a class="tool tComment <%= SetCurrent(suc, TypePage.Comment) %> <%=SetEnableClass(TourConfig.HienThiQuanLyBinhLuan) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourComment() %>"><%= TourKeyword.QuanLyBinhLuan %></a>
    <a class="tool tBooking <%= SetCurrent(suc, TypePage.Booking) %> <%=SetEnableClass(TourConfig.HienThiQuanLyDonDatTour) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourBooking() %>"><%= TourKeyword.QuanLyDonDatTour %></a>
    <a class="tool tBooking <%= SetCurrent(suc, TypePage.Booking+"02") %> <%=SetEnableClass(TourConfig.HienThiQuanLyDonDatTour02) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourBooking() %>02"><%= TourKeyword.QuanLyDonDatTour02 %></a>
    <a class="tool tItem <%= SetCurrent(suc, TypePage.Item) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourItem() %>"><%= TourKeyword.QuanLyDanhSach %></a>
    <div class="cb h15"><!----></div>

    <div class="subHead"><%= TourKeyword.CongCu %></div>
    <a class="tool tCate plus <%= SetCurrent(suc, TypePage.CreateCate) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourCateCreate() %>"><%= TourKeyword.ThemMoiDanhMuc %></a>
    <a class="tool tProperty plus <%= SetCurrent(suc, TypePage.CreateVehicle) %> <%=SetEnableClass(TourConfig.HienThiQuanLyPhuongTien) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourVehicleCreate() %>"><%= TourKeyword.ThemMoiPhuongTien %></a>
    <a class="tool tService plus <%= SetCurrent(suc, TypePage.CreateService) %> <%=SetEnableClass(TourConfig.HienThiQuanLyDichVuPhu) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourServiceCreate() %>"><%= TourKeyword.ThemMoiDichVu %></a>
    <a class="tool tVehicle plus <%= SetCurrent(suc, TypePage.CreateProperty) %> <%=SetEnableClass(TourConfig.HienThiQuanLyThuocTinh) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourPropertyCreate() %>"><%= TourKeyword.ThemMoiThuocTinh %></a>
    <a class="tool tGroup plus <%= SetCurrent(suc, TypePage.CreateGroupItem) %> <%=SetEnableClass(TourConfig.HienThiQuanLyNhom) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourGroupItemCreate() %>"><%= TourKeyword.ThemMoiNhom %></a>
    <a class="tool tItem plus <%= SetCurrent(suc, TypePage.CreateItem) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourItemCreate() %>"><%= TourKeyword.ThemMoi %></a>
    <div class="cb h15"><!----></div>

    <div class="subHead"><%= TourKeyword.TinhNangKhac %></div>
    <a class="tool tConfig <%= SetCurrent(suc, TypePage.Configuration) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourConfig() %>"><%= TourKeyword.CauHinh %></a>
    <a class="tool tRecycle" href="javascript://"><%= TourKeyword.ThungRac %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleCate) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourCateRec() %>">- <%= TourKeyword.DanhMuc %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleVehicle) %> <%=SetEnableClass(TourConfig.HienThiQuanLyPhuongTien) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourVehicleRec() %>">- <%= TourKeyword.PhuongTien %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleService) %> <%=SetEnableClass(TourConfig.HienThiQuanLyDichVuPhu) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourServiceRec() %>">- <%= TourKeyword.DichVu %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleProperty) %> <%=SetEnableClass(TourConfig.HienThiQuanLyThuocTinh) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourPropertyRec() %>">- <%= TourKeyword.ThuocTinh %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleGroupItem) %> <%=SetEnableClass(TourConfig.HienThiQuanLyNhom) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourGroupItemRec() %>">- <%= TourKeyword.Nhom %></a>
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleItem) %>" href="<%= TatThanhJsc.TourModul.Link.LnkMnTourItemRec() %>">- <%= TourKeyword.DanhSach %></a>
</div>