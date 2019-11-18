<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Detail.ascx.cs" Inherits="cms_display_Service_Controls_Detail" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Register Src="~/cms/display/Service/subControls/SubServiceCategory_Inquiry.ascx" TagPrefix="uc1" TagName="SubServiceCategory_Inquiry" %>
<%@ Register Src="~/cms/display/Service/subControls/SubServiceOtherItem.ascx" TagPrefix="uc1" TagName="SubServiceOtherItem" %>
<%@ Register Src="~/cms/display/CommonControls/CommonCuoiChiTietTin.ascx" TagPrefix="uc1" TagName="CommonCuoiChiTietTin" %>
<%@ Register Src="~/cms/display/Service/subControls/SubServiceDetail_Order.ascx" TagPrefix="uc1" TagName="SubServiceDetail_Order" %>

<div class="section wapperContentRow service section_detail">
  <div class="container">
    <div class="nbRow clearfix">
      <div class="colLeft">
        <div class="list nb-origent-toolbar">
          <div class="list-header">
            <h1>
              <a href="#" class="title list-title fSize-30 txtL nb-color-m3"><asp:Literal ID="ltrTitle" runat="server"></asp:Literal></a>
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
            <uc1:SubServiceDetail_Order runat="server" ID="SubServiceDetail_Order" />
          </div>
          <uc1:CommonCuoiChiTietTin runat="server" ID="CommonCuoiChiTietTin" />
        </div>
        <uc1:SubServiceOtherItem runat="server" ID="SubServiceOtherItem" />
      </div>
      <uc1:SubServiceCategory_Inquiry runat="server" ID="SubServiceCategory_Inquiry" />
    </div>
  </div>
</div>