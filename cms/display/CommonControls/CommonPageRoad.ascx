<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CommonPageRoad.ascx.cs" Inherits="cms_display_CommonControls_CommonPageRoad" %>

<div class="orientation">
  <div class="container">
    <ul class="navigation">
      <li class="element">
        <a href="/" class="link">
          <span><%=LanguageItemExtension.GetnLanguageItemTitleByName("Home") %></span>
          <i class="fa fa-angle-right" aria-hidden="true"></i>
        </a>
      </li>
      <asp:Literal ID="ltrRoad" runat="server"></asp:Literal>
    </ul>
  </div>
</div>