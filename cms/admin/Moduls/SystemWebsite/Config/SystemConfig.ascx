<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SystemConfig.ascx.cs" Inherits="cms_admin_Moduls_System_website_Config_AdmSystemConfig" %>
<div id="AdmSystemConfig">
    <div class="pl10">       
        <div class="cbh8"><!----></div>
        <div class="FormatColText"><div>Tự động lấy ảnh từ website khác</div></div>
        <div class='FormatColValue'>
            <asp:DropDownList ID="ddlShowpopup" Width="150px" runat="server">
                <asp:ListItem Text="Tắt" Value="0"></asp:ListItem>
                <asp:ListItem Text="Bật" Value="1"></asp:ListItem>
            </asp:DropDownList>
            <br /><br />
            (Tự động save ảnh từ website khác khi copy/paste nội dung từ website khác về website của bạn)
        </div>  
        <div class="cbh20"><!----></div>
        <div class="PdLeftButton">            
            <asp:LinkButton ID="btSave" runat="server" onclick="btSave_Click"><img src="cms/admin/cs/Icon/btnUpdate.png" border="0" /></asp:LinkButton>
       </div>
       <div class="cbh8"><!----></div>
    </div>
</div>