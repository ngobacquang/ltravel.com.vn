<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Control.ascx.cs" Inherits="cms_admin_Moduls_Other_Psg_Control" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Other/Psg/Control/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.PageSingleContentKeyword.ThemMoi %></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteRecListGroup('')" class="LinkDelete"><%=Developer.PageSingleContentKeyword.Xoa %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup', this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.PageSingleContentKeyword.TieuDe%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.PageSingleContentKeyword.ViTri%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.PageSingleContentKeyword.LuotXem%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.PageSingleContentKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.PageSingleContentKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.PageSingleContentKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
