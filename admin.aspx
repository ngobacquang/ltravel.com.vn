<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="admin" ValidateRequest="false" %>

<%@ Import Namespace="TatThanhJsc.Extension" %>

<%@ Register Src="cms/admin/Moduls/CommonControls/AdmFooter.ascx" TagName="u_adm_footer" TagPrefix="uc1" %>
<%@ Register Src="cms/admin/Moduls/CommonControls/Header/AdmHeader.ascx" TagName="u_adm_header" TagPrefix="uc2" %>
<%@ Register Src="cms/admin/Moduls/CommonControls/AdmControlsHorizaMenu.ascx" TagName="AdmControlsHorizaMenu" TagPrefix="uc4" %>

<%@ Register Src="cms/admin/Moduls/CommonControls/AdmRoad.ascx" TagName="AdmRoad" TagPrefix="uc3" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
  <title>Khu vực quản tri website</title>
  <script type="text/javascript">
    var WebsiteUrl = '<%=UrlExtension.WebisteUrl %>';
    var weburl = "<%=UrlExtension.WebisteUrl %>";
  </script>
  <script src="cms/admin/js/jquery-1.8.3.min.js" type="text/javascript"></script>

  <%--chọn ngày tháng với datepicker - https://api.jqueryui.com/datepicker/--%>
  <script src="js/datePicker/jquery-ui-1.11.4.js"></script>
	<link href="js/datePicker/jquery-ui.css" rel="stylesheet" />
	<script src="cms/admin/js/DatePicker/datePicker.js"></script>
	<script src="cms/admin/js/DatePicker/datepicker-vi.js"></script>

  <%--định dạng số tiền trong textbox - https://github.com/BobKnothe/autoNumeric--%>
  <script type="text/javascript" src="cms/admin/js/autoNumeric/autoNumeric.js"></script>

  <script src="cms/admin/js/jsColor/jscolor.js" type="text/javascript"></script>

  <script src="cms/admin/js/Common.js" type="text/javascript"></script>
  <script src="cms/admin/js/TAleart.js" type="text/javascript"></script>
  <script src="cms/admin/js/TCheckBox.js" type="text/javascript"></script>

  <script src="cms/admin/js/TCookie.js" type="text/javascript"></script>
  <script src="cms/admin/js/TWindow.js" type="text/javascript"></script>

  <script src="cms/admin/js/amcharts.js" type="text/javascript"></script>

  <%--jAlert - http://labs.abeautifulsite.net/archived/jquery-alerts/demo/--%>
  <script src="cms/admin/js/jAlert/jquery.alerts.js" type="text/javascript"></script>
  <script src="cms/admin/js/jAlert/jquery.ui.draggable.js" type="text/javascript"></script>
  <link href="cms/admin/js/jAlert/jquery.alerts.css" rel="stylesheet" />

  <script src="cms/admin/Ajax/Groups/_Groups.js" type="text/javascript"></script>
  <script src="cms/admin/Ajax/Items/_Items.js" type="text/javascript"></script>
  <script src="cms/admin/Ajax/SubItems/_SubItems.js" type="text/javascript"></script>

  <script src="cms/admin/Moduls/Menu/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Advertising/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Contact/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Content/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/AboutUs/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Tour/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Hotel/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/CustomerReviews/_js/js.js" type="text/javascript"></script>

  <script src="cms/admin/Moduls/Product/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/New/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Service/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Customer/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Other/SupportOnline/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/FileLibrary/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Video/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/PhotoAlbum/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/QA/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Deal/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Other/Tag/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/FileLibrary2/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Website/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Email/_js/js.js" type="text/javascript"></script>
  <script src="cms/admin/Moduls/Blog/_js/js.js" type="text/javascript"></script>

  <cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/cs/FixChromeNoWrap.css" rel="stylesheet" />
    <link href="~/cms/admin/cs/admin.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/cs/Common.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/cs/Icon.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/js/jAleart/jquery.alerts.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/Moduls/CommonControls/Header/Header/Header.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/Moduls/CommonControls/Header/AdmControlsHeaderTopMenu/AdmControlsHeaderTopMenu.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/Moduls/CommonControls/Header/AdmControlsHeaderLogo/AdmControlsHeaderLogo.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/Moduls/CommonControls/AdmFooter/AdmFooter.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/Moduls/CommonControls/AdmRoad/AdmRoad.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/Moduls/CommonControls/AdmControlsHorizaMenu/AdmControlsHorizaMenu.css" rel="stylesheet" type="text/css" />
    <link href="~/cms/admin/Moduls/Search/SubSearch/AdmSubSearchBoxSearch/AdmSubSearchBoxSearch.css" rel="stylesheet" type="text/css" />
  </cc1:StyleSheetCombiner>

  <link href="cms/admin/cs/AllModul/css.css" rel="stylesheet" />
</head>
<body class="m0">
  <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="BgPageAdmin" align="center">
      <div class="FormatWidth" align="left">
        <uc2:u_adm_header ID="u_adm_header1" runat="server" />
      </div>
      <div class="BArMenu">
        <div class="FormatWidth" align="left">
          <uc4:AdmControlsHorizaMenu ID="AdmControlsHorizaMenu1" runat="server" />
        </div>
      </div>
      <div class="BgPageContentWebsite" align="center">
        <div class="FormatPageContainContent" align="left">
          <%--<uc3:AdmRoad ID="AdmRoad1" runat="server" />--%>
          <div class="pdPageContainContent">
            <asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder>
          </div>
        </div>
      </div>
      <div class="BgBottomPage">&nbsp;</div>
      <div class="FormatWidth" align="center">
        <div class="pdFooter">
          <uc1:u_adm_footer ID="u_adm_footer1" runat="server" />
        </div>
      </div>
    </div>

    <script type="text/javascript">
      InitToggle(); //Khởi tạo trạng thái ẩn hiện cho các khối div có id bắt đầu bằng Toogle_

      InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục        
    </script>
  </form>
</body>
</html>
