<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Loadcontrol.ascx.cs" Inherits="cms_admin_FileLibrary2_Loadcontrol" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/FileLibrary2/_cs/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<%@ Register src="Leftmenu.ascx" tagname="AdmLeftmenu" tagprefix="uc1" %>
<div id="FileLibrary2Modul">
    <div id="AdmRoad">
        <a class="TextRoad">Bạn đang ở: </a>
        <a title="Trang chủ" class="TextRoad" href="admin.aspx">Trang chủ</a>
        <a title="Trang chủ" class="TextRoad arrow" href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2() %>">Dữ liệu</a>
        <div class="cbh0"><!----></div>
    
        <a class="config" href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2Config() %>" title="Click để cấu hình cho trang này"><span class="iconConfig dib">&nbsp;</span></a>
    </div>
    <div class="PositionLeftControl"><uc1:AdmLeftmenu ID="AdmLeftmenu" runat="server" /></div>
    <div class="PositionRightControl">
        <asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder>
    </div>
    <div class="cbh0"><!----></div>
</div>