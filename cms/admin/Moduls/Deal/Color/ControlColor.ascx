<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlColor.ascx.cs" Inherits="cms_admin_Moduls_Deal_Color_ControlColor" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Deal/Color/ControlColor/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="DealControlColor">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateColor() %>" class="LinkCreate"><%=Developer.DealKeyword.TaoMauMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.DealKeyword.XoaMauDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.DealKeyword.TenMau%></div>
        <div class="split">|</div>        
        <div class="cot6"><%=Developer.DealKeyword.MauSac %></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.DealKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.DealKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.DealKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
