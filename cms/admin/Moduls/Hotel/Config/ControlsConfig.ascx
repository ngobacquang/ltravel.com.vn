<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlsConfig.ascx.cs" Inherits="cms_admin_Hotel_Controls_AdmControlsConfiguration" %>
<%@ Import Namespace="Developer" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<div id="ControlsConfig">    
    <div class="fwb pb10">Cấu hình số lượng</div>
    <div class="cb h20"><!----></div>
    <div class="smalltextbox">
        <div class="fl pl20 pt3">Số <%= HotelKeyword.Hotel2 %> trên trang chủ:</div>
        <div class="fl pl10">
            <asp:TextBox ID="tbSoHotelTrenTrangChu" Height="22" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server"
                                            ErrorMessage="Vui lòng số tự nhiên(vd: 6)" ControlToValidate="tbSoHotelTrenTrangChu"
                                            Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*">
            </asp:RegularExpressionValidator>
        </div>
        <div class="cb h10"><!----></div>
        <div class="fl pl20 pt3">Số <%= HotelKeyword.Hotel2 %> trên trang danh mục:</div>
        <div class="fl pl10">
            <asp:TextBox ID="tbSoHotelTrenTrangDanhMuc" Height="22" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server"
                                            ErrorMessage="Vui lòng số tự nhiên(vd: 6)" ControlToValidate="tbSoHotelTrenTrangDanhMuc"
                                            Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*">
            </asp:RegularExpressionValidator>
        </div>
        <div class="cb h10"><!----></div>
        <div class="fl pl20 pt3">Số <%= HotelKeyword.Hotel2 %> khác trên một trang:</div>
        <div class="fl pl10">
            <asp:TextBox ID="tbSoHotelKhacTrenMotTrang" Height="22" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server"
                                            ErrorMessage="Vui lòng số tự nhiên(vd: 6)" ControlToValidate="tbSoHotelKhacTrenMotTrang"
                                            Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*">
            </asp:RegularExpressionValidator>
        </div>
    </div>

    <div class="cb h20"><!----></div>
    <div class="fwb pb10">Cấu hình hình ảnh</div>
    <div class="pl20 smalltextbox">
        <asp:CheckBox ID="cbDongDauAnh" runat="server" Text="Đóng dấu ảnh"/>
        <div class="khungThuocTinh">
            <div class="cot1 pb5">Ảnh làm dấu:</div>
            <div class="cot2">
                <div>
                    <asp:Literal ID="ltrWatermarkLogo" runat="server"></asp:Literal>
                    <asp:HiddenField ID="hdWatermarkLogo" runat="server" Value=""/>
                </div>
                <div>
                    <asp:FileUpload ID="fulDongDauAnh" runat="server"/> (Nên chọn ảnh .png hoặc .gif kích thước nhỏ vừa phải)
                </div>
            </div>
            <div class="cb h5"><!----></div>
            <div class="cot1 pt5">Vị trí dấu:</div>
            <div class="fl">
                <asp:RadioButtonList ID="rbViTriDongDau" CssClass="table-center" runat="server">
                    <asp:ListItem Text="Giữa ảnh" Value="0"></asp:ListItem>
                    <asp:ListItem Text="Góc trên-trái" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Góc trên-phải" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Góc dưới-trái" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Góc dưới-phải" Value="4" Selected="True"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="cb h5"><!----></div>
            <div class="cot1 pt5">Cách lề:</div>
            <div class="fl">
                <asp:TextBox ID="tbLeX" runat="server" ToolTip="Khoảng cách từ lề ngang tới ảnh con dấu"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="tbLeY" runat="server" ToolTip="Khoảng cách từ lề dọc tới ảnh con dấu"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;(Lề ngang - dọc)
            </div>
            <div class="cb h5"><!----></div>
            <div class="cot1 pt5">Tỷ lệ dấu/ảnh(%)</div>
            <div class="fl">
                <asp:TextBox ID="tbPhanTram" runat="server" ToolTip="Ảnh con dấu sẽ giãn theo tỷ lệ với ảnh nền nhưng không vượt quá kích thước thật của nó"></asp:TextBox> (Bỏ trống nếu muốn giữ nguyên kích thước ảnh dấu)
            </div>
            <div class="dn">
                <div class="cb h5"><!----></div>
                <div class="cot1">Độ trong suốt(%)</div>
                <div class="fl">
                    <asp:TextBox ID="tbTrongSuot" runat="server" ToolTip="Nhập giá trị từ 0 đến 100"></asp:TextBox>
                </div>
            </div>
            <div class="cb h5"><!----></div>
        </div>
        <div class="cb h10"><!----></div>

        <asp:CheckBox ID="cbHanCheKichThuoc" CssClass="flex-center" runat="server" Text="Hạn chế kích thước tối đa cho ảnh đại diện"/>
        <div class="khungThuocTinh">
            Rộng <asp:TextBox ID="tbHanCheW" runat="server" ToolTip="Chiều rộng lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
            Cao <asp:TextBox ID="tbHanCheH" runat="server" ToolTip="Chiều cao lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px
        </div>

        <div class="cb h10"><!----></div>
        <asp:CheckBox ID="cbTaoAnhNho" CssClass="flex-center" runat="server" Text="Tạo ảnh nhỏ cho ảnh đại diện(thumbnails)"/>
        <div class="khungThuocTinh">
            Rộng <asp:TextBox ID="tbAnhNhoW" runat="server" ToolTip="Chiều rộng của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
            Cao <asp:TextBox ID="tbAnhNhoH" runat="server" ToolTip="Chiều cao của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px
        </div>
    </div>

   <div class="cbh20">
    <!---->
  </div>
  <div class="fwb pb10">Cấu hình nội dung</div>
  <div class="pl20">Nội dung cuối trang danh sách:</div>
  <div class="pl20 pt5">
    <CKEditor:CKEditorControl ID="tbNoiDungCuoiTrangDanhSach" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/tour" Height="250px"></CKEditor:CKEditorControl>
  </div>
  <div class="cb h20">
    <!---->
  </div>
  <div class="pl20">Thông báo sau khi đặt phòng thành công:</div>
  <div class="pl20 pt5">
    <CKEditor:CKEditorControl ID="tbThongBaoDatPhongThanhCong" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/tour" Height="250px"></CKEditor:CKEditorControl>
  </div>
  <div class="cb h20">
    <!---->
  </div>

  <div class="cb h20"><!----></div>
        <div class="tac">
            <asp:Button ID="btSave" runat="server" onclick="btSave_Click" Width="120px" Text="Đồng ý" OnClientClick=" return CheckInput() "/>
        </div>
        <div class="cb h10"><!----></div>

  <div class="dn">
    <div class="cb h20"><!----></div>
    <div class="fwb pb10">Cấu hình tối ưu seo cho trang chính của modul</div>
    <div class="pl20 InsertPanel">
        <div class="row">
            <div class="text">Tên modul</div>
            <div class="control">
                <asp:TextBox ID="tbTitle" CssClass="tbTitle" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text">Mô tả modul</div>
            <div class="control">
                <asp:TextBox ID="tbDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
            </div>
        </div>

        <div class="row">
            <div class="text">Thẻ tiêu đề (title)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoTitle" CssClass="tbTitle_seo" runat="server"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text">Đường dẫn (url)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoUrl" runat="server" CssClass="tbLink_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text">Từ khóa (meta keyword)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text">Mô tả (meta description)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc_Seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text">Ảnh khi share (image)</div>
            <div class="control">
                <div class="khungThuocTinh psr">                    
                    <asp:HiddenField ID="hdShareImage" runat="server" Value=""/>       
                    <div>
                        <asp:Literal ID="ltrShareImage" runat="server" Visible="true"></asp:Literal>
                    </div>
                    <div>
                        <asp:LinkButton ID="btnXoaAnhHienTai" runat="server" Visible="false" CssClass="iconDelete pl20 pt10 pb10" onclick="btnXoaAnhHienTai_Click">Xóa hình ảnh hiện tại</asp:LinkButton>
                    </div>
                    <div>
                        <asp:FileUpload ID="flShareImage" runat="server" Width="220px"/>
                    </div>
                    <div>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                        ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flShareImage" Display="Dynamic"
                                                        SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)">
                        </asp:RegularExpressionValidator>
                    </div>                   
                </div>
            </div>
        </div>

        
    </div>
  </div>
</div>