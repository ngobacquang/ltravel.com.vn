<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_Product_Item_ShortCutItem" %>
<%@ Import Namespace="Developer" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<%@ Register Src="../../../../api/Product/Item/Index.ascx" TagName="Index" TagPrefix="uc1" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
  <link href="~/cms/admin/Moduls/Product/Item/ShortCutItem/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:HiddenField ID="hdOldProduct" runat="server" Value="" />
<asp:HiddenField ID="HdTimeCreate" runat="server" Value="" />
<asp:HiddenField ID="HdIitotalview" runat="server" />
<asp:HiddenField ID="hd_img" runat="server" />

<asp:HiddenField ID="hdIgid" runat="server" Value="" />
<asp:HiddenField ID="hdigi_id" runat="server" Value="" />

<asp:HiddenField ID="hdThongTinThem" runat="server" />
<asp:HiddenField ID="hdEnable" runat="server" />
<asp:HiddenField ID="hdNgayXuatBan" runat="server" />
<asp:HiddenField ID="hdNguoiDangCu" runat="server" />

<div id="admscitem">
  <div class="cb h20">
    <!---->
  </div>
  <div class="text">
    <div class="pt8"><%=ProductKeyword.DanhMucCha%></div>
  </div>
  <div class="control">
    <asp:DropDownList ID="ddl_group_product" runat="server" Width="222px" AutoPostBack="True" OnSelectedIndexChanged="ddl_group_product_SelectedIndexChanged"></asp:DropDownList>
  </div>
  <div class="cbh8">
    <!---->
  </div>

  <asp:Panel ID="pnCacDanhMucKhac" runat="server">
    <div class="text">
      <div class="pt8">Các danh mục khác (<span id="CountOtherCate">-</span>)</div>
    </div>
    <div class="control">
      <div class="pt8">
        <a href="javascript:Toggle('Toogle_DanhMucKhac')">Click để ẩn/hiện các danh mục khác</a>
      </div>
      <div class="khungThuocTinh" id="Toogle_DanhMucKhac" style="max-height: 200px; overflow: auto">
        <asp:CheckBoxList ID="cbListCates" runat="server" onchange="CountOtherCate(this.id)">
        </asp:CheckBoxList>

        <script type="text/javascript">
          function CountOtherCate(id) {
            var count = jQuery("#" + id + " input[type=checkbox]:checked").length;;
            jQuery("#CountOtherCate").html(count);
          }

          CountOtherCate("<%=cbListCates.ClientID%>");
        </script>
      </div>
    </div>
    <div class="cbh8">
      <!---->
    </div>
  </asp:Panel>


  <div class="text">
    <div class="pt8"><%=ProductKeyword.TieuDe%></div>
  </div>
  <div class="control">
    <asp:TextBox ID="txt_title" runat="server" Width="600px" CssClass="tbTitle"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
      ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="txt_title"></asp:RequiredFieldValidator>
  </div>

  <div class="cbh8">
    <!---->
  </div>
  <div class="text">
    <div class="pt8"><%=ProductKeyword.Ma%></div>
  </div>
  <div class="control">
    <asp:TextBox ID="tbKey" runat="server" Width="600px"></asp:TextBox>
  </div>

  <div class="dn<%=(ProductConfig.KeyHienThiGiaChoSanPham)?"1":"" %>">
    <div class="cbh8">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=ProductKeyword.GiaNiemYet%></div>
    </div>
    <div class="control">
      <div>
        <asp:TextBox ID="tbPrice" runat="server" Width="400px" onkeyup="HienThiGia(this,'giaBan')" onblur="HideList('price')" onfocus="ShowList('price')"></asp:TextBox>
        <span style="font: bold 13px Arial" id="giaBan">
          <!---->
        </span>
      </div>
      <div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
          ErrorMessage="Vui lòng nhập giá kiểu số (vd:12 hoặc 12.5)" ControlToValidate="tbPrice" Display="Dynamic"
          SetFocusOnError="True" ValidationExpression="(\d)*(\.)?(\d)*"></asp:RegularExpressionValidator>
      </div>
    </div>

    <div class="cbh8">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=ProductKeyword.GiaBan%></div>
    </div>
    <div class="control">
      <div>
        <asp:TextBox ID="tbPriceOld" runat="server" Width="400px" onkeyup="HienThiGia(this,'giaNiemYet')" onblur="HideList('niemYet')" onfocus="ShowList('niemYet')"></asp:TextBox>
        <span style="font: bold 13px Arial" id="giaNiemYet">
          <!---->
        </span>
      </div>
      <div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
          ErrorMessage="Vui lòng nhập giá kiểu số (vd:12 hoặc 12.5)" ControlToValidate="tbPriceOld" Display="Dynamic"
          SetFocusOnError="True" ValidationExpression="(\d)*(\.)?(\d)*"></asp:RegularExpressionValidator>
      </div>
    </div>
    <script type="text/javascript">
      function HienThiGia(idTextBoxGia, idHienThi) {
        var gia = idTextBoxGia.value;
        gia = DinhDangGia(gia);
        document.getElementById(idHienThi).innerHTML = gia;
      }
      function DinhDangGia(number) {
        if (isNaN(number)) return "<span style='font:normal 12px Arial;color:red'>Giá nhập sai định dạng!</span>";
        var str = new String(number);

        var indexOfdot = str.indexOf(".", 0);
        var phanThapPhan;
        if (indexOfdot > -1) {
          phanThapPhan = "," + str.substring(indexOfdot + 1, len);
          str = str.substring(0, indexOfdot);
        }

        var result = "", len = str.length;
        for (var i = len - 1; i >= 0; i--) {
          if ((i + 1) % 3 == 0 && i + 1 != len) result += ".";
          result += str.charAt(len - 1 - i);
        }

        if (indexOfdot > -1)
          result += phanThapPhan;

        return result;
      }
    </script>
  </div>
  <div class="cbh8">
    <!---->
  </div>
  <div class="text">
    <div class="pt8"><%=ProductKeyword.MoTa%></div>
  </div>
  <div class="box">
    <asp:TextBox ID="txt_description" runat="server" Width="600px" Height="60px" CssClass="tbDesc" TextMode="MultiLine"></asp:TextBox>
  </div>
  <div class="cbh8">
    <!---->
  </div>
  <div class="text">
    <div class="pt8"><%=ProductKeyword.NgayDang%></div>
  </div>
  <div>
    <asp:TextBox ID="txtCreateDate" runat="server" Width="150px"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txtCreateDate"></asp:RequiredFieldValidator>
  </div>
  <div class="cbh8">
    <!---->
  </div>

  <div class="text">
    <div class="pt8"><%=ProductKeyword.ThuTu%></div>
  </div>
  <div class="control">
    <asp:TextBox ID="tbOrder" runat="server" Width="35px" Text="1"></asp:TextBox>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
      ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbOrder" Display="Dynamic"
      SetFocusOnError="True" ValidationExpression="(\d)*"></asp:RegularExpressionValidator>
  </div>

  <div class="cbh8">
    <!---->
  </div>
  <div class="cbh8">
    <!---->
  </div>
  <div style="float: left" class="text"><%=ProductKeyword.AnhDaiDien%></div>
  <div style="float: left; width: 600px">
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
        <asp:Literal ID="ltimg" runat="server" Visible="true"></asp:Literal>
      </div>
      <div>
        <asp:LinkButton ID="lnk_delete_Image_current" runat="server" Visible="false" OnClick="lnk_delete_Image_current_Click">Xóa hình ảnh hiện tại</asp:LinkButton>
      </div>
      <div>
        <asp:FileUpload ID="flimg" runat="server" Width="220px" />
      </div>
      <div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
          ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic"
          SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
      </div>
      <a class="ThietLapAnh" href="javascript:Toggle('Toogle_ThietLapAnhDaiDien')">Ẩn/Hiện thiết lập ảnh</a>
      <div class="pt8">
        <asp:CheckBox ID="cbLayAnhTuNoiDung" CssClass="flex-center" runat="server" Checked="True" Text="Lấy ảnh đầu tiên trong Chi tiết làm ảnh đại diện" />
      </div>
      <div id="Toogle_ThietLapAnhDaiDien">
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
  <div class="cbh8">
    <!---->
  </div>

  <div class="dn">
    <div class="text">
      <div class="pt8"><%=ProductKeyword.MoTaHinhAnh%></div>
    </div>
    <div class="box">
      <asp:TextBox ID="TbDescImg" runat="server" Width="600px"></asp:TextBox>
    </div>
    <div class="cbh10">
      <!---->
    </div>
  </div>

  <!--123-->
  <uc1:Index ID="Index1" runat="server" />
  <!--End 123-->

  <div class="cbh10">
    <!---->
  </div>
  <div>Thông số (chất liệu, màu sắc, kích thước...)</div>
  <div class="cbh10">
    <!---->
  </div>
  <div>
    <CKEditor:CKEditorControl ID="tbThongSo" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Product"></CKEditor:CKEditorControl>
  </div>
  <div class="cbh10">
    <!---->
  </div>

  <div class="cbh10">
    <!---->
  </div>
  <div><%=ProductKeyword.ChiTiet%></div>
  <div class="cbh10">
    <!---->
  </div>
  <div>
    <CKEditor:CKEditorControl ID="txt_content" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Product"></CKEditor:CKEditorControl>
  </div>
  <div class="cbh10">
    <!---->
  </div>

  <asp:Panel ID="pnAddNickHoTroTrucTuyen" runat="server">
    <div class="cbh8">
      <!---->
    </div>
    <div><%=Developer.ProductKeyword.NickHoTroChoSanPhamNay%></div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="ThuocTinhSanPham">
      <asp:Repeater ID="rptNicks" runat="server">
        <ItemTemplate>
          <div class='motMuc'>
            <asp:CheckBox ID="checkBoxNicks" runat="server" ToolTip='<%#Eval(TatThanhJsc.Columns.ItemsColumns.IidColumn).ToString() %>' />
            <%#Eval(TatThanhJsc.Columns.ItemsColumns.VititleColumn).ToString() %>
          </div>
        </ItemTemplate>
      </asp:Repeater>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <asp:Panel ID="pnThuocTinhSanPham" runat="server">
    <div class="cbh8">
      <!---->
    </div>
    <div><%=Developer.ProductKeyword.ThuocTinhSanPham%></div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="ThuocTinhSanPham">
      <asp:Repeater ID="rptProperties" runat="server">
        <ItemTemplate>
          <div class='motMuc'>
            <asp:CheckBox ID="checkBoxProperties" runat="server" ToolTip='<%#Eval(TatThanhJsc.Columns.GroupsColumns.IgidColumn).ToString() %>' />
            <%#Eval(TatThanhJsc.Columns.GroupsColumns.VgnameColumn).ToString() %>
          </div>
        </ItemTemplate>
      </asp:Repeater>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <asp:Panel ID="pnThuocTinhLoc" runat="server">
    <div class="cbh8">
      <!---->
    </div>
    <div><%=Developer.ProductKeyword.ChonThuocTinhLoc %></div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="ThuocTinhLocSanPham">
      <asp:Repeater ID="rptParentFilter" runat="server">
        <ItemTemplate>
          <div class='motThuocTinh'>
            <div class='tenThuocTinhCha'><%#Eval(TatThanhJsc.Columns.GroupsColumns.VgnameColumn).ToString() %></div>
            <div id="DanhSachThuocTinhLocSanPham">
              <asp:RadioButtonList ID="rdblAnswer" runat="server" DataSource='<%#GetSubFilter(Eval(TatThanhJsc.Columns.GroupsColumns.IgidColumn).ToString(),Eval(TatThanhJsc.Columns.GroupsColumns.VgparamsColumn).ToString(),"0") %>' DataTextField='<%#TatThanhJsc.Columns.GroupsColumns.VgnameColumn%>' DataValueField='<%#TatThanhJsc.Columns.GroupsColumns.IgidColumn %>'>
              </asp:RadioButtonList>
              <asp:CheckBoxList ID="cblAnswer" runat="server" DataSource='<%#GetSubFilter(Eval(TatThanhJsc.Columns.GroupsColumns.IgidColumn).ToString(),Eval(TatThanhJsc.Columns.GroupsColumns.VgparamsColumn).ToString(),"1") %>' DataTextField='<%#TatThanhJsc.Columns.GroupsColumns.VgnameColumn%>' DataValueField='<%#TatThanhJsc.Columns.GroupsColumns.IgidColumn %>'>
              </asp:CheckBoxList>
              <div class="cbh0">
                <!---->
              </div>
            </div>
            <div class="cbh0">
              <!---->
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>
      <div class="cbh0">
        <!---->
      </div>
    </div>
  </asp:Panel>
  <div class="cb h10">
    <!---->
  </div>

  <div class="KhungToiUu PdKhungToiUu">
    <div class="TextSeoLink"><%=ProductKeyword.ToiUuTimKiem%> </div>
    <div>
      <div class="text">
        <div class="pt8"><%=ProductKeyword.ToiUuTheTieuDe%> </div>
      </div>
      <div class="control1">
        <asp:TextBox ID="textTagTitle" runat="server" Width="400px" CssClass="tbTitle_seo"></asp:TextBox>
      </div>
      <div class="cbh8">
        <!---->
      </div>
      <div class="text">
        <div class="pt8"><%=ProductKeyword.ToiUuDuongDan%> </div>
      </div>
      <div class="control1">
        <asp:TextBox ID="textLinkRewrite" runat="server" Width="400px" CssClass="tbLink_seo"></asp:TextBox>
      </div>
      <div class="cbh8">
        <!---->
      </div>
      <div class="text">
        <div class="pt8"><%=ProductKeyword.ToiUuTheTuKhoa%> </div>
      </div>
      <div class="control1">
        <asp:TextBox ID="textTagKeyword" runat="server" Width="400px" CssClass="tbKeyword_seo"></asp:TextBox>
      </div>
      <div class="cbh8">
        <!---->
      </div>
      <div class="text">
        <div class="pt8"><%=ProductKeyword.ToiUuTheMoTa%> </div>
      </div>
      <div class="control1">
        <asp:TextBox ID="textTagDescription" runat="server" CssClass="tbDesc_Seo" Width="550px" Height="50px" TextMode="MultiLine"></asp:TextBox>
      </div>
      <div class="cbh8">
        <!---->
      </div>
      <div class="dn">
        <div class="text">
          <div class="pt8"><%=ProductKeyword.Tag%> </div>
        </div>
        <div class="control1">
          <asp:TextBox ID="TextBox1" runat="server" Width="550px" Height="50px" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="cbh8">
          <!---->
        </div>
      </div>
    </div>
  </div>
  <div class="cb h20">
    <!---->
  </div>
  <asp:Literal ID="ltrTrangThai" runat="server" />
  <asp:Panel ID="pnTichChonDeHienThi" runat="server">
    <div class="fl">
      <asp:CheckBox ID="chk_status" runat="server" CssClass="cccc fs11 flex-center" Text="(tích chọn để hiển thị)" Checked="true" />
    </div>
    <div class="cbh5">
      <!---->
    </div>
    <div class="text">
      <!---->
      &nbsp;
    </div>
  </asp:Panel>
  <div>
    <asp:CheckBox CssClass="fl flex-center" ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này" />
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="cbh20">
    <!---->
  </div>

  <div class="tac">
    <asp:Button ID="btn_insert_update" Width="120px" runat="server" OnClick="btn_insert_update_Click" Text="Đồng ý" />
    <asp:Button ID="btn_cancel" Width="80px" runat="server" Text="Hủy bỏ" OnClick="btn_cancel_Click" CausesValidation="false" />
  </div>
  <div class="cbh10">
    <!---->
  </div>
</div>
