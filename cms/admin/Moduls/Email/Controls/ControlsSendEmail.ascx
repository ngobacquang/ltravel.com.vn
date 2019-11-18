<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ControlsSendEmail.ascx.cs" Inherits="cms_admin_Moduls_Email_Controls_AdmControlsSendEmail" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<div id="AdmControlsSendEmail">
    <div class="PositionRightControl">
        <div class="pdControl">
            <div class='GuiTop'>
                <asp:Button ID="btSendTop" runat="server" Text="Gửi" Width="120px" onclick="btSend_Click"/>                    
            </div>
            <asp:Literal ID="ltrDaGuiCho" runat="server"></asp:Literal>            
            <div class='guiCho'>
                Gửi email định kỳ
            </div>            
            <div class='khungND'>
                Tiêu đề email:
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="*" ControlToValidate="tbTieuDe" Display="Dynamic" 
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div>
                <asp:TextBox ID="tbTieuDe" runat="server" Width="750px"></asp:TextBox>                
            </div>
            <div class='khungND pt10'>
                Nội dung email
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="*" ControlToValidate="tbContent" Display="Dynamic" 
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div>
                <CKEditor:CKEditorControl ID="tbContent" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Email"></CKEditor:CKEditorControl>
            </div>
            <div class='Gui'>
                <asp:Button ID="btSend" runat="server" Text="Gửi" Width="120px" 
                    onclick="btSend_Click"/>
            </div>
        </div>
    </div>
</div>