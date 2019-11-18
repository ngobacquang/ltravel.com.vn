<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CommonHeader.ascx.cs" Inherits="cms_display_CommonControls_CommonHeader" %>
<%@ Register Src="~/cms/display/Banner/LogoMain.ascx" TagPrefix="uc1" TagName="LogoMain" %>
<%@ Register Src="~/cms/display/CommonControls/CommonMenuMain.ascx" TagPrefix="uc1" TagName="CommonMenuMain" %>
<%@ Register Src="~/cms/display/Banner/CacMangXHDauTrang.ascx" TagPrefix="uc1" TagName="CacMangXHDauTrang" %>
<%@ Register Src="~/cms/display/Banner/ChonNgonNgu.ascx" TagPrefix="uc1" TagName="ChonNgonNgu" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>

<div class="header">
  <div id="nb_navigation_type_07">
    <div class="nb-top-nav">
      <div class="container wapper-fluid">
        <div class="row">
          <div class="col">
            <div class="blog blogLogo">
              <uc1:LogoMain runat="server" ID="LogoMain" />      
            </div>
          </div>
          <div class="col">
            <div class="blog-action">
              <div class="blog contact">
                <asp:Literal ID="ltrHotline" runat="server" />    
              </div>
              <uc1:CacMangXHDauTrang runat="server" ID="CacMangXHDauTrang" />
              <uc1:ChonNgonNgu runat="server" ID="ChonNgonNgu" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <nav class="nb-main-navbar">
      <div class="container wapper-fluid">
        <div class="nb-navbar-row">
          <div class="nb_tablertAction">
            <div class="blog blogToggler">
              <a href="#" class="nb-menu-icon">
                <span class="icon-menu"></span>
              </a>
              <span class="txt"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Menu") %></span>
            </div>
            <uc1:CacMangXHDauTrang runat="server" ID="CacMangXHDauTrang1" />
          </div>
          <uc1:CommonMenuMain runat="server" ID="CommonMenuMain" />
        </div>
      </div>
    </nav>
  </div>
  <div id="nb_affixPad">
  </div>
</div>