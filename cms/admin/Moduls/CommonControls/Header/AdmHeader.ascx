<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmHeader.ascx.cs" Inherits="cms_admin_CommonControls_AdmHeader" %>
<%@ Register src="AdmControlsHeaderLogo.ascx" tagname="AdmControlsHeaderLogo" tagprefix="uc2" %>
<%@ Register src="AdmControlsHeaderTopMenu.ascx" tagname="AdmControlsHeaderTopMenu" tagprefix="uc3" %>
<%@ Register src="../../Search/SubSearch/AdmSubSearchBoxSearch.ascx" tagname="AdmSubSearchBoxSearch" tagprefix="uc1" %>
<div id="AdmHeader">
    <div class="FormatColLogo"><uc2:AdmControlsHeaderLogo ID="AdmControlsHeaderLogo1" runat="server" /></div>
    <div class="FormatColRightControl">
        <uc3:AdmControlsHeaderTopMenu ID="AdmControlsHeaderTopMenu1" runat="server" />        
        <div><uc1:AdmSubSearchBoxSearch ID="AdmSubSearchBoxSearch1" runat="server" /></div>
    </div>
    <div class="cbh0"><!----></div>
</div>