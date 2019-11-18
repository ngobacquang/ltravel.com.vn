<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_FileLibrary2_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.FileLibrary2Modul" %>
<div id="FileLibrary2AdmLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.FileLibrary2Keyword.TongQuanModul %></a></div>
    <div class="DanhMucQuanLy"><%=Developer.FileLibrary2Keyword.DanhMucQuanLy %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
        <div class="PdIconInfomation"><div class='iconDanhMuc'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2Cate() %>"><%=Developer.FileLibrary2Keyword.QuanLyDanhMuc %></a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
        <div class="PdIconInfomation"><div class='iconDanhSach'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2Item() %>"><%=Developer.FileLibrary2Keyword.QuanLyDanhSach %></a>
        <div class="cbh8"><!----></div>
    </div>

    <div class="ArroundCate<%=SetSelectedCate(TypePage.GroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhom'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2GroupItem() %>"><%=Developer.FileLibrary2Keyword.QuanLyNhom %></a>
        <div class="cbh8"><!----></div>
    </div>
   
    <asp:Panel ID="pnThuocTinhDuLieu2" runat="server">
     <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2Property() %>"><%=Developer.FileLibrary2Keyword.QuanLyThuocTinh%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>        
    
    <asp:Panel ID="pnDanhSachPhanHoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Comment) %>">
        <div class="PdIconInfomation"><div class='iconPhanHoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2Comment() %>"><%=Developer.FileLibrary2Keyword.DanhSachPhanHoi%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>

    <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    <div class="cbh20"><!----></div>

    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.FileLibrary2Keyword.CongCu %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableTool() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập dữ liệu từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2CateCreate() %>"><%=Developer.FileLibrary2Keyword.ThemMoiDanhMuc %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập dữ liệu từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2ItemCreate() %>"><%=Developer.FileLibrary2Keyword.ThemMoi %></a>
        <div class="cbh0"><!----></div>
    </div>    

    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhomThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2GroupItemCreate() %>"><%=Developer.FileLibrary2Keyword.ThemMoiNhom %></a>
        <div class="cbh0"><!----></div>
    </div>
<%--    <div class="ArroundCate<%=SetSelectedCate("ImportItem") %>">
        <div class="PdIconInfomation"><a href="#" title="Click để nhập dữ liệu từ Excel"><div class='iconExcel'><!----></div></a></div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=ImportItem"><%=Developer.FileLibrary2Keyword.CapNhatQuaExcel %></a>
        <div class="cbh0"><!----></div>
    </div>   --%>   
    <asp:Panel ID="pnThuocTinhDuLieu2_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2PropertyCreate() %>"><%=Developer.FileLibrary2Keyword.ThemMoiThuocTinh%></a>
        <div class="cbh0"><!----></div>
    </div>   
    </asp:Panel>    
    
    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.FileLibrary2Keyword.TinhNangKhac %></div>
    <div class="PdSpaceCate"><div class='<%=SetCustomizeOther() %>'><div class="SpaceCate"><!----></div></div></div>
    <asp:Panel ID="pnThongKeBaoCao" runat="server">
    <%--<div class="ArroundCate<%=SetSelectedCate(TypePage.Report) %>">
        <div class="PdIconInfomation"><div class='iconReport'><!----></div></div>
        <a class="TextCateManager" href="<%=LinkManageReport %>"><%=Developer.FileLibrary2Keyword.ThongKeBaoCao%></a>
        <div class="cbh0"><!----></div>
    </div>--%>
    </asp:Panel>    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
        <div class="PdIconInfomation"><a href="#"><div class='iconConfig'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnFileLibrary2Config() %>"><%=Developer.FileLibrary2Keyword.CauHinh %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
        <div class="PdIconInfomation"><div class='iconRecycle'><!----></div></div>
        <div class="TextCateManager"><%=Developer.FileLibrary2Keyword.ThungRac %></div>
        <div class="cbh0"><!----></div>
    </div>    
    <div class="cbh5"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnFileLibrary2CateRec() %>"><%=Developer.FileLibrary2Keyword.DanhMuc %></a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnFileLibrary2ItemRec() %>"><%=Developer.FileLibrary2Keyword.DanhSach %></a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnFileLibrary2GroupItemRec() %>"><%=Developer.FileLibrary2Keyword.Nhom %></a>
    <div class="cbh0"><!----></div>
    <asp:Panel ID="pnThuocTinhDuLieu2_ThungRac" runat="server">    
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnFileLibrary2PropertyRec() %>"><%=Developer.FileLibrary2Keyword.ThuocTinh%></a>
    <div class="cbh0"><!----></div>
    </asp:Panel>                
</div>