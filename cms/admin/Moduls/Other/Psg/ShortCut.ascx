﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCut.ascx.cs" Inherits="cms_admin_Moduls_Other_Psg_ShortCut" %>
<%@ Import Namespace="Developer" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">
    <link href="~/cms/admin/Moduls/Other/Psg/ShortCut/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>
<asp:HiddenField ID="hd_img" runat="server" />
<div id="ShortCut">
    <div class="TxtInsertUpdate"><asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
    <div class="pdControl">
        <div class="cb h20"><!----></div>        
        <div class="text"><div class="pt5"><%=Developer.PageSingleContentKeyword.ViTri%></div></div>
        <div class="control"><asp:DropDownList ID="DdlPosition" runat="server" Width="252px"></asp:DropDownList></div>
        <div class="cbh8"><!----></div>    
        <div class="text"><div class="pt5"><%=PageSingleContentKeyword.TieuDe%></div></div>
        <div class="control">
            <asp:TextBox ID="txt_title_modul" runat="server" Width="580px" CssClass="tbTitle"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txt_title_modul" Display="Dynamic"></asp:RequiredFieldValidator>                
        </div>
        <div class="cbh8"><!----></div>         
        <div class="text"><div class="pt5"><%=PageSingleContentKeyword.MoTa%>:</div></div>
        <div class="control">
            <asp:TextBox ID="txtDesc" runat="server" Width="580px" Height="50px" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>                            
        </div>
        <div class="cbh8"><!----></div>         
        <div class="text"><%=PageSingleContentKeyword.AnhDaiDien%>:</div>
        <div class="controlImg">
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
            <div><asp:LinkButton ID="btnXoaAnhHienTai" runat="server" Visible="false" onclick="btnXoaAnhHienTai_Click">Xóa hình ảnh hiện tại</asp:LinkButton></div>
            <div><asp:FileUpload ID="flimg" runat="server" Width="220px" /></div>
            <div>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ErrorMessage="Vui lòng chọn ảnh có phần mở rộng là jpg, jpeg, png, gif hoặc bmp." ControlToValidate="flimg" Display="Dynamic" 
                    SetFocusOnError="True" ValidationExpression=".+\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)"></asp:RegularExpressionValidator>
            </div>    
            <a class="ThietLapAnh" href="javascript:Toggle('Toogle_ThietLapAnhDaiDien')">Ẩn/Hiện thiết lập ảnh</a>        
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
        </div>
        </div>
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt5"><%=PageSingleContentKeyword.NgayDang %>:</div></div>
        <div class="control">
            <asp:TextBox ID="txtCreateDate" runat="server" Width="150px"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txtCreateDate"></asp:RequiredFieldValidator>
        </div>
        <div class="cb"><!----></div>
        <div class="text"><div class="pt5"><%=PageSingleContentKeyword.ThuTu %>:</div></div>
        <div class="control">
            <asp:TextBox ID="txt_ordermodul" runat="server" Width="35px" Text="1"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="txt_ordermodul" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator> 
        </div>
        <div class="cbh8"><!----></div>
        <div><%=NewKeyword.ChiTiet%></div>
        <div class="cbh10"><!----></div>
        <div><CKEditor:CKEditorControl ID="txt_content" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/PageSingleContent"></CKEditor:CKEditorControl></div>        
        <div class="cbh20"><!----></div>
        <div class="KhungToiUu PdKhungToiUu">
            <div class="TextSeoLink"><%=PageSingleContentKeyword.ToiUuTimKiem%> </div>
            <div class="text"><div class="pt5"><%=NewKeyword.ToiUuDuongDan%>: </div></div>
            <div class="control"><asp:TextBox ID="textLinkRewrite" runat="server" Width="450px" CssClass="tbLink_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=PageSingleContentKeyword.ToiUuTheTieuDe%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagTitle" runat="server" Width="450px" CssClass="tbTitle_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=PageSingleContentKeyword.ToiUuTheTuKhoa%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagKeyword" runat="server" Width="450px" CssClass="tbKeyword_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt5"><%=PageSingleContentKeyword.ToiUuTheMoTa%>: </div></div>
            <div class="control"><asp:TextBox ID="textTagDescription" runat="server" CssClass="tbDesc_Seo" Width="550px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
        </div>
    
        <div class="cb h8"><!----></div>
        <div class="text"><div class="pt5"><%=PageSingleContentKeyword.TrangThai %>:</div></div>
        <div class="control">
            <div><asp:CheckBox ID="chk_status" runat="server" CssClass="cccc fs11" Text="(tích chọn để hiển thị)" Checked="true"/></div>
        </div>
        <div class="cbh8"><!----></div>
        <div class="text"><!---->&nbsp;</div>
        <div class="control">
            <asp:CheckBox CssClass='fl' ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
            <div class="cbh0"><!----></div>
        </div>
        <div class="cb h20"><!----></div>
        <div class="tac">
            <asp:Button ID="btn_insert_update" runat="server" onclick="btn_insert_update_Click" Width="120px"/>
            <asp:Button ID="btn_cancel" runat="server" Text="Hủy bỏ" onclick="btn_cancel_Click" Width="80px" CausesValidation="false"/>
        </div>                
        <div class="cb h10"><!----></div>
    </div>
</div>