<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupThemLichTrinh.aspx.cs" Inherits="cms_admin_Moduls_Tour_Item_Popup_PopupThemLichTrinhAspx" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm mới, chỉnh sửa lịch trình</title>    
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
                <div class="text">Ngày</div>
                <div class="control">
                    <asp:TextBox ID="tbNgay" runat="server" placeholder="VD: Ngày 1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbNgay">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <div class="text">Tên hoạt động</div>
                <div class="control">
                    <asp:TextBox ID="tbTenHoatDong" runat="server" placeholder="VD: Thăm quan Hà Nội"></asp:TextBox>                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbTenHoatDong">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
            <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện"/>
            <div class="row <%=SetEnableClass(TourConfig.HienThiCacDiemDenSeQua) %>">
                <div class="text">Các điểm đến sẽ qua</div>
                <div class="control">
                    <asp:TextBox ID="tbCacDiemDenSeQua" runat="server" placeholder="VD: Hà Nội, Sapa"></asp:TextBox>
                    <div class="pt5">
                        Hoặc chọn thay thế từ danh sách dưới để liên kết với modul điểm đến (cần xóa trống ô ở trên)<br/>
                        <div class="chonDienDen">
                            <div class="col1" onclick="HoverNutChon()">
                                <div class="head">Tất cả điểm đến</div>
                                <div class="cacDiemDenChuaChon">                                
                                    <asp:Literal ID="ltrCacDiemDenChuaChon" runat="server"></asp:Literal>
                                </div>
                            </div>
                            <div class="col2">
                                <a class="chon" href="javascript:ChonDiemDenSeQua()" title="Chọn các điểm đến đang được tích ở cột trái">>></a><br/>
                                <a class="bochon" href="javascript:BoChonDiemDenSeQua()" title="Bỏ chọn các điểm đến đang được tích ở cột phải"><<</a>
                            </div>
                            <div class="col3" onclick="HoverNutBoChon()">
                                <div class="head">Các điểm đến đã chọn</div>
                                <div class="cacDiemDenDaChon">
                                    <asp:Literal ID="ltrCacDiemDenDaChon" runat="server"></asp:Literal>
                                </div>
                            </div>
                            <asp:HiddenField ID="hdIdCacDiemDenSeQua" runat="server" />
                            <script type="text/javascript">
                                //Hiển thị ra các điểm đến đã chọn bằng javascript
                                //Code behind sẽ đẩy ra danh sách các điểm đã chọn vào hidden field hdIdCacDiemDenSeQua, sau đó js sẽ hiển thị ra
                                function HienThiDiemDaChon() {
                                    $(".cacDiemDenDaChon").html("");
                                    var listId = $("#<%=hdIdCacDiemDenSeQua.ClientID%>").val().split(",");

                                    for (var i = 0; i < listId.length; i++) {
                                        var cb = $(".cacDiemDenChuaChon input[type=checkbox][id=cbd_0_" + listId[i] + "]");                                        
                                        if (cb.length > 0) {
                                            var text = $(cb).parent().text();
                                            var id = "cbd_1_" + listId[i];

                                            if ($(".cacDiemDenDaChon input[type=checkbox][id=" + id + "]").length < 1)
                                                $(".cacDiemDenDaChon").append("<div class='dest0'><label for='" + id + "'><input id='" + id + "' type='checkbox'/>" + text + "</label></div>");
                                        }
                                    }
                                }

                                HienThiDiemDaChon();
                            </script>
                            <script type="text/javascript">
                                function ChonDiemDenSeQua() {
                                    $(".cacDiemDenChuaChon input[type=checkbox]:checked").each(function () {
                                        var id = $(this).attr("id").replace("cbd_0_", "cbd_1_");
                                        var text = $(this).parent().text();

                                        if ($(".cacDiemDenDaChon input[type=checkbox][id=" + id + "]").length < 1)
                                            $(".cacDiemDenDaChon").append("<div class='dest0'><label for='" + id + "'><input id='" + id + "' type='checkbox'/>" + text + "</label></div>");

                                        $(this).attr("checked", false);
                                    });

                                    CapNhatIdDiemDaChon();
                                    BoHoverCacNut();
                                }

                                function BoChonDiemDenSeQua() {
                                    $(".cacDiemDenDaChon input[type=checkbox]:checked").each(function () {
                                        $(this).parent().parent().remove();
                                    });

                                    CapNhatIdDiemDaChon();
                                    BoHoverCacNut();
                                }

                                /*Cập nhật ra textbox server control để dùng code behind lưu lại*/
                                function CapNhatIdDiemDaChon() {
                                    var listId = "";
                                    $(".cacDiemDenDaChon input[type=checkbox]").each(function () {
                                        listId += $(this).attr("id").replace("cbd_1_", "") + ",";

                                    });

                                    $("#<%=hdIdCacDiemDenSeQua.ClientID%>").val(listId);
                                }

                                function HoverNutChon() {
                                    if ($(".cacDiemDenChuaChon input[type=checkbox]:checked").length > 0) {
                                        $(".chonDienDen .bochon").removeClass("hover");
                                        $(".chonDienDen .chon").addClass("hover");
                                    } else
                                        BoHoverCacNut();
                                }

                                function HoverNutBoChon() {
                                    if ($(".cacDiemDenDaChon input[type=checkbox]:checked").length > 0) {
                                        $(".chonDienDen .chon").removeClass("hover");
                                        $(".chonDienDen .bochon").addClass("hover");
                                    } else
                                        BoHoverCacNut();
                                }

                                function BoHoverCacNut() {
                                    $(".chonDienDen .chon").removeClass("hover");
                                    $(".chonDienDen .bochon").removeClass("hover");
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row <%=SetEnableClass(TourConfig.HienThiBuaAn) %>">
                <div class="text">Có bữa ăn</div>
                <div class="control">
                    <asp:CheckBoxList ID="cblBuaAn" runat="server">
                        <asp:ListItem Text="Ăn sáng(B)" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Ăn trưa(L)" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Ăn tối(D)" Value="3"></asp:ListItem>
                    </asp:CheckBoxList>
                </div>
            </div>
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
            <div class="row">
                Hoạt động chi tiết
                <div class="pt5">
                    <CKEditor:CKEditorControl ID="tbHoatDongChiTiet" FilebrowserBrowseUrl="/ckeditor/ckfinder/ckfinder.aspx" runat="server"></CKEditor:CKEditorControl>
                    <asp:HiddenField ID="hdHoatDongChiTiet" runat="server" />
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
