<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Index.ascx.cs" Inherits="cms_display_Search_Controls_Index" %>

<div class="section main-grid tours">
  <div class="container">
    <div class="list">
      <div class="list-search"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Tìm thấy") %>
      <asp:Literal ID="ltrTotalResult" runat="server"></asp:Literal>
      <%=LanguageItemExtension.GetnLanguageItemTitleByName("tour") %> <asp:Literal ID="ltrDiemDen" runat="server"></asp:Literal> <asp:Literal ID="ltrThoiGian" runat="server"></asp:Literal></div>
      <div class="list-body">
        <div class="wap clearfix">
          <asp:Literal ID="ltrList" runat="server"></asp:Literal>
        </div>
      </div>
    </div>
    <asp:Literal ID="ltrPagging" runat="server"></asp:Literal>
  </div>
</div>