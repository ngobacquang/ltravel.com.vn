<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubHotelDetail_Images.ascx.cs" Inherits="cms_display_Hotel_subControls_SubHotelDetail_Images" %>

<div class="slider slider-for slick-slider" data-slick='{"slidesToShow": 1, "asNavFor": ".slider-nav", "fade": false}'>
  <asp:Literal ID="ltrMainImages" runat="server"></asp:Literal>
</div>
<div class="slider slider-nav slick-slider" data-slick='{"slidesToShow": 5, "slidesToScroll": 1, "asNavFor": ".slider-for", "arrows": false, "vertical": true, "centerMode": true, "focusOnSelect": true, "autoplay": true}'>
  <asp:Literal ID="ltrOtherImages" runat="server"></asp:Literal>
</div>