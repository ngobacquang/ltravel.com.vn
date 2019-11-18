<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Media.ascx.cs" Inherits="cms_admin_System_website_Media_AdmMedia" %>
<div id="AdmEmailWebsite">
    <div class="pdControl">
        <asp:RadioButton ID="rdUp" Checked="true" Text="Tải nhạc nền từ máy" runat="server" AutoPostBack="True" GroupName="rdMedia" oncheckedchanged="rdUp_CheckedChanged" />
        <asp:RadioButton ID="rdLink" Text="Nhập link nhúng từ website" runat="server" AutoPostBack="True" GroupName="rdMedia" oncheckedchanged="rdLink_CheckedChanged" />
        <div class="cbh8"><!----></div>
        <asp:Panel ID="pnUp" runat="server">
            <div style="font-size:11px;">(File nhạc nền có định dạng .mp3 hoặc .wma dung lượng dưới 3 Megabytes)</div>
            <div class="cbh8"><!----></div>
            <div class="FormatColText"><div>Tải lên từ máy:</div></div>
            <div><asp:FileUpload ID="fuMedia" runat="server" /></div>
            <div class="cbh8"><!----></div>
            <div style="font-size:11px; font-style:italic;"><asp:Literal ID="ltMediaName" runat="server"></asp:Literal></div>
            <div class="cbh5"><!----></div>
            <div><asp:LinkButton ID="lbtDelCurrentMedia" Font-Size="11px" runat="server" onclick="lbtDelCurrentMedia_Click" Visible="False">Xóa nhạc nền hiện tại</asp:LinkButton></div>
            <div class="cbh8"><!----></div>
        </asp:Panel>
        <asp:Panel ID="pnLink" runat="server" Visible="False">
            <div class="FormatColText"><div>Nhập mã nhúng:</div></div>
            <div><asp:TextBox ID="txt_source" TextMode="MultiLine" runat="server" Width="300px" Height="100px"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
        </asp:Panel>
        <asp:RadioButton Checked="true" ID="rdOn" Text="Bật nhạc nền" runat="server" 
            AutoPostBack="True" GroupName="rdOnOff" />
        <asp:RadioButton ID="rdOff" Text="Tắt nhạc nền" runat="server" 
            AutoPostBack="True" GroupName="rdOnOff" />
        <div class="cbh8"><!----></div>
        <div class="PdLeftButton">            
            <asp:Button ID="LbUpdate" runat="server" onclick="btn_save_Click" Text="Cập nhật" />
        </div>
    </div>
</div>