<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Detail.ascx.cs" Inherits="cms_display_Hotel_Controls_Detail" %>
<%@ Register Src="~/cms/display/Service/subControls/SubServiceCategory_Inquiry.ascx" TagPrefix="uc1" TagName="SubServiceCategory_Inquiry" %>
<%@ Register Src="~/cms/display/Hotel/subControls/SubHotelOtherItem.ascx" TagPrefix="uc1" TagName="SubHotelOtherItem" %>
<%@ Register Src="~/cms/display/CommonControls/CommonCuoiChiTietTin.ascx" TagPrefix="uc1" TagName="CommonCuoiChiTietTin" %>
<%@ Register Src="~/cms/display/Hotel/subControls/SubHotelDetail_Booking.ascx" TagPrefix="uc1" TagName="SubHotelDetail_Booking" %>
<%@ Register Src="~/cms/display/Hotel/subControls/SubHotelDetail_Images.ascx" TagPrefix="uc1" TagName="SubHotelDetail_Images" %>

<div class="section wapperContentRow hotel_detail section_detail">
  <div class="container">
    <div class="nbRow clearfix">
      <div class="colLeft">
        <div class="hotel_detail">
          <div class="list">
            <div class="list-body">
              <div class="sublist sublist-1">
                <h1 class="">
                  <a href="#" class="title list-title  fSize-30 fSize-md-26 fSize-sm-26"><asp:Literal ID="ltrTitle" runat="server"></asp:Literal></a>
                </h1>
                <div class="price">
                  <span class="real nb-color-m2 font-weight-bold">
                    <asp:Literal ID="ltrSalePrice" runat="server" />
                  </span>
                  <span class="throught">
                    <asp:Literal ID="ltrPrice" runat="server" /></span>
                </div>
                <br>
                <div class="sublist-body">
                  <div class="blog clearfix">
                    <uc1:SubHotelDetail_Images runat="server" ID="SubHotelDetail_Images" />
                  </div>
                </div>
              </div>
              <div class="sublist sublist-2">
                <a href="#" class="title borBot sublist-title fSize-20"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Detailed description") %></a>
                <div class="sublist-body">
                  <asp:Literal ID="ltContent" runat="server"></asp:Literal>
                </div>
              </div>
            </div>
          </div>
          <uc1:SubHotelDetail_Booking runat="server" ID="SubHotelDetail_Booking" />
        </div>
        <div class="nb-origent-toolbar">
          <uc1:CommonCuoiChiTietTin runat="server" ID="CommonCuoiChiTietTin" />
        </div>
        <uc1:SubHotelOtherItem runat="server" ID="SubHotelOtherItem" />
      </div>
      <uc1:SubServiceCategory_Inquiry runat="server" ID="SubServiceCategory_Inquiry" />
    </div>
  </div>
</div>