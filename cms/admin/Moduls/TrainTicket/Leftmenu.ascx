<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_TrainTicket_AdmLeftmenu" %>
<%@ Import Namespace="TatThanhJsc.TrainTicketModul" %>
<div id="TrainTicketAdmLeftMenu">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>"><%=Developer.TrainTicketKeyword.TongQuanModul %></a></div>
    <div class="DanhMucQuanLy"><%=Developer.TrainTicketKeyword.DanhMucQuanLy %></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableSpaceCate() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cate) %>">
        <div class="PdIconInfomation"><div class='iconDanhMuc'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketCate() %>"><%=Developer.TrainTicketKeyword.QuanLyDanhMuc %></a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Item) %>">
        <div class="PdIconInfomation"><div class='iconDanhSach'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketItem() %>"><%=Developer.TrainTicketKeyword.QuanLyDanhSach %></a>
        <div class="cbh8"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.GroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhom'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketGroupItem() %>"><%=Developer.TrainTicketKeyword.QuanLyNhom %></a>
        <div class="cbh8"><!----></div>
    </div>
    <asp:Panel ID="pnThuocTinhLocTrainTicket" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Filter) %>">
        <div class="PdIconInfomation"><div class='iconLoc'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketFilter() %>"><%=Developer.TrainTicketKeyword.QuanLyThuocTinhLoc%></a>
        <div class="cbh8"><!----></div>
    </div>    
    </asp:Panel>
    <asp:Panel ID="pnThuocTinhTrainTicket" runat="server">
     <div class="ArroundCate<%=SetSelectedCate(TypePage.Property) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketProperty() %>"><%=Developer.TrainTicketKeyword.QuanLyThuocTinh%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>        
    <asp:Panel ID="PnColor" runat="server">    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Color) %>">
        <div class="PdIconInfomation"><div class='iconMau'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketColor() %>"><%=Developer.TrainTicketKeyword.QuanLyMau%></a>
        <div class="cbh8"><!----></div>
    </div>    
    </asp:Panel>
    <asp:Panel ID="PnProvider" runat="server">    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Provider) %>">
        <div class="PdIconInfomation"><div class='iconProvider'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketProvider() %>"><%=Developer.TrainTicketKeyword.QuanLyHangSanXuat%></a>
        <div class="cbh8"><!----></div>
    </div>    
    </asp:Panel>
    <asp:Panel ID="pnDanhSachPhanHoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Comment) %>">
        <div class="PdIconInfomation"><div class='iconPhanHoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketComment() %>"><%=Developer.TrainTicketKeyword.DanhSachPhanHoi%></a>
        <div class="cbh8"><!----></div>
    </div>
    </asp:Panel>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Cart) %>">
        <div class="PdIconInfomation"><div class='iconDonHang'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketCart() %>"><%=Developer.TrainTicketKeyword.QuanLyDonHang%></a>
        <div class="cbh8"><!----></div>
    </div>
    <!--API-->
    <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    <div class="cbh20"><!----></div>

    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.TrainTicketKeyword.CongCu%></div>
    <div class="PdSpaceCate"><div class='<%=SetEnableTool() %>'><div class="SpaceCate"><!----></div></div></div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateCate) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportCategory" title="Click để nhập Vé tàu từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketCateCreate() %>"><%=Developer.TrainTicketKeyword.ThemMoiDanhMuc %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateItem) %>">
        <div class="PdIconInfomation"><a href="?uc=<%=uc %>&suc=ImportItem" title="Click để nhập Vé tàu từ Excel"><div class='iconDanhSachThemMoi'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketItemCreate() %>"><%=Developer.TrainTicketKeyword.ThemMoi %></a>
        <div class="cbh0"><!----></div>
    </div>    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateGroupItem) %>">
        <div class="PdIconInfomation"><div class='iconNhomThemMoi'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketGroupItemCreate() %>"><%=Developer.TrainTicketKeyword.ThemMoiNhom %></a>
        <div class="cbh0"><!----></div>
    </div>
    <asp:Panel ID="pnThuocTinhTrainTicket_ThemMoi" runat="server">
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProperty) %>">
        <div class="PdIconInfomation"><div class='iconThuocTinh'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketPropertyCreate() %>"><%=Developer.TrainTicketKeyword.ThemMoiThuocTinh%></a>
        <div class="cbh0"><!----></div>
    </div>   
    </asp:Panel>    
    <asp:Panel ID="pnThuocTinhLocTrainTicket_ThemMoi" runat="server">
     <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateFilter) %>">
        <div class="PdIconInfomation"><div class='iconLoc'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketFilterCreate() %>"><%=Developer.TrainTicketKeyword.ThemMoiThuocTinhLoc%></a>
        <div class="cbh0"><!----></div>
    </div>   
    </asp:Panel>
    <asp:Panel ID="PnColor_ThemMoi" runat="server">    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateColor) %>">
        <div class="PdIconInfomation"><div class='iconMau'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketColorCreate() %>"><%=Developer.TrainTicketKeyword.ThemMoiMau%></a>
        <div class="cbh0"><!----></div>
    </div>
    </asp:Panel>
    <asp:Panel ID="pnProvider_ThemMoi" runat="server">    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.CreateProvider) %>">
        <div class="PdIconInfomation"><div class='iconProvider'><!----></div></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketProviderCreate() %>"><%=Developer.TrainTicketKeyword.ThemMoiHangSanXuat%></a>
        <div class="cbh0"><!----></div>
    </div>
    </asp:Panel>
    <div class="cbh20"><!----></div>
    <div class="DanhMucQuanLy"><%=Developer.TrainTicketKeyword.TinhNangKhac %></div>
    <div class="PdSpaceCate"><div class='<%=SetCustomizeOther() %>'><div class="SpaceCate"><!----></div></div></div>
    <asp:Panel ID="pnThongKeBaoCao" runat="server">
    </asp:Panel>    
    <div class="ArroundCate<%=SetSelectedCate(TypePage.Configuration) %>">
        <div class="PdIconInfomation"><a href="#"><div class='iconConfig'><!----></div></a></div>
        <a class="TextCateManager" href="<%=Link.LnkMnTrainTicketConfig() %>"><%=Developer.TrainTicketKeyword.CauHinh %></a>
        <div class="cbh0"><!----></div>
    </div>
    <div class="ArroundCate<%=SetSelectedRecycleBin() %>">
        <div class="PdIconInfomation"><div class='iconRecycle'><!----></div></div>
        <div class="TextCateManager"><%=Developer.TrainTicketKeyword.ThungRac %></div>
        <div class="cbh0"><!----></div>
    </div>    
    <div class="cbh5"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleCate) %>" href="<%=Link.LnkMnTrainTicketCateRec() %>"><%=Developer.TrainTicketKeyword.DanhMuc %></a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleItem) %>" href="<%=Link.LnkMnTrainTicketItemRec() %>"><%=Developer.TrainTicketKeyword.DanhSach %></a>
    <div class="cbh0"><!----></div>
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleGroupItem) %>" href="<%=Link.LnkMnTrainTicketGroupItemRec() %>"><%=Developer.TrainTicketKeyword.Nhom %></a>
    <div class="cbh0"><!----></div>
    <asp:Panel ID="pnThuocTinhTrainTicket_ThungRac" runat="server">    
    <div class="PdSubIconRecycleBin">-</div>
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProperty) %>" href="<%=Link.LnkMnTrainTicketPropertyRec() %>"><%=Developer.TrainTicketKeyword.ThuocTinh%></a>
    <div class="cbh0"><!----></div>
    </asp:Panel>        
    <asp:Panel ID="pnThuocTinhLocTrainTicket_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>    
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleFilter) %>" href="<%=Link.LnkMnTrainTicketFilterRec() %>"><%=Developer.TrainTicketKeyword.ThuocTinhLoc%></a>
    <div class="cbh0"><!----></div>
    </asp:Panel>
    <asp:Panel ID="PnColor_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>    
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleColor) %>" href="<%=Link.LnkMnTrainTicketColorRec() %>"><%=Developer.TrainTicketKeyword.MauTrainTicket%></a>
    <div class="cbh0"><!----></div>
    </asp:Panel>
    <asp:Panel ID="pnProvider_ThungRac" runat="server">
    <div class="PdSubIconRecycleBin">-</div>    
    <a class="TextCateManager <%=SetSelectedCate(TypePage.RecycleProvider) %>" href="<%=Link.LnkMnTrainTicketProviderRec() %>"><%=Developer.TrainTicketKeyword.HangSanXuat%></a>
    <div class="cbh0"><!----></div>
    </asp:Panel>
</div>