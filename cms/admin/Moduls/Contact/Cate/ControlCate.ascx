<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlCate.ascx.cs" Inherits="cms_admin_Moduls_ContactUs_Cate_ControlCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Contact/Cate/ControlCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />        
<div id="ContactUsControlCate">
    <div class="BgTabTool">
        <asp:LinkButton CssClass="LinkCreate" ID="lbtCreate" runat="server" onclick="lbtCreate_Click"><%=Developer.ContactKeyword.TaoNhomBaiVietMoi %></asp:LinkButton>
        &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.ContactKeyword.XoaNhomBaiVietDangChon %></a>                   
    </div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left"><%=Developer.ContactKeyword.TenNhomBaiViet%></div>
        <div class="split">|</div>
        <div class="cot3"><%=Developer.ContactKeyword.SoBaiViet%></div>
        <div class="split">|</div>
        <div class="cot4"><%=Developer.ContactKeyword.NhomCon%></div>
        <div class="split">|</div>
        <div class="cot5"><%=Developer.ContactKeyword.ThuTu %></div>
        <div class="split">|</div>
        <div class="cot6"><%=Developer.ContactKeyword.TrangThai %></div>
        <div class="split">|</div>
        <div class="cot7"><%=Developer.ContactKeyword.CongCu %></div>
        <div class="cbh0"><!----></div>
    </div>
    <div class="content">
        <asp:Literal ID="LtCates" runat="server"></asp:Literal>
        <div class="cbh5"><!----></div>
    </div>
    <div class="cb h25"><!----></div>
</div>
