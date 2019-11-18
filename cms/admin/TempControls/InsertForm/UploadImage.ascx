<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UploadImage.ascx.cs" Inherits="cms_admin_TempControls_InsertForm_UploadImage" %>
<div class="UploadImage">
  <asp:HiddenField ID="hdImage" runat="server" Value="" />
  <div class="row">
    <div class="text">
      <asp:Literal ID="ltrText" runat="server"></asp:Literal></div>
    <div class="control">
      <div class="khungThuocTinh psr">
        <%--Đóng dấu ảnh--%>
        <asp:HiddenField ID="hdLogoImage" runat="server" Value="" />
        <asp:HiddenField ID="hdViTriDongDau" runat="server" Value="" />
        <asp:HiddenField ID="hdLeX" runat="server" Value="" />
        <asp:HiddenField ID="hdLeY" runat="server" Value="" />
        <asp:HiddenField ID="hdTyLe" runat="server" Value="" />
        <asp:HiddenField ID="hdTrongSuot" runat="server" Value="" />
        <%--Đóng dấu ảnh - end --%>
        <div>
          <asp:Literal ID="ltimg" runat="server" Visible="true"></asp:Literal></div>
        <div>
          <asp:LinkButton ID="btnXoaAnhHienTai" runat="server" Visible="false" OnClick="btnXoaAnhHienTai_Click">Xóa hình ảnh hiện tại</asp:LinkButton></div>
        <div>
          <asp:FileUpload ID="flimg" runat="server" Width="220px" /></div>
        <div>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
            ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic"
            SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
        </div>
        <a class="ThietLapAnh" href="javascript://" onclick="$(this).parent().find('.Toogle_ThietLapAnhDaiDien').toggle()">Ẩn/Hiện thiết lập ảnh</a>
        <div class="pt5">
          <asp:CheckBox ID="cbLayAnhTuNoiDung" CssClass="flex-center" runat="server" Checked="True" Text="Lấy ảnh đầu tiên trong Chi tiết làm ảnh đại diện" />
        </div>
        <div class="Toogle_ThietLapAnhDaiDien" style="display: none">
          <%--Đặt tên div bắt đầu bằng Toogle_ để được khởi tạo trạng thái ẩn hiện bằng js --%>
          <div class="cb h5">
            <!---->
          </div>
          <asp:CheckBox ID="cbDongDauAnh" CssClass="flex-center" runat="server" Text="Đóng dấu ảnh" />
          <div class="cb h5">
            <!---->
          </div>
          <div class="fl">
            <asp:CheckBox ID="cbHanCheKichThuoc" CssClass="flex-center" runat="server" Text="Hạn chế kích thước tối đa cho ảnh đại diện" />
            <div class="khungThuocTinh">
              Rộng
              <asp:TextBox ID="tbHanCheW" Width="40" runat="server" ToolTip="Chiều rộng lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                        Cao
              <asp:TextBox ID="tbHanCheH" Width="40" runat="server" ToolTip="Chiều cao lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px
            </div>
          </div>
          <div class="fr">
            <asp:CheckBox ID="cbTaoAnhNho" CssClass="flex-center" runat="server" Text="Tạo ảnh nhỏ cho ảnh đại diện(thumbnails)" />
            <div class="khungThuocTinh">
              Rộng
              <asp:TextBox ID="tbAnhNhoW" Width="40" runat="server" ToolTip="Chiều rộng của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                    Cao
              <asp:TextBox ID="tbAnhNhoH" Width="40" runat="server" ToolTip="Chiều cao của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px
            </div>
          </div>
          <div class="cb">
            <!---->
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
