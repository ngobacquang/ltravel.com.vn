<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCate.ascx.cs" Inherits="cms_admin_Moduls_Tag_Cate_ControlCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Other/Tag/Cate/ControlCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="TagControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.TagKeyword.TaoDanhMucMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.TagKeyword.XoaDanhMucDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.TagKeyword.TenDanhMuc%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.TagKeyword.TagChoMdul%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.TagKeyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.TagKeyword.SoMucCon%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.TagKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.TagKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.TagKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
