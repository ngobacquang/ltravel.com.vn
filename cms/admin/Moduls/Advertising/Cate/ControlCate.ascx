<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCate.ascx.cs" Inherits="cms_admin_Moduls_Advertising_Cate_ControlCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Advertising/Cate/ControlCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="AdvertisingControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.AdvertisingKeyword.TaoNhomBaiVietMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.AdvertisingKeyword.XoaNhomBaiVietDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.AdvertisingKeyword.TenNhomBaiViet%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.AdvertisingKeyword.ViTri%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.AdvertisingKeyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.AdvertisingKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.AdvertisingKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.AdvertisingKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
