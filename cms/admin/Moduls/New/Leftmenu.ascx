<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_New_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.NewsModul" %>
<div id="NewAdmLeftMenu">
  <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.NewKeyword.TongQuanModul %></a></div>
  <div class="DanhMucQuanLy"><%=Developer.NewKeyword.DanhMucQuanLy %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableSpaceCate() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>

  <%--edit here--%>
  <asp:Panel ID="pnQuanLyDanhMuc" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
      <div class="PdIconInfomation">
        <div class='iconDanhMuc'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnNewsCate() %>"><%=Developer.NewKeyword.QuanLyDanhMuc %></a>
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
    <a class="TextCateManager" href="<%=Link.LnkMnNewsItem() %>"><%=Developer.NewKeyword.QuanLyDanhSach %></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnNewsGroupItem() %>"><%=Developer.NewKeyword.QuanLyNhom %></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:Panel ID="pnThuocTinhTinTuc" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnNewsProperty() %>"><%=Developer.NewKeyword.QuanLyThuocTinh%></a>
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
      <a class="TextCateManager" href="<%=Link.LnkMnNewsComment() %>"><%=Developer.NewKeyword.DanhSachPhanHoi%></a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder> 

  <div class="cbh20">
    <!---->
  </div>
  <div class="DanhMucQuanLy"><%=Developer.NewKeyword.CongCu %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableTool() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>

  <%--edit here--%>
  <asp:Panel ID="pnThemMoiDanhMuc" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
      <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập tin tức từ Excel">
        <div class='iconDanhSachThemMoi'>
          <!---->
        </div>
      </a></div>
      <a class="TextCateManager" href="<%=Link.LnkMnNewsCateCreate() %>"><%=Developer.NewKeyword.ThemMoiDanhMuc %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
    <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập tin tức từ Excel">
      <div class='iconDanhSachThemMoi'>
        <!---->
      </div>
    </a></div>
    <a class="TextCateManager" href="<%=Link.LnkMnNewsItemCreate() %>"><%=Developer.NewKeyword.ThemMoi %></a>
    <div class="cbh0">
      <!---->
    </div>
  </div>

  <%--edit here--%>
  <asp:Panel ID="pnThemMoiNhom" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
      <div class="PdIconInfomation">
        <div class='iconNhomThemMoi'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnNewsGroupItemCreate() %>"><%=Developer.NewKeyword.ThemMoiNhom %></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <%--    <div class="ArroundCate<%=SetSelectedCate("ImportItem") %>">
        <div class="PdIconInfomation"><a href="#" title="Click để nhập tin tức từ Excel"><div class='iconExcel'><!----></div></a></div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=ImportItem"><%=Developer.NewKeyword.CapNhatQuaExcel %></a>
        <div class="cbh0"><!----></div>
    </div>   --%>
  <asp:Panel ID="pnThuocTinhTinTuc_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
      <div class="PdIconInfomation">
        <div class='iconThuocTinh'>
          <!---->
        </div>
      </div>
      <a class="TextCateManager" href="<%=Link.LnkMnNewsPropertyCreate() %>"><%=Developer.NewKeyword.ThemMoiThuocTinh%></a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>

  <div class="cbh20">
    <!---->
  </div>
  <div class="DanhMucQuanLy"><%=Developer.NewKeyword.TinhNangKhac %></div>
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
        <a class="TextCateManager" href="<%=LinkManageReport %>"><%=Developer.NewKeyword.ThongKeBaoCao%></a>
        <div class="cbh0"><!----></div>
    </div>--%>
  </asp:Panel>

  <%--edit here--%>
  <asp:Panel ID="pnCauHinh" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
      <div class="PdIconInfomation"><a href="#">
        <div class='iconConfig'>
          <!---->
        </div>
      </a></div>
      <a class="TextCateManager" href="<%=Link.LnkMnNewsConfig() %>"><%=Developer.NewKeyword.CauHinh %></a>
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
    <div class="TextCateManager"><%=Developer.NewKeyword.ThungRac %></div>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="cbh5">
    <!---->
  </div>

  <%--edit here--%>
  <asp:Panel ID="pnThungRacDanhMuc" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnNewsCateRec() %>"><%=Developer.NewKeyword.DanhMuc %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
  <div class="PdSubIconRecycleBin">-</div>
  <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnNewsItemRec() %>"><%=Developer.NewKeyword.DanhSach %></a>
  <div class="cbh0">
    <!---->
  </div>

  <%--edit here--%>
  <asp:Panel ID="pnThungRacNhom" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnNewsGroupItemRec() %>"><%=Developer.NewKeyword.Nhom %></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>

  <%--edit here--%>
  <asp:Panel ID="pnThuocTinhTinTuc_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnNewsPropertyRec() %>"><%=Developer.NewKeyword.ThuocTinh%></a>
    <div class="cbh0">
      <!---->
    </div>
  </asp:Panel>
</div>