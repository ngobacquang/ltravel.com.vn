<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Blog_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.BlogModul" %>
<div id="BlogAdmLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.BlogKeyword.TongQuanModul %></a></div>
    <div class="DanhMucQuanLy"><%=Developer.BlogKeyword.DanhMucQuanLy %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
        <div class="PdIconInfomation"><div class='iconDanhMuc'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogCate() %>"><%=Developer.BlogKeyword.QuanLyDanhMuc %></a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
        <div class="PdIconInfomation"><div class='iconDanhSach'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogItem() %>"><%=Developer.BlogKeyword.QuanLyDanhSach %></a>
        <div class="cbh8"><!----></div>
    </div>

    <div class="ArroundCate<%=SetSelectedCate(TypePage.GroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhom'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogGroupItem() %>"><%=Developer.BlogKeyword.QuanLyNhom %></a>
        <div class="cbh8"><!----></div>
    </div>
   
    <asp:Panel ID="pnThuocTinhBlog" runat="server">
     <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogProperty() %>"><%=Developer.BlogKeyword.QuanLyThuocTinh%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>        
    
    <asp:Panel ID="pnDanhSachPhanHoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Comment) %>">
        <div class="PdIconInfomation"><div class='iconPhanHoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogComment() %>"><%=Developer.BlogKeyword.DanhSachPhanHoi%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>

    <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    <div class="cbh20"><!----></div>

    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.BlogKeyword.CongCu %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableTool() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập blog từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogCateCreate() %>"><%=Developer.BlogKeyword.ThemMoiDanhMuc %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập blog từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogItemCreate() %>"><%=Developer.BlogKeyword.ThemMoi %></a>
        <div class="cbh0"><!----></div>
    </div>    

    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhomThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogGroupItemCreate() %>"><%=Developer.BlogKeyword.ThemMoiNhom %></a>
        <div class="cbh0"><!----></div>
    </div>
<%--    <div class="ArroundCate<%=SetSelectedCate("ImportItem") %>">
        <div class="PdIconInfomation"><a href="#" title="Click để nhập blog từ Excel"><div class='iconExcel'><!----></div></a></div>
        <a class="TextCateManager" href="?uc=<%=uc %>&suc=ImportItem"><%=Developer.BlogKeyword.CapNhatQuaExcel %></a>
        <div class="cbh0"><!----></div>
    </div>   --%>   
    <asp:Panel ID="pnThuocTinhBlog_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogPropertyCreate() %>"><%=Developer.BlogKeyword.ThemMoiThuocTinh%></a>
        <div class="cbh0"><!----></div>
    </div>   
    </asp:Panel>    
    
    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.BlogKeyword.TinhNangKhac %></div>
    <div class="PdSpaceCate"><div class='<%=SetCustomizeOther() %>'><div class="SpaceCate"><!----></div></div></div>
    <asp:Panel ID="pnThongKeBaoCao" runat="server">
    <%--<div class="ArroundCate<%=SetSelectedCate(TypePage.Report) %>">
        <div class="PdIconInfomation"><div class='iconReport'><!----></div></div>
        <a class="TextCateManager" href="<%=LinkManageReport %>"><%=Developer.BlogKeyword.ThongKeBaoCao%></a>
        <div class="cbh0"><!----></div>
    </div>--%>
    </asp:Panel>    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
        <div class="PdIconInfomation"><a href="#"><div class='iconConfig'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnBlogConfig() %>"><%=Developer.BlogKeyword.CauHinh %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
        <div class="PdIconInfomation"><div class='iconRecycle'><!----></div></div>
        <div class="TextCateManager"><%=Developer.BlogKeyword.ThungRac %></div>
        <div class="cbh0"><!----></div>
    </div>    
    <div class="cbh5"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnBlogCateRec() %>"><%=Developer.BlogKeyword.DanhMuc %></a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnBlogItemRec() %>"><%=Developer.BlogKeyword.DanhSach %></a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnBlogGroupItemRec() %>"><%=Developer.BlogKeyword.Nhom %></a>
    <div class="cbh0"><!----></div>
    <asp:Panel ID="pnThuocTinhBlog_ThungRac" runat="server">    
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnBlogPropertyRec() %>"><%=Developer.BlogKeyword.ThuocTinh%></a>
    <div class="cbh0"><!----></div>
    </asp:Panel>                
</div>