<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutCate.ascx.cs" Inherits="cms_admin_Moduls_Advertising_Cate_ShortCutCate" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
  <link href="~/cms/admin/Moduls/Advertising/Cate/ShortCutCate/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<asp:HiddenField ID="hd_img" runat="server" />
<div id="admsccate">
  <div class="TxtInsertUpdate">
    <asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
  <div class="pdControl">
    <div class="cb h20">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=Developer.ProductKeyword.ViTri%></div>
    </div>
    <div class="control">
      <asp:DropDownList ID="DdlPosition" runat="server" Width="252px" AutoPostBack="True"
        OnSelectedIndexChanged="DdlPosition_SelectedIndexChanged">
      </asp:DropDownList>
    </div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=Developer.AdvertisingKeyword.DanhMucCha %></div>
    </div>
    <div class="control">
      <asp:DropDownList ID="DdlGroupAdvertising" runat="server"
        Width="252px">
      </asp:DropDownList>
    </div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=Developer.AdvertisingKeyword.TieuDeNhom %></div>
    </div>
    <div class="control">
      <asp:TextBox ID="txt_title_modul" runat="server" Width="580px" CssClass="tbTitle"></asp:TextBox>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txt_title_modul" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=Developer.AdvertisingKeyword.MoTa%>:</div>
    </div>
    <div class="control">
      <asp:TextBox ID="txtDesc" runat="server" Width="580px" Height="50px" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
    </div>
    <div class="cbh8">
      <!---->
    </div>
    <div class="text">
      <div class="pt8"><%=Developer.AdvertisingKeyword.ThuTu %>:</div>
    </div>
    <div class="control">
      <asp:TextBox ID="txt_ordermodul" runat="server" Width="35px" Text="1"></asp:TextBox>
      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="txt_ordermodul" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
    </div>
    <div class="cb h8">
      <!---->
    </div>
    <div class="text">
      <div class="pt5"><%=Developer.AdvertisingKeyword.TrangThai %>:</div>
    </div>
    <div class="control">
      <div>
        <asp:CheckBox ID="chk_status" runat="server" CssClass="cccc fs11 flex-center" Text="(tích chọn để hiển thị)" Checked="true" /></div>
    </div>
    <div class="cbh5">
      <!---->
    </div>
    <div class="text">
      <!---->
      &nbsp;</div>
    <div class="control">
      <asp:CheckBox CssClass='fl flex-center' ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này" />
      <div class="cbh0">
        <!---->
      </div>
    </div>

    <div class="dn">
      <div class="cbh20">
        <!---->
      </div>
      <div class="TextSeoLink"><%=Developer.AdvertisingKeyword.ToiUuTimKiem%> </div>
      <div>
        <div class="text">
          <div class="pt8"><%=Developer.AdvertisingKeyword.ToiUuDuongDan%>: </div>
        </div>
        <div class="control">
          <asp:TextBox ID="textLinkRewrite" runat="server" Width="450px" CssClass="tbLink_seo"></asp:TextBox></div>
        <div class="cbh8">
          <!---->
        </div>
        <div class="text">
          <div class="pt8"><%=Developer.AdvertisingKeyword.ToiUuTheTieuDe%>: </div>
        </div>
        <div class="control">
          <asp:TextBox ID="textTagTitle" runat="server" Width="450px" CssClass="tbTitle_seo"></asp:TextBox></div>
        <div class="cbh8">
          <!---->
        </div>
        <div class="text">
          <div class="pt8"><%=Developer.AdvertisingKeyword.ToiUuTheTuKhoa%>: </div>
        </div>
        <div class="control">
          <asp:TextBox ID="textTagKeyword" runat="server" Width="450px" CssClass="tbKeyword_seo"></asp:TextBox></div>
        <div class="cbh8">
          <!---->
        </div>
        <div class="text">
          <div class="pt8"><%=Developer.AdvertisingKeyword.ToiUuTheMoTa%>: </div>
        </div>
        <div class="control">
          <asp:TextBox ID="textTagDescription" runat="server" CssClass="tbDesc_Seo" Width="580px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
        <div class="cbh8">
          <!---->
        </div>
      </div>
    </div>
    <div class="cb h20">
      <!---->
    </div>
    <div class="tac">
      <asp:Button ID="btn_insert_update" runat="server" OnClick="btn_insert_update_Click" Width="120px" />
      <asp:Button ID="btn_cancel" runat="server" Text="Hủy bỏ" OnClick="btn_cancel_Click" Width="80px" CausesValidation="false" />
    </div>
  </div>
</div>
