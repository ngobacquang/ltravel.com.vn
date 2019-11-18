<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutCate.ascx.cs" Inherits="cms_admin_Moduls_Destination_Cate_ShortCutCate" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/GoogleMapMarkLocation.ascx" TagPrefix="uc1" TagName="GoogleMapMarkLocation" %>


<asp:HiddenField ID="hdOldContent" runat="server" Value=""/>

<div id="ShortCutCate" class="InsertPanel InitQuikMenu">
    <div class="head"><asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal></div>
    <div class="controlBox">
        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.DanhMucCha %></div>
            <div class="control"><asp:DropDownList ID="ddlParentCate" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlParentCate_SelectedIndexChanged"></asp:DropDownList></div>
        </div>
        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.TenDanhMuc%></div>
            <div class="control">
                <asp:TextBox ID="tbTitle" runat="server" CssClass="tbTitle"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbTitle" Display="Dynamic"></asp:RequiredFieldValidator>                
            </div>
        </div>
        <div class="row">
            <div class="text"><div class="pt5"><%=Developer.DestinationKeyword.MoTa%></div></div>
            <div class="control">
                <asp:TextBox ID="tbDesc" runat="server" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>                            
            </div>
        </div>

        <uc1:UploadImage runat="server" id="flAnhDaiDien" Text="Ảnh đại diện tour"/>
        <uc1:UploadImage runat="server" id="flAnhQuocGia" Text="Cờ quốc gia (nếu có)"/>
        <uc1:UploadImage runat="server" id="flAnhGioiThieu" Text="Ảnh giới thiệu điểm đến"/>

        <asp:PlaceHolder ID="plOtherInfo" runat="server" Visible="False">
            <div class="row">
                <div class="text">Population (dân số)</div>
                <div class="control">
                    <asp:TextBox ID="tbDanSo" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="text">Capital City (thủ đô)</div>
                <div class="control">
                    <asp:TextBox ID="tbThuDo" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="text">People (dân tộc)</div>
                <div class="control">
                    <asp:TextBox ID="tbDanToc" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="text">Language (ngôn ngữ)</div>
                <div class="control">
                    <asp:TextBox ID="tbNgonNgu" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="text">Currency (tiền tệ)</div>
                <div class="control">
                    <asp:TextBox ID="tbTienTe" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="text">Time Zone (múi giờ)</div>
                <div class="control">
                    <asp:TextBox ID="tbMuiGio" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="text">International Dialing Code<br/>(Mã điện thoại quốc tế)</div>
                <div class="control">
                    <asp:TextBox ID="tbMaDTQuocTe" runat="server"></asp:TextBox>
                </div>
            </div>
        </asp:PlaceHolder>
        
        <uc1:GoogleMapMarkLocation runat="server" ID="GoogleMapMarkLocation" />

        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.ThuTu %></div>
            <div class="control">
                <asp:TextBox ID="tbOrder" runat="server" Width="35px" Text="1"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Vui lòng nhập thứ tự kiểu số(vd: 2)" ControlToValidate="tbOrder" Display="Dynamic" SetFocusOnError="True" ValidationExpression="\d*"></asp:RegularExpressionValidator> 
            </div>
        </div>
        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.TrangThai %></div>
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
        
        <div class="row">
            Thông tin tổng quan (Dân số, thời tiết, ngôn ngữ...)
            <div class="pt10"><CKEditor:CKEditorControl ID="tbThongSoTongQuan" Height="300px" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&amp;path=pic/Destination"></CKEditor:CKEditorControl></div>
        </div>

        <div class="row">
            <%=Developer.ProductKeyword.ChiTiet%>        
            <div class="pt10"><CKEditor:CKEditorControl ID="tbDetail" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&amp;path=pic/Destination"></CKEditor:CKEditorControl></div>
        </div>
                
        
        <div class="subHead"><%=Developer.DestinationKeyword.ToiUuTimKiem%> </div>
        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.ToiUuTheTieuDe%> (title)</div>
            <div class="control"><asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox></div>    
        </div>
        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.ToiUuDuongDan%> (url)</div>
            <div class="control"><asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox></div>
        </div>        
        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.ToiUuTheTuKhoa%> (meta keyword)</div>
            <div class="control"><asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox></div>    
        </div>
        <div class="row">
            <div class="text"><%=Developer.DestinationKeyword.ToiUuTheMoTa%> (meta description)</div>
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