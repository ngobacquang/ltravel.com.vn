<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EmailWebsite.ascx.cs" Inherits="cms_admin_System_website_EmailWebsite_AdmEmailWebsite" %>
<asp:HiddenField ID="hdOldPassword" runat="server" />
<div id="AdmEmailWebsite">
  <div class="pdControl">
    <div style="line-height: 22px">
      <b>Email hệ thống:</b><br />
      Vui lòng nhập đúng email và mật khẩu. Email này được dùng để gửi và nhận các thông tin từ hệ thống.<br />
      <b>Chú ý:</b> không nên dùng tài khoản quan trọng của bạn vì email này có thể bị đưa vào dạng <b>SPAM</b>
    </div>
    <div class="cbh15">
      <!---->
    </div>
    <div class="FormatColText">
      <div>Mail hệ thống website:</div>
    </div>
    <div>
      <asp:TextBox ID="tbEmail" runat="server" Width="200px"></asp:TextBox></div>
    <div>
      <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
        ErrorMessage="Email không hợp lệ" ControlToValidate="tbEmail"
        Display="Dynamic" SetFocusOnError="True"
        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
    </div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="FormatColText">
      <div>Mật khẩu Email:</div>
    </div>
    <style>
      .password-custom { height: 26px; padding: 0 5px; box-sizing: border-box; }
    </style>
    <div>
      <asp:TextBox ID="tbPassword" runat="server" Width="200px" CssClass="password-custom" TextMode="Password"></asp:TextBox>
      <asp:Literal ID="ltrPasswordStatus" runat="server"></asp:Literal>
    </div>

    <div class="cbh20">
      <!---->
    </div>
    <div class="cbh20">
      <!---->
    </div>
    <div>
      <b>Danh sách các email phụ(cách nhau bởi dấu ,):</b> các email này dùng để nhận các tin từ hệ thống.
    </div>
    <div class="cbh8">
      <!---->
    </div>
    <div>
      <asp:TextBox ID="tbSubEmail" runat="server" Width="95%" Height="80px" TextMode="MultiLine"></asp:TextBox>
    </div>
    <div>
      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
        ErrorMessage="Các email không hợp lệ" ControlToValidate="tbSubEmail"
        Display="Dynamic" SetFocusOnError="True"
        ValidationExpression="(\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(,)?)*"></asp:RegularExpressionValidator>
    </div>
    <div class="cbh8">
      <!---->
    </div>
    <div>
      <asp:LinkButton ID="LbUpdate" runat="server" OnClick="btn_save_Click"><img src="cms/admin/cs/Icon/btnUpdate.png" border="0" /></asp:LinkButton>
    </div>
  </div>
</div>
