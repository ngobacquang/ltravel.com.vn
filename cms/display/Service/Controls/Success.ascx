<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Success.ascx.cs" Inherits="cms_display_Service_Controls_Success" %>
<%@ Register Src="~/cms/display/Service/subControls/SubServiceCategory_Inquiry.ascx" TagPrefix="uc1" TagName="SubServiceCategory_Inquiry" %>

<div class="section wapperContentRow service">
  <div class="container">
    <div class="nbRow clearfix">
      <div class="colLeft">
        <div class="section submit-secces">
          <div class="item">
            <div class="item-img">
              <a href="#" class="imgc">
                <img src="/Themes/Theme01/Assets/Css/Images/_Icon/tick-secces.png" />
              </a>
            </div>
            <div class="item-body">
              <asp:Literal ID="ltrContent" runat="server"></asp:Literal>             
              <div class="item-links">
                <a href="/" class="item-link" title="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Home") %>"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Home") %></a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <uc1:SubServiceCategory_Inquiry runat="server" ID="SubServiceCategory_Inquiry" />
    </div>
  </div>
</div>