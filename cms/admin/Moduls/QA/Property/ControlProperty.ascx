﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlProperty.ascx.cs" Inherits="cms_admin_Moduls_QA_Property_ControlProperty" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/QA/Property/ControlProperty/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlProperty">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.QAKeyword.TaoThuocTinhMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.QAKeyword.XoaThuocTinhDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.QAKeyword.TenThuocTinh%></div>
        <div class="split">|</div>        
        <div class="cot5"><%=Developer.QAKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.QAKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.QAKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
