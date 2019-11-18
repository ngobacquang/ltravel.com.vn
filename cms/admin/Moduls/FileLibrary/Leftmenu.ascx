<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_FileLibrary_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.FileLibraryModul" %>
<div id="FileLibraryAdmLeftMenu">
  <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.FileLibraryKeyword.TongQuanModul %></a></div>
  <div class="DanhMucQuanLy"><%=Developer.FileLibraryKeyword.DanhMucQuanLy %></div>
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
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryCate() %>"><%=Developer.FileLibraryKeyword.QuanLyDanhMuc %></a>
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
    <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryItem() %>"><%=Developer.FileLibraryKeyword.QuanLyDanhSach %></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryGroupItem() %>"><%=Developer.FileLibraryKeyword.QuanLyNhom %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhDuLieu" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryProperty() %>"><%=Developer.FileLibraryKeyword.QuanLyThuocTinh%></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryComment() %>"><%=Developer.FileLibraryKeyword.DanhSachPhanHoi%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
  <div class="cbh20">
    <!---->
  </div>

  <div class="DanhMucQuanLy"><%=Developer.FileLibraryKeyword.CongCu %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableTool() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  
  <asp:Panel ID="pnThemMoiDanhMuc" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
      <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập dữ liệu từ Excel">
        <div class='iconDanhSachThemMoi'>
          <!---->
        </div>
      </a></div>
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryCateCreate() %>"><%=Developer.FileLibraryKeyword.ThemMoiDanhMuc %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
    <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập dữ liệu từ Excel">
      <div class='iconDanhSachThemMoi'>
        <!---->
      </div>
    </a></div>
    <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryItemCreate() %>"><%=Developer.FileLibraryKeyword.ThemMoi %></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryGroupItemCreate() %>"><%=Developer.FileLibraryKeyword.ThemMoiNhom %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <%--    <div class="ArroundCate<%=SetSelectedCate("ImportItem") %>">
        <div class="PdIconInfomation"><a href="#" title="Click để nhập dữ liệu từ Excel"><div class='iconExcel'><!----></div></a></div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=ImportItem"><%=Developer.FileLibraryKeyword.CapNhatQuaExcel %></a>
        <div class="cbh0"><!----></div>
    </div>   --%>
  <asp:Panel ID="pnThuocTinhDuLieu_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryPropertyCreate() %>"><%=Developer.FileLibraryKeyword.ThemMoiThuocTinh%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="cbh20">
    <!---->
  </div>
  <div class="DanhMucQuanLy"><%=Developer.FileLibraryKeyword.TinhNangKhac %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetCustomizeOther() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <asp:Panel ID="pnThongKeBaoCao" runat="server">
    <%--<div class="ArroundCate<%=SetSelectedCate(TypePage.Report) %>">
        <div class="PdIconInfomation"><div class='iconReport'><!----></div></div>
        <a class="TextCateManager" href="<%=LinkManageReport %>"><%=Developer.FileLibraryKeyword.ThongKeBaoCao%></a>
        <div class="cbh0"><!----></div>
    </div>--%>
  </asp:Panel>
  
  <asp:Panel ID="pnCauHinh" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
      <div class="PdIconInfomation"><a href="#">
        <div class='iconConfig'>
          <!---->
        </div>
      </a></div>
      <a class="TextCateManager" href="<%=Link.LnkMnFileLibraryConfig() %>"><%=Developer.FileLibraryKeyword.CauHinh %></a>
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
    <div class="TextCateManager"><%=Developer.FileLibraryKeyword.ThungRac %></div>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="cbh5">
    <!---->
  </div>
  
  <asp:Panel ID="pnThungRacDanhMuc" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnFileLibraryCateRec() %>"><%=Developer.FileLibraryKeyword.DanhMuc %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>

  <div class="PdSubIconRecycleBin">-</div>
  <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnFileLibraryItemRec() %>"><%=Developer.FileLibraryKeyword.DanhSach %></a>
  <div class="cbh0">
    <!---->
  </div>
  
  <asp:Panel ID="pnThungRacNhom" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnFileLibraryGroupItemRec() %>"><%=Developer.FileLibraryKeyword.Nhom %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhDuLieu_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnFileLibraryPropertyRec() %>"><%=Developer.FileLibraryKeyword.ThuocTinh%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
</div>
