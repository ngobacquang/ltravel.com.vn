<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Index.ascx.cs" Inherits="cms_admin_Moduls_Homepage_Index" %>
<%@ Register TagPrefix="cc2" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc2:StyleSheetCombiner ID="sheetCombiner" runat="server">
<link href="~/cms/admin/Moduls/Homepage/_cs/_cs.css" rel="stylesheet" type="text/css" />
</cc2:StyleSheetCombiner>
<div id="AdmRoad">
    <a class="TextRoad">Bạn đang ở: </a>
    <a title="Trang chủ" class="TextRoad" href="admin.aspx">Trang chủ</a>
    <div class="cbh0"><!----></div>
    
    <a class="config" href="admin.aspx?uc=config" title="Click để cấu hình cho trang này"><span class="iconConfig dib">&nbsp;</span></a>
</div>
<div id="Homei">    
    <div class="ShortCutTool">
        <div class="cbh20"><!----></div>     
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowNew)%>' >
            <a href="<%=TatThanhJsc.NewsModul.Link.LnkMnNewsItemCreate() %>" class="NewItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.NewsModul.Link.LnkMnNewsItemCreate() %>" class="TtlCreate">Thêm tin tức</a>
        </div>
               
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowProduct)%>' >
            <a href="<%=TatThanhJsc.ProductModul.Link.LnkMnProductItemCreate() %>" class="ProductItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.ProductModul.Link.LnkMnProductItemCreate() %>" class="TtlCreate">Thêm sản phẩm</a>
        </div>
              
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowService)%>' >
            <a href="<%=TatThanhJsc.ServiceModul.Link.LnkMnServiceItemCreate() %>" class="ServiceItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.ServiceModul.Link.LnkMnServiceItemCreate() %>" class="TtlCreate">Thêm dịch vụ</a>
        </div>
                
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowPhotoAlbum)%>' >
            <a href="<%=TatThanhJsc.PhotoAlbumModul.Link.LnkMnPhotoAlbumItemCreate() %>" class="PhotoItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.PhotoAlbumModul.Link.LnkMnPhotoAlbumItemCreate() %>" class="TtlCreate">Thêm ảnh - thư viện ảnh</a>
        </div>
               
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowVideo)%>' >
            <a href="<%=TatThanhJsc.VideoModul.Link.LnkMnVideoItemCreate() %>" class="VideoItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.VideoModul.Link.LnkMnVideoItemCreate() %>" class="TtlCreate">Thêm video</a>
        </div>
              
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowFilelibrary)%>' >
            <a href="<%=TatThanhJsc.FileLibraryModul.Link.LnkMnFileLibraryItemCreate() %>" class="FileItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.FileLibraryModul.Link.LnkMnFileLibraryItemCreate() %>" class="TtlCreate">Thêm file - thư viện file</a>
        </div>   
            
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowCustomer)%>' >
            <a href="<%=TatThanhJsc.CustomerModul.Link.LnkMnCustomerItemCreate() %>" class="CustomerItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.CustomerModul.Link.LnkMnCustomerItemCreate() %>" class="TtlCreate">Thêm khách hàng</a>
        </div>
               
        <div class="ColIco" align="center" style='<%=SetDisplay(HorizaMenuConfig.ShowAdv)%>' >
            <a href="<%=TatThanhJsc.AdvertisingModul.Link.LnkMnAdvertisingItemCreate() %>" class="AdvItem">&nbsp;</a>
            <a href="<%=TatThanhJsc.AdvertisingModul.Link.LnkMnAdvertisingItemCreate() %>" class="TtlCreate">Thêm ảnh quảng cáo</a>
        </div>             
        <div class="cbh20"><!----></div>
    </div>
    <div id="ListSubControls">
        <asp:PlaceHolder ID="plLoadControls" runat="server"></asp:PlaceHolder>
        <div class="cb"><!----></div>
    </div>

    <div class="cbh20"><!----></div>
    <script type="text/javascript">
        var chart;
        var legend;
        <asp:Literal ID="LtScriptChartTotalItem" runat="server"></asp:Literal>
        AmCharts.ready(function () {
            // PIE CHART
            chart = new AmCharts.AmPieChart();
            chart.dataProvider = chartData1;
            chart.titleField = "country1";
            chart.valueField = "value";
            chart.outlineColor = "#FFF";
            chart.outlineAlpha = 0.8;
            chart.outlineThickness = 2;
            // this makes the chart 3D
            chart.depth3D = 10;
            chart.angle = 30;
            var legend = new AmCharts.AmLegend();
            
            chart.addLegend(legend);
            chart.marginLeft = 10;
            
            // WRITE
            chart.write("chartdivTotal");
        });
    </script>
    <script type="text/javascript">
        var chart;
        var legend;
        <asp:Literal ID="LtScriptChart" runat="server"></asp:Literal>
        AmCharts.ready(function () {
            // PIE CHART
            chart1 = new AmCharts.AmPieChart();
            chart1.dataProvider = chartData;
            var legend = new AmCharts.AmLegend();
            chart1.addLegend(legend);
            chart1.titleField = "country";
            chart1.valueField = "value";
            chart1.outlineColor = "#FFFFFF";
            chart1.outlineAlpha = 0.8;
            chart1.outlineThickness = 2;
            // this makes the chart 3D
            chart1.depth3D = 10;
            chart1.angle = 30;

            // WRITE
            chart1.write("chartdiv");
        });
    </script>    
    <div class="ColChart pr20">
        <div class="TtlTab">Thông kê số lượng bài viết</div>
        <div id="chartdivTotal" style="width: 480px; height: 280px;border: solid 1px #ccc"></div>
    </div>
    <div class="ColChart">
        <div class="TtlTab">Thông kê số lượt xem từng modul</div>
        <div id="chartdiv" style="width: 470px; height: 280px;border: solid 1px #ccc;padding-left: 10px"></div>
    </div>
    <div class="cbh0"></div>
</div>




