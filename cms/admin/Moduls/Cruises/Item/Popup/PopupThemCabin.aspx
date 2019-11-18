<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupThemCabin.aspx.cs" Inherits="cms_admin_Moduls_Cruises_Item_Popup_PopupThemCabinAspx" ValidateRequest="false" %>
<%@ Import Namespace="Developer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm mới, chỉnh sửa cabin</title>    
    <script src="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    
    <link href="../../../../cs/Common.css" rel="stylesheet" />
    <link href="../../../../cs/admin.css" rel="stylesheet" />
    <link href="../../../../cs/AllModul/css.css" rel="stylesheet" />
    
    <%--jAlert - http://labs.abeautifulsite.net/archived/jquery-alerts/demo/--%>
    <script src="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/js/jAlert/jquery.alerts.js" type="text/javascript"></script>
    <script src="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/js/jAlert/jquery.ui.draggable.js" type="text/javascript"></script>    
    <link href="../../../../js/jAleart/jquery.alerts.css" rel="stylesheet" />
    
    <%--định dạng số tiền trong textbox - https://github.com/BobKnothe/autoNumeric--%>    
    <script type="text/javascript" src="<%=TatThanhJsc.Extension.UrlExtension.WebisteUrl %>cms/admin/js/autoNumeric/autoNumeric.js"></script>

</head>
<body style="margin:0;padding:0;background:#fff">
    <form id="form1" runat="server">
    <div class="InsertPanel">
        <%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
        <%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>

        <div class="head"><asp:Literal ID="ltrHead" runat="server"></asp:Literal></div>
        <div class="controlBox">
            <div class="row">
                <div class="text">Cabin</div>
                <div class="control">
                    <asp:TextBox ID="tbCabin" runat="server" placeholder="VD: Deluxe Cabin"></asp:TextBox>                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbCabin">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện"/>
            
            <div class="row">
                <div class="text">Sức chứa tối đa</div>
                <div class="control">
                    <asp:TextBox ID="tbSuChuaToiDa" runat="server" Width="50px" Text="1" CssClass="autoNumeric"></asp:TextBox> người
                </div>
            </div>
            <div class="row">
                <div class="text"><%= CruisesKeyword.GiaNiemYet %></div>
                <div class="control">
                    <asp:TextBox ID="tbGiaNiemYet" runat="server" CssClass="autoNumeric"></asp:TextBox>                
                </div>
            </div>
            <div class="row">
                <div class="text"><%= CruisesKeyword.GiaKhuyenMai %></div>
                <div class="control">
                    <asp:TextBox ID="tbGiaKhuyenMai" runat="server" CssClass="autoNumeric"></asp:TextBox>                
                </div>
            </div>
            <div class="row">
                <div class="text">Tiện ích cabin</div>
                <div class="khungThuocTinh cblBaoGom">
                    <asp:CheckBoxList ID="cblBaoGom" runat="server"></asp:CheckBoxList>
                </div>
            </div>

            <div class="row">
                <div class="text">Có thể trả lại cabin không (refundable)</div>
                <div class="control">
                    <asp:DropDownList ID="ddlCoTheTraPhongKhong" runat="server" CssClass="width2">
                        <asp:ListItem Text="Không" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Có" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row">
                <div class="text">Có gồm bữa sáng không</div>
                <div class="control">
                    <asp:DropDownList ID="ddlCoGomBuaSangKhong" runat="server" CssClass="width2">
                        <asp:ListItem Text="Không" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Có" Value="1"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row">
                <div class="text">Diện tích cabin</div>
                <div class="control">
                    <asp:TextBox ID="tbDienTichPhong" runat="server" CssClass="autoNumeric" Width="50px">0</asp:TextBox> m<sup>2</sup>
                </div>
            </div>
            <div class="row">
                <div class="text">Loại giường</div>
                <div class="control">
                    <asp:TextBox ID="tbLoaiGiuong" runat="server" CssClass="width2"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="text">Hướng</div>
                <div class="control">
                    <asp:TextBox ID="tbHuongPhong" runat="server" CssClass="width2"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div class="text">Thứ tự</div>
                <div class="control">
                    <asp:TextBox ID="tbThuTu" runat="server" Width="50px" Text="1" CssClass="NotReset autoNumeric"></asp:TextBox>                   
                </div>
            </div>
            <div class="row">
                <div class="text">Trạng thái</div>
                <div class="control">
                    <asp:CheckBox ID="cbTrangThai" runat="server" Text="Tích chọn để hiển thị" Checked="true"/>
                </div>
            </div>
            <div class="row">
                Mô tả chi tiết
                <div class="pt5">
                    <CKEditor:CKEditorControl ID="tbChiTiet" runat="server"></CKEditor:CKEditorControl>
                    <asp:HiddenField ID="hdChiTiet" runat="server" />
                </div>            
            </div>
            <div class="tac">
                <asp:Button ID="btOK" runat="server" Text="Đồng ý" OnClick="btOK_Click" OnClientClick="RemoveAutoNumeric()"/>
                
                <div class="thongBaoTaoXong">
                    <asp:Literal ID="ltrThongBao" runat="server"></asp:Literal>
                </div>
            </div>
            <div class="cbh10"><!----></div>
        </div>
    </div>
        
    <script type="text/javascript">
        $(document).ready(function () {
            $(".autoNumeric").autoNumeric("init", {
                aSep: '.',
                aDec: ',',
                aForm: true,
                mDec: '0'
            });

            //$("#ShortcutItems .autoNumeric").autoNumeric("set", this.val());
        });
    
        //Xóa định dạng khi postback, phải gọi hàm này ở nút postback (OnClientClick="RemoveAutoNumeric()")
        function RemoveAutoNumeric() {
            jQuery('.autoNumeric').each(function () {
                jQuery(this).val(jQuery(this).autoNumeric('get'));
            });
        }
    </script>
    </form>
</body>
</html>
