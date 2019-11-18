<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_SupportOnline_Item_ShortCutItem" %>
<%@ Import Namespace="Developer" %>
<%@ Register TagPrefix="cc1" Namespace="CssJscriptOptimizer.Controls" Assembly="CssJscriptOptimizer" %>
<cc1:StyleSheetCombiner ID="sheetCombiner" runat="server">    
    <link href="~/cms/admin/Moduls/Other/SupportOnline/Item/ShortCutItem/_cs.css" rel="stylesheet" type="text/css" />
</cc1:StyleSheetCombiner>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:HiddenField ID="hdOldSupportOnline" runat="server" Value=""/>
<asp:HiddenField ID="HdTimeCreate" runat="server" Value=""/>
<asp:HiddenField ID="hd_img" runat="server" />
<asp:HiddenField ID="HdIitotalview" runat="server" />

<div id="admscitem">
    <div class="cb h20"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.DanhMucCha%></div></div>
    <div class="control"><asp:DropDownList ID="ddl_group_product" runat="server" Width="222px"></asp:DropDownList> </div>
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.TieuDe%></div></div>
    <div class="control">
        <asp:TextBox ID="txt_title" runat="server" Width="600px" CssClass="tbTitle"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="txt_title"></asp:RequiredFieldValidator>     
    </div>
        
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Yahoo%></div></div>
    <div class="control">
        <asp:TextBox ID="tbYahoo" runat="server" Width="600px"></asp:TextBox>        
    </div>
    
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Skype%></div></div>
    <div class="control">
        <asp:TextBox ID="tbSkype" runat="server" Width="600px"></asp:TextBox>        
    </div>
    
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Phone%></div></div>
    <div class="control">
        <asp:TextBox ID="tbPhone" runat="server" Width="600px"></asp:TextBox>        
    </div>
    
    <div class="dn">
        <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Mobile%></div></div>
    <div class="control">
        <asp:TextBox ID="tbMobile" runat="server" Width="600px"></asp:TextBox>        
    </div>
    </div>
    
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Email%></div></div>
    <div class="control">
        <asp:TextBox ID="tbEmail" runat="server" Width="600px"></asp:TextBox>        
    </div>
    
    <div class="dn">
        <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Zalo%></div></div>
    <div class="control">
        <asp:TextBox ID="tbZalo" runat="server" Width="600px"></asp:TextBox>        
    </div>
    
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Viber%></div></div>
    <div class="control">
        <asp:TextBox ID="tbViber" runat="server" Width="600px"></asp:TextBox>        
    </div>
    
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Facebook%></div></div>
    <div class="control">
        <asp:TextBox ID="tbFacebook" runat="server" Width="600px"></asp:TextBox>        
    </div>
    
    <div class="cbh8"><!----></div>
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.LoaiKhac%></div></div>
    <div class="control">
        <asp:TextBox ID="tbLoaiKhac" runat="server" Width="400px"></asp:TextBox><br/>
        <div class="pt10 huongDanKhac" style="line-height:18px">
            Hướng dẫn cho link của loại khác
            <ol>
                <li>Gọi tới số điện thoại: <b>tel:số điện thoại</b>. Ví dụ: <a href="tel:0902234481">tel:0902234481</a></li>
                <li>Gửi tới email nào đó: <b>mailto:email_nhận</b>. Ví dụ: <a href="mailto:kythuat@tatthanh.com.vn">mailto:kythuat@tatthanh.com.vn</a></li>
                <li>Link tới website: <b>link web đầy đủ</b>. Ví dụ: <a href="http://tatthanh.com.vn">http://tatthanh.com.vn</a></li>
                <li>Nhắn tin tới Yahoo: <b>ymsgr:sendim?tên_nick</b>. Ví dụ: <a href="ymsgr:sendim?hotro.tatthanh">ymsgr:sendim?hotro.tatthanh</a></li>
                <li>Gọi tới Skype: <b>skype:tên_nick?call</b>. Ví dụ: <a href="skype:hotro.tatthanh?call">skype:hotro.tatthanh?call</a></li>
                <li>Nhắn tin tới Skype: <b>skype:tên_nick?chat</b>. Ví dụ: <a href="skype:hotro.tatthanh?chat">skype:hotro.tatthanh?chat</a></li>
                <li>Nhắn tin tới facebook messenger: <b>https://www.facebook.com/messages/nick_facebook</b>. Ví dụ: <a href="https://www.facebook.com/messages/nick_facebook">https://www.facebook.com/messages/nick_facebook</a></li>
                <li>Mở cửa sổ chát Zopim (yêu cầu trang phải cài mã Zopim trước): <b>javascript:$zopim.livechat.window.toggle();</b>. Ví dụ: <a href="javascript:$zopim.livechat.window.toggle();">javascript:$zopim.livechat.window.toggle();</a></li>
                <li>Mở cửa sổ chát Subiz (yêu cầu trang phải cài mã Subiz trước): <b>javascript:_sbzq.push(['expandWidget']);</b>. Ví dụ: <a href="javascript:_sbzq.push(['expandWidget']);">javascript:_sbzq.push(['expandWidget']);</a></li>                
                <li>Gọi tới Zalo: <b>...</b></li>
                <li>Gọi tới Viber: <b>viber://add?number=số_cần_gọi</b>. Ví dụ: <a href="viber://add?number=0902234481">viber://add?number=0902234481</a></li>
            </ol>
            <style type="text/css">
                .huongDanKhac a{color:#7b68ee}
            </style>         
        </div>
    </div>
    </div>

    <div class="dn">
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Ma%></div></div>
        <div class="control">
            <asp:TextBox ID="tbKey" runat="server" Width="400px"></asp:TextBox>        
        </div>
    </div>

    <div class="cbh8"><!----></div>
    
    <div class="dn">
    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.MoTa%></div></div>
    <div class="box"><asp:TextBox ID="txt_description" runat="server" CssClass="tbDesc" Width="600px" Height="60px"  TextMode="MultiLine"></asp:TextBox></div>
    <div class="cbh8"><!----></div>
    </div>

    <div class="text"><div class="pt8"><%=SupportOnlineKeyword.NgayDang%></div></div>
    <div>
        <asp:TextBox ID="txtCreateDate" runat="server" Width="150px"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="txtCreateDate"></asp:RequiredFieldValidator>
    </div>
    <div class="cbh8"><!----></div>
    <div class="cbh8"><!----></div>
    <div style="float: left" class="text pt5"><%=SupportOnlineKeyword.AnhDaiDien%></div>
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
        <a class="ThietLapAnh dn" href="javascript:Toggle('Toogle_ThietLapAnhDaiDien')">Ẩn/Hiện thiết lập ảnh</a>        
        <div class="pt8 dn">
            <asp:CheckBox ID="cbLayAnhTuNoiDung" runat="server" Checked="True" Text="Lấy ảnh đầu tiên trong Chi tiết làm ảnh đại diện"/>
        </div>
        <div class="dn">
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
    </div></div>
    <div class="dn">
        <div class="cbh8"><!----></div>
        <div class="text"><div class="pt8"><%=SupportOnlineKeyword.MoTaHinhAnh%></div></div>
        <div class="box"><asp:TextBox ID="TbDescImg" runat="server" Width="600px"></asp:TextBox></div>
    </div>
    <div>
        <asp:PlaceHolder ID="plhOtherFields" runat="server"></asp:PlaceHolder>
    </div>
    <div class="dn">
    <div><%=SupportOnlineKeyword.ChiTiet%></div>
    <div class="cbh10"><!----></div>
    <div><CKEditor:CKEditorControl ID="txt_content" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/SupportOnline"></CKEditor:CKEditorControl></div>        
    <div class="cbh10"><!----></div>       
    </div>
                     
    <div class="cb h10"><!----></div>
     
    <div class="KhungToiUu PdKhungToiUu dn">
        <div class="TextSeoLink"><%=SupportOnlineKeyword.ToiUuTimKiem%> </div>
        <div>
            <div class="text"><div class="pt8"><%=SupportOnlineKeyword.ToiUuTheTieuDe%> </div></div>
            <div class="control1"><asp:TextBox ID="textTagTitle" runat="server" Width="400px" CssClass="tbTitle_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt8"><%=SupportOnlineKeyword.ToiUuDuongDan%> </div></div>
            <div class="control1"><asp:TextBox ID="textLinkRewrite" runat="server" Width="400px" CssClass="tbLink_seo"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt8"><%=SupportOnlineKeyword.ToiUuTheMoTa%> </div></div>
            <div class="control1"><asp:TextBox ID="textTagDescription" CssClass="tbDesc_Seo" runat="server" Width="550px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="text"><div class="pt8"><%=SupportOnlineKeyword.ToiUuTheTuKhoa%> </div></div>
            <div class="control1"><asp:TextBox ID="textTagKeyword" CssClass="tbKeyword_seo" runat="server" Width="400px"></asp:TextBox></div>
            <div class="cbh8"><!----></div>
            <div class="dn">
                <div class="text"><div class="pt8"><%=SupportOnlineKeyword.Tag%> </div></div>
                <div class="control1"><asp:TextBox ID="TextBox1" runat="server" Width="550px" Height="50px" TextMode="MultiLine"></asp:TextBox></div>
                <div class="cbh8"><!----></div>
            </div>
        </div>
    </div>
    
    <div class="text pt2"><%=SupportOnlineKeyword.TrangThai%></div>
    <div class="fl"><asp:CheckBox ID="chk_status" runat="server"  CssClass="cccc fs11 flex-center" Text="(tích chọn để hiển thị)" Checked="true"/></div>
    <div class="cbh8"><!----></div>
    <div class="text"><!---->&nbsp;</div>
    <div>
        <asp:CheckBox CssClass="fl flex-center" ID="ckbContinue" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
        <div class="cbh0"><!----></div>
    </div>
    <div class="cbh10"><!----></div>        

    <div class="tac">
        <asp:Button ID="btn_insert_update" Width="120px" runat="server" onclick="btn_insert_update_Click" />
        <asp:Button ID="btn_cancel" Width="80px" runat="server" Text="Hủy bỏ" onclick="btn_cancel_Click" CausesValidation="false"/>
    </div>
    <div class="cbh10"><!----></div>        
</div>
