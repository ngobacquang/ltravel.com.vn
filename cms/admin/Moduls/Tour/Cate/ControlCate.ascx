﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCate.ascx.cs" Inherits="cms_admin_Moduls_Tour_Cate_ControlCate" %>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ControlCate">
    <div class="BgTabTool">        
        <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.TourKeyword.TaoDanhMucMoi %></a>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.TourKeyword.XoaDanhMucDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.TourKeyword.TenDanhMuc%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.TourKeyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.TourKeyword.SoMucCon%></div>
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
