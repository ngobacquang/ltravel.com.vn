<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CommonCuoiChiTietTin.ascx.cs" Inherits="Cms_Common_CommonCuoiChiTietTin" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>

<div class="post-toolbar">
  <div class="tool-left">
    <a href="javascript:history.go(-1)" class="prev-page"><%= LanguageItemExtension.GetnLanguageItemTitleByName("Về trang trước") %></a>
    <a href="javascript:void(0)" class="email addthis_button_email"><%= LanguageItemExtension.GetnLanguageItemTitleByName("Gửi email") %></a>
    <a href="javascript:window.print()" class="print"><%= LanguageItemExtension.GetnLanguageItemTitleByName("In trang") %></a>
  </div>
  <div class="tool-right">
    <div class="social">
      <div id="fb-root"></div>
      <div class="fb-share-button" data-href="<%= UrlExtension.WebisteUrl + Request.RawUrl.Substring(1) %>"
        data-layout="button_count" data-size="small" data-mobile-iframe="true">
        <a target="_blank"
          href="<%= UrlExtension.WebisteUrl + Request.RawUrl.Substring(1) %>"
          class="fb-xfbml-parse-ignore"><%= LanguageItemExtension.GetnLanguageItemTitleByName("Chia sẻ") %></a>
      </div>
      <div class="fb-like" data-href="<%= UrlExtension.WebisteUrl + Request.RawUrl.Substring(1) %>"
        data-layout="button_count" data-action="like" data-size="small" data-show-faces="true"
        data-share="false">
      </div>
    </div>
    <div class="shareSocial">
      <div class="addthis_sharing_toolbox"></div>
    </div>
  </div>
</div>