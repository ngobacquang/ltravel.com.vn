<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlProperty.ascx.cs" Inherits="cms_admin_Moduls_TrainTicket_Property_ControlProperty" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/TrainTicket/Property/ControlProperty/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="TrainTicketControlProperty">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.TrainTicketKeyword.TaoThuocTinhMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.TrainTicketKeyword.XoaThuocTinhDangChon%></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.TrainTicketKeyword.TenThuocTinh%></div>
        <div class="split">|</div>        
        <div class="cot5"><%=Developer.TrainTicketKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.TrainTicketKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.TrainTicketKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
