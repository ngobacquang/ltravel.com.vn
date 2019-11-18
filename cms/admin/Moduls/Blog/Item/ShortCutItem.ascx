<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_Blog_Item_ShortCutItem" %>
<%@ Import Namespace="Developer" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">    
    <link href="~/cms/admin/Moduls/Blog/Item/ShortCutItem/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:HiddenField ID="hdOldBlog" runat="server" Value=""/>
<asp:HiddenField ID="HdTimeCreate" runat="server" Value=""/>
<asp:HiddenField ID="hd_img" runat="server" />
<asp:HiddenField ID="HdIitotalview" runat="server" />

<div id="admscitem">
    <div class="cb h20"><!----></div>
    <div class="text"><div class="pt5"><%=BlogKeyword.DanhMucCha%></div></div>
    <div class="control"><asp:DropDownList ID="ddl_group_product" runat="server" Width="222px"></asp:DropDownList> </div>
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=BlogKeyword.TieuDe%></div></div>
    <div class="control">
        <asp:TextBox ID="txt_title" runat="server" Width="600px" CssClass="tbTitle"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="txt_title"></asp:RequiredFieldValidator>     
    </div>

    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=BlogKeyword.Ma%></div></div>
    <div class="control">
        <asp:TextBox ID="tbKey" runat="server" Width="400px"></asp:TextBox>        
    </div>

    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=BlogKeyword.MoTa%></div></div>
    <div class="box"><asp:TextBox ID="txt_description" runat="server" Width="600px" Height="60px" CssClass="tbDesc" TextMode="MultiLine"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=BlogKeyword.TacGia%></div></div>
    <div class="control">
        <asp:TextBox ID="tbAuthor" runat="server" Width="400px"></asp:TextBox>        
    </div>
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt5"><%=BlogKeyword.NgayDang%></div></div>
    <div>
        <asp:TextBox ID="txtCreateDate" runat="server" Width="150px"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txtCreateDate"></asp:RequiredFieldValidator>
    </div>   
    <div class="cbh8"><!----></div>    
    <div class="text"><div class="pt5"><%=BlogKeyword.ThuTu%></div></div>
    <div class="control">
        <asp:TextBox ID="tbOrder" runat="server" Width="35px" Text="1"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbOrder" Display="Dynamic" 
                SetFocusOnError="True" ValidationExpression="(\d)*"></asp:RegularExpressionValidator>
    </div>

    <div class="cbh8"><!----></div>
    <div style="float: left" class="text"><%=BlogKeyword.AnhDaiDien%></div>
    <div style="float: left;width: 600px">
    <div class="khungThuocTinh psr">    
        <%--Đóng dấu ảnh--%>
        <asp:HiddenField ID="hdLogoImage" runat="server" Value=""/>
        <asp:HiddenField ID="hdViTriDongDau" runat="server" Value=""/>
        <asp:HiddenField ID="hdLeX" runat="server" Value=""/>
        <asp:HiddenField ID="hdLeY" runat="server" Value=""/>
        <asp:HiddenField ID="hdTyLe" runat="server" Value=""/>
        <asp:HiddenField ID="hdTrongSuot" runat="server" Value=""/>
        <%--Đóng dấu ảnh - end --%>
        <div><asp:Literal ID="ltimg" runat="server" Visible="true"></asp:Literal></div>
        <div><asp:LinkButton ID="lnk_delete_Image_current" runat="server" Visible="false" onclick="lnk_delete_Image_current_Click">Xóa hình ảnh hiện tại</asp:LinkButton></div>
        <div><asp:FileUpload ID="flimg" runat="server" Width="220px" /></div>
        <div>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic" 
                SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
        </div>    
        <a class="ThietLapAnh" href="javascript:Toggle('Toogle_ThietLapAnhDaiDien')">Ẩn/Hiện thiết lập ảnh</a>        
        <div class="pt5">
            <asp:CheckBox ID="cbLayAnhTuNoiDung" runat="server" Checked="True" Text="Lấy ảnh đầu tiên trong Chi tiết làm ảnh đại diện"/>
        </div>
        <div id="Toogle_ThietLapAnhDaiDien" style="display:none"> <%--Đặt tên div bắt đầu bằng Toogle_ để được khởi tạo trạng thái ẩn hiện bằng js --%>
            <div class="cb h10"><!----></div>
            <asp:CheckBox ID="cbDongDauAnh" runat="server" Text="Đóng dấu ảnh"/>
            <div class="cb h5"><!----></div>
            <div class="fl">
                <asp:CheckBox ID="cbHanCheKichThuoc" runat="server" Text="Hạn chế kích thước tối đa cho ảnh đại diện"/>
                <div class="khungThuocTinh">
                    Rộng <asp:TextBox ID="tbHanCheW" runat="server" ToolTip="Chiều rộng lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                    Cao <asp:TextBox ID="tbHanCheH" runat="server" ToolTip="Chiều cao lớn nhất có thể của ảnh đại diện, nếu ảnh có kích thước lớn hơn nó sẽ tự co lại"></asp:TextBox>&nbsp;px
                </div>
            </div>
            <div class="fr">
                <asp:CheckBox ID="cbTaoAnhNho" runat="server" Text="Tạo ảnh nhỏ cho ảnh đại diện(thumbnails)"/>
                <div class="khungThuocTinh">
                Rộng <asp:TextBox ID="tbAnhNhoW" runat="server" ToolTip="Chiều rộng của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px&nbsp;&nbsp;&nbsp;
                Cao <asp:TextBox ID="tbAnhNhoH" runat="server" ToolTip="Chiều cao của ảnh nhỏ. Ảnh nhỏ dùng để hiển thị thay thế cho ảnh đại diện nhằm giảm tải dữ liệu phải tải về máy khách khi hiển thị"></asp:TextBox>&nbsp;px
                </div>
            </div>
            <div class="cb"><!----></div>  
        </div>
    </div></div>
    <div class="dn">
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt5"><%=BlogKeyword.MoTaHinhAnh%></div></div>
        <div class="box"><asp:TextBox ID="TbDescImg" runat="server" Width="600px"></asp:TextBox></div>
    </div>
    <div>
        <asp:PlaceHolder ID="plhOtherFields" runat="server"></asp:PlaceHolder>
    </div>
    <div class="cbh10"><!----></div>
    
    <div><%=BlogKeyword.ChiTiet%></div>
    <div class="cbh10"><!----></div>
    <div><CKEditor:CKEditorControl ID="txt_content" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Blog"></CKEditor:CKEditorControl></div>        
    <div class="cbh10"><!----></div>       
                                
    <asp:Panel ID="pnThuocTinhBlog" runat="server">
    <div class="cbh8"><!----></div>        
    <div><%=Developer.BlogKeyword.ThuocTinhBlog%></div>
    <div class="cbh8"><!----></div>
    <div class="ThuocTinhBlog">
        <asp:Repeater ID="rptProperties" runat="server">
            <ItemTemplate>
                <div class='motMuc'>
                    <asp:CheckBox ID="checkBoxProperties" runat="server" ToolTip='<%#Eval(TatThanhJsc.Columns.GroupsColumns.IgidColumn).ToString() %>'/>                                    
                    <%#Eval(TatThanhJsc.Columns.GroupsColumns.VgnameColumn).ToString() %>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <div class="cbh0"><!----></div>
    </div>
    </asp:Panel>    
    <div class="cb h10"><!----></div>
     
    <div class="KhungToiUu PdKhungToiUu">
        <div class="TextSeoLink"><%=BlogKeyword.ToiUuTimKiem%> </div>
        <div>
            <div class="text"><div class="pt5"><%=BlogKeyword.ToiUuTheTieuDe%> </div></div>
            <div class="control1"><asp:TextBox ID="textTagTitle" runat="server" Width="400px" CssClass="tbTitle_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=BlogKeyword.ToiUuDuongDan%> </div></div>
            <div class="control1"><asp:TextBox ID="textLinkRewrite" runat="server" Width="400px" CssClass="tbLink_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=BlogKeyword.ToiUuTheMoTa%> </div></div>
            <div class="control1"><asp:TextBox ID="textTagDescription" runat="server" CssClass="tbDesc_Seo" Width="550px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=BlogKeyword.ToiUuTheTuKhoa%> </div></div>
            <div class="control1"><asp:TextBox ID="textTagKeyword" runat="server" Width="400px" CssClass="tbKeyword_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="dn">
                <div class="text"><div class="pt5"><%=BlogKeyword.Tag%> </div></div>
                <div class="control1"><asp:TextBox ID="TextBox1" runat="server" Width="550px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
                <div class="cbh8"><!----></div>
            </div>
        </div>
    </div>
    <div class="cbh8"><!----></div>
    <div class="text"><%=BlogKeyword.TrangThai%></div>
    <div class="fl"><asp:CheckBox ID="chk_status" runat="server"  CssClass="cccc fs11" Text="(tích chọn để hiển thị)" Checked="true"/></div>
    <div class="cbh8"><!----></div>
    <div class="text"><!---->&nbsp;</div>
    <div>
        <asp:CheckBox CssClass="fl" ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
        <div class="cbh0"><!----></div>
    </div>
    <div class="cbh20"><!----></div>        

    <div class="tac">
        <asp:Button ID="btn_insert_update" Width="120px" runat="server" onclick="btn_insert_update_Click" />
        <asp:Button ID="btn_cancel" Width="80px" runat="server" Text="Hủy bỏ" onclick="btn_cancel_Click" CausesValidation="false"/>
    </div>
    <div class="cbh10"><!----></div>        
</div>
