<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubCustomerReviewsOtherItem.ascx.cs" Inherits="cms_display_CustomerReviews_subControls_SubCustomerReviewsOtherItem" %>

<div class="section customer_say detail">
  <div class="container">
    <div class="list">
      <h2>
        <a href="#" class="title list-title fSize-28 fSize-md-26 fSize-sm-20"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Other comments") %></a>
      </h2>
      <div class="list-body">
        <div class="slick-slider" data-slick='{"slidesToShow": 3, "slidesToScroll": 1, "autoplay": true, "dots": false, "arrows":true, "responsive": [{"breakpoint":1025,"settings":{"slidesToShow": 2}},{"breakpoint":768,"settings": {"slidesToShow": 1}}]}'>
          <asp:Literal ID="ltrList" runat="server" />
        </div>
      </div>
    </div>
  </div>
</div>