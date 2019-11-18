<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutCate.ascx.cs" Inherits="cms_admin_Moduls_Email_Cate_ShortCutCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Email/Cate/ShortCutCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<asp:HiddenField ID="hd_img" runat="server" />
<div id="admsccate">
    <div class="TxtInsertUpdate"><asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
    <div class="pdControl">
        <div class="cb h20"><!----></div>        
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.DanhMucCha %></div></div>
        <div class="control"><asp:DropDownList ID="DdlGroupContactUs" runat="server" Width="252px"></asp:DropDownList></div>
        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.TieuDeNhom %></div></div>
        <div class="control">
            <asp:TextBox ID="txt_title_modul" runat="server" Width="580px" CssClass="tbTitle"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txt_title_modul" Display="Dynamic"></asp:RequiredFieldValidator>                
        </div>

        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.DiaChi %></div></div>
        <div class="control">
            <asp:TextBox ID="tbDiaChi" runat="server" Width="580px"></asp:TextBox>            
        </div>
        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.DienThoai %></div></div>
        <div class="control">
            <asp:TextBox ID="tbDienThoai" runat="server" Width="250px"></asp:TextBox>            
        </div>
        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.Fax %></div></div>
        <div class="control">
            <asp:TextBox ID="tbFax" runat="server" Width="250px"></asp:TextBox>            
        </div>
        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.Email %></div></div>
        <div class="control">
            <asp:TextBox ID="tbEmail" runat="server" Width="250px"></asp:TextBox>            
        </div>
        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5">Website</div></div>
        <div class="control">
            <asp:TextBox ID="tbWebsite" runat="server" Width="250px"></asp:TextBox>            
        </div>

        <div class="cbh8"><!----></div>         
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.MoTa%>:</div></div>
        <div class="control">
            <asp:TextBox ID="txtDesc" runat="server" Width="580px" Height="50px" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>                            
        </div>
        <div class="cbh8"><!----></div>         
        <div class="text"><%=Developer.ContactKeyword.AnhDaiDien%>:</div>
        <div class="controlImg">
        <div class="khungThuocTinh psr">
            <%--Đóng dấu ảnh--%>
            <asp:HiddenField ID="hdLogoImage" runat="server" Value=""/>
            <asp:HiddenField ID="hdViTriDongDau" runat="server" Value=""/>
            <asp:HiddenField ID="hdLeX" runat="server" Value=""/>
            <asp:HiddenField ID="hdLeY" runat="server" Value=""/>
            <asp:HiddenField ID="hdTyLe" runat="server" Value=""/>
            <asp:HiddenField ID="hdTrongSuot" runat="server" Value=""/>
            <%--Đóng dấu ảnh - end --%>    
            <div><asp:Literal ID="ltimg" runat="server" Visible="true"></asp:Literal></div>
            <div><asp:LinkButton ID="btnXoaAnhHienTai" runat="server" Visible="false" onclick="btnXoaAnhHienTai_Click">Xóa hình ảnh hiện tại</asp:LinkButton></div>
            <div><asp:FileUpload ID="flimg" runat="server" Width="220px" /></div>
            <div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic" 
                    SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
            </div>    
            <a class="ThietLapAnh" href="javascript:Toggle('Toogle_ThietLapAnhDaiDien')">Ẩn/Hiện thiết lập ảnh</a>        
            <div id="Toogle_ThietLapAnhDaiDien" style="display:none"> <%--Đặt tên div bắt đầu bằng Toogle_ để được khởi tạo trạng thái ẩn hiện bằng js --%>
                <div class="cb h10"><!----></div>
                <asp:CheckBox ID="cbDongDauAnh" runat="server" Text="Đóng dấu ảnh"/>
                <div class="cb h5"><!----></div>
                <div class="fl">
                    <asp:CheckBox ID="cbHanCheKichThuoc" runat="server" Text="Hạn chế kích thước tối đa cho ảnh đại diện"/>
                    <div class="khungThuocTinh">
                        Rộng <asp:TextBox ID="tbHanCheW" runat="server" ToolTip="Chiều rộng lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                        Cao <asp:TextBox ID="tbHanCheH" runat="server" ToolTip="Chiều cao lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px
                    </div>
                </div>
                <div class="fr">
                    <asp:CheckBox ID="cbTaoAnhNho" runat="server" Text="Tạo ảnh nhỏ cho ảnh đại diện(thumbnails)"/>
                    <div class="khungThuocTinh">
                    Rộng <asp:TextBox ID="tbAnhNhoW" runat="server" ToolTip="Chiều rộng của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                    Cao <asp:TextBox ID="tbAnhNhoH" runat="server" ToolTip="Chiều cao của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px
                    </div>
                </div>
                <div class="cb"><!----></div>  
            </div>
        </div>
        </div>
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.ThuTu %>:</div></div>
        <div class="control">
            <asp:TextBox ID="txt_ordermodul" runat="server" Width="35px" Text="1"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="txt_ordermodul" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator> 
        </div>
        <div class="cb h8"><!----></div>
        <div class="text"><div class="pt5"><%=Developer.ContactKeyword.TrangThai %>:</div></div>
        <div class="control">
            <div><asp:CheckBox ID="chk_status" runat="server" CssClass="cccc fs11" Text="(tích chọn để hiển thị)" Checked="true"/></div>
        </div>
        <div class="cbh8"><!----></div>

        <div>
            <style type="text/css">
                #map_canvas {width:700px; height:350px}
                .thongBaoChonBanDo{font:normal 13px/20px Tahoma;font-style:italic;text-align:justify;padding:5px 10px 10px 0}
                .pt10{padding-top:10px}
                .pb10{padding-bottom:10px}
                .pl20{padding-left:20px}
            </style>
            <script type="text/javascript">
                function ToogleGoogleMapPanel() {
                    if (document.getElementById('GoogleMapPanel').style.display == 'none') {
                        document.getElementById('GoogleMapPanel').style.display = 'block';
                        document.getElementById('buttonOpenGoogleMapPanel').innerHTML = "Đóng lại";
                        initialize(); //Gọi hàm khởi tạo bản đồ (tránh trường hợp bản đồ không load hết trên FF)
                    }
                    else {
                        document.getElementById('GoogleMapPanel').style.display = 'none';
                        document.getElementById('buttonOpenGoogleMapPanel').innerHTML = "Chọn vị trí";
                    }
                }
            </script>
            <div class='text'>
                Đánh dấu địa chỉ trên GoogleMap
            </div>
            <div class='control'>                
                <asp:TextBox ID="tbViDo" runat="server" CssClass="textBox" Width="130px"></asp:TextBox>
                <asp:TextBox ID="tbKinhDo" runat="server" CssClass="textBox" Width="130px"></asp:TextBox>                
                <a id="buttonOpenGoogleMapPanel" href="javascript:void(0);" onclick="ToogleGoogleMapPanel()">Chọn vị trí</a>                
            </div>
            <div class='cb h10'><!----></div>
        </div>
        <div id="GoogleMapPanel" class='cb' style="display:none;padding-left:20px">
            <div class='thongBaoChonBanDo'>
                <span class='fwb cRed'>Hướng dẫn:</span> bạn chỉ cần <b>kích chuột</b> để chọn vị trí của đơn vị bạn trên bản đồ <b>hoặc nhập địa chỉ</b> rồi nhấn Tìm địa chỉ.<br />
                Khi hiển thị chúng tôi sẽ lấy thông tin mà bạn đã cung cấp và hiển thị tại vị trí bạn vừa chọn(không phải thông tin bạn đang nhìn thấy trên bản đồ. Vì vậy bạn không cần lo lắng nếu thông tin địa chỉ nơi bạn chọn không hoàn toàn trùng với địa chỉ của bạn!)
            </div>        
            <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBd0CRmUEi0rqasieRwBmdjh1a8J9IkYLU"> 
            </script> 
            <script type="text/javascript">
                var geocoder;
                var map;
                var infowindow = new google.maps.InfoWindow();

                //Phương thức khởi tạo
                function initialize() {
                    geocoder = new google.maps.Geocoder();

                    //Khởi tạo vị trí giữa bản đồ (điền vĩ độ, kinh độ điểm cẩn hiển thị tại đây) (Xử lý lấy từ CSDL ra)
                    var latlng = new google.maps.LatLng("<%=lat %>", "<%=lng %>");
                    var myOptions = {
                        zoom: 15,
                        center: latlng,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    }

                    //Tìm div có id map_canvas để hiển thị bản đồ
                    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                    //Đánh dấu điểm tìm được
                    var marker = new google.maps.Marker({
                        position: latlng,
                        map: map
                    });

                    //Mở cửa sổ chứa thông tin của điểm tìm được. Điền thông tin của điểm đó tại đây (Xử lý lấy từ CSDL ra)
                    infowindow.setContent("<%=infoWindow %>");
                    infowindow.open(map, marker);

                    //Thêm sự kiện click vào map ---> Lấy vĩ độ, kinh độ, địa chỉ ---> điền vào các textbox (phục vụ việc lấy thông tin để lưu vào CSDL)
                    google.maps.event.addListener(map, 'click', function (event) {
                        codeLatLng(event.latLng);
                    });

                    //Tìm theo địa chỉ trên textbox
                    //codeAddress();
                }

                //Phương thức tìm thông tin địa chỉ theo địa chỉ truyền vào từ textbox address
                function codeAddress() {
                    var address = document.getElementById("address").value; //Lấy giá trị từ textbox
                    geocoder.geocode({ 'address': address }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            map.setCenter(results[0].geometry.location);
                            var marker = new google.maps.Marker({
                                map: map,
                                position: results[0].geometry.location
                            });


                            //Mở cửa sổ chứa thông tin của điểm tìm được.
                            infowindow.setContent(results[0].formatted_address);
                            infowindow.open(map, marker);

                            //Thêm sự kiện click vào điểm được đánh dấu
                            google.maps.event.addListener(marker, 'click', function () {
                                infowindow.setContent(results[0].formatted_address);
                                infowindow.open(map, marker);
                                FillValueToControls(latlng.lat(), latlng.lng(), results[0].formatted_address);
                            });

                            //Điền các thông tin của địa điểm tìm thấy vào các textbox (phục vụ việc lấy thông tin để lưu vào CSDL)
                            FillValueToControls(results[0].geometry.location.lat(), results[0].geometry.location.lng(), address);
                        } else {
                            //alert("Geocode was not successful for the following reason: " + status);
                            alert("Không tìm thấy địa chỉ bạn vừa nhập. Vui lòng thử địa chỉ khác hoặc kích chọn trực tiếp trên bản đồ.");
                        }
                    });
                }

                //Phương thức tìm thông tin địa chỉ theo vĩ độ và kinh độ của điểm của click chuột
                function codeLatLng(latlng) {
                    geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (results[1]) {
                                var marker = new google.maps.Marker({
                                    position: latlng,
                                    map: map
                                });

                                //Mở cửa sổ chứa thông tin của điểm tìm được.
                                infowindow.setContent(results[0].formatted_address);
                                infowindow.open(map, marker);

                                //Thêm sự kiện click vào điểm được đánh dấu
                                google.maps.event.addListener(marker, 'click', function () {
                                    infowindow.setContent(results[0].formatted_address);
                                    infowindow.open(map, marker);
                                    FillValueToControls(latlng.lat(), latlng.lng(), results[0].formatted_address);
                                });

                                //Điền các thông tin của địa điểm tìm thấy vào các textbox (phục vụ việc lấy thông tin để lưu vào CSDL)
                                FillValueToControls(latlng.lat(), latlng.lng(), results[0].formatted_address);
                            }
                        } else {
                            alert("Geocoder failed due to: " + status);
                        }
                    });

                }

                //Phương thức điền các thông tin của địa điểm tìm thấy vào các textbox (phục vụ việc lấy thông tin để lưu vào CSDL)
                function FillValueToControls(lat, lng, address) {
                    //Điền vĩ độ vào textbox
                    document.getElementById("<%=tbViDo.ClientID %>").value = lat;
                    //Điền kinh độ vào textbox
                    document.getElementById("<%=tbKinhDo.ClientID %>").value = lng;
                    //Điền giá trị vào textbox
                    document.getElementById("address").value = address;
                }

                //Phương thức tìm kiếm địa chỉ khi nhấn Enter tại textbox địa chỉ
                function onEnterPress(buttonName, e) {
                    var key;
                    if (window.event)
                        key = window.event.keyCode;     //IE
                    else
                        key = e.which;     //firefox
                    if (key == 13) {
                        var btn = document.getElementById(buttonName);
                        if (btn != null) {
                            btn.click();
                            event.keyCode = 0
                        }
                    }
                }
            </script>                        
            <div class='tac'>             
                <%--<input id="tbLat" type="textbox"/>
                <input id="tbLng" type="textbox"/>--%>
                <input id="address" type="text" onkeypress="onEnterPress('btSearch',event);" value="Hà Nội, Việt Nam" style="width:400px"/>
                <input id="btSearch" type="button" value="Tìm địa chỉ" onclick="codeAddress()" />
            </div> 
            <div id="map_canvas"></div>                        
        </div>

        <div class="cbh8"><!----></div>

        <div class="text"><!---->&nbsp;</div>
        <div class="control">
            <asp:CheckBox CssClass='fl' ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
            <div class="cbh0"><!----></div>
        </div>
        
        <div class="cbh20"><!----></div>
        <div class="TextSeoLink"><%=Developer.ContactKeyword.ToiUuTimKiem%> </div>
        <div>
            <div class="text"><div class="pt5"><%=Developer.ContactKeyword.ToiUuDuongDan%>: </div></div>
            <div class="control"><asp:TextBox ID="textLinkRewrite" runat="server" Width="450px" CssClass="tbLink_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=Developer.ContactKeyword.ToiUuTheTieuDe%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagTitle" runat="server" Width="450px" CssClass="tbTitle_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=Developer.ContactKeyword.ToiUuTheTuKhoa%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagKeyword" runat="server" Width="450px" CssClass="tbKeyword_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=Developer.ContactKeyword.ToiUuTheMoTa%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagDescription" runat="server" CssClass="tbDesc_Seo" Width="580px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
        </div>

        <div class="cb h20"><!----></div>
        <div class="tac">
            <asp:Button ID="btn_insert_update" runat="server" onclick="btn_insert_update_Click" Width="120px"/>
            <asp:Button ID="btn_cancel" runat="server" Text="Hủy bỏ" onclick="btn_cancel_Click" Width="80px" CausesValidation="false"/>
        </div>                
        <div class="cb h20"><!----></div>
    </div>
</div>