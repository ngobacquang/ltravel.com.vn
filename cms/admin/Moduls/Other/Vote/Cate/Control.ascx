<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Control.ascx.cs" Inherits="cms_admin_Moduls_Other_Vote_Cate_Control" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Other/Vote/Cate/Control/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="votec">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.VoteKeyword.TaoCauHoiMoi %></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteRecListGroups()" class="LinkDelete"><%=Developer.VoteKeyword.XoaCauHoiDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup', this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.VoteKeyword.CauHoi%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.VoteKeyword.TraLoi%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.VoteKeyword.CauHoiCon%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.VoteKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.VoteKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.VoteKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
