<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GoogleMapMarkLocation.ascx.cs" Inherits="cms_admin_TempControls_InsertForm_GoogleMapMarkLocation" %>
<div class="GoogleMapMarkLocation">
    <div class="row">
        <style type="text/css">
            #map_canvas{height:350px;margin-bottom:20px;margin-top:10px;width:700px;}
            .thongBaoChonBanDo{font:normal 13px/20px Tahoma;font-style:italic;padding:5px 10px 10px 0;text-align:justify;}
            .pt10{padding-top:10px}
            .pb10{padding-bottom:10px}
            .pl20{padding-left:20px}
            .GoogleMapMarkLocation a{color:blue}
            .GoogleMapMarkLocation input[type=text]{padding:5px}
        </style>
        <script type="text/javascript">
            function ToogleGoogleMapPanel() {
                if (document.getElementById("GoogleMapPanel").style.display == "none") {
                    document.getElementById("GoogleMapPanel").style.display = "block";
                    document.getElementById("buttonOpenGoogleMapPanel").innerHTML = "Đóng lại";
                    initialize(); //Gọi hàm khởi tạo bản đồ (tránh trường hợp bản đồ không load hết trên FF)
                } else {
                    document.getElementById("GoogleMapPanel").style.display = "none";
                    document.getElementById("buttonOpenGoogleMapPanel").innerHTML = "Chọn vị trí";
                }
            }
        </script>
        <div class="text">
            <asp:Literal ID="ltrText" runat="server"></asp:Literal>
        </div>
        <div class="control">
            <asp:TextBox ID="tbViDo" onfocus="ToogleGoogleMapPanel()" runat="server" CssClass="textBox" Width="130px"></asp:TextBox>
            <asp:TextBox ID="tbKinhDo" onfocus="ToogleGoogleMapPanel()" runat="server" CssClass="textBox" Width="130px"></asp:TextBox>
            <a id="buttonOpenGoogleMapPanel" href="javascript:void(0);" onclick=" ToogleGoogleMapPanel() ">Chọn vị trí</a>
        </div>
        <div class="cb h10"><!----></div>
    </div>
    <div id="GoogleMapPanel" class="cb" style="display:none;padding-left:20px">
        <div class="thongBaoChonBanDo">
            <span class="fwb cRed">Hướng dẫn:</span> bạn chỉ cần <b>kích chuột</b> để chọn vị trí của đơn vị bạn trên bản đồ <b>hoặc nhập địa chỉ</b> rồi nhấn Tìm địa chỉ.<br/>
            Khi hiển thị chúng tôi sẽ lấy thông tin mà bạn đã cung cấp và hiển thị tại vị trí bạn vừa chọn(không phải thông tin bạn đang nhìn thấy trên bản đồ. Vì vậy bạn không cần lo lắng nếu thông tin địa chỉ nơi bạn chọn không hoàn toàn trùng với địa chỉ của bạn!)
        </div>
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyBd0CRmUEi0rqasieRwBmdjh1a8J9IkYLU"></script>
        <script type="text/javascript">
            var geocoder;
            var map;
            var infowindow = new google.maps.InfoWindow();

            //Phương thức khởi tạo
            function initialize() {
                geocoder = new google.maps.Geocoder();

                //Khởi tạo vị trí giữa bản đồ (điền vĩ độ, kinh độ điểm cẩn hiển thị tại đây) (Xử lý lấy từ CSDL ra)
                var latlng = new google.maps.LatLng("<%= lat %>", "<%= lng %>");
                var myOptions = {
                    zoom: 15,
                    center: latlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                }; //Tìm div có id map_canvas để hiển thị bản đồ
                map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                //Đánh dấu điểm tìm được
                var marker = new google.maps.Marker({
                    position: latlng,
                    map: map
                });

                //Mở cửa sổ chứa thông tin của điểm tìm được. Điền thông tin của điểm đó tại đây (Xử lý lấy từ CSDL ra)
                infowindow.setContent("<%= infoWindow %>");
                infowindow.open(map, marker);

                //Thêm sự kiện click vào map ---> Lấy vĩ độ, kinh độ, địa chỉ ---> điền vào các textbox (phục vụ việc lấy thông tin để lưu vào CSDL)
                google.maps.event.addListener(map, "click", function(event) {
                    codeLatLng(event.latLng);
                });

                //Tìm theo địa chỉ trên textbox
                //codeAddress();
            }

            //Phương thức tìm thông tin địa chỉ theo địa chỉ truyền vào từ textbox address
            function codeAddress() {
                var address = document.getElementById("address").value; //Lấy giá trị từ textbox
                geocoder.geocode({ 'address': address }, function(results, status) {
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
                        google.maps.event.addListener(marker, "click", function() {
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
                geocoder.geocode({ 'latLng': latlng }, function(results, status) {
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
                            google.maps.event.addListener(marker, "click", function() {
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
                document.getElementById("<%= tbViDo.ClientID %>").value = lat;
                //Điền kinh độ vào textbox
                document.getElementById("<%= tbKinhDo.ClientID %>").value = lng;
                //Điền giá trị vào textbox
                document.getElementById("address").value = address;
            }

            //Phương thức tìm kiếm địa chỉ khi nhấn Enter tại textbox địa chỉ
            function onEnterPress(buttonName, e) {
                var key;
                if (window.event)
                    key = window.event.keyCode; //IE
                else
                    key = e.which; //firefox
                if (key == 13) {
                    var btn = document.getElementById(buttonName);
                    if (btn != null) {
                        btn.click();
                        event.keyCode = 0;
                    }

                    e.preventDefault();
                }
            }

            function CheckSearchMaps(e) {
                if (e.keyCode == 13) {
                    codeAddress();

                    e.preventDefault();
                }
            }
        </script>
        <div class="tac">
            <%--<input id="tbLat" type="textbox"/>
                <input id="tbLng" type="textbox"/>--%>
            <input id="address" type="text" onkeydown=" CheckSearchMaps(event); " value="<%=infoWindow %>" style="width:400px"/>
            <input id="btSearch" type="button" value="Tìm địa chỉ" onclick=" codeAddress() "/>
        </div>
        <div id="map_canvas"></div>
    </div>
</div>