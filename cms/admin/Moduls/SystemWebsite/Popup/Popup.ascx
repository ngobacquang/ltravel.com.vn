<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Popup.ascx.cs" Inherits="cms_admin_System_website_OtherSettings_AdmOtherSettings" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:HiddenField ID="hdOldContent" runat="server" />
<asp:HiddenField ID="hdOldDetail" runat="server" />
<div id="AdmInformationWebsite">
    <div class="pl10">       
        <div class="cbh8"><!----></div>
        <div class="FormatColText"><div>Hiển thị popup tại trang chủ:</div></div>
        <div class="fl w8">&nbsp;</div>
        <div>
            <asp:DropDownList ID="ddlShowpopup" runat="server">
                <asp:ListItem Text="Không" Value="0"></asp:ListItem>
                <asp:ListItem Text="Có" Value="1"></asp:ListItem>
            </asp:DropDownList>
        </div>  
        <div class="cbh8"><!----></div>        
        <div class="FormatColText"><div>Popup hiển thị tại trang chủ:</div></div>
        <div class="cbh8">&nbsp;</div>
        <div>
            <CKEditor:CKEditorControl ID="tbPopupContent" runat="server"></CKEditor:CKEditorControl>
        </div>
        <div class="cbh8"><!----></div>        
        <div class="FormatColText"><div>Nội dung trang chi tiết khi click vào Popup tại trang chủ:</div></div>
        <div class="cbh8">&nbsp;</div>
        <div>
            <CKEditor:CKEditorControl ID="tbPopupDetail" runat="server"></CKEditor:CKEditorControl>
        </div>    
        <div class="cbh20"><!----></div>
        <div class="PdLeftButton">            
            <asp:LinkButton ID="btSave" runat="server" onclick="btSave_Click"><img src="cms/admin/cs/Icon/btnUpdate.png" border="0" /></asp:LinkButton>
       </div>
       <div class="cbh8"><!----></div>
    </div>
</div>