﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_Moduls_Content_Loadcontrol" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Content/_cs/_Content.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<%@ Register src="Leftmenu.ascx" tagname="AdmLeftmenu" tagprefix="uc1" %>
<div id="ContentModul">
    <div id="AdmRoad">
        <a class="TextRoad">Bạn đang ở: </a>
        <a title="Trang chủ" class="TextRoad" href="admin.aspx">Trang chủ</a>
        <a title="Trang chủ" class="TextRoad arrow" href="<%=TatThanhJsc.ContentModul.Link.LnkMnContent() %>">Trang nội dung</a>
        <div class="cbh0"><!----></div>            
    </div>
    <div class="PositionLeftControl"><uc1:AdmLeftmenu ID="AdmLeftmenu" runat="server" /></div>
    <div class="PositionRightControl">
        <asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder>
    </div>
    <div class="cbh0"><!----></div>
</div>
