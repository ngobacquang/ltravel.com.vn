<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortcutMember.ascx.cs" Inherits="cms_admin_Moduls_Member_List_Shortcut" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Member/List/ShortcutMember/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hdTenDangNhap" runat="server" />

<asp:HiddenField ID="hdvProperty" runat="server" />
<asp:HiddenField ID="hdvMemberYahooNick" runat="server" />
<asp:HiddenField ID="hdvMemberPasswordQuestion" runat="server" />
<asp:HiddenField ID="hdvMemberPasswordAnswer" runat="server" />
<asp:HiddenField ID="hdvMemberComment" runat="server" />
<asp:HiddenField ID="hdiMemberTotalLogin" runat="server" />
<asp:HiddenField ID="hdiMemberTotalview" runat="server" />

<div id="ShortcutMember">
    <div class="head">Thông tin đăng nhập</div>
    <div class="row">
        <div class="text">Tên đăng nhập</div>
        <div class="control">
            <asp:TextBox ID="tbTenDangNhap" runat="server" ></asp:TextBox>
            <div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ErrorMessage="Vui lòng nhập từ 3 - 30 ký tự chữ hoặc số" ControlToValidate="tbTenDangNhap" 
                    Display="Dynamic" SetFocusOnError="True" ValidationExpression="([A-Za-z0-9\._-]){3,30}"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ErrorMessage="Vui lòng nhập 3 - 30 ký tự chữ hoặc số" 
                    ControlToValidate="tbTenDangNhap" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>  
            </div>
        </div>
        <div class="cb"><!----></div>
    </div>
    <asp:Literal ID="ltrGhiChuMatKhau" runat="server"></asp:Literal>
    <div class="row">
        <div class="text">Mật khẩu</div>
        <div class="control">
            <asp:TextBox ID="tbMatKhau" runat="server" TextMode="Password" CssClass="medium"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbMatKhau" ErrorMessage="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Nhập lại mật khẩu</div>
        <div class="control">
            <asp:TextBox ID="tbNhapLaiMatKhau" runat="server" TextMode="Password" CssClass="medium"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbNhapLaiMatKhau" ErrorMessage="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            <div>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Nhật lại mật khẩu không trùng với Mật khẩu" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbNhapLaiMatKhau" ControlToCompare="tbMatKhau"></asp:CompareValidator> 
            </div>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Email</div>
        <div class="control">
            <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
            <div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="tbEmail" ErrorMessage="Email không đúng định dạng. Vui lòng nhập email dạng: emailcuaban@gmail.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="cb"><!----></div>
    </div>
    
    
    <div class="head">Thông tin cá nhân</div>
    <div class="row">
        <div class="text">Ảnh đại diện</div>
        <div style="float: left;width: 600px">
            <div class="khungThuocTinh psr">
                <asp:HiddenField ID="hd_img" runat="server" />    
                <%--Đóng dấu ảnh--%>
                <asp:HiddenField ID="hdLogoImage" runat="server" Value=""/>
                <asp:HiddenField ID="hdViTriDongDau" runat="server" Value=""/>
                <asp:HiddenField ID="hdLeX" runat="server" Value=""/>
                <asp:HiddenField ID="hdLeY" runat="server" Value=""/>
                <asp:HiddenField ID="hdTyLe" runat="server" Value=""/>
                <asp:HiddenField ID="hdTrongSuot" runat="server" Value=""/>
                <%--Đóng dấu ảnh - end --%>
                <div><asp:Literal ID="ltimg" runat="server" Visible="true"></asp:Literal></div>
                <div><asp:LinkButton ID="lnk_delete_Image_current" runat="server" Visible="false" onclick="lnk_delete_Image_current_Click">Xóa hình ảnh hiện tại</asp:LinkButton></div>
                <div><asp:FileUpload ID="flimg" runat="server" Width="220px" /></div>
                <div>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic" 
                        SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
                </div>    
                <a class="ThietLapAnh" href="javascript:Toggle('Toogle_ThietLapAnhDaiDien')">Ẩn/Hiện thiết lập ảnh</a>        
                <div id="Toogle_ThietLapAnhDaiDien" style="display:none"> <%--Đặt tên div bắt đầu bằng Toogle_ để được khởi tạo trạng thái ẩn hiện bằng js --%>
                    <div class="cb h10"><!----></div>
                    <asp:CheckBox ID="cbDongDauAnh" runat="server" Text="Đóng dấu ảnh"/>
                    <div class="cb h5"><!----></div>
                    <div class="fl">
                        <asp:CheckBox ID="cbHanCheKichThuoc" runat="server" Text="Hạn chế kích thước tối đa cho ảnh đại diện"/>
                        <div class="khungThuocTinh">
                            Rộng <asp:TextBox ID="tbHanCheW" runat="server" ToolTip="Chiều rộng lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                            Cao <asp:TextBox ID="tbHanCheH" runat="server" ToolTip="Chiều cao lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px
                        </div>
                    </div>
                    <div class="fr">
                        <asp:CheckBox ID="cbTaoAnhNho" runat="server" Text="Tạo ảnh nhỏ cho ảnh đại diện(thumbnails)"/>
                        <div class="khungThuocTinh">
                        Rộng <asp:TextBox ID="tbAnhNhoW" runat="server" ToolTip="Chiều rộng của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                        Cao <asp:TextBox ID="tbAnhNhoH" runat="server" ToolTip="Chiều cao của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px
                        </div>
                    </div>
                    <div class="cb"><!----></div>  
                </div>
            </div>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Họ tên</div>
        <div class="control">
            <asp:TextBox ID="tbHoTen" runat="server"></asp:TextBox>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Ngày sinh</div>
        <div class="control">
            <asp:TextBox ID="tbNgaySinh" runat="server" CssClass="medium"></asp:TextBox> (MM/dd/yyyy)
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Giới tính</div>
        <div class="control">
            <asp:DropDownList ID="ddlGioiTinh" runat="server">
                <asp:ListItem Text="Nam" Value="1"></asp:ListItem>
                <asp:ListItem Text="Nữ" Value="0"></asp:ListItem>
                <asp:ListItem Text="Chưa có thông tin" Value=""></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Địa chỉ</div>
        <div class="control">
            <asp:TextBox ID="tbDiaChi" runat="server" CssClass="large"></asp:TextBox>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Số điện thoại</div>
        <div class="control">
            <asp:TextBox ID="tbDienThoai" runat="server" CssClass="medium"></asp:TextBox>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Trình độ học vấn</div>
        <div class="control">
            <asp:TextBox ID="tbTrinhDoHocVan" runat="server"></asp:TextBox>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Nghề nghiệp</div>
        <div class="control">
            <asp:TextBox ID="tbNgheNghiep" runat="server"></asp:TextBox>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Quan hệ xã hội</div>
        <div class="control">
            <asp:TextBox ID="tbQuanHeXaHoi" runat="server"></asp:TextBox>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Chiều cao</div>
        <div class="control">
            <asp:TextBox ID="tbChieuCao" runat="server" CssClass="medium"></asp:TextBox> cm
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Cân nặng</div>
        <div class="control">
            <asp:TextBox ID="tbCanNang" runat="server" CssClass="medium"></asp:TextBox> kg
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Câu giới thiệu ngắn</div>
        <div class="control">
            <asp:TextBox ID="tbCauGioiThieuNgan" runat="server" CssClass="large"></asp:TextBox>
        </div>
        <div class="cb"><!----></div>
    </div>
    
    <div class="row">
        <div class="text">Kích hoạt</div>
        <div class="control">
            <asp:DropDownList ID="ddlKichHoat" runat="server">
                <asp:ListItem Text="Đã kích hoạt" Value="1"></asp:ListItem>
                <asp:ListItem Text="Chưa kích hoạt" Value="0"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="cb"><!----></div>
    </div>
    <div class="row">
        <div class="text">Trạng thái đăng nhập</div>
        <div class="control">
            <asp:DropDownList ID="ddlTrangThai" runat="server">
                <asp:ListItem Text="Cho phép đăng nhập" Value="1"></asp:ListItem>
                <asp:ListItem Text="Tạm khóa" Value="0"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="cb"><!----></div>
    </div>
    
    <div class="row">
        <div class="text">&nbsp;</div>
        <div class="control">
            <asp:CheckBox CssClass="fl" ID="cbTiepTuc" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
        </div>
        <div class="cb"><!----></div>
    </div>

    <div class="row pt10">
        <div class="text">&nbsp;</div>
        <div class="control">
            <asp:Button ID="btOK" runat="server" Text="Thêm mới" OnClick="btOK_Click" />
            <asp:Button ID="btCancel" runat="server" Text="Hủy" CausesValidation="False" OnClick="btCancel_Click"/>
        </div>
        <div class="cb h20"><!----></div>
    </div>
</div>
