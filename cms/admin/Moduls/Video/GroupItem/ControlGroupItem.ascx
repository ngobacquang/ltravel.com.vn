<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlGroupItem.ascx.cs" Inherits="cms_admin_Moduls_Video_GroupItem_ControlGroupItem" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Video/GroupItem/ControlGroupItem/_cs.css" rel="stylesheet" type="text/css" />    
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlGroupItem">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.VideoKeyword.TaoNhomMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.VideoKeyword.XoaNhomDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.VideoKeyword.TenNhom%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.VideoKeyword.SoVideo%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.VideoKeyword.ViTri%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.VideoKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.VideoKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.VideoKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>

