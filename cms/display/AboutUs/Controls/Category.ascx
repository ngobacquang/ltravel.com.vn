<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Category.ascx.cs" Inherits="cms_display_AboutUs_Controls_Category" %>

<div class="section facilities aboutUs">
  <div class="container">
    <div class="list">
      <h1>
        <a href="#" class="title list-title txtCenter fSize-34 nb-color-m1"><asp:Literal ID="ltrCateName" runat="server"></asp:Literal></a>
      </h1>
      <p class="list-text hed txtCenter"><asp:Literal ID="ltrCateDesc" runat="server" /></p>
      <div class="list-body clearfix">
        <asp:Literal ID="ltrList" runat="server"></asp:Literal>
      </div>
    </div>
  </div>
</div>