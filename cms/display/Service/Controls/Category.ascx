<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Category.ascx.cs" Inherits="cms_display_Service_Controls_Category" %>
<%@ Register Src="~/cms/display/Service/subControls/SubServiceCategory_Inquiry.ascx" TagPrefix="uc1" TagName="SubServiceCategory_Inquiry" %>

<div class="section wapperContentRow service">
  <div class="container">
    <div class="nbRow clearfix">
      <div class="colLeft">
        <div class="list">
          <div class="list-body">
            <asp:Literal ID="ltrList" runat="server" />
          </div>
        </div>
      </div>
      <uc1:SubServiceCategory_Inquiry runat="server" ID="SubServiceCategory_Inquiry" />
    </div>
  </div>
</div>