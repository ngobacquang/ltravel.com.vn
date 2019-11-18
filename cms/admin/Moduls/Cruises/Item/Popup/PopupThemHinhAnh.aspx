<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupThemHinhAnh.aspx.cs" Inherits="cms_admin_Moduls_Cruises_Item_Popup_PopupThemHinhAnhAspx" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm mới, chỉnh sửa hình ảnh</title>    
    <script src="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    
    <link href="../../../../cs/Common.css" rel="stylesheet" />
    <link href="../../../../cs/admin.css" rel="stylesheet" />
    <link href="../../../../cs/AllModul/css.css" rel="stylesheet" />
    
    <%--jAlert - http://labs.abeautifulsite.net/archived/jquery-alerts/demo/--%>
    <script src="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/js/jAlert/jquery.alerts.js" type="text/javascript"></script>
    <script src="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/js/jAlert/jquery.ui.draggable.js" type="text/javascript"></script>    
    <link href="../../../../js/jAleart/jquery.alerts.css" rel="stylesheet" />
</head>
<body style="margin:0;padding:0;background:#fff">
    <form id="form1" runat="server">
    <div class="InsertPanel">
        <%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
        <%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>

        <div class="head"><asp:Literal ID="ltrHead" runat="server"></asp:Literal></div>
        <div class="controlBox">
            <div class="row">
                <div class="text">Tiêu đề</div>
                <div class="control">
                    <asp:TextBox ID="tbTieuDe" runat="server" placeholder="VD: Ảnh thăm quan Hà Nội"></asp:TextBox>                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbTieuDe">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <div class="text">Mô tả (nếu có)</div>
                <div class="control">
                    <asp:TextBox ID="tbMoTa" runat="server" TextMode="MultiLine" placeholder="VD: Ảnh thăm quan Hà Nội ngày..."></asp:TextBox>                    
                </div>
            </div>
            <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện" LayAnhTuNoiDung="False"/>
            
            
            <div class="row">
                <div class="text">Thứ tự</div>
                <div class="control">
                    <asp:TextBox ID="tbThuTu" runat="server" Width="35px" Text="1" CssClass="NotReset"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                                    ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbThuTu" Display="Dynamic"
                                                    SetFocusOnError="True" ValidationExpression="(\d)*">
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row">
                <div class="text">Trạng thái</div>
                <div class="control">
                    <asp:CheckBox ID="cbTrangThai" runat="server" Text="Tích chọn để hiển thị" Checked="true"/>
                </div>
            </div>
            
            <div class="tac">
                <asp:Button ID="btOK" runat="server" Text="Đồng ý" OnClick="btOK_Click"/>                
                <div class="thongBaoTaoXong">
                    <asp:Literal ID="ltrThongBao" runat="server"></asp:Literal>
                </div>
            </div>
            <div class="cbh10"><!----></div>
        </div>
    </div>
    </form>
</body>
</html>
