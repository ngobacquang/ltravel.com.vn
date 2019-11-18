<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Index.ascx.cs" Inherits="cms_admin_ModulMain_User_AdmIndex" %>
<%@ Import Namespace="TatThanhJsc"%>
<div id="PopUpInformationAccount">
    <asp:Panel ID="pnInfo" runat="server">    
    <div class="bdControl mhRightContent">
        <div class="bgTabControl"><div class="pl10">Thông tin tài khoản</div></div>
            <div class="pt10 pb10">                
            <div>
                <div class="ColText"><b>Tên tài khoản:</b> </div>
                <div class="ColValue"><asp:Literal ID="ltrTaiKhoan" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Họ và tên:</b> </div>
                <div class="ColValue"><asp:Literal ID="ltrHoTen" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Địa chỉ:</b></div>
                <div class="ColValue"><asp:Literal ID="ltrDiaChi" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Số điện thoại:</b></div>
                <div class="ColValue"><asp:Literal ID="ltrDienThoai" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Thư điện tử:</b></div>
                <div class="ColValue"><asp:Literal ID="ltrEmail" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>                
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Ngày tạo tài khoản:</b></div>
                <div class="ColValue"><asp:Literal ID="ltrNgayTao" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Lần đăng nhập cuối cùng:</b></div>
                <div class="ColValue"><asp:Literal ID="ltrLanDangNhapCuoi" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Lần đăng xuất cuối cùng:</b></div>
                <div class="ColValue"><asp:Literal ID="ltrLanDangXuatCuoi" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>                
                <div class="pdSpaceRow"><div class="bgSpaceRow"><div class="h1"><!----></div></div></div>
                <div class="ColText"><b>Ghi chú thêm:</b></div>
                <div class="ColValue"><asp:Literal ID="ltrGhiChu" runat="server"></asp:Literal></div>
                <div class="cbh0"><!----></div>
            </div>            
            <div class='khungDoiMatKhauVaThongTin'>
                <asp:LinkButton ID="lbtChangePassword" runat="server" CausesValidation="false" ToolTip="Click để thay đổi mật khẩu"
                    onclick="lbtChangePassword_Click">Đổi mật khẩu</asp:LinkButton> | 
                <asp:LinkButton ID="lbtChangeInfo" runat="server" CausesValidation="false"  ToolTip="Click để thay đổi thông tin cơ bản"
                    onclick="lbtChangeInfo_Click">Thay đổi thông tin</asp:LinkButton>
            </div>
        </div>
    </div>
    </asp:Panel>
    <asp:Panel ID="pnChangePassword" runat="server" Visible="false">
       <div class="bdControl mhRightContent">
            <div class="bgTabControl"><div class="pl10">Thay đổi mật khẩu</div></div>
            <div class="pt40 pb10 pl10">
                <div>
                    <div class='cotTrai'>Mật khẩu cũ</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbMatKhauCu" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>
                <div>
                    <div class='cotTrai'>Mật khẩu mới</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbMatKhauMoi" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>
                <div>
                    <div class='cotTrai'>Nhập lại mật khẩu mới</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbNhapLaiMatKhauMoi" runat="server" CssClass="textbox" TextMode="Password" onchange="KiemTraNhapLaiMatKhau()"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>                
                <div class='pt40'>
                    <script type="text/javascript">
                        function KiemTraNhapLaiMatKhau() {
                            if (document.getElementById('<%=tbMatKhauMoi.ClientID %>').value != document.getElementById('<%=tbNhapLaiMatKhauMoi.ClientID %>').value) {
                                alert('Nhập lại mật khẩu không chính xác.');
                                return false;
                            }
                            else
                                return true;
                        }

                        function KiemTraDuLieuMatKhau() {
                            if (document.getElementById('<%=tbMatKhauCu.ClientID %>').value.length < 1) {
                                alert('Vui lòng nhập mật khẩu cũ');                                
                                return false;
                            }
                            if (document.getElementById('<%=tbMatKhauMoi.ClientID %>').value.length < 1) {
                                alert('Vui lòng nhập mật khẩu mới');
                                return false;
                            }
                            if (!KiemTraNhapLaiMatKhau()) {
                                return false;
                            }
                            return true;
                        }
                    </script>

                    <asp:Button ID="btOKChangePassword" runat="server" Text="Cập nhật" Width="120px" OnClientClick="return KiemTraDuLieuMatKhau()"
                        CausesValidation="false" onclick="btOKChangePassword_Click"/>
                    <asp:Button ID="btCancelChangePassword" runat="server" Text="Huỷ" Width="120px"
                        CausesValidation="false" onclick="btCancelChangePassword_Click"/>
                </div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnChangeInfo" runat="server" Visible="false">
       <div class="bdControl mhRightContent">
            <div class="bgTabControl"><div class="pl10">Thay đổi thông tin</div></div>
            <div class="pt40 pb10 pl10">
                <div>
                    <div class='cotTrai'>Họ</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbHo" runat="server" CssClass="textbox"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>
                <div>
                    <div class='cotTrai'>Tên</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbTen" runat="server" CssClass="textbox"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>
                <div>
                    <div class='cotTrai'>Điện thoại</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbDienThoai" runat="server" CssClass="textbox"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>
                <div>
                    <div class='cotTrai'>Số CMND</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbSoCMND" runat="server" CssClass="textbox"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>
                <div>
                    <div class='cotTrai'>Địa chỉ</div>
                    <div class='fl'>
                        <asp:TextBox ID="tbDiaChi" runat="server" CssClass="textbox"></asp:TextBox>
                    </div>
                    <div class='cbh8'><!----></div>
                </div>

                <div class='pt40'>
                    <asp:Button ID="btOKChangeInfo" runat="server" Text="Cập nhật" Width="120px"
                        CausesValidation="false" onclick="btOKChangeInfo_Click"/>
                    <asp:Button ID="btCancelChangeInfo" runat="server" Text="Huỷ" Width="120px"
                        CausesValidation="false" onclick="btCancelChangeInfo_Click"/>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div>
    </div>
</div>



