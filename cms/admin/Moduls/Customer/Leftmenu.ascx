<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Customer_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.CustomerModul" %>
<div id="CustomerAdmLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.CustomerKeyword.TongQuanModul %></a></div>
    <div class="DanhMucQuanLy"><%=Developer.CustomerKeyword.DanhMucQuanLy %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
        <div class="PdIconInfomation"><div class='iconDanhMuc'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerCate() %>"><%=Developer.CustomerKeyword.QuanLyDanhMuc %></a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
        <div class="PdIconInfomation"><div class='iconDanhSach'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerItem() %>"><%=Developer.CustomerKeyword.QuanLyDanhSach %></a>
        <div class="cbh8"><!----></div>
    </div>

    <div class="dn">
        <div class="ArroundCate<%=SetSelectedCate(TypePage.GroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhom'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerGroupItem() %>"><%=Developer.CustomerKeyword.QuanLyNhom %></a>
        <div class="cbh8"><!----></div>
    </div>
    </div>
   
    <asp:Panel ID="pnThuocTinhKhachHang" runat="server">
     <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerProperty() %>"><%=Developer.CustomerKeyword.QuanLyThuocTinh%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>        
    
    <asp:Panel ID="pnDanhSachPhanHoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Comment) %>">
        <div class="PdIconInfomation"><div class='iconPhanHoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerComment() %>"><%=Developer.CustomerKeyword.DanhSachPhanHoi%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>

    <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    <div class="cbh20"><!----></div>

    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.CustomerKeyword.CongCu %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableTool() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập khách hàng từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerCateCreate() %>"><%=Developer.CustomerKeyword.ThemMoiDanhMuc %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập khách hàng từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerItemCreate() %>"><%=Developer.CustomerKeyword.ThemMoi %></a>
        <div class="cbh0"><!----></div>
    </div>    

    <div class="dn">
        <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhomThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerGroupItemCreate() %>"><%=Developer.CustomerKeyword.ThemMoiNhom %></a>
        <div class="cbh0"><!----></div>
    </div>
    </div>

<%--    <div class="ArroundCate<%=SetSelectedCate("ImportItem") %>">
        <div class="PdIconInfomation"><a href="#" title="Click để nhập khách hàng từ Excel"><div class='iconExcel'><!----></div></a></div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=ImportItem"><%=Developer.CustomerKeyword.CapNhatQuaExcel %></a>
        <div class="cbh0"><!----></div>
    </div>   --%>   
    <asp:Panel ID="pnThuocTinhKhachHang_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerPropertyCreate() %>"><%=Developer.CustomerKeyword.ThemMoiThuocTinh%></a>
        <div class="cbh0"><!----></div>
    </div>   
    </asp:Panel>    
    
    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.CustomerKeyword.TinhNangKhac %></div>
    <div class="PdSpaceCate"><div class='<%=SetCustomizeOther() %>'><div class="SpaceCate"><!----></div></div></div>
    <asp:Panel ID="pnThongKeBaoCao" runat="server">
    <%--<div class="ArroundCate<%=SetSelectedCate(TypePage.Report) %>">
        <div class="PdIconInfomation"><div class='iconReport'><!----></div></div>
        <a class="TextCateManager" href="<%=LinkManageReport %>"><%=Developer.CustomerKeyword.ThongKeBaoCao%></a>
        <div class="cbh0"><!----></div>
    </div>--%>
    </asp:Panel>    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
        <div class="PdIconInfomation"><a href="#"><div class='iconConfig'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnCustomerConfig() %>"><%=Developer.CustomerKeyword.CauHinh %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
        <div class="PdIconInfomation"><div class='iconRecycle'><!----></div></div>
        <div class="TextCateManager"><%=Developer.CustomerKeyword.ThungRac %></div>
        <div class="cbh0"><!----></div>
    </div>    
    <div class="cbh5"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnCustomerCateRec() %>"><%=Developer.CustomerKeyword.DanhMuc %></a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnCustomerItemRec() %>"><%=Developer.CustomerKeyword.DanhSach %></a>
    <div class="cbh0"><!----></div>
    <div class="dn">
        <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnCustomerGroupItemRec() %>"><%=Developer.CustomerKeyword.Nhom %></a>
    <div class="cbh0"><!----></div>
    </div>
    <asp:Panel ID="pnThuocTinhKhachHang_ThungRac" runat="server">    
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnCustomerPropertyRec() %>"><%=Developer.CustomerKeyword.ThuocTinh%></a>
    <div class="cbh0"><!----></div>
    </asp:Panel>                
</div>