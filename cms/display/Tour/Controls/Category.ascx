<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Category.ascx.cs" Inherits="cms_display_Tour_Controls_Category" %>

<div class="section main-grid tours">
  <div class="container">
    <div class="list">
      <h2>
        <a href="#" class="title list-title txtCenter fSize-34 nb-color-m1">
          <asp:Literal ID="ltrCateName" runat="server" /></a>
      </h2>
      <p class="list-text hed txtCenter">
        <asp:Literal ID="ltrCateDesc" runat="server" /></p>
      <div class="list-body">
        <asp:Literal ID="ltrNoResult" runat="server" />
        <asp:Panel ID="pnInfo" CssClass="wap clearfix" runat="server">
          <div class="col bigTwo">
            <div class="slick-slider" data-slick='{"slidesToShow": 1, "slidesToScroll": 1, "autoplay": true, "dots": false, "arrows":true}'>
              <asp:Literal ID="ltrList1" runat="server" />
            </div>
          </div>
          <asp:Literal ID="ltrList2" runat="server" />
        </asp:Panel>
      </div>
    </div>
  </div>
</div>
<asp:Literal ID="ltrPaging" runat="server" />
<br>
<div class="blogText">
  <div class="container">
    <asp:Literal ID="ltrText" runat="server" />
    <br>
    <br>
  </div>
</div>