<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_Moduls_Menu_Loadcontrol" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
<link href="~/cms/admin/Moduls/Menu/_cs/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<%@ Register src="Leftmenu.ascx" tagname="AdmLeftmenu" tagprefix="uc1" %>
<div id="MenuAdmLoadControls">
    <div id="AdmRoad">
        <a class="TextRoad">Bạn đang ở: </a>
        <a title="Trang chủ" class="TextRoad" href="admin.aspx">Trang chủ</a>
        <a title="Trang chủ" class="TextRoad arrow" href="<%=TatThanhJsc.MenuModul.Link.LnkMnMenu() %>">Menu</a>
        <div class="cbh0"><!----></div>            
    </div>
    <div class="PositionLeftControl"><uc1:AdmLeftmenu ID="AdmLeftmenu" runat="server" /></div>
    <div class="PositionRightControlModul"><asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder></div>
    <div class="cbh0"><!----></div>
</div>