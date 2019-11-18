<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlGroupItem.ascx.cs" Inherits="cms_admin_Moduls_FileLibrary_GroupItem_ControlGroupItem" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/FileLibrary/GroupItem/ControlGroupItem/_cs.css" rel="stylesheet" type="text/css" />    
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlGroupItem">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.FileLibraryKeyword.TaoNhomMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.FileLibraryKeyword.XoaNhomDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.FileLibraryKeyword.TenNhom%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.FileLibraryKeyword.SoFileLibrary%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.FileLibraryKeyword.ViTri%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.FileLibraryKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.FileLibraryKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.FileLibraryKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>

