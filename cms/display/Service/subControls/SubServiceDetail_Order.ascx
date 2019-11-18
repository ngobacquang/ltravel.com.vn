<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubServiceDetail_Order.ascx.cs" Inherits="cms_display_Service_subControls_SubServiceDetail_Order" %>

<div class="order-service detail" id="linkBook">
  <h2>
    <a href="#" class="title sublist-title fSize-30 txtL"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Order online service") %></a>
  </h2>
  <div id="OrderServiceForm" class="body">
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
    <div class="form-group fulWidth">
      <div class="input-control">
        <div class="input-group nb_input_iconInline form-select">
          <span class="icon icon-calendar"></span>
          <asp:DropDownList ID="ddlService2" ClientIDMode="Static" CssClass="form-control hFull" runat="server"></asp:DropDownList>
        </div>
      </div>
      <div class="input-control area-control">
        <div class="input-group nb_input_iconInline form-area">
          <span class="icon icon-comment"></span>
          <textarea id="tbContent2" class="form-control" rows="4"></textarea>
        </div>
      </div>
    </div>
    <a href="javascript:void(0)" onclick="BookingService(event)" type="submit" class="link linkSubmit"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Send") %></a>
  </div>
</div>

<script type="text/javascript">
  function BookingService(e) {
    e.preventDefault();
    loading(true);
    var form = "#OrderServiceForm",
        name = $("#tbName2").val(),
        phone = $("#tbPhone2").val(),
        email = $("#tbEmail2").val(),
        nationality = $("#tbNationality2").val(),
        service = $("#ddlService2").find("option:selected").text(),
        content = $("#tbContent2").val(),
        msg1 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Vui lòng nhập đủ thông tin trước khi gửi đăng ký")%>",
        msg2 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Địa chỉ email không hợp lệ")%>",
        msg3 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số điện thoại không hợp lệ")%>";

    if (validateForm2(form, msg1, msg2, msg3)) {
      $.ajax({
        url: weburl + "cms/display/Service/Ajax/Ajax.aspx",
        type: "POST",
        dataType: "json",
        data: {
          "action": "Booking",
          "name": name,
          "phone": phone,
          "email": email,
          "nationality": nationality,    
          "service": service,
          "content": content
        },
        success: function (res) {
          loading(false);
          if (res[0].toString() == "Success") {
            window.location.replace(weburl + "dat-dich-vu-thanh-cong.html");
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