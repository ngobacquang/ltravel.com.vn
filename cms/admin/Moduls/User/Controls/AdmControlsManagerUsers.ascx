<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdmControlsManagerUsers.ascx.cs" Inherits="cms_admin_ModulMain_User_Controls_AdmControlsManagerUsers" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>

<%@ Import Namespace="TatThanhJsc" %>
<asp:HiddenField ID="hd_insert_update" runat="server" />
<asp:HiddenField ID="hd_userid" runat="server" />
<asp:HiddenField ID="HdRoldId" runat="server" />
<asp:HiddenField ID="HdTimeCreate" runat="server" />
<asp:HiddenField ID="HdUserLastLogindate" runat="server" />
<asp:HiddenField ID="HdLastPasswordChangedDate" runat="server" />
<asp:HiddenField ID="HdUserLastLockoutDate" runat="server" />

<div id="ManagerUser">
  <div class="PositionRightControl">
    <asp:Panel ID="pn_list_users" runat="server">
      <div class="BgUserTabTool">
        <div class="pdTool">

          <div>
            <asp:LinkButton ID="lnk_create_account" runat="server" OnClick="lnk_create_account_Click" CssClass="LinkCreate">Tạo mới</asp:LinkButton>
          </div>
          <div class="SpaceCol">|</div>
          <div>
            <asp:LinkButton CssClass="LinkDelete" ID="lnk_delete_user_checked" runat="server" OnClick="lnk_delete_user_checked_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa các bản ghi vừa chọn? Chú ý: không thể xoá tài khoản admin và tài khoản bạn đang đăng nhập.');">Xóa</asp:LinkButton>
          </div>
          <div class="cbh0">
            <!---->
          </div>
        </div>
      </div>
      <div class="cbh0">
        <!---->
      </div>
      <div class="BgTabTitle" align="center">
        <div class="FormatCheckBox">
          <asp:CheckBox ID="chk_list" runat="server" AutoPostBack="true" OnCheckedChanged="chk_list_CheckedChanged" />
        </div>
        <div class="fl">|</div>
        <div class="FormatTitle" align="left">Tên đăng nhập</div>
        <div class="fl">|</div>
        <div class="FormatDcreateDate">Ngày khởi tạo</div>
        <div class="fl">|</div>
        <div class="FormatTimeLogin">Đăng nhập cuối</div>
        <div class="fl">|</div>
        <div class="FormatTimeLogout">Thoát cuối</div>
        <div class="fl">|</div>
        <div class="FormatStatus">Trạng thái</div>
        <div class="fl">|</div>
        <div class="FormatTool">Công cụ</div>
        <div class="cbh0">
          <!---->
        </div>
      </div>
      <div class="BgContainContent" align="center">
        <asp:Repeater ID="rp_mn_users" runat="server" OnItemCommand="rp_mn_users_ItemCommand">
          <ItemTemplate>
            <div class="FormatCellItem">
              <div class="pdCellItem">
                <div class="FormatCheckBox">
                  <asp:CheckBox ID="chk_item" runat="server" ToolTip='<%#Eval("UserId") %>' />
                </div>
                <div class="FormatSpaceCol">|</div>
                <div class="FormatTitle" align="left"><%#Eval("UserName").ToString() %></div>
                <div class="FormatSpaceCol">|</div>
                <div class="FormatDcreateDate"><%#TimeExtension.FormatTime(Eval("UserCreateDate"),6)%></div>
                <div class="FormatSpaceCol">|</div>
                <div class="FormatTimeLogin"><%#TimeExtension.FormatTime(Eval("UserLastLogindate"),6)%></div>
                <div class="FormatSpaceCol">|</div>
                <div class="FormatTimeLogin"><%#TimeExtension.FormatTime(Eval("UserLastLogindate"),6)%></div>
                <div class="FormatSpaceCol">|</div>
                <div class="FormatStatus">
                  <asp:LinkButton ID="lnkEditStatus" runat="server" CssClass="tdn tlink" CommandName="EditEnable" CommandArgument='<%#Eval("UserId").ToString() %>'>
                                <div class='EnableIcon<%#Eval("UserIsApproved").ToString()%>'><!----></div>
                  </asp:LinkButton>
                </div>
                <div class="FormatSpaceCol">|</div>
                <div class="FormatIconTool">
                  <div class="fr pl10">
                    <asp:LinkButton ID="lnk_delete" runat="server" ToolTip="Xóa tài khoản đang chọn" CommandName="delete" CommandArgument='<%#Eval("UserId").ToString() %>' CssClass="Tool">
                                        <div class="ImageDeleteRecord">&nbsp;</div>
                    </asp:LinkButton>
                  </div>
                  <div class="fr pl10">
                    <asp:LinkButton ID="lnk_update" runat="server" ToolTip="Cập nhật tài khoản đang chọn" CommandName="edit" CommandArgument='<%#Eval("UserId").ToString() %>' CssClass="Tool">
                                        <div class="ImageEditRecord">&nbsp;</div>
                    </asp:LinkButton>
                  </div>
                  <div class="fr pl10">
                    <asp:LinkButton ID="lnkChnagePassword" runat="server" ToolTip="Đổi mật khẩu tài khoản đang chọn" CommandName="ChangePassword" CommandArgument='<%#Eval("UserId").ToString() %>' CssClass="Tool">
                                        <div class="UserBgIconChangePassword">&nbsp;</div>
                    </asp:LinkButton>
                  </div>
                  <div class="fr">
                    <a href="javascript:void(0)" onclick="NewWindow_('cms/admin/Moduls/User/PopUp/InformationAccount.aspx?iuserid=<%#Eval("UserId")%>','ImageList','800','450','yes','yes')" class="tool" title="Xem thông tin chi tiết của tài khoản đang chọn">
                      <div class="UserBgIconInformation">&nbsp;</div>
                    </a>
                  </div>
                </div>
                <div class="cbh0">
                  <!---->
                </div>
              </div>
            </div>
          </ItemTemplate>
          <SeparatorTemplate>
            <div class="pdSpaceItem">
              <div class="SpaceItem">
                <!---->
              </div>
            </div>
          </SeparatorTemplate>
        </asp:Repeater>
      </div>
    </asp:Panel>
    <asp:Panel ID="pn_insert_update" runat="server" Visible="false">
      <style>.ColText { width: 110px!important; padding-bottom: 5px!important } .cRed { position: relative; right: -2px; top: -2px }</style>
      <div id="CreateUser">
        <div class="BgTabTitle">
          <div class="pl10">Thêm mới tài khoản</div>
        </div>
        <div class="pdControl">
          <asp:Literal ID="ltMes" runat="server"></asp:Literal>
          <!--Thông tin tài khoản-->
          <div class="Col1">
            <div class="TextInformationAcount">Thông tin tài khoản</div>
            <div class="ColText">
              <div class="pt5">Tên tài khoản</div>
            </div>
            <div class="fl">
              <div>
                <asp:TextBox ID="txt_UserName" runat="server" Width="250px" CssClass="textbox"></asp:TextBox><span class="cRed"> (*)</span>
              </div>
              <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                  ErrorMessage="Không được để trống" ControlToValidate="txt_UserName"
                  Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="pt5">Mật khẩu</div>
            </div>
            <div class="fl">
              <div>
                <asp:Literal ID="ltPw1" runat="server"></asp:Literal>
                <asp:TextBox ID="txt_password" runat="server" TextMode="Password" Width="250px" CssClass="textbox"></asp:TextBox><span class="cRed"> (*)</span>
              </div>
              <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                  ErrorMessage="Không được để trống" ControlToValidate="txt_password"
                  Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="pt5">Nhập lại mật khẩu</div>
            </div>
            <div class="fl">
              <div>
                <asp:Literal ID="ltRpPw1" runat="server"></asp:Literal>
                <asp:TextBox ID="txt_repeat_password" runat="server" TextMode="Password" Width="250px" CssClass="textbox"></asp:TextBox><span class="cRed"> (*)</span>
              </div>
              <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                  ErrorMessage="Không được để trống" ControlToValidate="txt_password"
                  Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server"
                  ErrorMessage="Nhập lại mật khẩu không đúng" ControlToCompare="txt_password"
                  ControlToValidate="txt_repeat_password" Display="Dynamic"
                  SetFocusOnError="True"></asp:CompareValidator>
              </div>
            </div>
            <div class="cbh15">
              <!---->
            </div>
            <asp:PlaceHolder ID="plDuyetTin" Visible="false" runat="server">
              <div class="cbh12">
              <!---->
              </div>
              <div class="TextInformationAcount">Phân quyền duyệt tin</div>
              <div class="ColdRole" style="margin-left: -3px">
                <asp:CheckBoxList ID="cblDuyetTin" ClientIDMode="Static" CssClass="table-center" runat="server"></asp:CheckBoxList>
              </div>
            </asp:PlaceHolder>
            <div class="cbh15">
              <!---->
            </div>
            <div class="TextInformationAcount">Phân quyền quản trị</div>
            <div class="cbh8">
              <!---->
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>
                <div>
                  <asp:CheckBox Font-Bold="true" ID="cbCheckAll" runat="server" CssClass="flex-center"
                    Text="Chọn/bỏ chọn tất cả" AutoPostBack="true"
                    OnCheckedChanged="cbCheckAll_CheckedChanged" />
                </div>
                <div class="cbh3">
                  <!---->
                </div>
                <style>
                  .cttable { width: 310px!important; margin-left: -1px }
                  .cttable table, .cttable tbody { width: 100%; display: flex; flex-wrap: wrap }
                  .cttable tr { width: 50% }
                </style>
                <div class="ColdRole cttable">
                  <asp:CheckBoxList ID="cblRole" CssClass="table-center" runat="server">
                  </asp:CheckBoxList>
                </div>                         
              </ContentTemplate>
            </asp:UpdatePanel>
            <div class="cbh20"></div>
          </div>
          <!--Thông tin cá nhân-->
          <div class="Col2">
            <div class="TextInformationAcount">Thông tin cá nhân</div>
            <div class="h10"></div>
            <div class="ColText">
              <div class="">Họ</div>
            </div>
            <div class="fl w190">
              <div>
                <asp:TextBox ID="txt_fname" runat="server" Width="250px" CssClass="textbox"></asp:TextBox><span class="cRed"> (*)</span>
              </div>
              <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                  ErrorMessage="Không được để trống" ControlToValidate="txt_fname"
                  Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="">Tên</div>
            </div>
            <div class="fl">
              <div>
                <asp:TextBox ID="txt_lname" runat="server" Width="250px" CssClass="textbox"></asp:TextBox><span class="cRed"> (*)</span>
              </div>
              <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                  ErrorMessage="Không được để trống" ControlToValidate="txt_lname"
                  Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
              </div>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="">Điện thoại</div>
            </div>
            <div class="fl">
              <asp:TextBox ID="txt_phone" runat="server" Width="250px" CssClass="textbox"></asp:TextBox>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="">Email</div>
            </div>
            <div class="fl">
              <div>
                <asp:TextBox ID="txt_email" runat="server" Width="250px" CssClass="textbox">hotro@tatthanh.com.vn</asp:TextBox><span class="cRed"> (*)</span>
              </div>
              <div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                  ErrorMessage="Không được để trống. " ControlToValidate="txt_email"
                  Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                  ErrorMessage="Email không hợp lệ" ControlToValidate="txt_email"
                  Display="Dynamic" SetFocusOnError="True"
                  ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
              </div>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="">Số CMND</div>
            </div>
            <div class="fl">
              <asp:TextBox ID="txt_identitycard" runat="server" Width="250px" CssClass="textbox"></asp:TextBox>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="">Địa chỉ</div>
            </div>
            <div class="fl">
              <asp:TextBox ID="txt_address" runat="server" Width="250px" CssClass="textbox"></asp:TextBox>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="">Tình trạng tài khoản</div>
            </div>
            <div>
              <asp:DropDownList ID="ddl_approved" runat="server" Width="250px" CssClass="textbox">
                <asp:ListItem Value="1">Đang hoạt động</asp:ListItem>
                <asp:ListItem Value="0">Đang bị khoá</asp:ListItem>
              </asp:DropDownList>
            </div>
            <div class="cbh8">
              <!---->
            </div>
            <div class="ColText">
              <div class="">Ghi chú thêm</div>
            </div>
            <div>
              <asp:TextBox ID="txt_comment" runat="server" Width="250px" TextMode="MultiLine" Height="120px" CssClass="textbox"></asp:TextBox>
            </div>
            <div class="cbh20"></div>
            <div class="pdButton" style="padding-left: 114px; padding-top: 0">
              <asp:Button ID="btn_insert_update" runat="server" OnClick="btn_insert_update_Click" Width="120px" />
              <asp:Button ID="btn_cancel" runat="server" CausesValidation="false" Text="Hủy bỏ" OnClick="btn_cancel_Click" Width="120px" />
            </div>
          </div>
          <div class="cb h0">
            <!---->
          </div>
        </div>
      </div>
    </asp:Panel>

    <asp:Panel ID="pnChangePassword" runat="server" Visible="false">
      <div id="ChangePassword">
        <div class="BgTabTitle">
          <div class="pl10">
            <asp:Literal ID="ltChangePassword" runat="server"></asp:Literal>
          </div>
        </div>
        <div class="pdControl">
          <asp:Literal ID="ltMesWhenChangePassword" runat="server"></asp:Literal>
          <asp:Panel ID="pnMatKhauCu" runat="server">
            <div class="ColText">
              <div>Mật khẩu cấp 1 cũ</div>
            </div>
            <div class="pt3">
              <asp:TextBox ID="tbChangeOldPassword" runat="server" TextMode="Password" Width="250px" CssClass="textbox"></asp:TextBox>
            </div>
            <div class="cbh8">
              <!---->
            </div>
          </asp:Panel>
          <div class="ColText">
            <div>Mật khẩu cấp 1 mới</div>
          </div>
          <div class="pt3">
            <asp:TextBox ID="tbChangeNewPassword" runat="server" TextMode="Password" Width="250px" CssClass="textbox"></asp:TextBox>
          </div>
          <div class="cbh8">
            <!---->
          </div>
          <div class="ColText">
            <div>Nhập lại mật khẩu</div>
          </div>
          <div class="pt3">
            <asp:TextBox ID="tbChangeRepeatNewPassword" runat="server" TextMode="Password" onchange="KiemTraNhapLaiMatKhau()" Width="250px" CssClass="textbox"></asp:TextBox>
          </div>
          <div class="cbh8">
            <!---->
          </div>
          <div class="pdButton">
            <script type="text/javascript">
              function KiemTraNhapLaiMatKhau() {
                if (document.getElementById('<%=tbChangeNewPassword.ClientID %>').value != document.getElementById('<%=tbChangeRepeatNewPassword.ClientID %>').value) {
                  alert('Nhập lại mật khẩu không chính xác.');
                  return false;
                }
                else
                  return true;
              }

              function KiemTraDuLieuMatKhau() {
                if (document.getElementById('<%=tbChangeNewPassword.ClientID %>').value.length < 1) {
                  alert('Vui lòng nhập mật khẩu mới');
                  return false;
                }
                if (!KiemTraNhapLaiMatKhau()) {
                  return false;
                }
                return true;
              }
            </script>

            <asp:Button ID="btnChangePassword" runat="server" Text="Đổi mật khẩu" CausesValidation="false" OnClick="btnChangePassword_Click" Width="120px" OnClientClick="return KiemTraDuLieuMatKhau()" />
            <asp:Button ID="btnBack" runat="server" Text="Hủy bỏ" CausesValidation="false" OnClick="btnBack_Click" Width="120px" />
          </div>
        </div>
      </div>
    </asp:Panel>
  </div>
</div>

<script>
  $("#cblDuyetTin input").click(function () {
    $("#cblDuyetTin input").prop("checked", false)
    $(this).prop("checked", true)
  })
</script>
