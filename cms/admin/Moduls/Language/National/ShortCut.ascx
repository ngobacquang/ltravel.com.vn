<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCut.ascx.cs" Inherits="cms_admin_Moduls_Language_National_ShortCut" %>
<asp:HiddenField ID="HdFlagNational" runat="server" />
<div id="AdmShortCutLanguageNational">
    <div class="PositionRightControl">
        <div class="BgTabMesInsertUpdate"><asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
        <div class="cbh20"><!----></div>
        <div class="FormatColTextLangNational pt5">Tên ngôn ngữ</div>
        <div class="FormatColBoxLangNational" style="position:relative;">
            <asp:TextBox ID="TbNameNational" runat="server" Width="220px" onblur="HideList('name')" onfocus="ShowList('name')"></asp:TextBox>
            <div style="display:none; width:220px; position:absolute; top:0; right:-210px; padding:5px; text-align:justify; background:#fff; border:1px solid #d0d0d0;" id='name'>
                Mời bạn nhập tên cho <b>Ngôn ngữ mới</b>
            </div>    
        </div>
        <div class="cbh10"><!----></div>
        <div class="FormatColTextLangNational pt5">Cờ quốc gia</div>
        <div class="FormatColBoxLangNational">
            <div><asp:Literal ID="ltimg" runat="server"></asp:Literal></div>                
            <div><asp:LinkButton ID="LbDelFlagCurrent" runat="server" onclick="LbDelFlagCurrent_Click" Visible="false">Xóa hình ảnh hiện tại</asp:LinkButton></div>
            <div><asp:FileUpload ID="flimg" runat="server" Width="225px"/></div>
            <div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic" 
                SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="cbh10"><!----></div>
        <div class="FormatColTextLangNational pt5">Thứ tự</div>
        <div class="FormatColBoxLangNational" style="position:relative;">
            <asp:TextBox ID="TbOrder" runat="server" Width="30px" onblur="HideList('thuTu')" onfocus="ShowList('thuTu')"></asp:TextBox>
            <div style="display:none; width:220px; position:absolute; top:0; right:-210px; padding:5px; text-align:justify; background:#fff; border:1px solid #d0d0d0;" id='thuTu'>
                Mời bạn nhập thứ tự cho <b>Ngôn ngữ mới</b>, Lưu ý thứ tự phải là một số
            </div> 
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
            ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="TbOrder" 
            Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
        </div>
        <div class="cbh10"><!----></div>
        <div class="FormatColTextLangNational pt3">Trạng thái</div>
        <div class="FormatColBoxLangNational"><asp:CheckBox ID="ChkStatus" CssClass="flex-center" runat="server" Text="(tích chọn để hiện thị)" /></div>
        <div class="cbh5"><!----></div>

        <asp:Panel ID="pnTiepTuc" runat="server">
            <div class="FormatColTextLangNational">&nbsp;</div>
            <div class="FormatColBoxLangNational"><asp:CheckBox ID="ckTiepTuc" CssClass="flex-center" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này" /></div>
            <div class="cbh10"><!----></div>
        </asp:Panel>

        <div class="FormatColButton">
            <div><asp:Button ID="BtnOk" runat="server" Text="Đồng ý" onclick="BtnOk_Click" CssClass="btnOk" Width="100px" /></div>
            <div><asp:Button ID="BtnReset" runat="server" Text="Nhập lại" onclick="BtnReset_Click" CssClass="btnOk" Width="100px" /></div>
        </div>
    </div>
</div>