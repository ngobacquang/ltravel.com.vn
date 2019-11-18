<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Index.ascx.cs" Inherits="cms_display_ContactUs_Controls_Index" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>

<div class="section contact">
  <div class="container">
    <div class="list">
      <h1>
        <a href="#" class="title list-title fSize-20 fSize-sm-18 nb-color-m1">
          <asp:Literal ID="ltrCateName" runat="server" />
        </a>
      </h1>
      <div class="list-body">
        <div class="row">
          <div class="col-12 col-sm-12 col-md-12 col-lg-6">
            <div class="sublist sublist-1">
              <asp:Literal ID="ltrInfo" runat="server"></asp:Literal>
              <div id="FormContact" class="form-action">
                <a href="#" class="title sublist-title fSize-20 fSize-sm-16 nb-color-m3"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Please fill up the form and send to us.") %></a>
                <div class="wap">
                  <div class="input-group nb-icon-form">
                    <input id="tbName" type="text" class="form-control form-name required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Name") %>">
                  </div>
                  <div class="input-group nb-icon-form">
                    <input id="tbPhone" type="text" class="form-control form-phone required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Phone") %>">
                  </div>
                  <div class="input-group nb-icon-form">
                    <input id="tbEmail" type="text" class="form-control form-mail" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Email") %>">
                  </div>
                  <div class="input-group nb-icon-form nb_input_iconInline form-select">
                    <span class="icon icon-hand"></span>
                    <asp:DropDownList ID="ddlPhongBan" ClientIDMode="Static" CssClass="form-control hFull form-select" runat="server"></asp:DropDownList>
                  </div>
                  <div class="input-group nb-icon-form">
                    <textarea id="tbContent" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Content") %>" class="form-control form-area required" rows="5"></textarea>
                  </div>
                  <div class="form-group links-submit">
                    <a href="javascript:SendContact()" type="submit" class="link link-submit"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Send") %></a>
                    <a href="#" onclick="resetForm('#FormContact', event)" type="submit" class="link link-submit"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Retype") %></a>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-12 col-sm-12 col-md-12 col-lg-6">
            <p class="title fSize-20 font-weight-bold"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Bản đồ googlemap") %></p>
            <div class="blogMap">
              <asp:Literal ID="ltrMap" runat="server" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  function SendContact() {
    loading(true);
    var name = $("#tbName").val(),
        email = $("#tbEmail").val(),
        phone = $("#tbPhone").val(),
        content = $("#tbContent").val(),
        phongban = $("#ddlPhongBan option:selected").text(),
        msg1 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Vui lòng nhập đủ thông tin trước khi gửi liên hệ!")%>",
        msg2 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Địa chỉ Email không hợp lệ!")%>",
        msg3 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số điện thoại không hợp lệ!")%>";

    if (validateForm("#FormContact", msg1, msg2, msg3)) {
      $.ajax({
        url: weburl + "cms/display/ContactUs/Ajax/Ajax.aspx",
        type: "POST",
        dataType: "json",
        data: {
          "action": "SendContact",
          "name": name,
          "email": email,
          "phone": phone,
          "noidung": content,
          "phongban": phongban
        },
        success: function (res) {
          loading(false);
          if (res[0].toString() == "Success") {
            window.location.href = weburl + "gui-lien-he-thanh-cong.html";
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