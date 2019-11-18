<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCut.ascx.cs" Inherits="cms_admin_Moduls_Language_Key_ShortCut" %>
<div id="AdmShortCutLanguageKey">
    <div class="PositionRightControl">
        <div class="BgTabMesInsertUpdate"><asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
        <div class="cbh20"><!----></div>
        <div class="LanguageKeyColText pt5">Mã từ khóa</div>
        <div class="LanguageKeyColBox" style="position:relative;">
            <asp:TextBox ID="TbCode" runat="server" Width="220px" onblur="HideList('TuKhoa')" onfocus="ShowList('TuKhoa')"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="true" Display="Dynamic" ControlToValidate="TbCode"></asp:RequiredFieldValidator>
            <div style="display:none; width:220px; position:absolute; top:0; right:-210px; padding:5px; text-align:justify; background:#fff; border:1px solid #d0d0d0;" id='TuKhoa'>
                Mời bạn nhập mã từ khóa mới
            </div>    
        </div>
        <div class="cbh10"><!----></div>
        <div class="LanguageKeyColText pt5">Mô tả</div>
        <div class="LanguageKeyColBox" style="position:relative;">
            <asp:TextBox ID="tbDesc" runat="server" Width="220px" onblur="HideList('MoTa')" onfocus="ShowList('MoTa')"></asp:TextBox>            
            <div style="display:none; width:220px; position:absolute; top:0; right:-210px; padding:5px; text-align:justify; background:#fff; border:1px solid #d0d0d0;" id='MoTa'>
                Mời bạn nhập mã từ khóa mới
            </div>    
        </div>
        <div class="cbh10"><!----></div>
        <asp:Panel ID="pnThemMaTuKhoa" runat="server">
            <div class="LanguageKeyColText">&nbsp;</div>
            <div class="LanguageKeyColBox" style="position:relative;">
                <asp:CheckBox ID="ckTiepTuc" CssClass="flex-center" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này" />
            </div>
            <div class="cbh10"><!----></div>
        </asp:Panel>
        <div class="LanguageKeyColButton">
            <div><asp:Button ID="BtnOk" runat="server" Text="Đồng ý" CssClass="btnOk" 
                    Width="100px" onclick="BtnOk_Click" /></div>
        </div>
    </div>
</div>