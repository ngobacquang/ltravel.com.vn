<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Detail.ascx.cs" Inherits="cms_display_AboutUs_Controls_Detail" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Register Src="~/cms/display/CommonControls/CommonCuoiChiTietTin.ascx" TagPrefix="uc1" TagName="CommonCuoiChiTietTin" %>
<%@ Register Src="~/cms/display/AboutUs/subControls/AboutUsOtherItem.ascx" TagPrefix="uc1" TagName="AboutUsOtherItem" %>

<div class="section introduct_detail">
  <div class="container">
    <div class="list nb-origent-toolbar">
      <div class="list-header">
        <h1>
          <a href="#" class="title list-title fSize-30 txtL"><asp:Literal ID="ltrTitle" runat="server"></asp:Literal></a>
        </h1>
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
      </div>
      <div class="list-body">
        <div class="post-content">
          <asp:Literal ID="ltContent" runat="server"></asp:Literal>
        </div>
      </div>
      <uc1:CommonCuoiChiTietTin runat="server" ID="CommonCuoiChiTietTin" />
    </div>
  </div>
</div>
<uc1:AboutUsOtherItem runat="server" ID="AboutUsOtherItem" />