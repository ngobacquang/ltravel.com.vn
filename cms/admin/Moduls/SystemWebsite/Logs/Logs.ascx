<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Logs.ascx.cs" Inherits="cms_admin_Moduls_SystemWebsite_Logs_Logs" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/SystemWebsite/Logs/Logs/css.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<div id="Logs">
    <div class="head">Hoạt động gần đây</div>

    <asp:Literal ID="ltrList" runat="server"></asp:Literal>
    
    <asp:Literal ID="ltrPagging" runat="server"></asp:Literal>
</div>