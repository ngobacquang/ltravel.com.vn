<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DisplayLoadControl.ascx.cs" Inherits="cms_display_DisplayLoadControl" %>
<%@ Register Src="~/cms/display/CommonControls/CommonHeader.ascx" TagPrefix="uc1" TagName="CommonHeader" %>
<%@ Register Src="~/cms/display/CommonControls/CommonFooter.ascx" TagPrefix="uc1" TagName="CommonFooter" %>
<%@ Register Src="~/cms/display/CommonControls/CommonPageRoad.ascx" TagPrefix="uc1" TagName="CommonPageRoad" %>
<%@ Register Src="~/cms/display/Tour/subControls/SubTour_Banner.ascx" TagPrefix="uc1" TagName="SubTour_Banner" %>


<uc1:CommonHeader runat="server" ID="CommonHeader" />

<div class="wapper-main">
  <uc1:SubTour_Banner Visible="false" runat="server" ID="SubTour_Banner" />
  <uc1:CommonPageRoad runat="server" ID="CommonPageRoad" />
  <asp:PlaceHolder ID="phLoadControl" runat="server"></asp:PlaceHolder>
</div>

<uc1:CommonFooter runat="server" ID="CommonFooter" />

<div id="nb-scrollTop">
	<a href="#" class="scrollToTop" title="Click để lên đầu trang">
		<i class="fa fa-angle-double-up" aria-hidden="true"></i>
	</a>
</div>

<script>
  (function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s);
    js.id = id;
    js.src =
      'https://connect.facebook.net/<%=LanguageItemExtension.GetnLanguageItemTitleByName("vi_VN")%>/sdk.js#xfbml=1&version=v2.11&appId=453642988336652';
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
  (function () {
    var po = document.createElement("script");
    po.type = "text/javascript";
    po.async = true;
    po.src = "https://apis.google.com/js/platform.js";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(po, s);
  })();
</script>