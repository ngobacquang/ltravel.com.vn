<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCate.ascx.cs" Inherits="cms_admin_Moduls_Hotel_Cate_ControlCate" %>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.HotelKeyword.TaoDanhMucMoi %></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.HotelKeyword.XoaDanhMucDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.HotelKeyword.TenDanhMuc%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.HotelKeyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.HotelKeyword.SoMucCon%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.HotelKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.HotelKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.HotelKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
