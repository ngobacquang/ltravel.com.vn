<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Moduls_Menu_Leftmenu" %>
<%@ Import Namespace="TatThanhJsc.MenuModul" %>
<div id="MenuAdmLeftMenu">
  <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="<%=Link.LnkMnMenu() %>">Tổng quan menu</a></div>

  <div class="DanhMucQuanLy">Danh mục quản lý</div>
  <div class="PdSpaceCate">
    <div>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>

  <asp:Literal ID="ltrControl" runat="server"></asp:Literal>


  <div class="cbh10">
    <!---->
  </div>
  <div class="DanhMucQuanLy">Công cụ</div>
  <div class="PdSpaceCate">
    <div>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>

  <asp:Literal ID="ltrShortCut" runat="server"></asp:Literal>


  <div class="cbh10">
    <!---->
  </div>

  <div class="DanhMucQuanLy">Tính năng khác</div>
  <div class="PdSpaceCate">
    <div>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <div class="ArroundCate">
    <div class="PdIconInfomation">
      <div class='iconRecycle'>
        <!---->
      </div>
    </div>
    <div class="TextCateManager">Thùng rác</div>
    <div class="cbh0">
      <!---->
    </div>
  </div>

  <asp:Literal ID="ltrRec" runat="server"></asp:Literal>
</div>
