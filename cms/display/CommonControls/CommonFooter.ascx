<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CommonFooter.ascx.cs" Inherits="cms_display_CommonControls_CommonFooter" %>
<%@ Register Src="~/cms/display/ContactUs/SubControls/SubContactUsMapAndInfoInFooter.ascx" TagPrefix="uc1" TagName="SubContactUsMapAndInfoInFooter" %>
<%@ Register Src="~/cms/display/CommonControls/CommonMenuBottom.ascx" TagPrefix="uc1" TagName="CommonMenuBottom" %>

<footer>
  <div class="foot-main">
    <div class="container">
      <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-6 col-xl-7">
          <div class="row tabOverturn">
            <div class="col-12 col-sm-12 col-md-8 col-lg-7 col-xl-7">
              <uc1:SubContactUsMapAndInfoInFooter runat="server" ID="SubContactUsMapAndInfoInFooter" />
              <div class="blog">
                <div class="head">
                  <%=LanguageItemExtension.GetnLanguageItemTitleByName("Sign up to receive information") %>
                </div>
                <div class="body">
                  <p><i><%=LanguageItemExtension.GetnLanguageItemTitleByName("Register new travel ideas in your inbox") %></i></p>
                  <div id="RegisForm" class="form-receive">
                    <input id="tbEmail" type="text" class="control required" placeholder="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Mail") %>" />
                    <a href="javascript:void(0)" onclick="RegisterEmail()" type="submit" class="link link-submit"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Send") %></a>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-12 col-sm-12 col-md-4 col-lg-5 col-xl-5">
              <div class="blog tripadvisor">
                <div class="head">
                  <%=LanguageItemExtension.GetnLanguageItemTitleByName("TRIPADVISOR") %>
                </div>
                <div class="body">
                  <asp:Literal ID="ltrTripadvisor" runat="server" />
                </div>
              </div>
            </div>
          </div>
        </div>
        <uc1:CommonMenuBottom runat="server" ID="CommonMenuBottom" />
      </div>
    </div>
  </div>
  <div class="foot-bot">
    <div class="container">
      <p><asp:Literal ID="ltrFooterCopyright" runat="server"></asp:Literal><span><a href="https://tatthanh.com.vn/" title="<%=LanguageItemExtension.GetnLanguageItemTitleByName("Thiết kế website và SEO - Tất Thành") %>"><%=LanguageItemExtension.GetnLanguageItemTitleByName("Thiết kế website và SEO - Tất Thành") %></a></span></p>
      <div class="view">
				<span>
					<i class="fa fa-users" aria-hidden="true"></i>
					<%=LanguageItemExtension.GetnLanguageItemTitleByName("Accessed") %>: <asp:Literal ID="ltrTotal" runat="server" />
				</span>
				<span>
					<i class="fa fa-bar-chart" aria-hidden="true"></i>
					<%=LanguageItemExtension.GetnLanguageItemTitleByName("Online") %>: <asp:Literal ID="ltrOnline" runat="server" />
				</span>
			</div>
    </div>
  </div>
</footer>

<script>
  function RegisterEmail() {
    var $selector = "#RegisForm",
        $ms1 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Vui lòng điền đủ thông tin trước khi gửi đăng ký")%>",
        $ms2 = "<%=LanguageItemExtension.GetnLanguageItemTitleByName("Email không hợp lệ!")%>";

    if(validateForm($selector, $ms1, $ms2, "")) {
      loading(true);
      $.ajax({
        url: weburl + "cms/display/Ajax/RegisEmail.aspx",
        type: "POST",
        data: {
          "email": $("#tbEmail").val()
        }
      }).done(function () {
        loading(false);
        alert("<%=LanguageItemExtension.GetnLanguageItemTitleByName("Đăng ký thành công. Chúng tôi sẽ gửi những thông tin và khuyến mãi mới nhất tới bạn qua thông tin mà bạn đã cung cấp. Xin cảm ơn !")%>");
        $("#tbEmail").val('');
      }).fail(function () {
        loading(false);
        alert('<%=LanguageItemExtension.GetnLanguageItemTitleByName("Có lỗi xảy ra, bạn vui lòng thử lại sau")%>');
      });
    }
  }
</script>