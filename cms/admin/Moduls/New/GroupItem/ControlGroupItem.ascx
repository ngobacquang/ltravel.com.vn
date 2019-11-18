﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlGroupItem.ascx.cs" Inherits="cms_admin_Moduls_New_GroupItem_ControlGroupItem" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
  <link href="~/cms/admin/Moduls/New/GroupItem/ControlGroupItem/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hd_modulid" runat="server" />
<asp:HiddenField ID="hd_parent" runat="server" />
<div id="ControlGroupItem">
  <div class="BgTabTool">
    <a href="<%=LinkCreateCate() %>" class="LinkCreate"><%=Developer.NewKeyword.TaoNhomMoi%></a>
    &nbsp;|&nbsp;
        <a href="javascript:DeleteListGroups()" class="LinkDelete"><%=Developer.NewKeyword.XoaNhomDangChon%></a>
  </div>
  <div class="BgTabTitle" align="center">
    <div class="cot1 pt5">
      <input id="CbList" type="checkbox" onclick="CheckAllCheckBox('CbGroup', this)" /></div>
    <div class="split">|</div>
    <div class="cot2" align="left"><%=Developer.NewKeyword.TenNhom%></div>
    <div class="split">|</div>
    <div class="cot3"><%=Developer.NewKeyword.SoNews%></div>
    <div class="split">|</div>
    <div class="cot4"><%=Developer.NewKeyword.ViTri%></div>
    <div class="split">|</div>
    <div class="cot5"><%=Developer.NewKeyword.ThuTu %></div>
    <div class="split">|</div>
    <div class="cot6"><%=Developer.NewKeyword.TrangThai %></div>
    <div class="split">|</div>
    <div class="cot7"><%=Developer.NewKeyword.CongCu %></div>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="content">
    <asp:Literal ID="LtCates" runat="server"></asp:Literal>
    <div class="cbh5">
      <!---->
    </div>
  </div>
  <div class="cb h25">
    <!---->
  </div>
</div>

