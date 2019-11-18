<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_AboutUs_Leftmenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.AboutUsModul" %>
<div id="Leftmenu" class="colLeft">
  <a class="head" href="admin.aspx?uc=<%= uc %>"><%= AboutUsKeyword.TongQuanModul %><span><!----></span></a>

  <div class="subHead"><%= AboutUsKeyword.DanhMucQuanLy %></div>

  <asp:Panel ID="pnQuanLyDanhMuc" runat="server">
    <a class="tool tCate <%= SetCurrent(suc, TypePage.Cate) %>" href="<%= Link.LnkMnAboutUsCate() %>"><%= AboutUsKeyword.QuanLyDanhMuc %></a>
  </asp:Panel>

  <a class="tool tItem <%= SetCurrent(suc, TypePage.Item) %>" href="<%= Link.LnkMnAboutUsItem() %>"><%= AboutUsKeyword.QuanLyDanhSach %></a>
  
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
    <div class="dn">
      <a class="tool tGroup <%= SetCurrent(suc, TypePage.GroupItem) %>" href="<%= Link.LnkMnAboutUsGroupItem() %>"><%= AboutUsKeyword.QuanLyNhom %></a>
    </div>
  </asp:Panel>
  <div class="cb h15">
    <!---->
  </div>

  <div class="subHead"><%= AboutUsKeyword.CongCu %></div>

  <asp:Panel ID="pnThemMoiDanhMuc" runat="server">
    <a class="tool tCate plus <%= SetCurrent(suc, TypePage.CreateCate) %>" href="<%= Link.LnkMnAboutUsCateCreate() %>"><%= AboutUsKeyword.ThemMoiDanhMuc %></a>
  </asp:Panel>

  <a class="tool tItem plus <%= SetCurrent(suc, TypePage.CreateItem) %>" href="<%= Link.LnkMnAboutUsItemCreate() %>"><%= AboutUsKeyword.ThemMoi %></a>
  
  <asp:Panel ID="pnThemMoiNhom" runat="server">
    <div class="dn">
      <a class="tool tGroup plus <%= SetCurrent(suc, TypePage.CreateGroupItem) %>" href="<%= Link.LnkMnAboutUsGroupItemCreate() %>"><%= AboutUsKeyword.ThemMoiNhom %></a>
    </div>
  </asp:Panel>

  <div class="cb h15">
    <!---->
  </div>

  <div class="subHead"><%= AboutUsKeyword.TinhNangKhac %></div>
  
  <asp:Panel ID="pnCauHinh" runat="server">
    <a class="tool tConfig <%= SetCurrent(suc, TypePage.Configuration) %>" href="<%= Link.LnkMnAboutUsConfig() %>"><%= AboutUsKeyword.CauHinh %></a>
  </asp:Panel>

  <a class="tool tRecycle" href="javascript://"><%= AboutUsKeyword.ThungRac %></a>
  
  <asp:Panel ID="pnThungRacDanhMuc" runat="server">
    <a class="subtool <%= SetCurrent(suc, TypePage.RecycleCate) %>" href="<%= Link.LnkMnAboutUsCateRec() %>">- <%= AboutUsKeyword.DanhMuc %></a>
  </asp:Panel>

  <asp:Panel ID="pnThungRacNhom" runat="server">
    <div class="dn">
      <a class="subtool <%= SetCurrent(suc, TypePage.RecycleGroupItem) %>" href="<%= Link.LnkMnAboutUsGroupItemRec() %>">- <%= AboutUsKeyword.Nhom %></a>
    </div>
  </asp:Panel>
 
  <a class="subtool <%= SetCurrent(suc, TypePage.RecycleItem) %>" href="<%= Link.LnkMnAboutUsItemRec() %>">- <%= AboutUsKeyword.DanhSach %></a>
</div>
