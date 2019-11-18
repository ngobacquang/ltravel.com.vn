<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Success.ascx.cs" Inherits="cms_display_ContactUs_Controls_Success" %>

<div class="section">
  <div class="container">
    <div class="submit-secces">
      <div class="item">
        <div class="item-img">
          <a href="#" class="imgc">
            <img src="/Themes/Theme01/Assets/Css/Images/_Icon/tick-secces.png" />
          </a>
        </div>
        <div class="item-body">
          <asp:Literal ID="ltrContent" runat="server"></asp:Literal>        
          <div class="item-links">
            <a href="/" class="item-link"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Home") %></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>