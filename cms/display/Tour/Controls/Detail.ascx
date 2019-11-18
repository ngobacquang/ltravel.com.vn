<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Detail.ascx.cs" Inherits="cms_display_Tour_Controls_Detail" %>
<%@ Register Src="~/cms/display/Service/subControls/SubServiceCategory_Inquiry.ascx" TagPrefix="uc1" TagName="SubServiceCategory_Inquiry" %>
<%@ Register Src="~/cms/display/Tour/subControls/SubTourOtherItem.ascx" TagPrefix="uc1" TagName="SubTourOtherItem" %>
<%@ Register Src="~/cms/display/CommonControls/CommonCuoiChiTietTin.ascx" TagPrefix="uc1" TagName="CommonCuoiChiTietTin" %>
<%@ Register Src="~/cms/display/Tour/subControls/SubTourDetail_Booking.ascx" TagPrefix="uc1" TagName="SubTourDetail_Booking" %>

<div class="section wapperContentRow tour_detail">
  <div class="container">
    <div class="nbRow clearfix">
      <div class="colLeft">
        <div class="infor_main">
          <div class="list">
            <div class="list-body">
              <div class="sublist sublist-1">
                <div class="item item-row">
                  <div class="item-img">
                    <a href="#" class="imgc">
                      <asp:Literal ID="ltrImage" runat="server" />
                    </a>
                  </div>
                  <div class="item-body">
                    <h1>
                      <a href="#" class="title item-title fSize-20 nb-color-m3">
                        <asp:Literal ID="ltrTitle" runat="server" /></a>
                    </h1>
                    <p class="description">
                      <asp:Literal ID="ltrDesc" runat="server" />
                    </p>
                    <div class="detail">
                      <p class="dong">
                        <span class="left">
                          <i class="fa fa-clock-o" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Duration") %>
                        </span>
                        <span class="right">
                          <asp:Literal ID="ltrDuration" runat="server" /></span>
                      </p>
                      <p class="dong">
                        <span class="left">
                          <i class="fa fa-calendar-check-o" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Departure from") %>
                        </span>
                        <span class="right">
                          <asp:Literal ID="ltrDepartureFrom" runat="server" /></span>
                      </p>
                      <p class="dong">
                        <span class="left">
                          <i class="fa fa-calendar-check-o" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Departure time") %>
                        </span>
                        <span class="right">
                          <asp:Literal ID="ltrDepartureTime" runat="server" /></span>
                      </p>
                      <p class="dong">
                        <span class="left">
                          <i class="fa fa-car" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Vehicle") %>                         
                        </span>
                        <span class="right"><asp:Literal ID="ltrVehicle" runat="server" /></span>
                      </p>
                    </div>
                    <div class="action-book">
                      <a href="#!" class="link" data-scroll="linkBook"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Booking") %></a>
                      <div class="item-price">
                        <span class="real">
                          <asp:Literal ID="ltrSalePrice" runat="server" /></span>
                        <span class="throught">
                          <asp:Literal ID="ltrPrice" runat="server" /></span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="sublist sublist-2">
                <div class="nq-scroll">
                  <nav class="nav-scrollspy">
                    <ul>
                      <li class="active"><a href="#!" data-scroll="itinerary"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Itinerary") %></a></li>
                      <li><a href="#!" data-scroll="image"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Image Gllery") %></a></li>
                      <li><a href="#!" data-scroll="video"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Video") %></a></li>
                      <li><a href="#!" data-scroll="map"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Map") %></a></li>
                    </ul>
                  </nav>
                  <div class="body-scrollspy nq-con">
                    <div id="itinerary" class="blogContent">
                      <h2>
                        <a href="#" class="title">
                          <i class="fa fa-map-o" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Itinerary") %>
                        </a>
                      </h2>
                      <div class="body">
                        <div class="nb-collapse-accordion">
                          <asp:Literal ID="ltrItinerary" runat="server" />
                        </div>
                      </div>
                    </div>
                    <div id="image" class="blogContent">
                      <h2>
                        <a href="#" class="title">
                          <i class="fa fa-picture-o" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Image Gllery") %>
                        </a>
                      </h2>
                      <div class="body">
                        <asp:Literal ID="ltrImages" runat="server" />
                      </div>
                    </div>
                    <div id="video" class="blogContent">
                      <h2>
                        <a href="#" class="title">
                          <i class="fa fa-play-circle-o" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Video") %>
                        </a>
                      </h2>
                      <div class="body">
                        <div class="video-container">
                          <asp:Literal ID="ltrVideo" runat="server" />
                        </div>
                      </div>
                    </div>
                    <div id="map" class="blogContent">
                      <h2>
                        <a href="#" class="title">
                          <i class="fa fa-map" aria-hidden="true"></i>
                          <%=LanguageItemExtension.GetnLanguageItemTitleByName("Map") %>
                        </a>
                      </h2>
                      <div class="body">
                        <div class="mapCompany">
                          <asp:Literal ID="ltrMap" runat="server" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <uc1:SubTourDetail_Booking runat="server" ID="SubTourDetail_Booking" />
            </div>
          </div>
        </div>
        <div class="nb-origent-toolbar">
          <uc1:CommonCuoiChiTietTin runat="server" ID="CommonCuoiChiTietTin" />
        </div>
        <uc1:SubTourOtherItem runat="server" ID="SubTourOtherItem" />
      </div>
      <uc1:SubServiceCategory_Inquiry runat="server" ID="SubServiceCategory_Inquiry" />
    </div>
  </div>
</div>