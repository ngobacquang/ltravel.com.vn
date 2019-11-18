<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OptimizeWebsite.ascx.cs" Inherits="cms_admin_System_website_OptimizeWebsite_AdmOptimizeWebsite" %>
<div id="AdmOptimizeWebsite">
    <div class="pdControl">
        <div class="FormatColText"><div class="fwb pb3">Tiêu đề website:</div></div>
        <div class="FormatColBox"><asp:TextBox ID="txt_title_website" runat="server" Width="600px" TextMode="MultiLine" Height="70px"></asp:TextBox></div>
        <div class="cbh8"><!----></div>
        <div class="FormatColText"><div class="fwb pb3">Từ khóa website:</div></div>
        <div class="FormatColBox"><asp:TextBox ID="txt_key_website" runat="server" Width="600px" TextMode="MultiLine" Height="100px"></asp:TextBox></div>
        <div class="cbh8"><!----></div>
        <div class="FormatColText"><div class="fwb pb3">Mô tả website:</div></div>
        <div class="FormatColBox"><asp:TextBox ID="TbDescWebsite" runat="server" Width="600px" TextMode="MultiLine" Height="100px"></asp:TextBox></div>
        <div class="cbh8"><!----></div>
        <div class="FormatColText"><div class="fwb pb3">Mã nhúng Google Analytics:</div></div>
        <div class="FormatColBox"><asp:TextBox ID="TbGoogleAnalytics" runat="server" Width="600px" TextMode="MultiLine" Height="150px"></asp:TextBox></div>
        <div class="cbh8"><!----></div>
        <div class="PdLeftButton"><asp:LinkButton ID="LbUpdate" runat="server" onclick="btn_save_Click"><img src="cms/admin/cs/Icon/btnUpdate.png" border="0" /></asp:LinkButton></div>
    </div>
</div>