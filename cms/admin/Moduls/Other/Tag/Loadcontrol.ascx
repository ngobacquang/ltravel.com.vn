<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_Tag_Loadcontrol" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Other/Tag/_cs/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder>