<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Index.ascx.cs" Inherits="cms_admin_System_website_AdmIndex" %>
<div id="AdmIndex">
    <div class="pdControl">
    <div class="TextTabCate">Quản lý tối thuộc tính website</div>
    <table cellpadding="0" CellSpacing="0" border="0" width="730px" BorderColor="#dcdcdc">
        <tr>
            <td width="150px"><div class="TextCol">Logo:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtLogo" runat="server"></asp:Literal></div></td>
        </tr>
        <tr>
            <td width="150px"><div class="TextCol">Email:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtEmail" runat="server"></asp:Literal></div></td>
        </tr>
        <tr style="display:none">
            <td width="150px"><div class="TextCol">Điện thoại:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtPhone" runat="server"></asp:Literal></div></td>
        </tr>
        <tr>
            <td width="150px"><div class="TextCol">Đường dây nóng:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtHotLine" runat="server"></asp:Literal></div></td>
        </tr>
        <tr>
            <td width="150px"><div class="TextCol">Icon trên trình duyệt:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtFavicon" runat="server"></asp:Literal></div></td>
        </tr>
        <tr>
            <td width="150px"><div class="TextCol">Nội dung chân trang:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtContentFooter" runat="server"></asp:Literal></div></td>
        </tr>
    </table>
    <div class="cbh25"><!----></div>
    <div class="TextTabCate">Quản lý tối ưu website</div>
    <table cellpadding="0" CellSpacing="0" border="0" width="730px" BorderColor="#dcdcdc">
        <tr>
            <td width="150px"><div class="TextCol">Tiêu đề website:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtTitleWeb" runat="server"></asp:Literal></div></td>
        </tr>
        <tr>
            <td width="150px"><div class="TextCol">Từ khóa website:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtKeyWordWeb" runat="server"></asp:Literal></div></td>
        </tr>
        <tr>
            <td width="150px"><div class="TextCol">Mô tả website:</div></td>
            <td width="580px"><div class="TextCol2"><asp:Literal ID="LtDescWeb" runat="server"></asp:Literal></div></td>
        </tr>
    </table>
    </div>
</div>