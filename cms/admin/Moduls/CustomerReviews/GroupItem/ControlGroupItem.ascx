<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlGroupItem.ascx.cs" Inherits="cms_admin_Moduls_CustomerReviews_GroupItem_ControlGroupItem" %>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.CustomerReviewsKeyword.TaoNhomMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.CustomerReviewsKeyword.XoaNhomDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.CustomerReviewsKeyword.TenNhom%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.CustomerReviewsKeyword.SoCustomerReviews%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.CustomerReviewsKeyword.ViTri%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.CustomerReviewsKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.CustomerReviewsKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.CustomerReviewsKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>

