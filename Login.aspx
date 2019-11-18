<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Khu vực đăng nhập hệ thống quản trị website</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    * { -moz-box-sizing: border-box; -webkit-box-sizing: border-box; box-sizing: border-box; }
    body { font: normal 13px Arial; margin: 0; padding: 0; color: #333; }
    a { color: #007bff; text-decoration: none; }
    .cb { clear: both; }
    .tac { text-align: center; }
    .col-left { background: #f1f1f1; bottom: 0; left: 0; position: fixed; top: 0; width: 268px; z-index: 1; overflow: auto; }
    .col-right { bottom: 0; left: 268px; position: fixed; right: 0; top: 0; z-index: 1; }

    #ttiflogin { bottom: 0; left: 0; position: absolute; right: 0; top: 0; z-index: 1; }
      #ttiflogin iframe { border: 0; height: 100%; left: 0; position: absolute; top: 0; width: 100%; z-index: 1; }


    .login-form-body { padding: 15px 30px; }
    .form-group { margin-bottom: 1rem; }
    label { display: inline-block; margin-bottom: .5rem; }
    .form-control { background-clip: padding-box; background-color: #fff; border: 1px solid #ced4da; border-radius: .25rem; color: #495057; display: block; font-size: 13px; line-height: 1.5; padding: .375rem .75rem; transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out; width: 100%; }
    .btn { -moz-user-select: none; -ms-user-select: none; -webkit-user-select: none; border: 1px solid transparent; border-radius: .25rem; display: inline-block; font-size: 13px; line-height: 1.5; padding: .375rem .75rem; text-align: center; transition: color .15s ease-in-out, background-color .15s ease-in-out, border-color .15s ease-in-out, box-shadow .15s ease-in-out; user-select: none; vertical-align: middle; white-space: nowrap; }
    .btn-primary { background-color: #36821B; border-color: #36821B; color: #fff; }
    .btn-block { display: block; width: 100%; }
    .alert { position: relative; padding: .75rem; margin-bottom: 1rem; border: 1px solid transparent; border-radius: .25rem; margin-top: 0.5rem; }
    .alert-success { color: #155724; background-color: #d4edda; border-color: #c3e6cb; }
    .alert-danger { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }

    .FormatFlatLang { display: inline-block; }
      .FormatFlatLang a { display: inline-block; }
      .FormatFlatLang img { width: 28px; height: 20px; opacity: 0.3; box-shadow: 1px 1px 1px rgba(0,0,0,0.8); }
        .FormatFlatLang img.imgFlagCurrent { opacity: 1; }
        .FormatFlatLang img:hover { opacity: 1; }

    .login-text { line-height: 1.5; padding-top: 1rem; }
      .login-text h1 { font-size: 16px; margin-top: 0; padding-top: 0; }

    @media(max-width:767px) {
      .col-left,
      .col-right { width: 100%; bottom: auto; top: auto; left: auto; right: auto; position: relative; }
      .col-right { height: 100vh; min-height: 500px; }
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="col-left">
      <div class="login-form-body">
        <div class="login-logo form-group tac">
          <img src="http://ioffice.tatthanh.com.vn/themes/admin/assets/css/images/menu-left-logo.png" alt="Tất Thành" style="max-width: 100%" />
        </div>
        <div class="login-form">
          <div class="form-group">
            <label for="tbAccountName">Tên đăng nhập</label>
            <asp:TextBox ID="tbAccountName" ClientIDMode="Static" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
              ErrorMessage="<p>Vui lòng điền tên đăng nhập</p>" ControlToValidate="tbAccountName"
              Display="Dynamic" SetFocusOnError="True">
            </asp:RequiredFieldValidator>
          </div>
          <div class="form-group">
            <label for="tbPassword">Mật khẩu</label>
            <asp:TextBox ID="tbPassword" ClientIDMode="Static" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
              ErrorMessage="<p>Vui lòng điền mật khẩu</p>" ControlToValidate="tbPassword"
              Display="Dynamic" SetFocusOnError="True">
            </asp:RequiredFieldValidator>
          </div>
          <div class="form-group">
            <asp:Button ID="btLogin" runat="server" Text="Đăng nhập" ToolTip="Click để đăng nhập vào hệ thống" OnClick="btLogin_Click" CssClass="btn btn-primary btn-block" />
            <asp:Literal ID="ltrLoginResult" runat="server"></asp:Literal>
          </div>
          <style>.FormatFlatLang img{height:28px}</style>
          <div class="form-group">
            <div class="pdFlatLang tac">
              <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
                <ItemTemplate>
                  <div class="FormatFlatLang">
                    <asp:LinkButton ID="lbtSelectLanguage" runat="server" CommandName="select" CommandArgument='<%#Eval("iLanguageNationalId").ToString()%>' ToolTip="Click vào để chọn ngôn ngữ này" CausesValidation="false">                
                                        <%#TatThanhJsc.Extension.ImagesExtension.GetImage(TatThanhJsc.LanguageModul.FolderPic.Language, Eval("nLanguageNationalFlag").ToString(), Eval(TatThanhJsc.Columns.LanguageNationalColumns.nLanguageNationalName).ToString(), "imgFlag" + SetCurrentLanguage(Eval(TatThanhJsc.Columns.LanguageNationalColumns.iLanguageNationalId).ToString()), false, false, "")%>
                    </asp:LinkButton>
                  </div>
                </ItemTemplate>
              </asp:Repeater>
              <div class="cbh0">
                <!---->
              </div>
            </div>
          </div>
        </div>
        <div class="login-text">
          <h1>Hệ thống quản trị website</h1>
          <p>Quý khách đăng nhập bằng tên đăng nhập và mật khẩu được cung cấp khi đăng ký sử dụng dịch vụ tại Tất Thành.</p>
          <p>Sau khi đăng nhập quý khách có thể xem và quản lý các thông tin trên website của quý khách.</p>
          <p>Nếu quý khách cần hỗ trợ thêm vui lòng truy cập <a href="https://tatthanh.com.vn/" target="_blank">www.tatthanh.com.vn</a></p>
          <p>Trân trọng cảm ơn quý khách!</p>
        </div>
      </div>
    </div>
    <div class="col-right">
      <div id="ttiflogin"></div>
      <script type="text/javascript">
        window._ttiflogin ||
            function () {
              const s = document.createElement("script");
              s.type = "text/javascript";
              s.async = true;
              s.src = "http://vpdt.tatthanh.com.vn/iflogin.js";
              const fs = document.getElementsByTagName("script")[0];
              fs.parentNode.insertBefore(s, fs);
            }(window);
      </script>
    </div>
    <div class="cb"></div>
  </form>
</body>
</html>
