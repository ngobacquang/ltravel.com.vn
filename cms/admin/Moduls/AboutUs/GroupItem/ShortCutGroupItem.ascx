<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutGroupItem.ascx.cs" Inherits="cms_admin_Moduls_AboutUs_GroupItem_ShortCutGroupItem" %>

<%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>
<div id="ShortCutCate" class="InsertPanel InitQuikMenu">
  <div class="head">
    <asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
  <div class="controlBox">
    <div class="row">
      <div class="text">
        <div class="pt5"><%=Developer.AboutUsKeyword.ViTri%></div>
      </div>
      <div class="control">
        <asp:DropDownList ID="DdlPosition" runat="server" Width="252px"></asp:DropDownList>
      </div>
    </div>
    <div class="row">
      <div class="text">
        <div class="pt5"><%=Developer.AboutUsKeyword.TenNhom %></div>
      </div>
      <div class="control">
        <asp:TextBox ID="tbTitle" runat="server" Width="585px" CssClass="tbTitle"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbTitle" Display="Dynamic"></asp:RequiredFieldValidator>
      </div>
    </div>
    <div class="row">
      <div class="text">
        <div class="pt5"><%=Developer.AboutUsKeyword.MoTa%></div>
      </div>
      <div class="control">
        <asp:TextBox ID="tbDesc" runat="server" Width="585px" Height="50px" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text">
        <div class="pt5"><%=Developer.AboutUsKeyword.SoAboutUsDuocHienThi %></div>
      </div>
      <div class="control">
        <asp:TextBox ID="tbMaxItem" runat="server" Width="35px" Text="10"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="tbMaxItem" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
      </div>
    </div>
    <div class="row">
      <div class="text">
        <div class="pt5"><%=Developer.AboutUsKeyword.ThuTu %></div>
      </div>
      <div class="control">
        <asp:TextBox ID="tbOrder" runat="server" Width="35px" Text="1"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="tbOrder" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
      </div>
    </div>
    <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện" LayAnhTuNoiDung="false" />

    <div class="cb h5"></div>

    <div class="KhungToiUu PdKhungToiUu">
      <div class="subHead"><%=Developer.AboutUsKeyword.ToiUuTimKiem%> </div>
      <div class="row">
        <div class="text"><%=Developer.AboutUsKeyword.ToiUuDuongDan%></div>
        <div class="control">
          <asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox></div>
      </div>
      <div class="row">
        <div class="text"><%=Developer.AboutUsKeyword.ToiUuTheTieuDe%></div>
        <div class="control">
          <asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox></div>
      </div>
      <div class="row">
        <div class="text"><%=Developer.AboutUsKeyword.ToiUuTheTuKhoa%></div>
        <div class="control">
          <asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox></div>
      </div>
      <div class="row">
        <div class="text"><%=Developer.AboutUsKeyword.ToiUuTheMoTa%></div>
        <div class="control">
          <asp:TextBox ID="tbSeoDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc_Seo"></asp:TextBox></div>
      </div>
    </div>
    <div class="cb h15"></div>
    <div class="row">
      <div class="text">
        <div class="pt5"><%=Developer.AboutUsKeyword.TrangThai %></div>
      </div>
      <div class="control">
        <asp:CheckBox ID="cbStatus" CssClass="flex-center" runat="server" Text="Tích chọn để hiển thị" Checked="true" />
      </div>
    </div>
    <div class="row">
      <div class="text">&nbsp;</div>
      <div class="control">
        <asp:CheckBox ID="ckbContinue" CssClass="flex-center" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này" />
      </div>
    </div>
    <div class="cb h10">
      <!---->
    </div>
    <div class="tac">
      <asp:Button ID="btOK" runat="server" OnClick="btOK_Click" />
      <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" OnClick="btCancel_Click" CausesValidation="false" />
    </div>
    <div class="cb h20">
      <!---->
    </div>
  </div>
</div>
