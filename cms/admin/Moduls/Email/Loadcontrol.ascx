<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_Email_Loadcontrols" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Email/_cs/css.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<%@ Register src="Leftmenu.ascx" tagname="Leftmenu" tagprefix="uc1" %>
<div id="AdmPageSingleContentLoadControls">
    <div class="cbh8"><!----></div>
    <div class="PositionLeftControl">
        <uc1:Leftmenu ID="Leftmenu" runat="server" />
        <div style="position:absolute;bottom:0;left:0">
        <a href="?uc=Email&suc=ConfigurationHidden" title="Cấu hình ẩn cho modul gửi email định kỳ">&nbsp;&nbsp;</a>        
        </div>
    </div>
    <div class="PositionRightControlModul"><asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder></div>
    <div class="cbh0"><!----></div>
</div>