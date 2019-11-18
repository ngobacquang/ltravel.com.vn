<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmLoadcontrol.ascx.cs" Inherits="cms_admin_ModulMain_Language_AdmLoadcontrol" %>
<%@ Register src="AdmLeftmenu.ascx" tagname="AdmLeftmenu" tagprefix="uc1" %>
<link href="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/Moduls/Language/_cs/_cs.css" rel="stylesheet" type="text/css" />
<div id="AdmLanguageLoadControls">
    <div class="cb h10"><!----></div>
    <div class="PositionLeftControl"><uc1:AdmLeftmenu ID="AdmLeftmenu" runat="server" /></div>
    <div class="PositionRightControlModul"><asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder></div>
    <div class="cbh0"><!----></div>
</div>