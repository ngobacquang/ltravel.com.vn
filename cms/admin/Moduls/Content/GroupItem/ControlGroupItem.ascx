<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlGroupItem.ascx.cs" Inherits="cms_admin_Moduls_Content_GroupItem_ControlGroupItem" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Content/GroupItem/ControlGroupItem/_cs.css" rel="stylesheet" type="text/css" />    
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ContentControlCate">
    <div class="BgTabTool">
        <asp:LinkButton CssClass="LinkCreate" ID="lbtCreate" runat="server" onclick="lbtCreate_Click"><%=Developer.ContentKeyword.TaoViTriBaiVietMoi%></asp:LinkButton>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.ContentKeyword.XoaViTriBaiVietDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.ContentKeyword.TenViTriBaiViet%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.ContentKeyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.ContentKeyword.ViTri%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.ContentKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.ContentKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.ContentKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>

