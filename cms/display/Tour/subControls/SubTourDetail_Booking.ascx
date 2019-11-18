<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubTourDetail_Booking.ascx.cs" Inherits="cms_display_Tour_subControls_SubTourDetail_Booking" %>

<div class="sublist-3">
  <div class="" id="linkBook">
    <h2>
      <a href="#" class="title sublist-title fSize-30 txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Book your trip") %>
      </a>
    </h2>
    <div id="TourBookingForm" class="body">
      <h3>
        <a href="#" class="title fSize-20"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Welcome to Ltravel. Start planning your adventure to Vietnam now") %></a>
      </h3>
      <p><%=LanguageItemExtension.GetnLanguageItemTitleByName("You are requiring on:") %> <asp:Literal ID="ltrTitle" runat="server" /></p>
      <h3 class="title font-weight-bold fSize-16"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Your contact details:") %></h3>
      <div class="form-group form-inline">
        <div class="input-control">
          <div class="input-group nb_input_iconInline">
            <span class="icon icon-user"></span>
            <input id="tbName2" type="text" class="form-control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Full name (*)") %>">
          </div>
        </div>
        <div class="input-control">
          <div class="input-group nb_input_iconInline">
            <span class="icon icon-phone2"></span>
            <input id="tbPhone2" type="text" class="form-control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Phone (*)") %>">
          </div>
        </div>
        <div class="input-control">
          <div class="input-group nb_input_iconInline">
            <span class="icon icon-mail"></span>
            <input id="tbEmail2" type="text" class="form-control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Email (*)") %>">
          </div>
        </div>
        <div class="input-control">
          <div class="input-group nb_input_iconInline">
            <span class="icon icon-map"></span>
            <input id="tbNationality2" type="text" class="form-control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Nationality (*)") %>">
          </div>
        </div>
      </div>
      <div class="form-group form-inline">
        <div class="input-control">
          <h3 class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Number of Adults *") %></h3>
          <div class="input-group nb_input_count">
            <span class="action acTru">
              <a href="#" class="link"></a>
            </span>
            <input id="SoLuongNguoiLon" onchange="TinhTongGia()" data-price="<%=GiaNguoiLon %>" data-min="1" disabled="disabled" type="text" class="form-control" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng") %>" value="1">
            <span class="action acCong">
              <a href="#" class="link"></a>
            </span>
          </div>
        </div>
        <div class="input-control">
          <h3 class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Child from 8 to 11 years old") %></h3>
          <div class="input-group nb_input_count">
            <span class="action acTru">
              <a href="#" class="link"></a>
            </span>
            <input id="SoLuongTreViThanhNien" onchange="TinhTongGia()" data-price="<%=GiaTreViThanhNien %>" data-min="0" disabled="disabled" type="text" class="form-control" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng") %>" value="0">
            <span class="action acCong">
              <a href="#" class="link"></a>
            </span>
          </div>
        </div>
      </div>
      <div class="form-group form-inline">
        <div class="input-control">
          <h3 class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Child from 3 to 7 years old") %></h3>
          <div class="input-group nb_input_count">
            <span class="action acTru">
              <a href="#" class="link"></a>
            </span>
            <input id="SoLuongTreEm" onchange="TinhTongGia()" data-price="<%=GiaTreEm %>" data-min="0" disabled="disabled" type="text" class="form-control" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng") %>" value="0">
            <span class="action acCong">
              <a href="#" class="link"></a>
            </span>
          </div>
        </div>
        <div class="input-control">
          <h3 class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Infant (under 2 years old)") %></h3>
          <div class="input-group nb_input_count">
            <span class="action acTru">
              <a href="#" class="link"></a>
            </span>
            <input id="SoLuongEmBe" onchange="TinhTongGia()" data-price="<%=GiaEmBe %>" data-min="0" disabled="disabled" type="text" class="form-control" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số lượng") %>" value="0">
            <span class="action acCong">
              <a href="#" class="link"></a>
            </span>
          </div>
        </div>
      </div>
      <div class="form-group form-inline">
        <div class="input-control">
          <h3 class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Departure time") %></h3>
          <div class="input-group nb_input_iconInline">
            <span class="icon icon-calendar"></span>
            <input id="tbNgayKhoiHanh" type="text" class="form-control datepicker" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Departure time") %>">
          </div>
        </div>
        <div class="input-control">
          <label class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Please select your trips") %></label>
          <div class="input-group nb_input_iconInline form-select">
            <span class="icon icon-fly"></span>
            <asp:DropDownList ID="ddlChuyenDi" onchange="ChuyenDiThayDoi()" ClientIDMode="Static" CssClass="form-control hFull" runat="server"></asp:DropDownList>
          </div>
        </div>
      </div>
      <div class="form-group total-price">
        <div class="input-control">
          <h3 class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Total amount(VND)") %></h3>
          <div class="input-group mb-2">
            <span><span id="ToTalPrice2" data-price="<%=ToTalPriceOrigin %>" class="d-inline-block w-auto"><%=ToTalPrice %></span> <span id="SubPrice" class="d-inline-block w-auto">
              <asp:Literal ID="ltrSubPrice" runat="server" /></span></span>
          </div>
        </div>
      </div>
      <div class="form-group form-inline mrb-0">
        <div class="input-control area-control">
          <h3 class="title txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Anything else we should know?") %></h3>
          <div class="input-group nb_input_iconInline form-area">
            <span class="icon icon-comment"></span>
            <textarea id="tbContent2" class="form-control" rows="4"></textarea>
          </div>
        </div>
      </div>
      <a href="javascript:void(0)" onclick="BookingTour(event)" type="submit" class="link linkSubmit"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Booking now") %></a>
    </div>
  </div>
</div>

<script type="text/javascript">
  function FormatNumber(num) {
    return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.")
  }

  function TinhTongGia() {
    if ($("#ToTalPrice2").attr("data-price") !== "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Liên hệ")%>") {
      var GiaGoc = Number($("#ToTalPrice2").attr("data-price")),
        GiaNguoiLon = 0,
        GiaTreViThanhNien = Number($("#SoLuongTreViThanhNien").attr("data-price")) * Number($("#SoLuongTreViThanhNien").attr("value")),
        GiaTreEm = Number($("#SoLuongTreEm").attr("data-price")) * Number($("#SoLuongTreEm").attr("value")),
        GiaEmBe = Number($("#SoLuongEmBe").attr("data-price")) * Number($("#SoLuongEmBe").attr("value"));

      if ($("#SoLuongNguoiLon").attr("value") !== "1") {
        GiaNguoiLon = Number($("#SoLuongNguoiLon").attr("data-price")) * (Number($("#SoLuongNguoiLon").attr("value")) - 1);
      }

      $("#ToTalPrice2").text(FormatNumber(GiaGoc + GiaNguoiLon + GiaTreViThanhNien + GiaTreEm + GiaEmBe));
      $("#SubPrice").text("<%=LanguageItemExtension.GetnLanguageItemTitleByName("VND")%>");
    } else {
      $("#SubPrice").text("");
    }
  }

  function ChuyenDiThayDoi() {
    $.ajax({
      url: weburl + "cms/display/Tour/Ajax/Ajax.aspx",
      type: "POST",
      dataType: "json",
      data: {
        "action": "GetPrice",
        "iid": $("#ddlChuyenDi").find("option:selected").val()
      },
      success: function (res) {
        loading(false);
        if (res[0].toString() == "Success") {
          $("#ToTalPrice2").attr("data-price", res[1].toString());
          $("#ToTalPrice2").text(res[2].toString());
          $("#SoLuongNguoiLon").attr("data-price", res[3].toString());
          $("#SoLuongTreViThanhNien").attr("data-price", res[4].toString());
          $("#SoLuongTreEm").attr("data-price", res[5].toString());
          $("#SoLuongEmBe").attr("data-price", res[6].toString());

          TinhTongGia();
        }
      },
      error: function (error) {
        loading(false);
        alert('<%=LanguageItemExtension.GetnLanguageItemTitleByName("Hệ thống đang bận, bạn vui lòng thử lại sau!") %>');
      }
    });
  }

  function BookingTour(e) {
    e.preventDefault();
    loading(true);
    var form = "#TourBookingForm",
        name = $("#tbName2").val(),
        phone = $("#tbPhone2").val(),
        email = $("#tbEmail2").val(),
        nationality = $("#tbNationality2").val(),        
        departureTime = $("#tbNgayKhoiHanh").val(),
        totalPrice = $("#ToTalPrice2").text(),
        trip = $("#ddlChuyenDi").find("option:selected").text(),
        content = $("#tbContent2").val(),
        nguoilon = $("#SoLuongNguoiLon").val(),
        trevithanhnien = $("#SoLuongTreViThanhNien").val(),
        treem = $("#SoLuongTreEm").val(),
        embe = $("#SoLuongEmBe").val(),
        msg1 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Vui lòng nhập đủ thông tin trước khi gửi đăng ký")%>",
        msg2 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Địa chỉ email không hợp lệ")%>",
        msg3 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số điện thoại không hợp lệ")%>";

    if (validateForm2(form, msg1, msg2, msg3)) {
      $.ajax({
        url: weburl + "cms/display/Tour/Ajax/Ajax.aspx",
        type: "POST",
        dataType: "json",
        data: {
          "action": "Booking",
          "iid": "<%=GetIid%>",
          "name": name,
          "phone": phone,
          "email": email,
          "nationality": nationality,    
          "departureTime": departureTime,
          "totalPrice": totalPrice,
          "trip": trip,
          "content": content,
          "nguoilon": nguoilon,
          "trevithanhnien": trevithanhnien,
          "treem": treem,
          "embe": embe
        },
        success: function (res) {
          loading(false);
          if (res[0].toString() == "Success") {
            window.location.replace(weburl + "dat-tour-thanh-cong.html");
          }
        },
        error: function (error) {
          loading(false);
          alert('<%=LanguageItemExtension.GetnLanguageItemTitleByName("Hệ thống đang bận, bạn vui lòng thử lại sau!") %>');
        }
      });
    }
  };
</script>