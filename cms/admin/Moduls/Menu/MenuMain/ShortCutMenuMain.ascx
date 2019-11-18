<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutMenuMain.ascx.cs" Inherits="cms_admin_Moduls_Menu_MenuMain_ShortCutMenuMain" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Menu/MenuMain/ShortCutMenuMain/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<asp:HiddenField ID="hdTotalItem" runat="server" />
<asp:HiddenField ID="hdImg" runat="server" />
<asp:HiddenField ID="hdImg2" runat="server" />

<div id="MenuAdmShortCut">
    <div class="TxtInsertUpdate"><asp:Literal ID="lt_insert_update" runat="server"></asp:Literal></div>
    <div class="pdControl">
        <div class="cb h20"><!----></div>        
        <div class="text"><div class="pt8">Danh mục cha:</div></div>
        <div class="control">
            <asp:DropDownList ID="ddlParrentCategories" runat="server" Width="603px"></asp:DropDownList>                
        </div>
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <div class="cbh8"><!----></div>       
        <div class="text">Chọn modul có sẵn:</div>
        <div class="control">
            <div><asp:DropDownList ID="ddlModul" Width="603px" runat="server" onselectedindexchanged="ddlModul_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></div>
            <div class="cbh5"><!----></div>
            <div><asp:DropDownList ID="ddlModulCate" Width="603px" runat="server" onselectedindexchanged="ddlModulCate_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></div>
        </div>
        <div class="cbh8"><!----></div>                      
        <div class="text">Tên menu:</div>
        <div class="control">
                <asp:TextBox ID="tbTitle" runat="server" Width="603px" CssClass="tbTitle"></asp:TextBox>                    
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbTitle" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        <div class="cbh8"><!----></div>
        <div class="text">Đường dẫn:</div>
        <div class="control">
            <asp:TextBox ID="tbUrl" runat="server" Width="603px"></asp:TextBox>                
        </div>
        <div class="cbh8"><!----></div>
        
            </ContentTemplate>
        </asp:UpdatePanel>       
        <div class="cbh8"><!----></div>
        <div>
            <div class="text"><div class="pt8">Ảnh đại diện 1:</div></div>
            <div class="control">
                <div><asp:Literal ID="ltimg" runat="server"></asp:Literal></div>
                <div><asp:LinkButton ID="btnXoaAnhHienTai" runat="server" onclick="btnXoaAnhHienTai_Click" Visible="false">Xóa ảnh hiện tại</asp:LinkButton></div>
                <asp:FileUpload ID="flimg" runat="server" Width="600px" />
            </div>
            <div class="cbh0"><!----></div>
            <div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="flimg" Display="Dynamic" 
                    ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." 
                    SetFocusOnError="True" 
                    ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
            </div>
            <div class="cbh8"><!----></div>
            <div class="dn">
                <div class="text">
                <div class="pt8">Ảnh đại diện 2:</div>
            </div>
            <div class="control">
                <div><asp:Literal ID="ltimg2" runat="server"></asp:Literal></div>
                <div><asp:LinkButton ID="btnXoaAnhHienTai2" runat="server" onclick="btnXoaAnhHienTai2_Click" Visible="false">Xóa ảnh hiện tại</asp:LinkButton></div>
                <asp:FileUpload ID="flimgHover" runat="server" Width="600px" />
            </div>
            <div class="cbh0"><!----></div>
            <div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="flimgHover" Display="Dynamic" 
                    ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." 
                    SetFocusOnError="True" 
                    ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
            </div>
            <div class="cbh8"><!----></div>
            </div>
        </div>
        <div class="text"><div class="pt8">Tùy chọn mở trang:</div></div>
        <div class="control">
            <asp:DropDownList ID="ddlNewTabOption" runat="server" Width="603px">
                <asp:ListItem Value="0">Mở trang tại của sổ hiện tại</asp:ListItem>
                <asp:ListItem Value="1">Mở trang tại của sổ mới</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt8">Thứ tự:</div></div>
        <div class="control">
            <asp:TextBox ID="tbOrder" runat="server" Width="35px" Text="1"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="tbOrder" 
                Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator>
        </div>
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt5">Trạng thái:</div></div>
        <div class="control"><asp:CheckBox ID="cbStatus" Checked="true" runat="server" CssClass="cccc fs11 flex-center" Text="(tích chọn để hiển thị)" /></div>
        <div class="cbh5"><!----></div>
        <asp:Panel ID="pnTiepTucMenu" runat="server">
            <div class="text"><div class="pt8">&nbsp;</div></div>
            <div class="control"><asp:CheckBox ID="cbContinue" Checked="true" runat="server" CssClass="cccc fs11 flex-center" Text="Tiếp tục tạo mục mới sau khi tạo mục này" /></div>
            <div class="cbh8"><!----></div>
        </asp:Panel>
        
        <div class="dn"> 
        <div class="TextSeoLink">Tối ưu cho công cụ tìm kiếm: </div>
        <div>
            <div class="text"><div class="pt8">Link Rewrite: </div></div>
            <div class="control"><asp:TextBox ID="tbLinkRewrite" runat="server" Width="450px" CssClass="tbLink_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt8">Tag tiêu đề: </div></div>
            <div class="control"><asp:TextBox ID="tbTagTitle" runat="server" Width="450px" CssClass="tbTitle_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt8">Tag từ khóa: </div></div>
            <div class="control"><asp:TextBox ID="tbTagKeyword" runat="server" Width="450px" CssClass="tbKeyword_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt8">Tag mô tả: </div></div>
            <div class="control"><asp:TextBox ID="tbTagDescription" runat="server" CssClass="tbDesc_Seo" Width="600px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
        </div>
        </div>

        <div class="cb h20"><!----></div>
        <div class="tac">
            <asp:Button ID="btOK" runat="server" onclick="btOK_Click"/>
            <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" onclick="btCancel_Click" CausesValidation="false"/>
        </div>
        <div class="cb h20"><!----></div>
    </div>    
</div>