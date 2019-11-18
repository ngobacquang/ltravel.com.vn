<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutCate.ascx.cs" Inherits="cms_admin_Moduls_Hotel_Cate_ShortCutCate" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>

<asp:HiddenField ID="hdOldContent" runat="server" Value=""/>

<div id="ShortCutCate" class="InsertPanel InitQuikMenu">
    <div class="head"><asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
    <div class="controlBox">
        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.DanhMucCha %></div>
            <div class="control"><asp:DropDownList ID="ddlParentCate" runat="server"></asp:DropDownList></div>
        </div>
        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.TenDanhMuc%></div>
            <div class="control">
                <asp:TextBox ID="tbTitle" runat="server" CssClass="tbTitle"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbTitle" Display="Dynamic"></asp:RequiredFieldValidator>                
            </div>
        </div>
        <div class="row">
            <div class="text"><div class="pt5"><%=Developer.HotelKeyword.MoTa%></div></div>
            <div class="control">
                <asp:TextBox ID="tbDesc" runat="server" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>                            
            </div>
        </div>

        <uc1:UploadImage runat="server" id="flAnhDaiDien" Text="Ảnh đại diện"/>

        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.ThuTu %></div>
            <div class="control">
                <asp:TextBox ID="tbOrder" runat="server" Width="35px" Text="1"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="tbOrder" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator> 
            </div>
        </div>
        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.TrangThai %></div>
            <div class="control">
                <asp:CheckBox ID="cbStatus" runat="server" Text="Tích chọn để hiển thị" Checked="true"/>
            </div>
        </div>
        <div class="row">
            <div class="text">&nbsp;</div>
            <div class="control">
                <asp:CheckBox ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>                
            </div>
        </div>
        <div class="row dn">
            <%=Developer.ProductKeyword.ChiTiet%>        
            <div class="pt10"><CKEditor:CKEditorControl ID="tbDetail" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&amp;path=pic/Hotel"></CKEditor:CKEditorControl></div>
        </div>
                
        
        <div class="subHead"><%=Developer.HotelKeyword.ToiUuTimKiem%> </div>
        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.ToiUuTheTieuDe%> (title)</div>
            <div class="control"><asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox></div>    
        </div>
        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.ToiUuDuongDan%> (url)</div>
            <div class="control"><asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox></div>
        </div>        
        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.ToiUuTheTuKhoa%> (meta keyword)</div>
            <div class="control"><asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox></div>    
        </div>
        <div class="row">
            <div class="text"><%=Developer.HotelKeyword.ToiUuTheMoTa%> (meta description)</div>
            <div class="control"><asp:TextBox ID="tbSeoDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc_Seo"></asp:TextBox></div>
        </div>        

        <div class="cb h20"><!----></div>
        <div class="tac">
            <div class="text textFinish" style="font-size:0">Hoàn thành</div><div class="cb"><!----></div>
            <asp:Button ID="btOK" runat="server" onclick="btOK_Click"/>
            <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" onclick="btCancel_Click" CausesValidation="false"/>            
        </div>                
        <div class="cb h10"><!----></div>
    </div>
</div>