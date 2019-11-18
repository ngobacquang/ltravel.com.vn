<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AboutUsOtherItem.ascx.cs" Inherits="cms_display_AboutUs_subControls_AboutUsOtherItem" %>

<div class="section post-same infor-same other-posts">
  <div class="container">
    <div class="list">
      <h2><a href="#" class="title list-title fSize-28 txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Other posts") %></a></h2>
      <div class="list-body">
        <div class="slick-slider" data-slick='{"slidesToShow": 4, "slidesToScroll": 1, "autoplay": true, "dots": false, "arrows":true, "responsive": [{"breakpoint":1025,"settings":{"slidesToShow": 3}},{"breakpoint":768,"settings": {"slidesToShow": 1}}]}'>
          <asp:Literal ID="ltrList" runat="server" />  
        </div>
      </div>
    </div>
  </div>
</div>