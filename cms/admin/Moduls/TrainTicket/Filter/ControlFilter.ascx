<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlFilter.ascx.cs" Inherits="cms_admin_Moduls_TrainTicket_Filter_ControlFilter" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/TrainTicket/Filter/ControlFilter/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="TrainTicketControlFilter">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateFilter() %>" class="LinkCreate"><%=Developer.TrainTicketKeyword.TaoThuocTinhLocMoi%></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.TrainTicketKeyword.XoaThuocTinhLocDangChon %></a>                   

        <div class="fr pt4"><asp:DropDownList ID="ddl_type_groupnews_show" runat="server" AutoPostBack="true" Width="180px" Height="20px" CssClass="TextInDdl" onselectedindexchanged="ddl_type_groupnews_show_SelectedIndexChanged"></asp:DropDownList></div>
        <div class="cb"><!----></div>
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.TrainTicketKeyword.TenThuocTinh%></div>
        <div class="split">|</div>        
        <div class="cot3" align="left"><%=Developer.TrainTicketKeyword.LoaiThuocTinh%></div>
        <div class="split">|</div>        
        <div class="cot4"><%=Developer.TrainTicketKeyword.SoMucCon%></div>
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
