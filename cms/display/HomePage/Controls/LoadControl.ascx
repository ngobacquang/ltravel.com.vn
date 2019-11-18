<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoadControl.ascx.cs" Inherits="cms_display_HomePage_Controls_LoadControl" %>
<%@ Register Src="~/cms/display/Banner/SlideTrangChu.ascx" TagPrefix="uc1" TagName="SlideTrangChu" %>
<%@ Register Src="~/cms/display/AboutUs/subControls/SubAboutUsHomepage.ascx" TagPrefix="uc1" TagName="SubAboutUsHomepage" %>
<%@ Register Src="~/cms/display/CustomerReviews/subControls/SubCustomerReviewsHomepage.ascx" TagPrefix="uc1" TagName="SubCustomerReviewsHomepage" %>
<%@ Register Src="~/cms/display/Hotel/subControls/SubHotelHomepage.ascx" TagPrefix="uc1" TagName="SubHotelHomepage" %>
<%@ Register Src="~/cms/display/Tour/subControls/SubTourHomepage.ascx" TagPrefix="uc1" TagName="SubTourHomepage" %>
<%@ Register Src="~/cms/display/Search/subControls/SubSearchHomepage.ascx" TagPrefix="uc1" TagName="SubSearchHomepage" %>

<div class="banner main">
  <uc1:SlideTrangChu runat="server" ID="SlideTrangChu" />
  <uc1:SubSearchHomepage runat="server" ID="SubSearchHomepage" />
</div>
<uc1:SubTourHomepage runat="server" ID="SubTourHomepage" />
<uc1:SubAboutUsHomepage runat="server" ID="SubAboutUsHomepage" />
<div class="container">
  <hr>
</div>
<uc1:SubHotelHomepage runat="server" ID="SubHotelHomepage" />
<div class="container">
  <hr>
</div>
<uc1:SubCustomerReviewsHomepage runat="server" ID="SubCustomerReviewsHomepage" />