<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_Advertising_Item_ShortCutItem" %>
<%@ Import Namespace="Developer" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
  <link href="~/cms/admin/Moduls/Advertising/Item/ShortCutItem/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<asp:HiddenField ID="hdThongTinThem" runat="server" />
<asp:HiddenField ID="hdEnable" runat="server" />
<asp:HiddenField ID="hdNgayXuatBan" runat="server" />
<asp:HiddenField ID="hdNguoiDangCu" runat="server" />

<div id="admscitem">
  <div class="TxtInsertUpdate">
    <asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
  <div class="pdControl">
    <asp:HiddenField ID="hdImg" runat="server" />
    <asp:HiddenField ID="hdImg2" runat="server" />
    <div class="cb h20">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=AdvertisingKeyword.NhomBaiViet%></div>
    </div>
    <div class="control">
      <asp:DropDownList ID="ddl_group_product" runat="server" Width="280px"></asp:DropDownList>
    </div>
    <div class="cbh8">
      <!---->
    </div>

    <div class="text">
      <div class="pt8"><%=AdvertisingKeyword.TieuDeBaiViet%></div>
    </div>
    <div class="control">
      <asp:TextBox ID="txt_title" runat="server" Width="600px" CssClass="tbTitle"></asp:TextBox>
    </div>
    <div class="cbh8">
      <!---->
    </div>

    <div class="text">
      <div class="pt8"><%=AdvertisingKeyword.MoTa%></div>
    </div>
    <div class="control">
      <asp:TextBox ID="TbDesc" runat="server" Width="600px" Height="50px" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
    </div>
    <div class="cbh8">
      <!---->
    </div>

    <div class="text">
      <div class="pt8"><%=AdvertisingKeyword.LinkQuangCaoDanToi%></div>
    </div>
    <div class="control">
      <asp:TextBox ID="txt_link_adv" runat="server" Width="600px"></asp:TextBox>
    </div>
    <div class="cbh8">
      <!---->
    </div>

    <div class="dn">
      <div class="text">
        <div class="pt8"><%=AdvertisingKeyword.ChieuRong%></div>
      </div>
      <div class="control">
        <asp:TextBox ID="txt_width_adv" runat="server" Width="60px" ToolTip="Chỉ cần nhập cho ảnh dạng flash"></asp:TextBox>
        Chỉ cần nhập cho ảnh dạng flash
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
          ErrorMessage="Vui lòng nhập kiểu số(vd: 100)" ControlToValidate="txt_width_adv"
          Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
      </div>
      <div class="cbh8">
        <!---->
      </div>

      <div class="text">
        <div class="pt8"><%=AdvertisingKeyword.ChieuCao%></div>
      </div>
      <div class="control">
        <asp:TextBox ID="txt_height_adv" runat="server" Width="60px" ToolTip="Chỉ cần nhập cho ảnh dạng flash"></asp:TextBox>
        Chỉ cần nhập cho ảnh dạng flash
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
          ErrorMessage="Vui lòng nhập kiểu số(vd: 100)" ControlToValidate="txt_height_adv"
          Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
      </div>
      <div class="cbh8">
        <!---->
      </div>
    </div>

    <div class="text">
      <div class="pt8"><%=AdvertisingKeyword.QuangCaoSeMoRa%></div>
    </div>
    <div class="control">
      <asp:DropDownList ID="ddl_type_open" runat="server" Width="280px">
        <asp:ListItem Value="1">Mở trang tại của sổ mới</asp:ListItem>
        <asp:ListItem Value="0">Mở trang tại của sổ hiện tại</asp:ListItem>
      </asp:DropDownList>
    </div>
    <div class="cbh8">
      <!---->
    </div>

    <div class="text">
      <div class="pt8"><%=AdvertisingKeyword.AnhDaiDien%></div>
    </div>
    <div class="fl">
      <div>
        <asp:Literal ID="ltimg" runat="server" Visible="true"></asp:Literal></div>
      <div>
        <asp:FileUpload ID="flimg" runat="server" Width="220px" /></div>
      <div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
          ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc swf." ControlToValidate="flimg" Display="Dynamic"
          SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|swf|JPG|JPEG|PNG|GIF|SWF)"></asp:RegularExpressionValidator>
      </div>
    </div>
    <div class="cbh8">
      <!---->
    </div>


    <div class="dn">
      <div class="text">
        <div class="pt8"><%=AdvertisingKeyword.AnhDaiDien2%></div>
      </div>
      <div class="fl">
        <div>
          <asp:Literal ID="ltimg2" runat="server" Visible="true"></asp:Literal></div>
        <div>
          <asp:FileUpload ID="flimg2" runat="server" Width="220px" /></div>
        <div>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server"
            ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc swf." ControlToValidate="flimg2" Display="Dynamic"
            SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|swf|JPG|JPEG|PNG|GIF|SWF)"></asp:RegularExpressionValidator>
        </div>
      </div>

      <div class="cbh8">
        <!---->
      </div>

      <div class="text">
        <div class="pt8"><%=AdvertisingKeyword.AnhQuangCaoTuLink%></div>
      </div>
      <div class="control">
        <asp:TextBox ID="txt_link_to_image" runat="server" Width="600px" Height="50px" TextMode="MultiLine"></asp:TextBox>
      </div>
    </div>
    <div class="cbh8">
      <!---->
    </div>


    <div class="text">
      <div class="pt8"><%=AdvertisingKeyword.ThuTu%></div>
    </div>
    <div class="control">
      <asp:TextBox ID="txt_order" runat="server" Width="60px" Text="1"></asp:TextBox>
      <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
        ErrorMessage="Vui lòng nhập kiểu số(vd: 1)" ControlToValidate="txt_order"
        Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
    </div>
    <div class="cbh10">
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
      <asp:Button ID="btn_insert_update" Width="120px" runat="server" OnClick="btn_insert_update_Click" />
      <asp:Button ID="btn_cancel" Width="80px" runat="server" Text="Hủy bỏ" OnClick="btn_cancel_Click" CausesValidation="false" />
    </div>
    <div class="cbh10">
      <!---->
    </div>
  </div>
</div>
