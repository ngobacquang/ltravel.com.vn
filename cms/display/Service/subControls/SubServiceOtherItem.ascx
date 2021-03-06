﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubServiceOtherItem.ascx.cs" Inherits="cms_display_Service_subControls_SubServiceOtherItem" %>

<div class="section other-trips other-service">
  <div class="list">
    <h2><a href="#" class="title list-title fSize-28 txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Other service") %></a></h2>
    <div class="list-body">
      <div class="slick-slider" data-slick='{"slidesToShow": 3, "slidesToScroll": 1, "autoplay": true, "dots": false, "arrows":true, "responsive": [{"breakpoint":1025,"settings":{"slidesToShow": 2}},{"breakpoint":768,"settings": {"slidesToShow": 1}}]}'>
        <asp:Literal ID="ltrList" runat="server" />
      </div>
    </div>
  </div>
</div>