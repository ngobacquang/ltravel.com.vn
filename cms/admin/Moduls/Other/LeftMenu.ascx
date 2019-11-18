<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LeftMenu.ascx.cs" Inherits="cms_admin_Moduls_Other_LeftMenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.AdminModul" %>
<%@ Import Namespace="TatThanhJsc.OtherModul" %>

<div id="lm_OtherModul">
    <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="<%=LinkAdmin.GoAdminModul(CodeApplications.other) %>">Tính năng khác</a></div>
    
    <asp:Panel ID="pnSO" runat="server">
        <div class="bTab1"><%=Developer.SupportOnlineKeyword.TongQuanModul %></div>
        <div class="PdSpaceCate"><div class="mnl_line1 bcccc"><!----></div></div>
        <div class="ArroundCate<%=SetSelectedSO(TypePage.Cate) %>">
            <div class="mn-r-arw"><!----></div>
            <a class="TextCateManager" href="<%=TatThanhJsc.OtherModul.Link.LnkMnSupportOnlineCate() %>"><%=Developer.SupportOnlineKeyword.QuanLyDanhMuc %></a>
            <div class="cbh8"><!----></div>
        </div>
        <div class="ArroundCate<%=SetSelectedSO(TypePage.Item) %>">
            <div class="mn-r-arw"><!----></div>
            <a class="TextCateManager" href="<%=TatThanhJsc.OtherModul.Link.LnkMnSupportOnlineItem() %>"><%=Developer.SupportOnlineKeyword.QuanLyDanhSach %></a>
            <div class="cbh8"><!----></div>
        </div>      
        <asp:PlaceHolder ID="PhManagerApi" runat="server"></asp:PlaceHolder>
    </asp:Panel>
    
    <asp:Panel ID="pnPsg" runat="server">
        <div class="bTab1"><%=Developer.PageSingleContentKeyword.TongQuanModul %></div>
        <div class="PdSpaceCate"><div class="mnl_line1 bcccc"><!----></div></div>
        <div class="ArroundCate<%=SetSelected(CodeApplications.PageSingleContent) %>">
            <div class="mn-r-arw"><!----></div>
            <a class="TextCateManager" href="<%=TatThanhJsc.OtherModul.Link.LnkMnPsg() %>"><%=ContentKeyword.Content %></a>
        </div>
        <div class="cbh20"><!----></div>
    </asp:Panel>

    <div class="bTab1">Tính năng khác</div>
    <div class="PdSpaceCate"><div class="mnl_line1 bcccc"><!----></div></div>

    <asp:Panel ID="pnVote" runat="server">    
        <div class="ArroundCate<%=SetSelected(CodeApplications.Vote) %>">
            <div class="mn-r-arw"><!----></div>
            <a class="TextCateManager" href="<%=TatThanhJsc.OtherModul.Link.LnkMnVote() %>"><%=VoteKeyword.Vote %></a>
            <div class="cbh8"><!----></div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnSiteMap" runat="server">
        <div class="ArroundCate<%=SetSelected(CodeApplications.SiteMap) %>">
            <div class="mn-r-arw"><!----></div>
            <a class="TextCateManager" href="<%=TatThanhJsc.OtherModul.Link.LnkMnSiteMap() %>"><%=SiteMapKeyword.SiteMap %></a>
            <div class="cbh8"><!----></div>
        </div>
    </asp:Panel>
    
    <asp:Panel ID="pnTag" runat="server">
        <div class="ArroundCate<%=SetSelected(CodeApplications.Tag) %>">
            <div class="mn-r-arw"><!----></div>
            <a class="TextCateManager" href="<%=TatThanhJsc.OtherModul.Link.LnkMnTag() %>"><%=TagKeyword.Tag %></a>
            <div class="cbh8"><!----></div>
        </div>
    </asp:Panel>
    
    <asp:Panel ID="pnDcLink" runat="server">
        <div class="ArroundCate<%=SetSelected("dclink") %>">
            <div class="mn-r-arw"><!----></div>
            <a class="TextCateManager" href="?uc=other&uco=dclink">Kiểm tra trùng link</a>
            <div class="cbh8"><!----></div>
        </div>
    </asp:Panel>
</div>