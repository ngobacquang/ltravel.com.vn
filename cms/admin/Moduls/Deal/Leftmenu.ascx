<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Deal_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.DealModul" %>
<div id="DealAdmLeftMenu">
  <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.DealKeyword.TongQuanModul %></a></div>
  <div class="DanhMucQuanLy"><%=Developer.DealKeyword.DanhMucQuanLy %></div>
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
      <a class="TextCateManager" href="<%=Link.LnkMnDealCate() %>"><%=Developer.DealKeyword.QuanLyDanhMuc %></a>
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
    <a class="TextCateManager" href="<%=Link.LnkMnDealItem() %>"><%=Developer.DealKeyword.QuanLyDanhSach %></a>
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

  <asp:Panel ID="pnQuanLyNhom" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.GroupItem) %>">
      <div class="PdIconInfomation">
        <div class='iconNhom'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnDealGroupItem() %>"><%=Developer.DealKeyword.QuanLyNhom %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>


  <asp:Panel ID="pnThuocTinhLocDeal" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Filter) %>">
      <div class="PdIconInfomation">
        <div class='iconLoc'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnDealFilter() %>"><%=Developer.DealKeyword.QuanLyThuocTinhLoc%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <asp:Panel ID="pnThuocTinhDeal" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnDealProperty() %>"><%=Developer.DealKeyword.QuanLyThuocTinh%></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnDealColor() %>"><%=Developer.DealKeyword.QuanLyMau%></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnDealProvider() %>"><%=Developer.DealKeyword.QuanLyHangSanXuat%></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnDealComment() %>"><%=Developer.DealKeyword.DanhSachPhanHoi%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <div class="ArroundCate<%=SetSelectedCate(TypePage.Cart) %> dn">
    <div class="PdIconInfomation">
      <div class='iconDonHang'>
        <!---->
      </div>
    </div>
    <a class="TextCateManager" href="<%=Link.LnkMnDealCart() %>"><%=Developer.DealKeyword.QuanLyDonHang%></a>
    <div class="cbh8">
      <!---->
    </div>
  </div>
  <!--API-->
  <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
  <div class="cbh20">
    <!---->
  </div>

  <div class="DanhMucQuanLy"><%=Developer.DealKeyword.CongCu%></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableTool() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  
  <asp:Panel ID="pnThemMoiDanhMuc" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
      <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập deal từ Excel">
        <div class='iconDanhSachThemMoi'>
          <!---->
        </div>
      </a></div>
      <a class="TextCateManager" href="<%=Link.LnkMnDealCateCreate() %>"><%=Developer.DealKeyword.ThemMoiDanhMuc %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
    <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập deal từ Excel">
      <div class='iconDanhSachThemMoi'>
        <!---->
      </div>
    </a></div>
    <a class="TextCateManager" href="<%=Link.LnkMnDealItemCreate() %>"><%=Developer.DealKeyword.ThemMoi %></a>
    <div class="cbh0">
      <!---->
    </div>
  </div>

  <asp:Panel ID="pnThemMoiNhom" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
      <div class="PdIconInfomation">
        <div class='iconNhomThemMoi'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnDealGroupItemCreate() %>"><%=Developer.DealKeyword.ThemMoiNhom %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhDeal_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnDealPropertyCreate() %>"><%=Developer.DealKeyword.ThemMoiThuocTinh%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <asp:Panel ID="pnThuocTinhLocDeal_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateFilter) %>">
      <div class="PdIconInfomation">
        <div class='iconLoc'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnDealFilterCreate() %>"><%=Developer.DealKeyword.ThemMoiThuocTinhLoc%></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnDealColorCreate() %>"><%=Developer.DealKeyword.ThemMoiMau%></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnDealProviderCreate() %>"><%=Developer.DealKeyword.ThemMoiHangSanXuat%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <div class="cbh20">
    <!---->
  </div>
  <div class="DanhMucQuanLy"><%=Developer.DealKeyword.TinhNangKhac %></div>
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
      <a class="TextCateManager" href="<%=Link.LnkMnDealConfig() %>"><%=Developer.DealKeyword.CauHinh %></a>
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
    <div class="TextCateManager"><%=Developer.DealKeyword.ThungRac %></div>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="cbh5">
    <!---->
  </div>
  
  <asp:Panel ID="pnThungRacDanhMuc" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnDealCateRec() %>"><%=Developer.DealKeyword.DanhMuc %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>

  <div class="PdSubIconRecycleBin">-</div>
  <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnDealItemRec() %>"><%=Developer.DealKeyword.DanhSach %></a>
  <div class="cbh0">
    <!---->
  </div>
  
  <asp:Panel ID="pnThungRacNhom" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnDealGroupItemRec() %>"><%=Developer.DealKeyword.Nhom %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhDeal_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnDealPropertyRec() %>"><%=Developer.DealKeyword.ThuocTinh%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <asp:Panel ID="pnThuocTinhLocDeal_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleFilter) %>" href="<%=Link.LnkMnDealFilterRec() %>"><%=Developer.DealKeyword.ThuocTinhLoc%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <asp:Panel ID="PnColor_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleColor) %>" href="<%=Link.LnkMnDealColorRec() %>"><%=Developer.DealKeyword.MauDeal%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <asp:Panel ID="pnProvider_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProvider) %>" href="<%=Link.LnkMnDealProviderRec() %>"><%=Developer.DealKeyword.HangSanXuat%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
</div>
