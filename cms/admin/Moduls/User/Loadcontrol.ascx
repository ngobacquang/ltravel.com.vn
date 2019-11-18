<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_ModulMain_User_AdmLoadcontrols" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/User/cs/css.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<%@ Register src="Leftmenu.ascx" tagname="Leftmenu" tagprefix="uc1" %>
<div id="AdmUserLoadControls">
    <div id="AdmRoad">
        <a class="TextRoad">Bạn đang ở: </a>
        <a title="Trang chủ" class="TextRoad" href="admin.aspx">Trang chủ</a>
        <a title="Trang chủ" class="TextRoad arrow" href="<%="admin.aspx?uc=" + TatThanhJsc.UserModul.CodeApplications.User + "&suc=manager" %>">Tài khoản</a>
        <div class="cbh0"><!----></div>            
    </div>
    <div class="PositionLeftControl"><uc1:Leftmenu ID="Leftmenu" runat="server" /></div>
    <div class="PositionRightControlModul"><asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder></div>
    <div class="cbh0"><!----></div>
</div>