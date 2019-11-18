<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_CustomerReviews_Leftmenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.CustomerReviewsModul" %>
<div id="Leftmenu" class="colLeft">
  <a class="head" href="admin.aspx?uc=<%= uc %>"><%= CustomerReviewsKeyword.TongQuanModul %><span><!----></span></a>

  <div class="subHead"><%= CustomerReviewsKeyword.DanhMucQuanLy %></div>

  <asp:Panel ID="pnQuanLyDanhMuc" runat="server">
    <a class="tool tCate <%= SetCurrent(suc, TypePage.Cate) %>" href="<%= Link.LnkMnCustomerReviewsCate() %>"><%= CustomerReviewsKeyword.QuanLyDanhMuc %></a>
  </asp:Panel>

  <a class="tool tItem <%= SetCurrent(suc, TypePage.Item) %>" href="<%= Link.LnkMnCustomerReviewsItem() %>"><%= CustomerReviewsKeyword.QuanLyDanhSach %></a>
  
  <asp:Panel ID="pnQuanLyBaiVietDaXuatBan" Visible="false" runat="server">
    <a class="tool tCate <%= SetCurrent(suc, "QuanLyBaiVietDaXuatBan") %>" href="?uc=<%=uc %>&suc=QuanLyBaiVietDaXuatBan"><%=DuyetTinKeyword.QuanLyBaiVietDaXuatBan %></a>
  </asp:Panel>

  <asp:Panel ID="pnQuanLyBaiVietChoPheDuyet" Visible="false" runat="server">
    <a class="tool tCate <%= SetCurrent(suc, "QuanLyBaiVietChoPheDuyet") %>" href="?uc=<%=uc %>&suc=QuanLyBaiVietChoPheDuyet"><%=DuyetTinKeyword.QuanLyBaiVietChoPheDuyet %></a>
  </asp:Panel>

  <asp:Panel ID="pnQuanLyBaiVietDaDuocDuyet" Visible="false" runat="server">
    <a class="tool tCate <%= SetCurrent(suc, "QuanLyBaiVietDaDuocDuyet") %>" href="?uc=<%=uc %>&suc=QuanLyBaiVietDaDuocDuyet"><%=DuyetTinKeyword.QuanLyBaiVietDaDuocDuyet %></a>
  </asp:Panel>

  <asp:Panel ID="pnQuanLyBaiVietBiHuy" Visible="false" runat="server">
        <a class="tool tCate <%= SetCurrent(suc, "QuanLyBaiVietBiHuy") %>" href="?uc=<%=uc %>&suc=QuanLyBaiVietBiHuy"><%=DuyetTinKeyword.QuanLyBaiVietBiHuy %></a>
  </asp:Panel>

  <asp:Panel ID="pnQuanLyNhom" runat="server">
    <div class="">
      <a class="tool tGroup <%= SetCurrent(suc, TypePage.GroupItem) %>" href="<%= Link.LnkMnCustomerReviewsGroupItem() %>"><%= CustomerReviewsKeyword.QuanLyNhom %></a>
    </div>
  </asp:Panel>

  <div class="cb h15">
    <!---->
  </div>

  <div class="subHead"><%= CustomerReviewsKeyword.CongCu %></div>

  <asp:Panel ID="pnThemMoiDanhMuc" runat="server">
    <a class="tool tCate plus <%= SetCurrent(suc, TypePage.CreateCate) %>" href="<%= Link.LnkMnCustomerReviewsCateCreate() %>"><%= CustomerReviewsKeyword.ThemMoiDanhMuc %></a>
  </asp:Panel>

  <a class="tool tItem plus <%= SetCurrent(suc, TypePage.CreateItem) %>" href="<%= Link.LnkMnCustomerReviewsItemCreate() %>"><%= CustomerReviewsKeyword.ThemMoi %></a>
  
  <asp:Panel ID="pnThemMoiNhom" runat="server">
    <div class="">
      <a class="tool tGroup plus <%= SetCurrent(suc, TypePage.CreateGroupItem) %>" href="<%= Link.LnkMnCustomerReviewsGroupItemCreate() %>"><%= CustomerReviewsKeyword.ThemMoiNhom %></a>
    </div>
  </asp:Panel>

  <div class="cb h15">
    <!---->
  </div>

  <div class="subHead"><%= CustomerReviewsKeyword.TinhNangKhac %></div>

  <asp:Panel ID="pnCauHinh" runat="server">
    <a class="tool tConfig <%= SetCurrent(suc, TypePage.Configuration) %>" href="<%= Link.LnkMnCustomerReviewsConfig() %>"><%= CustomerReviewsKeyword.CauHinh %></a>
  </asp:Panel>

  <a class="tool tRecycle" href="javascript://"><%= CustomerReviewsKeyword.ThungRac %></a>

  <asp:Panel ID="pnThungRacDanhMuc" runat="server">
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleCate) %>" href="<%= Link.LnkMnCustomerReviewsCateRec() %>">- <%= CustomerReviewsKeyword.DanhMuc %></a>
  </asp:Panel>

  <a class="subtool <%= SetCurrent(suc, TypePage.RecycleItem) %>" href="<%= Link.LnkMnCustomerReviewsItemRec() %>">- <%= CustomerReviewsKeyword.DanhSach %></a>
  
  <asp:Panel ID="pnThungRacNhom" runat="server">
    <div class="">
      <a class="subtool <%= SetCurrent(suc, TypePage.RecycleGroupItem) %>" href="<%= Link.LnkMnCustomerReviewsGroupItemRec() %>">- <%= CustomerReviewsKeyword.Nhom %></a>
    </div>
  </asp:Panel>
</div>