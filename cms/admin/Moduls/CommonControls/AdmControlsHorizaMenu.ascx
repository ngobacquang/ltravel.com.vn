<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmControlsHorizaMenu.ascx.cs" Inherits="cms_admin_Controls_HorizalMenu_AdmControlsHorizaMenu" %>
<%@ Import Namespace="Developer" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<div id="AdmControlsHorizaMenu">
  <ul id="nav">
    <div class="navItem w30">
      <li class="top"><a href="admin.aspx" class="IconHomePage">&nbsp;</a></li>
    </div>
    <asp:Panel ID="pnAboutUs" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.AboutUsModul.Link.LnkMnAboutUs() %>" id="New" class="top_link<%=GetCurrent(TatThanhJsc.AboutUsModul.CodeApplications.AboutUs) %>"><span><%=AboutUsKeyword.AboutUs1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucAboutUs" runat="server">
            <li><a href="<%=TatThanhJsc.AboutUsModul.Link.LnkMnAboutUsCate() %>">Quản lý danh mục <%=AboutUsKeyword.AboutUs2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.AboutUsModul.Link.LnkMnAboutUsItem() %>">Quản lý danh sách <%=AboutUsKeyword.AboutUs2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucAboutUs" runat="server">
            <li><a href="<%=TatThanhJsc.AboutUsModul.Link.LnkMnAboutUsCateCreate() %>">Thêm mới danh mục <%=AboutUsKeyword.AboutUs2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.AboutUsModul.Link.LnkMnAboutUsItemCreate() %>">Thêm mới <%=AboutUsKeyword.AboutUs2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnTour" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.TourModul.Link.LnkMnTour() %>" id="A8" class="top_link<%=GetCurrent(TatThanhJsc.TourModul.CodeApplications.Tour) %>"><span><%=TourKeyword.Tour1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.TourModul.Link.LnkMnTourCate() %>">Quản lý danh mục <%=TourKeyword.Tour2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TourModul.Link.LnkMnTourItem() %>">Quản lý danh sách <%=TourKeyword.Tour2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TourModul.Link.LnkMnTourCateCreate() %>">Thêm mới danh mục <%=TourKeyword.Tour2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TourModul.Link.LnkMnTourItemCreate() %>">Thêm mới <%=TourKeyword.Tour2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnHotel" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.HotelModul.Link.LnkMnHotel() %>" id="A8" class="top_link<%=GetCurrent(TatThanhJsc.HotelModul.CodeApplications.Hotel) %>"><span><%=HotelKeyword.Hotel1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.HotelModul.Link.LnkMnHotelCate() %>">Quản lý danh mục <%=HotelKeyword.Hotel2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.HotelModul.Link.LnkMnHotelItem() %>">Quản lý danh sách <%=HotelKeyword.Hotel2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.HotelModul.Link.LnkMnHotelCateCreate() %>">Thêm mới danh mục <%=HotelKeyword.Hotel2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.HotelModul.Link.LnkMnHotelItemCreate() %>">Thêm mới <%=HotelKeyword.Hotel2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnProduct" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.ProductModul.Link.LnkMnProduct() %>" id="Product" class="top_link<%=GetCurrent(TatThanhJsc.ProductModul.CodeApplications.Product) %>"><span><%=ProductKeyword.Product1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucProduct" runat="server">
            <li><a href="<%=TatThanhJsc.ProductModul.Link.LnkMnProductCate() %>">Quản lý danh mục <%=ProductKeyword.Product2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.ProductModul.Link.LnkMnProductItem() %>">Quản lý danh sách <%=ProductKeyword.Product2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucProduct" runat="server">
            <li><a href="<%=TatThanhJsc.ProductModul.Link.LnkMnProductCateCreate() %>">Thêm mới danh mục <%=ProductKeyword.Product2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.ProductModul.Link.LnkMnProductItemCreate() %>">Thêm mới <%=ProductKeyword.Product2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnDeal" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.DealModul.Link.LnkMnDeal() %>" id="A11" class="top_link<%=GetCurrent(TatThanhJsc.DealModul.CodeApplications.Deal) %>"><span><%=DealKeyword.Deal1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucDeal" runat="server">
            <li><a href="<%=TatThanhJsc.DealModul.Link.LnkMnDealCate() %>">Quản lý danh mục <%=DealKeyword.Deal2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.DealModul.Link.LnkMnDealItem() %>">Quản lý danh sách <%=DealKeyword.Deal2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucDeal" runat="server">
            <li><a href="<%=TatThanhJsc.DealModul.Link.LnkMnDealCateCreate() %>">Thêm mới danh mục <%=DealKeyword.Deal2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.DealModul.Link.LnkMnDealItemCreate() %>">Thêm mới <%=DealKeyword.Deal2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnFileLibrary" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.FileLibraryModul.Link.LnkMnFileLibrary() %>" id="A4" class="top_link<%=GetCurrent(TatThanhJsc.FileLibraryModul.CodeApplications.FileLibrary) %>"><span><%=FileLibraryKeyword.FileLibrary1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucFileLibrary" runat="server">
            <li><a href="<%=TatThanhJsc.FileLibraryModul.Link.LnkMnFileLibraryCate() %>">Quản lý danh mục <%=FileLibraryKeyword.FileLibrary2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.FileLibraryModul.Link.LnkMnFileLibraryItem() %>">Quản lý danh sách <%=FileLibraryKeyword.FileLibrary2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucFileLibrary" runat="server">
            <li><a href="<%=TatThanhJsc.FileLibraryModul.Link.LnkMnFileLibraryCateCreate() %>">Thêm mới danh mục <%=FileLibraryKeyword.FileLibrary2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.FileLibraryModul.Link.LnkMnFileLibraryItemCreate() %>">Thêm mới <%=FileLibraryKeyword.FileLibrary2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnService" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.ServiceModul.Link.LnkMnService() %>" id="A4" class="top_link<%=GetCurrent(TatThanhJsc.ServiceModul.CodeApplications.Service) %>"><span><%=ServiceKeyword.Service1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucService" runat="server">
            <li><a href="<%=TatThanhJsc.ServiceModul.Link.LnkMnServiceCate() %>">Quản lý danh mục <%=ServiceKeyword.Service2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.ServiceModul.Link.LnkMnServiceItem() %>">Quản lý danh sách <%=ServiceKeyword.Service2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucService" runat="server">
            <li><a href="<%=TatThanhJsc.ServiceModul.Link.LnkMnServiceCateCreate() %>">Thêm mới danh mục <%=ServiceKeyword.Service2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.ServiceModul.Link.LnkMnServiceItemCreate() %>">Thêm mới <%=ServiceKeyword.Service2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnNew" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.NewsModul.Link.LnkMnNews() %>" id="New" class="top_link<%=GetCurrent(TatThanhJsc.NewsModul.CodeApplications.News) %>"><span><%=NewKeyword.New1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucNew" runat="server">
            <li><a href="<%=TatThanhJsc.NewsModul.Link.LnkMnNewsCate() %>">Quản lý danh mục <%=NewKeyword.New2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.NewsModul.Link.LnkMnNewsItem() %>">Quản lý danh sách <%=NewKeyword.New2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucNew" runat="server">
            <li><a href="<%=TatThanhJsc.NewsModul.Link.LnkMnNewsCateCreate() %>">Thêm mới danh mục <%=NewKeyword.New2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.NewsModul.Link.LnkMnNewsItemCreate() %>">Thêm mới <%=NewKeyword.New2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnPhotoAlbum" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.PhotoAlbumModul.Link.LnkMnPhotoAlbum() %>" id="A4" class="top_link<%=GetCurrent(TatThanhJsc.PhotoAlbumModul.CodeApplications.PhotoAlbum) %>"><span><%=PhotoAlbumKeyword.PhotoAlbum1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucPhotoAlbum" runat="server">
            <li><a href="<%=TatThanhJsc.PhotoAlbumModul.Link.LnkMnPhotoAlbumCate() %>">Quản lý danh mục <%=PhotoAlbumKeyword.PhotoAlbum2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.PhotoAlbumModul.Link.LnkMnPhotoAlbumItem() %>">Quản lý danh sách <%=PhotoAlbumKeyword.PhotoAlbum2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucPhotoAlbum" runat="server">
            <li><a href="<%=TatThanhJsc.PhotoAlbumModul.Link.LnkMnPhotoAlbumCateCreate() %>">Thêm mới danh mục <%=PhotoAlbumKeyword.PhotoAlbum2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.PhotoAlbumModul.Link.LnkMnPhotoAlbumItemCreate() %>">Thêm mới <%=PhotoAlbumKeyword.PhotoAlbum2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnVideo" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.VideoModul.Link.LnkMnVideo() %>" id="A4" class="top_link<%=GetCurrent(TatThanhJsc.VideoModul.CodeApplications.Video) %>"><span><%=VideoKeyword.Video1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucVideo" runat="server">
            <li><a href="<%=TatThanhJsc.VideoModul.Link.LnkMnVideoCate() %>">Quản lý danh mục <%=VideoKeyword.Video2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.VideoModul.Link.LnkMnVideoItem() %>">Quản lý danh sách <%=VideoKeyword.Video2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucVideo" runat="server">
            <li><a href="<%=TatThanhJsc.VideoModul.Link.LnkMnVideoCateCreate() %>">Thêm mới danh mục <%=VideoKeyword.Video2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.VideoModul.Link.LnkMnVideoItemCreate() %>">Thêm mới <%=VideoKeyword.Video2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnQA" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.QAModul.Link.LnkMnQA() %>" id="A7" class="top_link<%=GetCurrent(TatThanhJsc.QAModul.CodeApplications.QA) %>"><span><%=QAKeyword.QA1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucQA" runat="server">
            <li><a href="<%=TatThanhJsc.QAModul.Link.LnkMnQACate() %>">Quản lý danh mục <%=QAKeyword.QA2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.QAModul.Link.LnkMnQAItem() %>">Quản lý danh sách <%=QAKeyword.QA2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucQA" runat="server">
            <li><a href="<%=TatThanhJsc.QAModul.Link.LnkMnQACateCreate() %>">Thêm mới danh mục <%=QAKeyword.QA2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.QAModul.Link.LnkMnQAItemCreate() %>">Thêm mới <%=QAKeyword.QA2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnCustomerReviews" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.CustomerReviewsModul.Link.LnkMnCustomerReviews() %>" id="New" class="top_link<%=GetCurrent(TatThanhJsc.CustomerReviewsModul.CodeApplications.CustomerReviews) %>"><span><%=CustomerReviewsKeyword.CustomerReviews1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyDanhMucCustomerReviews" runat="server">
            <li><a href="<%=TatThanhJsc.CustomerReviewsModul.Link.LnkMnCustomerReviewsCate() %>">Quản lý danh mục <%=CustomerReviewsKeyword.CustomerReviews2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.CustomerReviewsModul.Link.LnkMnCustomerReviewsItem() %>">Quản lý danh sách <%=CustomerReviewsKeyword.CustomerReviews2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiDanhMucCustomerReviews" runat="server">
            <li><a href="<%=TatThanhJsc.CustomerReviewsModul.Link.LnkMnCustomerReviewsCateCreate() %>">Thêm mới danh mục <%=CustomerReviewsKeyword.CustomerReviews2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.CustomerReviewsModul.Link.LnkMnCustomerReviewsItemCreate() %>">Thêm mới <%=CustomerReviewsKeyword.CustomerReviews2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnBlog" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.BlogModul.Link.LnkMnBlog() %>" id="Blog" class="top_link<%=GetCurrent(TatThanhJsc.BlogModul.CodeApplications.Blog) %>"><span><%=BlogKeyword.Blog1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.BlogModul.Link.LnkMnBlogCate() %>">Quản lý danh mục <%=BlogKeyword.Blog2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.BlogModul.Link.LnkMnBlogItem() %>">Quản lý danh sách <%=BlogKeyword.Blog2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.BlogModul.Link.LnkMnBlogGroupItem() %>">Quản lý nhóm <%=BlogKeyword.Blog2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.BlogModul.Link.LnkMnBlogCateCreate() %>">Thêm mới danh mục <%=BlogKeyword.Blog2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.BlogModul.Link.LnkMnBlogItemCreate() %>">Thêm mới <%=BlogKeyword.Blog2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.BlogModul.Link.LnkMnBlogGroupItemCreate() %>">Thêm mới nhóm <%=BlogKeyword.Blog2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnDestination" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.DestinationModul.Link.LnkMnDestination() %>" class="top_link<%=GetCurrent(TatThanhJsc.DestinationModul.CodeApplications.Destination) %>"><span><%=DestinationKeyword.Destination1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.DestinationModul.Link.LnkMnDestinationCate() %>">Quản lý danh mục <%=DestinationKeyword.Destination2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.DestinationModul.Link.LnkMnDestinationCateCreate() %>">Thêm mới danh mục <%=DestinationKeyword.Destination2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnCustomer" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.CustomerModul.Link.LnkMnCustomer() %>" id="A5" class="top_link<%=GetCurrent(TatThanhJsc.CustomerModul.CodeApplications.Customer) %>"><span><%=CustomerKeyword.Customer1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.CustomerModul.Link.LnkMnCustomerCate() %>">Quản lý danh mục <%=CustomerKeyword.Customer2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.CustomerModul.Link.LnkMnCustomerItem() %>">Quản lý danh sách <%=CustomerKeyword.Customer2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.CustomerModul.Link.LnkMnCustomerCateCreate() %>">Thêm mới danh mục <%=CustomerKeyword.Customer2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.CustomerModul.Link.LnkMnCustomerItemCreate() %>">Thêm mới <%=CustomerKeyword.Customer2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnCruises" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.CruisesModul.Link.LnkMnCruises() %>" id="A8" class="top_link<%=GetCurrent(TatThanhJsc.CruisesModul.CodeApplications.Cruises) %>"><span><%=CruisesKeyword.Cruises1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.CruisesModul.Link.LnkMnCruisesCate() %>">Quản lý danh mục <%=CruisesKeyword.Cruises2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.CruisesModul.Link.LnkMnCruisesItem() %>">Quản lý danh sách <%=CruisesKeyword.Cruises2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.CruisesModul.Link.LnkMnCruisesCateCreate() %>">Thêm mới danh mục <%=CruisesKeyword.Cruises2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.CruisesModul.Link.LnkMnCruisesItemCreate() %>">Thêm mới <%=CruisesKeyword.Cruises2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnTrainTicket" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.TrainTicketModul.Link.LnkMnTrainTicket() %>" id="A10" class="top_link<%=GetCurrent(TatThanhJsc.TrainTicketModul.CodeApplications.TrainTicket) %>"><span><%=TrainTicketKeyword.TrainTicket1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.TrainTicketModul.Link.LnkMnTrainTicketCate() %>">Quản lý danh mục <%=TrainTicketKeyword.TrainTicket2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TrainTicketModul.Link.LnkMnTrainTicketItem() %>">Quản lý danh sách <%=TrainTicketKeyword.TrainTicket2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TrainTicketModul.Link.LnkMnTrainTicketGroupItem() %>">Quản lý nhóm <%=TrainTicketKeyword.TrainTicket2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TrainTicketModul.Link.LnkMnTrainTicketCateCreate() %>">Thêm mới danh mục <%=TrainTicketKeyword.TrainTicket2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TrainTicketModul.Link.LnkMnTrainTicketItemCreate() %>">Thêm mới <%=TrainTicketKeyword.TrainTicket2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.TrainTicketModul.Link.LnkMnTrainTicketGroupItemCreate() %>">Thêm mới nhóm <%=TrainTicketKeyword.TrainTicket2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnFileLibrary2" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2() %>" id="A4" class="top_link<%=GetCurrent(TatThanhJsc.FileLibrary2Modul.CodeApplications.FileLibrary2) %>"><span><%=FileLibrary2Keyword.FileLibrary21 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2Cate() %>">Quản lý danh mục <%=FileLibrary2Keyword.FileLibrary22 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2Item() %>">Quản lý danh sách <%=FileLibrary2Keyword.FileLibrary22 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2GroupItem() %>">Quản lý nhóm <%=FileLibrary2Keyword.FileLibrary22 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2CateCreate() %>">Thêm mới danh mục <%=FileLibrary2Keyword.FileLibrary22 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2ItemCreate() %>">Thêm mới <%=FileLibrary2Keyword.FileLibrary22 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.FileLibrary2Modul.Link.LnkMnFileLibrary2GroupItemCreate() %>">Thêm mới nhóm <%=FileLibrary2Keyword.FileLibrary22 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnContact" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.ContactModul.Link.LnkMnContact() %>" id="A6" class="top_link<%=GetCurrent(TatThanhJsc.ContactModul.CodeApplications.Contact) %>"><span><%=ContactKeyword.Contact1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.ContactModul.Link.LnkMnContactCate() %>">Quản lý nhóm <%=ContactKeyword.Contact2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.ContactModul.Link.LnkMnContactItem() %>">Quản lý danh sách <%=ContactKeyword.Contact2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.ContactModul.Link.LnkMnContactCateCreate() %>">Thêm mới nhóm <%=ContactKeyword.Contact2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnMember" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.MemberModul.Link.LnkMnMember() %>" id="A3" class="top_link<%=GetCurrent(TatThanhJsc.MemberModul.CodeApplications.Member) %>"><span><%=MemberKeyword.Member1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.MemberModul.Link.LnkMnMemberItem() %>">Quản lý danh sách <%=MemberKeyword.Member2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnAdvertising" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.AdvertisingModul.Link.LnkMnAdvertising() %>" id="A1" class="top_link<%=GetCurrent(TatThanhJsc.AdvertisingModul.CodeApplications.Advertising) %>"><span><%=AdvertisingKeyword.Advertising1 %></span></a>
        <ul class="sub">
          <asp:Panel ID="pnQuanLyViTriQuangCao" runat="server">
            <li><a href="<%=TatThanhJsc.AdvertisingModul.Link.LnkMnAdvertisingCate() %>">Quản lý vị trí <%=AdvertisingKeyword.Advertising2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.AdvertisingModul.Link.LnkMnAdvertisingItem() %>">Quản lý danh sách <%=AdvertisingKeyword.Advertising2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <asp:Panel ID="pnThemMoiViTriQuangCao" runat="server">
            <li><a href="<%=TatThanhJsc.AdvertisingModul.Link.LnkMnAdvertisingCateCreate() %>">Thêm mới vị trí <%=AdvertisingKeyword.Advertising2 %></a></li>
            <div class="spaceRow">
              <div class="SpaceRowMenu">
                <!---->
              </div>
            </div>
          </asp:Panel>
          <li><a href="<%=TatThanhJsc.AdvertisingModul.Link.LnkMnAdvertisingItemCreate() %>">Thêm mới hình ảnh <%=AdvertisingKeyword.Advertising2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="pnDuyetTin" CssClass="navItem" Visible="false" runat="server">
      <li class="top"><a href="admin.aspx?uc=DuyetTin" class="top_link<%=GetCurrent("DuyetTin") %>"><span>Duyệt tin</span></a></li>
    </asp:Panel>
    <asp:Panel ID="PnEmail" runat="server" CssClass="navItem">
      <li class="top"><a href="admin.aspx?uc=<%=TatThanhJsc.MemberModul.CodeApplications.MemberNewsletter %>" class="top_link<%=GetCurrent("Email") %>"><span>Nhận email</span></a></li>
    </asp:Panel>
    <asp:Panel ID="PnMenu" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.MenuModul.Link.LnkMnMenu() %>" id="Menu" class="top_link<%=GetCurrent(TatThanhJsc.AdminModul.Keyword.ManageMenu) %>"><span><%=MenuKeyword.Menu1 %></span></a>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnContent" runat="server" CssClass="navItem">
      <li class="top"><a href="<%=TatThanhJsc.ContentModul.Link.LnkMnContent() %>" id="A2" class="top_link<%=GetCurrent(TatThanhJsc.ContentModul.CodeApplications.Content) %>"><span><%=ContentKeyword.Content1 %></span></a>
        <ul class="sub">
          <li><a href="<%=TatThanhJsc.ContentModul.Link.LnkMnContentCate() %>">Quản lý nhóm <%=ContentKeyword.Content2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.ContentModul.Link.LnkMnContentItem() %>">Quản lý danh sách <%=ContentKeyword.Content2 %>t</a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.ContentModul.Link.LnkMnContentCateCreate() %>">Thêm mới nhóm <%=ContentKeyword.Content2 %></a></li>
          <div class="spaceRow">
            <div class="SpaceRowMenu">
              <!---->
            </div>
          </div>
          <li><a href="<%=TatThanhJsc.ContentModul.Link.LnkMnContentItemCreate() %>">Thêm mới <%=ContentKeyword.Content2 %></a></li>
        </ul>
      </li>
    </asp:Panel>
    <asp:Panel ID="PnOther" runat="server" CssClass="navItem">
      <li class="top"><a href="?uc=other" id="shop" class="top_link"><span class="down">Khác</span></a>
        <ul class="sub">
          <asp:Panel ID="PnSupportOnline" runat="server">
            <li><a href="<%=TatThanhJsc.OtherModul.Link.LnkMnSupportOnline() %>"><%=SupportOnlineKeyword.SupportOnline1 %></a></li>
            <div class="spaceRow">
              <!---->
            </div>
          </asp:Panel>
          <asp:Panel ID="PnPsg" runat="server">

            <li><a href="<%=TatThanhJsc.OtherModul.Link.LnkMnPsg() %>"><%=ContentKeyword.Content1 %></a></li>
            <div class="spaceRow">
              <!---->
            </div>

          </asp:Panel>
          <asp:Panel ID="PnVote" runat="server">

            <li><a href="<%=TatThanhJsc.OtherModul.Link.LnkMnVote() %>"><%=VoteKeyword.Vote1 %></a></li>
            <div class="spaceRow">
              <!---->
            </div>

          </asp:Panel>


          <asp:Panel ID="pnSiteMap" runat="server">

            <li><a href="<%=TatThanhJsc.OtherModul.Link.LnkMnSiteMap() %>"><%=SiteMapKeyword.SiteMap1 %></a></li>
            <div class="spaceRow">
              <!---->
            </div>

          </asp:Panel>

          <asp:Panel ID="PnTag" runat="server">

            <li><a href="<%=TatThanhJsc.OtherModul.Link.LnkMnTag() %>"><%=TagKeyword.Tag1 %></a></li>
            <div class="spaceRow">
              <!---->
            </div>

          </asp:Panel>

          <asp:Panel ID="PnCopyItem" runat="server">
            <li><a href="javascript:NewWindow_('cms/admin/TempControls/PopUp/Items/CopyItemFromOtherSite.aspx','ImageList','950','550','yes','yes')">Duyệt tin</a></li>
          </asp:Panel>

          <asp:Panel ID="pnDcLink" runat="server">
            <li><a href="?uc=other&uco=dclink">Kiểm tra trùng link</a></li>
          </asp:Panel>
        </ul>
      </li>
    </asp:Panel>
  </ul>
</div>
