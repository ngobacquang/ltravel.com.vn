<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmLeftmenu.ascx.cs" Inherits="cms_admin_ModulMain_Language_AdmLeftmenu" %>
<div id="AdmLanguageLeftMenu">
  <div class="BgTabTongQuan">
    <a class="TextInTabTongQuan" href="admin.aspx?uc=<%= uc %>">Tổng quan modul từ khóa</a>
  </div>
  <div class="DanhMucQuanLy">Danh mục quản lý</div>
  <div class="PdSpaceCate">
    <div class="<%= SetEnableSpaceCate() %>">
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <asp:Panel ID="pnQuanLyNgonNgu" runat="server">
    <div class="ArroundCate<%= SetSelectedCate("national") %>">
      <div class="BgImageIconLanguage">&nbsp;</div>
      <a class="TextCateManager" href="?uc=<%= uc %>&suc=national">Quản lý ngôn ngữ</a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <asp:Panel ID="pnQuanLyMaTuKhoa" runat="server">
    <div class="ArroundCate<%= SetSelectedCate("code") %>">
      <div class="BgImageIconKey">&nbsp;</div>
      <a class="TextCateManager" href="?uc=<%= uc %>&suc=code">Quản lý mã từ khóa</a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <asp:Panel ID="pnQuanLyTuKhoa" runat="server">
    <div class="ArroundCate<%= SetSelectedCate("keyword") %>">
      <div class="BgImageIconBarcode">&nbsp;</div>
      <a class="TextCateManager" href="?uc=<%= uc %>&suc=keyword">Quản lý từ khóa</a>
      <div class="cbh8">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <div class="cbh20">
    <!---->
  </div>
  <div class="DanhMucQuanLy">Công cụ</div>
  <div class="PdSpaceCate">
    <div class="<%= SetEnableTool() %>">
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <asp:Panel ID="pnQuanLyNgonNgu_ThemMoi" runat="server">
    <div class="ArroundCate<%= SetSelectedCate("CreateLanguageNational") %>">
      <div class="BgImageIconAdd">&nbsp;</div>
      <a class="TextCateManager" href="?uc=<%= uc %>&suc=CreateLanguageNational">Thêm mới ngôn ngữ</a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <asp:Panel ID="pnQuanLyMaTuKhoa_ThemMoi" runat="server">
    <div class="ArroundCate<%= SetSelectedCate("CreateLanguageKey") %>">
      <div class="BgImageIconAdd">&nbsp;</div>
      <a class="TextCateManager" href="?uc=<%= uc %>&suc=CreateLanguageKey">Thêm mới mã từ khóa</a>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <div class="dn">
    <asp:Panel ID="pnQuanLyTuKhoa_ThemMoi" runat="server" Visible="False">
      <div class="ArroundCate<%= SetSelectedCate("ImportLanguageKey") %>">
        <div class="BgImageIconAdd">&nbsp;</div>
        <a class="TextCateManager" href="?uc=<%= uc %>&suc=ImportLanguageKey">Nhập mã từ khóa từ <b>Excel</b></a>
        <div class="cbh0">
          <!---->
        </div>
      </div>
    </asp:Panel>
  </div>
  <div class="cbh20">
    <!---->
  </div>
</div>
