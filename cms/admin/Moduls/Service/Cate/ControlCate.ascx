﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCate.ascx.cs" Inherits="cms_admin_Moduls_Service_Cate_ControlCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Service/Cate/ControlCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.ServiceKeyword.TaoDanhMucMoi %></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.ServiceKeyword.XoaDanhMucDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.ServiceKeyword.TenDanhMuc%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.ServiceKeyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.ServiceKeyword.SoMucCon%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.ServiceKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.ServiceKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.ServiceKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
