﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlGroupItem.ascx.cs" Inherits="cms_admin_Moduls_Customer_GroupItem_ControlGroupItem" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Customer/GroupItem/ControlGroupItem/_cs.css" rel="stylesheet" type="text/css" />    
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlGroupItem">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.CustomerKeyword.TaoNhomMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.CustomerKeyword.XoaNhomDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.CustomerKeyword.TenNhom%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.CustomerKeyword.SoCustomer%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.CustomerKeyword.ViTri%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.CustomerKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.CustomerKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.CustomerKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>

