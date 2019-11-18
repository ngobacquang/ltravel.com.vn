<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>
<%@ Register Src="~/cms/display/DisplayLoadControl.ascx" TagPrefix="uc1" TagName="DisplayLoadControl" %>

<!DOCTYPE html<%-- PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"--%>>

<html xmlns="http://www.w3.org/1999/xhtml" debug="true" lang="vi">
<head runat="server">
	<title><asp:Literal ID="ltrTitle" runat="server"></asp:Literal></title>
	<meta name="format-detection" content="telephone=no" />
	<meta name="MobileOptimized" content="device-width" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta name="format-detection" content="telephone=no">
  <asp:Literal ID="ltrMetaOther" runat="server"></asp:Literal>
  <asp:Literal ID="ltrMetaShare" runat="server"></asp:Literal>
  <asp:Literal ID="ltrFavicon" runat="server"></asp:Literal>
  <asp:Literal ID="ltrGA" runat="server"></asp:Literal>

  <script>
    var webUrl = "<%= UrlExtension.WebisteUrl %>";
    var weburl = "<%= UrlExtension.WebisteUrl %>";
    if (document.URL.indexOf("www.") > -1) window.location = document.URL.replace("www.", "");
    if (window.location.protocol === 'http:' && document.URL.indexOf('localhost') < 0) {
      var restOfUrl = window.location.href.substr(5);
      window.location = 'https:' + restOfUrl;
    }
  </script>

  <link href="/Themes/Theme01/Assets/Css/jquery-ui.css" rel="stylesheet" />
  <link href="/Themes/Theme01/Assets/Js/datepicker-master/dist/datepicker.min.css" rel="stylesheet" />
  <link href="/Themes/Theme01/Assets/Css/__main.min.css" rel="stylesheet" />
</head>
<body>
  <form id="form1" runat="server">
    <div>
      <uc1:DisplayLoadControl runat="server" ID="DisplayLoadControl" />
    </div>
  </form>
  <script src="/Themes/Theme01/Assets/Js/__Homepage.min.js"></script>
  <script src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-549cfbb03cd40d94" async="async"></script>
  <script src="/js/cookie.js"></script>
  <script src="/js/common_code.js"></script>
  <script>
    menuMarking("<%=cRewrite%>");
  </script>
</body>
</html>