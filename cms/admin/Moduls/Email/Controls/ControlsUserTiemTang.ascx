<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlsUserTiemTang.ascx.cs" Inherits="cms_admin_ModulMain_Email_Controls_AdmControlsUserTiemTang" %>
<%@ Import Namespace="TatThanhJsc.Columns" %>
<%@ Import Namespace="TatThanhJsc.Extension" %>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
  <ContentTemplate>
    <asp:HiddenField ID="hd_modulid" runat="server" />
    <asp:HiddenField ID="hd_parent" runat="server" />
    <div id="ProductAdmControlsCategory">
      <div class="PositionRightControl">
        <div class="BgTabTool">
          <div class="pdTool">
            <div>
              <asp:LinkButton CssClass="LinkDelete" ID="lnk_delete_user_checked" runat="server" OnClick="lnk_delete_user_checked_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xoá các tài khoản này?');">Xóa các tài khoản đang chọn</asp:LinkButton>
            </div>
            <div class="FormatTextBox">
              <div class="cb h4">
                <!---->
              </div>
              <asp:TextBox ID="txtKeySearch" runat="server"
                Width="250px" Height="22px" CssClass="TextInBox"
                onclick="if(this.value=='Nhập địa chỉ email cần tìm') this.value=''"
                onblur="if(this.value.length<1) this.value='Nhập địa chỉ email cần tìm'"
                AutoPostBack="True" OnTextChanged="txtKeySearch_TextChanged">Nhập địa chỉ email cần tìm</asp:TextBox>
            </div>
            <div class="cbh0">
              <!---->
            </div>
          </div>
        </div>
        <div class="cbh0">
          <!---->
        </div>
        <div class="BgTabTitle box-post" align="center">
          <div class="FormatCheckBox" align="center">
            <asp:CheckBox ID="chk_list" runat="server" AutoPostBack="true" OnCheckedChanged="chk_list_CheckedChanged" /></div>
          <div class="SplitBar">|</div>
          <div class="FormatTitle cot2" align="left">
            <asp:LinkButton ID="lbtName" runat="server" OnClick="lbtName_Click" CssClass="arrowSort" ToolTip="Click để sắp xếp danh sách theo trường này">Địa chỉ Email</asp:LinkButton>
          </div>
          <div class="SplitBar">|</div>
          <div class="FormatTitle cot3" style="min-width: 250px" align="left">
            Ngày đăng ký
          </div>
          <div class="SplitBar">|</div>
          <div class="FormatOnTabCollumTool cot7" align="center" style="padding-right: 0!important">Công cụ</div>
          <div class="cbh0">
            <!---->
          </div>
        </div>
        <div class="BgContainContent" align="center">
          <asp:Repeater ID="rp_mn_users" runat="server" OnItemCommand="rp_mn_users_ItemCommand">
            <ItemTemplate>
              <div class="FormatCellItem">
                <div class="pdCellItem box-post">
                  <div class="FormatCheckBox box-cb">
                    <asp:CheckBox ID="chk_item" runat="server" ToolTip='<%#Eval("IMID")%>' /></div>
                  <div class="SplitBar">|</div>
                  <div class="FormatTitle cot2" align="left">
                    <%#Eval(MembersColumns.VmemberaccountColumn).ToString()%>
                  </div>
                  <div class="SplitBar">|</div>
                  <div class="FormatTitle cot3" style="min-width: 250px" align="left">
                    <%#TimeExtension.FormatTime(Eval(MembersColumns.DmembercreatedateColumn),6)%><br />
                  </div>
                  <div class="SplitBar">|</div>
                  <div class="cot7" align="center">
                    <div>
                      <asp:LinkButton ID="LnkDel" runat="server" CommandName="delete" CommandArgument='<%#Eval("IMID").ToString() %>' OnClientClick="return confirm('Bạn có chắc chắn muốn xoá tài khoản vừa chọn?');" ToolTip="Click vào để xóa tài khoản này"><div class='iconDelete'><!----></div></asp:LinkButton></div>
                    <div class="IconTool">
                      <asp:LinkButton ID="lbtDoiMatKhau" runat="server" CommandName="editPassword" CommandArgument='<%#Eval("IMID").ToString() %>' ToolTip="Click vào để đổi mật khẩu cho tài khoản này"><div class='iconChangePassword'><!----></div></asp:LinkButton></div>
                    <div class="cbh0">
                      <!---->
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
      </div>
      <div id="FormatFooterRightControl">
        <div class="ColShowItem">
          <div class="TextShow">Hiển thị</div>
          <div class="BoxShow">
            <asp:DropDownList ID="DdlListShowItem" runat="server" Width="50px" Height="19px" CssClass="TextInBox" OnSelectedIndexChanged="DdlListShowItem_SelectedIndexChanged" AutoPostBack="true">
              <asp:ListItem Value="10">10</asp:ListItem>
              <asp:ListItem Value="20">20</asp:ListItem>
              <asp:ListItem Value="30">30</asp:ListItem>
              <asp:ListItem Value="50">50</asp:ListItem>
              <asp:ListItem Value="100">100</asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="cbh0">
            <!---->
          </div>
        </div>
        <div class="ColPagging">
          <div id="AdminPagging">
            <asp:Literal ID="LtPagging" runat="server"></asp:Literal></div>
        </div>
        <div class="cbh0">
          <!---->
        </div>
      </div>
    </div>
  </ContentTemplate>
</asp:UpdatePanel>
