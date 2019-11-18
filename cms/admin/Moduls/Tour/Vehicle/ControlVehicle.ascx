<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlVehicle.ascx.cs" Inherits="cms_admin_Moduls_Tour_Vehicle_ControlVehicle" %>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate">Tạo thời gian mới</a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete">Xóa thời gian đang chọn</a>                   
    </div>
    <div class="BgTabTitle box-post" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left">Thời gian</div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.TourKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.TourKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.TourKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
