<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_CustomerReviews_Item_ShortCutItem" %>
<%@ Import Namespace="Developer" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>

<asp:HiddenField ID="hdTotalView" runat="server" />
<asp:HiddenField ID="hdGroupsItemId" runat="server" />

<asp:HiddenField ID="hdThongTinThem" runat="server" />
<asp:HiddenField ID="hdEnable" runat="server" />
<asp:HiddenField ID="hdNgayXuatBan" runat="server" />
<asp:HiddenField ID="hdNguoiDangCu" runat="server" />

<div id="ShortCutItem" class="InsertPanel InitQuikMenu">
  <div class="head">
    <asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal>
  </div>
  <div class="controlBox">
    <div class="row">
      <div class="text"><%= CustomerReviewsKeyword.DanhMucCha %></div>
      <div class="control">
        <asp:DropDownList ID="ddlParentCate" runat="server"></asp:DropDownList>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= CustomerReviewsKeyword.HoTen %></div>
      <div class="control">
        <asp:TextBox ID="tbHoTen" runat="server" CssClass="tbTitle"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
          ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbHoTen">
        </asp:RequiredFieldValidator>
      </div>
    </div>
    <div class="row">
      <div class="text">Mô tả</div>
      <div class="control">
        <asp:TextBox ID="txt_description" runat="server" Width="600px" Height="60px" CssClass="tbDesc" TextMode="MultiLine"></asp:TextBox>
      </div>
    </div>
    <div class="row dn">
      <div class="text"><%= CustomerReviewsKeyword.Email %></div>
      <div class="control">
        <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
      </div>
    </div>
    <div class="row dn">
      <div class="text"><%= CustomerReviewsKeyword.DiaChi %></div>
      <div class="control">
        <asp:TextBox ID="tbDiaChi" runat="server"></asp:TextBox>
      </div>
    </div>
    <div class="row dn">
      <div class="text"><%= CustomerReviewsKeyword.CongTy %></div>
      <div class="control">
        <asp:TextBox ID="tbCongTy" runat="server"></asp:TextBox>
      </div>
    </div>
    <div class="row dn">
      <div class="text"><%= CustomerReviewsKeyword.ChucVu %></div>
      <div class="control">
        <asp:TextBox ID="tbChucVu" runat="server"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= CustomerReviewsKeyword.NgayDang %></div>
      <div class="control">
        <asp:TextBox ID="tbNgayDang" runat="server" CssClass="stb"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbNgayDang"></asp:RequiredFieldValidator>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= CustomerReviewsKeyword.ThuTu %></div>
      <div class="control">
        <asp:TextBox ID="tbThuTu" runat="server" Width="35px" Text="1" CssClass="NotReset"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
          ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbThuTu" Display="Dynamic"
          SetFocusOnError="True" ValidationExpression="(\d)*">
        </asp:RegularExpressionValidator>
      </div>
    </div>
    <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện" />

    

    <div class="row dn">
      <div class="text"><%= CustomerReviewsKeyword.TieuDeYKien %></div>
      <div class="control">
        <asp:TextBox ID="tbTieuDeYKien" runat="server"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= CustomerReviewsKeyword.ChiTiet %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbChiTiet" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/CustomerReviews"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdChiTiet" runat="server" Value="" />
      </div>
    </div>
    <div class="h3"></div>

    <div class="KhungToiUu PdKhungToiUu">
      <div class="subHead"><%= CustomerReviewsKeyword.ToiUuTimKiem %> </div>

      <div class="row">
        <div class="text"><%= CustomerReviewsKeyword.ToiUuTheTieuDe %></div>
        <div class="control">
          <asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox>
        </div>
      </div>
      <div class="row">
        <div class="text"><%= CustomerReviewsKeyword.ToiUuDuongDan %></div>
        <div class="control">
          <asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox>
        </div>
      </div>
      <div class="row">
        <div class="text"><%= CustomerReviewsKeyword.ToiUuTheTuKhoa %></div>
        <div class="control">
          <asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox>
        </div>
      </div>
      <div class="row">
        <div class="text"><%= CustomerReviewsKeyword.ToiUuTheMoTa %></div>
        <div class="control">
          <asp:TextBox ID="tbSeoDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc_Seo"></asp:TextBox>
        </div>
      </div>
    </div>

    <div class="h15"></div>

    <div class="row"> 
      <asp:Literal ID="ltrTrangThai" runat="server" />
      <asp:Panel ID="pnTichChonDeHienThi" runat="server">
        <div class="control">
          <asp:CheckBox ID="cbTrangThai" CssClass="flex-center" runat="server" Text="Tích chọn để hiển thị" Checked="true" />
        </div>
      </asp:Panel>
    </div>
    <div class="row">
      <div class="text">&nbsp;</div>
      <div class="control">
        <asp:CheckBox ID="cbTiepTuc" CssClass="flex-center" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này" />
      </div>
    </div>

    <div class="h15"></div>

    <div class="tac">
      <asp:Button ID="btOK" runat="server" OnClientClick="RemoveAutoNumeric()" OnClick="btOK_Click" />
      <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" OnClick="btCancel_Click" CausesValidation="false" />
    </div>
    <div class="cbh10">
      <!---->
    </div>
  </div>
</div>
