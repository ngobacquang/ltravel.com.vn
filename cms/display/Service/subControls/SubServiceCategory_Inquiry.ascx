<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SubServiceCategory_Inquiry.ascx.cs" Inherits="cms_display_Service_subControls_SubServiceCategory_Inquiry" %>

<div class="colRight">
  <div class="widget inquiry">
    <div class="head">
      <%=LanguageItemExtension.GetnLanguageItemTitleByName("Quick inquiry") %>
    </div>
    <div class="body">
      <div id="QuickInquiryForm" class="form-action">
        <input id="tbName" type="text" class="input-control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Enter your name") %>" />
        <input id="tbEmail" type="text" class="input-control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Enter your mail") %>" />
        <input id="tbReEmail" type="text" class="input-control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Comfirm your mail") %>" />
        <textarea id="tbContent" class="input-control area required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Tell us your tour ideas: where to visit, how many people and days, and your hotel style...") %>" rows="4"></textarea>
        <a href="javascript:void(0)" onclick="RegisInquiry(event)" type="submit" class="link link-submit"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Sen my inquiry") %></a>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  function RegisInquiry(e) {
    e.preventDefault();
    loading(true);
    var form = "#QuickInquiryForm",
        name = $("#tbName").val(),
        email = $("#tbEmail").val(),
        reEmail = $("#tbReEmail").val(),
        content = $("#tbContent").val(),
        msg1 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Vui lòng nhập đủ thông tin trước khi gửi đăng ký")%>",
        msg2 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Địa chỉ email không hợp lệ")%>",
        msg3 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Số điện thoại không hợp lệ")%>";

    if (validateForm(form, msg1, msg2, msg3)) {
      if(email == reEmail) {
        $.ajax({
          url: weburl + "cms/display/Service/Ajax/Ajax.aspx",
          type: "POST",
          dataType: "json",
          data: {
            "action": "Inquiry",
            "name": name,
            "email": email,
            "content": content
          },
          success: function (res) {
            loading(false);
            if (res[0].toString() == "Success") {
              alert('<%=LanguageItemExtension.GetnLanguageItemTitleByName("Gửi thông tin thành công! Chúng tôi sẽ liên lạc với bạn trong thời gian sớm nhất!") %>');
            }
          },
          error: function (error) {
            loading(false);
            alert('<%=LanguageItemExtension.GetnLanguageItemTitleByName("Hệ thống đang bận, bạn vui lòng thử lại sau!") %>');
          }
        });
      } else {
        alert('<%=LanguageItemExtension.GetnLanguageItemTitleByName("Địa chỉ Email không trùng khớp!") %>');
        loading(false);
        $("#tbReEmail").css("border", "dashed 1px #ff0014").focus();
      }
    }
  };
</script>

