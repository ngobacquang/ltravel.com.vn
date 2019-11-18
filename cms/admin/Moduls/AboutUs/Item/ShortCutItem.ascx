<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_AboutUs_Item_ShortCutItem" %>
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
      <div class="text"><%= AboutUsKeyword.DanhMucCha %></div>
      <div class="control">
        <asp:DropDownList ID="ddlParentCate" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlParentCate_SelectedIndexChanged"></asp:DropDownList>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= tieuDe %></div>
      <div class="control">
        <asp:TextBox ID="tbTitle" runat="server" CssClass="tbTitle"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
          ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbTitle">
        </asp:RequiredFieldValidator>
      </div>
    </div>
    <asp:PlaceHolder ID="plMa" runat="server">
      <div class="row">
        <div class="text"><%= AboutUsKeyword.Ma %></div>
        <div class="control">
          <asp:TextBox ID="tbKey" runat="server"></asp:TextBox>
        </div>
      </div>
    </asp:PlaceHolder>
    <div class="row">
      <div class="text"><%= moTa %></div>
      <div class="control">
        <asp:TextBox ID="tbDesc" runat="server" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
      </div>
    </div>

        <div class="row">
      <div class="text"><%= AboutUsKeyword.NgayDang %></div>
      <div class="control">
        <asp:TextBox ID="tbNgayDang" runat="server" CssClass="stb"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbNgayDang"></asp:RequiredFieldValidator>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= AboutUsKeyword.ThuTu %></div>
      <div class="control">
        <asp:TextBox ID="tbThuTu" runat="server" Width="35px" Text="1" CssClass="NotReset"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
          ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbThuTu" Display="Dynamic"
          SetFocusOnError="True" ValidationExpression="(\d)*">
        </asp:RegularExpressionValidator>
      </div>
    </div>

    <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện" />

    <asp:PlaceHolder ID="plNicks" runat="server">
      <div class="pt10 pb5"><b>Các thông tin liên hệ:</b></div>
      <asp:PlaceHolder ID="plFacebook" runat="server">
        <div class="row">
          <div class="text" title="1">Facebook</div>
          <div class="control">
            <asp:TextBox ID="tbFacebook" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plGooglePlus" runat="server">
        <div class="row">
          <div class="text" title="2">Google +</div>
          <div class="control">
            <asp:TextBox ID="tbGooglePlus" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plTwitter" runat="server">
        <div class="row">
          <div class="text" title="3">Twitter</div>
          <div class="control">
            <asp:TextBox ID="tbTwitter" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plYoutube" runat="server">
        <div class="row">
          <div class="text" title="4">Youtube</div>
          <div class="control">
            <asp:TextBox ID="tbYoutube" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plInstagram" runat="server">
        <div class="row">
          <div class="text" title="5">Instagram</div>
          <div class="control">
            <asp:TextBox ID="tbInstagram" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plPhone" runat="server">
        <div class="row">
          <div class="text" title="6">Điện thoại</div>
          <div class="control">
            <asp:TextBox ID="tbPhone" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plEmail" runat="server">
        <div class="row">
          <div class="text" title="7">Email</div>
          <div class="control">
            <asp:TextBox ID="tbEmail" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plSkype" runat="server">
        <div class="row">
          <div class="text" title="8">Skype</div>
          <div class="control">
            <asp:TextBox ID="tbSkype" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plViber" runat="server">
        <div class="row">
          <div class="text" title="9">Viber</div>
          <div class="control">
            <asp:TextBox ID="tbViber" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <asp:PlaceHolder ID="plZalo" runat="server">
        <div class="row">
          <div class="text" title="10">Zalo</div>
          <div class="control">
            <asp:TextBox ID="tbZalo" runat="server"></asp:TextBox>
          </div>
        </div>
      </asp:PlaceHolder>
      <div class="cb h10"></div>
    </asp:PlaceHolder>

    <div class="row">
      <div class="text"><%= AboutUsKeyword.ChiTiet %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbChiTiet" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/AboutUs"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdChiTiet" runat="server" Value="" />
      </div>
    </div>

    <div class="KhungToiUu PdKhungToiUu">
      <div class="subHead"><%= AboutUsKeyword.ToiUuTimKiem %> </div>
      <div class="row">
        <div class="text"><%= AboutUsKeyword.ToiUuDuongDan %></div>
        <div class="control">
          <asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox>
        </div>
      </div>
      <div class="row">
        <div class="text"><%= AboutUsKeyword.ToiUuTheTieuDe %></div>
        <div class="control">
          <asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox>
        </div>
      </div>

      <div class="row">
        <div class="text"><%= AboutUsKeyword.ToiUuTheTuKhoa %></div>
        <div class="control">
          <asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox>
        </div>
      </div>
      <div class="row">
        <div class="text"><%= AboutUsKeyword.ToiUuTheMoTa %></div>
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

    <div class="h10"></div>

    <div class="tac">
      <asp:Button ID="btOK" runat="server" OnClientClick="RemoveAutoNumeric()" OnClick="btOK_Click" />
      <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" OnClick="btCancel_Click" CausesValidation="false" />
    </div>
    <div class="cbh10">
      <!---->
    </div>
  </div>
</div>
