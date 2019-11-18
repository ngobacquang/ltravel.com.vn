<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoadControl.ascx.cs" Inherits="cms_admin_System_website_AdmLoadControls" %>
<%@ Import Namespace="TatThanhJsc.SystemWebsiteModul" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/SystemWebsite/cs/css.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<%@ Register src="Leftmenu.ascx" tagname="Leftmenu" tagprefix="uc1" %>
<div id="AdmLoadControls">
    <div id="AdmRoad">
        <a class="TextRoad">Bạn đang ở: </a>
        <a title="Trang chủ" class="TextRoad" href="admin.aspx">Trang chủ</a>
        <a title="Trang chủ" class="TextRoad arrow" href="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>admin.aspx?uc=Systemwebsite">Hệ thống</a>
        <div class="cbh0"><!----></div>            
    </div>
    <div class="PositionLeftControl">
        <uc1:Leftmenu ID="Leftmenu" runat="server" />
        <div style="position:absolute;bottom:0;left:0">            
            <a href="?uc=<%=CodeApplications.Systemwebsite %>&suc=ConfigurationHidden" title="Cấu hình ẩn cho modul hệ thống">&nbsp;&nbsp;</a>
        </div>
    </div>
    <div class="PositionRightControl"><asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder></div>
    <div class="cbh0"><!----></div>
</div>