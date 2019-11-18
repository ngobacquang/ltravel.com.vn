<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Category.ascx.cs" Inherits="cms_display_CustomerReviews_Controls_Category" %>

<div class="section customer_comments">
  <div class="container">
    <div class="list">
      <h1>
        <a href="#" class="title list-title txtCenter fSize-34 fSize-md-26 nb-color-m1"><asp:Literal ID="ltrCateName" runat="server"></asp:Literal></a>
      </h1>
      <p class="list-text hed txtCenter"><asp:Literal ID="ltrCateDesc" runat="server" /></p>
      <div class="list-body">
        <div class="row">
          <asp:Literal ID="ltrList" runat="server"></asp:Literal>
        </div>
      </div>
    </div>
  </div>
</div>