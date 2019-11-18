<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutColor.ascx.cs" Inherits="cms_admin_Moduls_Product_Color_ShortCutColor" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Product/Color/ShortCutColor/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<asp:HiddenField ID="hd_img" runat="server" />
<div id="admsccate">
    <div class="TxtInsertUpdate"><asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
    <div class="pdControl">
        <div class="cb h20"><!----></div>        
        <div class="text"><div class="pt5"><%=Developer.ProductKeyword.DanhMucCha %></div></div>
        <div class="control"><asp:DropDownList ID="DdlGroupProduct" runat="server" Width="252px"></asp:DropDownList></div>
        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5"><%=Developer.ProductKeyword.TenMau%></div></div>
        <div class="control">
            <asp:TextBox ID="txt_title_modul" runat="server" Width="580px" CssClass="tbTitle"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txt_title_modul" Display="Dynamic"></asp:RequiredFieldValidator>                
        </div>
        <div class="cbh8"><!----></div>         
        <div class="text"><div class="pt5"><%=Developer.ProductKeyword.MoTa%>:</div></div>
        <div class="control">
            <asp:TextBox ID="txtDesc" runat="server" Width="580px" Height="50px" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>                            
        </div>
        
        <div class="cbh8"><!----></div>         
        <div class="text"><div class="pt5"><%=Developer.ProductKeyword.ChonMaMau%>:</div></div>
        <div class="control">
            <asp:TextBox ID="tbColor" Width="100px" runat="server" class="color"></asp:TextBox>                    
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbColor"></asp:RequiredFieldValidator>
        </div>        
                        
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt5"><%=Developer.ProductKeyword.ThuTu %>:</div></div>
        <div class="control">
            <asp:TextBox ID="txt_ordermodul" runat="server" Width="35px" Text="1"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="txt_ordermodul" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator> 
        </div>
        <div class="cb h8"><!----></div>
        <div class="text"><div class="pt5"><%=Developer.ProductKeyword.TrangThai %>:</div></div>
        <div class="control">
            <div><asp:CheckBox ID="chk_status" runat="server" CssClass="cccc fs11" Text="(tích chọn để hiển thị)" Checked="true"/></div>
        </div>
        <div class="cbh8"><!----></div>
        <div class="text"><!---->&nbsp;</div>
        <div class="control">
            <asp:CheckBox CssClass='fl' ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
            <div class="cbh0"><!----></div>
        </div>
        
        <div class="cbh20"><!----></div>
        <div class="TextSeoLink"><%=Developer.ProductKeyword.ToiUuTimKiem%> </div>
        <div>
            <div class="text"><div class="pt5"><%=Developer.ProductKeyword.ToiUuDuongDan%>: </div></div>
            <div class="control"><asp:TextBox ID="textLinkRewrite" runat="server" Width="450px" CssClass="tbLink_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=Developer.ProductKeyword.ToiUuTheTieuDe%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagTitle" runat="server" Width="450px" CssClass="tbTitle_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=Developer.ProductKeyword.ToiUuTheTuKhoa%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagKeyword" runat="server" Width="450px" CssClass="tbKeyword_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=Developer.ProductKeyword.ToiUuTheMoTa%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagDescription" runat="server" CssClass="tbDesc_Seo" Width="580px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
        </div>

        <div class="cb h20"><!----></div>
        <div class="tac">
            <asp:Button ID="btn_insert_update" runat="server" onclick="btn_insert_update_Click" Width="120px"/>
            <asp:Button ID="btn_cancel" runat="server" Text="Hủy bỏ" onclick="btn_cancel_Click" Width="80px" CausesValidation="false"/>
        </div>                
    </div>
</div>