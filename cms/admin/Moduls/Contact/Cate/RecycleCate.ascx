<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecycleCate.ascx.cs" Inherits="cms_admin_Moduls_ContactUs_Cate_RecycleCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Contact/Cate/RecycleCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_insert_update" runat="server" />
<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />
<asp:HiddenField ID="hd_desc_id" runat="server" />
<asp:HiddenField ID="hdImg" runat="server" />
<asp:HiddenField ID="hdImgHover" runat="server" />
<asp:HiddenField ID="HdTotalView" runat="server" />

<div id="ContactUsRecycleCate">
    <div class="BgTabTool"><a href="javascript:DeleteRecListGroup('<%=pic %>')" class="LinkDelete">Xóa mục đang chọn</a></div>
    <div class="cbh0"><!----></div>
    <div class="BgTabTitle" align="center">
        <div class="cot1 pt5"><input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup',this)" /></div>
        <div class="split">|</div>
        <div class="cot2" align="left">Tên</div>
        <div class="split">|</div>
        <div class="cot4" align="left">Đường dẫn</div>
        <div class="split">|</div>
        <div class="cot5">Thứ tự</div>
        <div class="split">|</div>
        <div class="cot7">Công cụ</div>
        <div class="cbh0"><!----></div>
    </div>
    <div align="center" class="content">
        <asp:Literal ID="LtListMenus" runat="server"></asp:Literal>
    </div>
</div>