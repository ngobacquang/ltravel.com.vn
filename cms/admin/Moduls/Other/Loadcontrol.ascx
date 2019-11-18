<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_Moduls_Other_Loadcontrol" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server"><link href="~/cms/admin/Moduls/Other/_cs/_cs.css" rel="stylesheet" type="text/css" /></cc1:StyleSheetCombiner>
<%@ Register src="Leftmenu.ascx" tagname="AdmLeftmenu" tagprefix="uc1" %>
<div id="SupportOnlineModul">
    <div id="AdmRoad">
        <asp:Literal ID="LtRoad" runat="server"></asp:Literal>
    </div>
    <div class="PositionLeftControl"><uc1:AdmLeftmenu ID="AdmLeftmenu" runat="server" /></div>
    <div class="PositionRightControl">
        <asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder>
        
    </div>
    <div class="cbh0"><!----></div>
</div>