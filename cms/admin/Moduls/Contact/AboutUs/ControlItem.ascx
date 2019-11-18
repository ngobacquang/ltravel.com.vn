<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlItem.ascx.cs" Inherits="cms_admin_Moduls_ContactUs_AboutUs_ControlItem" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Contact/AboutUs/_cs/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<div id="ContactAboutUs">
    <asp:HiddenField ID="hdNoiDungTrangLienHe" runat="server" />
    <asp:HiddenField ID="hdThongBaoSauKhiGuiLienHe" runat="server" />
    <div class="pdControl">
      <div class="dn">
        <div class="TtlContactContent">Nội dung trang liên hệ</div>
        <div class="cb h10"><!----></div>
        <div><CKEditor:CKEditorControl ID="tbNoiDungTrangLienHe" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/contact"></CKEditor:CKEditorControl></div>
        <div class="cb h10"><!----></div>
      </div>
        
        <div class="TtlContactContent">Thông báo sau khi gửi liên hệ thành công</div>
        <div class="cb h10"><!----></div>
        <div><CKEditor:CKEditorControl ID="tbThongBaoSauKhiGuiLienHe" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/contact"></CKEditor:CKEditorControl></div>
        <div class="cb h10"><!----></div>
        
        
      <div class="dn">
        <div class="TtlContactContent">Thông báo sau khi gửi đăng ký dịch vụ thành công</div>
        <div class="cb h10"><!----></div>
        <div><CKEditor:CKEditorControl ID="tbThongBaoSauKhiGuiDKDichVu" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/contact"></CKEditor:CKEditorControl></div>
        <div class="cb h10"><!----></div>
      </div>

        <div><asp:Button ID="BtnSave" runat="server" Text="Cập nhật" onclick="BtnSave_Click" /></div>
    </div>
</div>