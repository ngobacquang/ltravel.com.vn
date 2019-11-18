<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCate.ascx.cs" Inherits="cms_admin_Moduls_FileLibrary2_Cate_ControlCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/FileLibrary2/Cate/ControlCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.FileLibrary2Keyword.TaoDanhMucMoi %></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.FileLibrary2Keyword.XoaDanhMucDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.FileLibrary2Keyword.TenDanhMuc%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.FileLibrary2Keyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.FileLibrary2Keyword.SoMucCon%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.FileLibrary2Keyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.FileLibrary2Keyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.FileLibrary2Keyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
