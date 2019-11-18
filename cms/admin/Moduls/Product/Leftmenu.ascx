<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Product_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.ProductModul" %>
<div id="ProductAdmLeftMenu">
  <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.ProductKeyword.TongQuanModul %></a></div>
  <div class="DanhMucQuanLy"><%=Developer.ProductKeyword.DanhMucQuanLy %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableSpaceCate() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>

  <asp:Panel ID="pnQuanLyDanhMuc" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
      <div class="PdIconInfomation">
        <div class='iconDanhMuc'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductCate() %>"><%=Developer.ProductKeyword.QuanLyDanhMuc %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
    <div class="PdIconInfomation">
      <div class='iconDanhSach'>
        <!---->
      </div>
    </div>
    <a class="TextCateManager" href="<%=Link.LnkMnProductItem() %>"><%=Developer.ProductKeyword.QuanLyDanhSach %></a>
    <div class="cbh8">
      <!---->
    </div>
  </div>

  <asp:Panel ID="pnQuanLyBaiVietDaXuatBan" Visible="false" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("QuanLyBaiVietDaXuatBan") %>">
      <div class="PdIconInfomation">
        <div class='iconDanhSach'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="?uc=<%=uc %>&suc=QuanLyBaiVietDaXuatBan"><%=Developer.DuyetTinKeyword.QuanLyBaiVietDaXuatBan %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnQuanLyBaiVietChoPheDuyet" Visible="false" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("QuanLyBaiVietChoPheDuyet") %>">
      <div class="PdIconInfomation">
        <div class='iconDanhSach'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="?uc=<%=uc %>&suc=QuanLyBaiVietChoPheDuyet"><%=Developer.DuyetTinKeyword.QuanLyBaiVietChoPheDuyet %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnQuanLyBaiVietDaDuocDuyet" Visible="false" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("QuanLyBaiVietDaDuocDuyet") %>">
      <div class="PdIconInfomation">
        <div class='iconDanhSach'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="?uc=<%=uc %>&suc=QuanLyBaiVietDaDuocDuyet"><%=Developer.DuyetTinKeyword.QuanLyBaiVietDaDuocDuyet %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnQuanLyBaiVietBiHuy" Visible="false" runat="server">
    <div class="ArroundCate<%=SetSelectedCate("QuanLyBaiVietBiHuy") %>">
      <div class="PdIconInfomation">
        <div class='iconDanhSach'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="?uc=<%=uc %>&suc=QuanLyBaiVietBiHuy"><%=Developer.DuyetTinKeyword.QuanLyBaiVietBiHuy %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnNhom" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.GroupItem) %>">
      <div class="PdIconInfomation">
        <div class='iconNhom'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductGroupItem() %>"><%=Developer.ProductKeyword.QuanLyNhom %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhLocSanPham" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Filter) %>">
      <div class="PdIconInfomation">
        <div class='iconLoc'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductFilter() %>"><%=Developer.ProductKeyword.QuanLyThuocTinhLoc%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhSanPham" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductProperty() %>"><%=Developer.ProductKeyword.QuanLyThuocTinh%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="PnColor" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Color) %>">
      <div class="PdIconInfomation">
        <div class='iconMau'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductColor() %>"><%=Developer.ProductKeyword.QuanLyMau%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="PnProvider" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Provider) %>">
      <div class="PdIconInfomation">
        <div class='iconProvider'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductProvider() %>"><%=Developer.ProductKeyword.QuanLyHangSanXuat%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnDanhSachPhanHoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Comment) %>">
      <div class="PdIconInfomation">
        <div class='iconPhanHoi'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductComment() %>"><%=Developer.ProductKeyword.DanhSachPhanHoi%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnDonHang" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cart) %>">
      <div class="PdIconInfomation">
        <div class='iconDonHang'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductCart() %>"><%=Developer.ProductKeyword.QuanLyDonHang%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <!--API-->
  <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
  <div class="cbh20">
    <!---->
  </div>

  <div class="DanhMucQuanLy"><%=Developer.ProductKeyword.CongCu%></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableTool() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>

  <asp:Panel ID="pnThemMoiDanhMuc" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
      <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập sản phẩm từ Excel">
        <div class='iconDanhSachThemMoi'>
          <!---->
        </div>
      </a></div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductCateCreate() %>"><%=Developer.ProductKeyword.ThemMoiDanhMuc %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
    <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập sản phẩm từ Excel">
      <div class='iconDanhSachThemMoi'>
        <!---->
      </div>
    </a></div>
    <a class="TextCateManager" href="<%=Link.LnkMnProductItemCreate() %>"><%=Developer.ProductKeyword.ThemMoi %></a>
    <div class="cbh0">
      <!---->
    </div>
  </div>

  <asp:Panel ID="pnNhom_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
      <div class="PdIconInfomation">
        <div class='iconNhomThemMoi'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductGroupItemCreate() %>"><%=Developer.ProductKeyword.ThemMoiNhom %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhSanPham_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductPropertyCreate() %>"><%=Developer.ProductKeyword.ThemMoiThuocTinh%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhLocSanPham_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateFilter) %>">
      <div class="PdIconInfomation">
        <div class='iconLoc'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductFilterCreate() %>"><%=Developer.ProductKeyword.ThemMoiThuocTinhLoc%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="PnColor_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateColor) %>">
      <div class="PdIconInfomation">
        <div class='iconMau'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductColorCreate() %>"><%=Developer.ProductKeyword.ThemMoiMau%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnProvider_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProvider) %>">
      <div class="PdIconInfomation">
        <div class='iconProvider'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductProviderCreate() %>"><%=Developer.ProductKeyword.ThemMoiHangSanXuat%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <div class="cbh20">
    <!---->
  </div>
  <div class="DanhMucQuanLy"><%=Developer.ProductKeyword.TinhNangKhac %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetCustomizeOther() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <asp:Panel ID="pnThongKeBaoCao" runat="server">
  </asp:Panel>
  
  <asp:Panel ID="pnCauHinh" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
      <div class="PdIconInfomation"><a href="#">
        <div class='iconConfig'>
          <!---->
        </div>
      </a></div>
      <a class="TextCateManager" href="<%=Link.LnkMnProductConfig() %>"><%=Developer.ProductKeyword.CauHinh %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
    <div class="PdIconInfomation">
      <div class='iconRecycle'>
        <!---->
      </div>
    </div>
    <div class="TextCateManager"><%=Developer.ProductKeyword.ThungRac %></div>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="cbh5">
    <!---->
  </div>
  <asp:Panel ID="pnThungRacDanhMuc" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnProductCateRec() %>"><%=Developer.ProductKeyword.DanhMuc %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <div class="PdSubIconRecycleBin">-</div>
  <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnProductItemRec() %>"><%=Developer.ProductKeyword.DanhSach %></a>
  <div class="cbh0">
    <!---->
  </div>
  <asp:Panel ID="pnNhom_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnProductGroupItemRec() %>"><%=Developer.ProductKeyword.Nhom %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhSanPham_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnProductPropertyRec() %>"><%=Developer.ProductKeyword.ThuocTinh%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <asp:Panel ID="pnThuocTinhLocSanPham_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleFilter) %>" href="<%=Link.LnkMnProductFilterRec() %>"><%=Developer.ProductKeyword.ThuocTinhLoc%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <asp:Panel ID="PnColor_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleColor) %>" href="<%=Link.LnkMnProductColorRec() %>"><%=Developer.ProductKeyword.MauSanPham%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <asp:Panel ID="pnProvider_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProvider) %>" href="<%=Link.LnkMnProductProviderRec() %>"><%=Developer.ProductKeyword.HangSanXuat%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
</div>
