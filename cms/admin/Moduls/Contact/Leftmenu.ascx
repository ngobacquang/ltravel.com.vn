<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Moduls_ContactUs_Leftmenu" %>
<%@ Import Namespace="TatThanhJsc.ContactModul" %>
<div id="ContactUsAdmLeftMenu">
  <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="<%=Link.LnkMnContact() %>"><%=Developer.ContactKeyword.TongQuan %></a></div>
  <div class="DanhMucQuanLy"><%=Developer.ContactKeyword.DanhMucQuanLy %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableSpaceCate() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
    <div class="PdIconInfomation">
      <div class="iconDanhMuc">
        <!---->
      </div>
    </div>
    <a class="TextCateManager" href="<%=Link.LnkMnContactCate() %>"><%=Developer.ContactKeyword.QuanLyNhomBaiViet %></a>
    <div class="cbh8">
      <!---->
    </div>
  </div>
  <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
    <div class="PdIconInfomation">
      <div class='iconDanhSach'>
        <!---->
      </div>
    </div>
    <a class="TextCateManager" href="<%=Link.LnkMnContactItem() %>"><%=Developer.ContactKeyword.QuanLyDanhSachBaiViet %></a>
    <div class="cbh8">
      <!---->
    </div>
  </div>
  <div class="ArroundCate<%=SetSelectedCate(TypePage.ContactContent) %>">
    <div class="PdIconInfomation">
      <div class='iconDanhSach'>
        <!---->
      </div>
    </div>
    <a class="TextCateManager" href="<%=Link.LnkMnContactContent() %>"><%=Developer.ContactKeyword.QuanLyNoiDungTrangLienHe%></a>
    <div class="cbh8">
      <!---->
    </div>
  </div>
  <div class="cbh8">
    <!---->
  </div>
  <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
  <div class="cbh20">
    <!---->
  </div>

  <div class="DanhMucQuanLy"><%=Developer.ContactKeyword.CongCu %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableTool() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
    <div class="PdIconInfomation">
      <div class='iconDanhMucThemMoi'>
        <!---->
      </div>
    </div>
    <a class="TextCateManager" href="<%=Link.LnkMnContactCateCreate() %>"><%=Developer.ContactKeyword.ThemMoiNhomBaiViet %></a>
    <div class="cbh0">
      <!---->
    </div>
  </div>

  <div class="cbh20">
    <!---->
  </div>
  <div class="DanhMucQuanLy"><%=Developer.ContactKeyword.TinhNangKhac %></div>
  <div class="PdSpaceCate">
    <div class='<%=SetEnableTool() %>'>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
    <div class="PdIconInfomation">
      <div class='iconRecycle'>
        <!---->
      </div>
    </div>
    <div class="TextCateManager"><%=Developer.ContactKeyword.ThungRac %></div>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="cbh5">
    <!---->
  </div>
  <div class="PdSubIconRecycleBin">-</div>
  <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnContactCateRec() %>"><%=Developer.ContactKeyword.NhomBaiViet %></a>
  <div class="cbh0">
    <!---->
  </div>
  <div class="PdSubIconRecycleBin">-</div>
  <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnContactItemRec() %>"><%=Developer.ContactKeyword.DanhSachBaiViet%></a>
  <div class="cbh0">
    <!---->
  </div>

</div>
