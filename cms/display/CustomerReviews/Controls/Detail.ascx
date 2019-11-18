<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Detail.ascx.cs" Inherits="cms_display_CustomerReviews_Detail" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Register Src="~/cms/display/CustomerReviews/subControls/SubCustomerReviewsOtherItem.ascx" TagPrefix="uc1" TagName="SubCustomerReviewsOtherItem" %>
<%@ Register Src="~/cms/display/CommonControls/CommonCuoiChiTietTin.ascx" TagPrefix="uc1" TagName="CommonCuoiChiTietTin" %>

<div class="section customer_comment_detail">
  <div class="container">
    <div class="list">
      <div class="list-header">
        <div class="infor-user item">
          <div class="item-body">
            <div class="item-img">
              <a href="#" class="imgc">
                <asp:Literal ID="ltrAvatar" runat="server" />
              </a>
            </div>
            <div class="item-body">
              <h1>
                <a href="#" class="title item-title customer-name"><asp:Literal ID="ltrTitle" runat="server"></asp:Literal></a>
              </h1>
            </div>
          </div>
        </div>
      </div>
      <div class="list-body nb-origent-toolbar">
        <div class="post-entry">
          <div class="post-date">
            <asp:Literal ID="ltrDate" runat="server"></asp:Literal>
            -
            <asp:Literal ID="ltrViews" runat="server"></asp:Literal></div>
          <div class="right">
            <div class="post-size">
              <a class="normal" href="#"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Cỡ chữ") %></a>
              <a class="large" href="#"><i class="fa fa-plus"></i></a>
              <a class="small" href="#"><i class="fa fa-minus"></i></a>
            </div>
            <div class="social">
              <div class="fb-share-button" data-href="<%= UrlExtension.WebisteUrl + Request.RawUrl.Substring(1) %>" data-layout="button_count" data-size="small" data-mobile-iframe="true">
                <a target="_blank" href="<%= UrlExtension.WebisteUrl + Request.RawUrl.Substring(1) %>" class="fb-xfbml-parse-ignore"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Chia sẻ") %></a>
              </div>
              <div class="fb-like" data-href="<%= UrlExtension.WebisteUrl + Request.RawUrl.Substring(1) %>" data-layout="button_count" data-action="like" data-size="small" data-show-faces="true" data-share="false"></div>
            </div>
          </div>
        </div>
        <div class="post-content">
          <asp:Literal ID="ltContent" runat="server"></asp:Literal>
        </div>
        <uc1:CommonCuoiChiTietTin runat="server" ID="CommonCuoiChiTietTin" />
      </div>
    </div>
  </div>
</div>
<uc1:SubCustomerReviewsOtherItem runat="server" ID="SubCustomerReviewsOtherItem" />
