<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_Cruises_Item_ShortCutItem" %>
<%@ Import Namespace="Developer" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/GoogleMapMarkLocation.ascx" TagPrefix="uc1" TagName="GoogleMapMarkLocation" %>
<%@ Register Src="~/cms/admin/Moduls/Cruises/Item/Popup/PopupThemLichTrinh.ascx" TagPrefix="uc1" TagName="PopupThemLichTrinh" %>
<%@ Register Src="~/cms/admin/Moduls/Cruises/Item/Popup/PopupThemHinhAnh.ascx" TagPrefix="uc1" TagName="PopupThemHinhAnh" %>
<%@ Register Src="~/cms/admin/Moduls/Cruises/Item/Popup/PopupThemCabin.ascx" TagPrefix="uc1" TagName="PopupThemCabin" %>



<asp:HiddenField ID="hdTotalView" runat="server"/>
<asp:HiddenField ID="hdGroupsItemId" runat="server"/>
<div id="ShortCutItem" class="InsertPanel InitQuikMenu">
    <div class="head">
        <asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal>
    </div>
    <div class="controlBox">
        <div class="row">
            <div class="text"><%= CruisesKeyword.DanhMucCha %></div>
            <div class="control">
                <asp:DropDownList ID="ddlParentCate" runat="server"></asp:DropDownList>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.TieuDe %></div>
            <div class="control">
                <asp:TextBox ID="tbTenCruises" runat="server" CssClass="tbTitle"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                            ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbTenCruises">
                </asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.Ma %></div>
            <div class="control">
                <asp:TextBox ID="tbMaCruises" runat="server"></asp:TextBox>                
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.MoTa %></div>
            <div class="control">
                <asp:TextBox ID="tbMoTa" runat="server" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
            </div>
        </div>
        <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện"/>
        
        <div class="row">
            <div class="text"><%= CruisesKeyword.GiaNiemYet %></div>
            <div class="control">
                <asp:TextBox ID="tbGiaNiemYet" runat="server" CssClass="autoNumeric">0</asp:TextBox>                
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.GiaKhuyenMai %></div>
            <div class="control">
                <asp:TextBox ID="tbGiaKhuyenMai" runat="server" CssClass="autoNumeric">0</asp:TextBox>                
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.ThoiGianCruises %></div>
            <div class="control">
                <div class="fl"><asp:TextBox ID="tbSoNgay" runat="server" CssClass="autoNumeric">0</asp:TextBox> ngày</div>
                <div class="fl pl10"><asp:TextBox ID="tbSoDem" runat="server" CssClass="autoNumeric">0</asp:TextBox> đêm</div>
                <div class="cb"><!----></div>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.TongSoKhach %></div>
            <div class="control">
                <asp:TextBox ID="tbTongSoKhach" runat="server" CssClass="autoNumeric">0</asp:TextBox>                
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.NgayKhoiHanh %></div>
            <div class="control">
                <asp:TextBox ID="tbNgayKhoiHanh" runat="server" placeholder="VD: hàng ngày, hàng tuần, 15/01/2006"></asp:TextBox>                
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.CacDiemDenSeQua %></div>
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
                                    if (cb.length>0) {
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

        <div class="row">
            <div class="text"><%= CruisesKeyword.NgayDang %></div>
            <div class="control">
                <asp:TextBox ID="tbNgayDang" runat="server" CssClass="stb"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbNgayDang"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.ThuTu %></div>
            <div class="control">
                <asp:TextBox ID="tbThuTu" runat="server" Width="35px" Text="1" CssClass="NotReset"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                                ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbThuTu" Display="Dynamic"
                                                SetFocusOnError="True" ValidationExpression="(\d)*">
                </asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.TrangThai %></div>
            <div class="control">
                <asp:CheckBox ID="cbTrangThai" runat="server" Text="Tích chọn để hiển thị" Checked="true"/>
            </div>
        </div>
        <div class="row">
            <div class="text">&nbsp;</div>
            <div class="control">
                <asp:CheckBox ID="cbTiepTuc" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này"/>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.TongQuan %></div>
            <div class="pt5 cb">
                <CKEditor:CKEditorControl ID="tbTongQuan" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Cruises"></CKEditor:CKEditorControl>
                <asp:HiddenField ID="hdTongQuan" runat="server" Value=""/>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.LichTrinh %></div>
            <div class="pt5 cb">
                <CKEditor:CKEditorControl ID="tbLichTrinh" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Cruises"></CKEditor:CKEditorControl>
                <asp:HiddenField ID="hdLichTrinh" runat="server" Value=""/>
            </div>
            <div class="pt5 pb5">
                Hoặc lên lịch trình từng ngày (cần xóa trống ô ở trên) <a class="LinkCreate" href="javascript:ThemLichTrinh(<%=iid %>)">Thêm lịch trình</a>
            </div>
            
            <uc1:PopupThemLichTrinh runat="server" ID="PopupThemLichTrinh" />            
        </div>
        <div class="row">
            <div class="text" style="width:auto;float:none;display:inline-block"><%= CruisesKeyword.HinhAnh %></div>
            <a class="LinkCreate" href="javascript:ThemHinhAnh(<%=iid %>)">Thêm hình ảnh</a>
            
            <uc1:PopupThemHinhAnh runat="server" ID="PopupThemHinhAnh" />
        </div>
        
        <div class="row">
            <div class="text" style="width:auto;float:none;display:inline-block"><%= CruisesKeyword.Cabin %></div>
            <a class="LinkCreate" href="javascript:ThemCabin(<%=iid %>)">Thêm cabin</a>
            
            <uc1:PopupThemCabin runat="server" ID="PopupThemCabin" />
        </div>

        <div class="row">
            <div class="text"><%= CruisesKeyword.BangGiaVaChoO %></div>
            <div class="pt5 cb">
                <CKEditor:CKEditorControl ID="tbBangGiaVaChoO" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Cruises"></CKEditor:CKEditorControl>
                <asp:HiddenField ID="hdBangGiaVaChoO" runat="server" Value=""/>
            </div>
        </div>        
        <div class="row">
            <div class="text"><%= CruisesKeyword.MaDinhKemBanDoCruises %></div>
            <div class="control">
                <asp:TextBox ID="tbMaDinhKemBanDoCruises" runat="server" TextMode="MultiLine" placeholder="Là đoạn mã chia sẻ được lấy từ Google maps"></asp:TextBox>
            </div>
        </div>        
        <uc1:GoogleMapMarkLocation runat="server" ID="GoogleMapMarkLocation" Text="Hoặc chọn vị trí ở bản đồ sau"/>
        <div class="row">
            <div class="text"><%= CruisesKeyword.BaoGom %></div>
            <div class="pt5 cb">
                <CKEditor:CKEditorControl ID="tbBaoGom" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Cruises"></CKEditor:CKEditorControl>
                <asp:HiddenField ID="hdBaoGom" runat="server" Value=""/>
            </div>
            <div class="pt5">
                Hoặc tích chọn thay thế từ danh sách dưới (cần xóa trống ô ở trên)<br/>
                <div class="khungThuocTinh cblBaoGom">
                    <asp:CheckBoxList ID="cblBaoGom" runat="server"></asp:CheckBoxList>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.KhongBaoGom %></div>
            <div class="pt5 cb">
                <CKEditor:CKEditorControl ID="tbKhongBaoGom" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Cruises"></CKEditor:CKEditorControl>
                <asp:HiddenField ID="hdKhongBaoGom" runat="server" Value=""/>
            </div>
            <div class="pt5">
                Hoặc tích chọn thay thế từ danh sách dưới (cần xóa trống ô ở trên)<br/>
                <div class="khungThuocTinh cblKhongBaoGom">
                    <asp:CheckBoxList ID="cblKhongBaoGom" runat="server"></asp:CheckBoxList>
                </div>
            </div>
            
            <script type="text/javascript">
                //js khi tích hoặc bỏ tích ở bao gồm, không bao gồm thì tự bỏ tích mục tương ứng ở phần kia
                $(".cblBaoGom input[type=checkbox]").change(function() {
                    var text = $(this).parent().find("label").text();
                    var checked = !this.checked;
                    $(".cblKhongBaoGom label").filter(function(index) { return $(this).text() === text; }).parent().find("input[type=checkbox]").attr("checked", checked);
                });

                $(".cblKhongBaoGom input[type=checkbox]").change(function () {
                    var text = $(this).parent().find("label").text();
                    var checked = !this.checked;
                    $(".cblBaoGom label").filter(function (index) { return $(this).text() === text; }).parent().find("input[type=checkbox]").attr("checked", checked);
                });
            </script>
        </div>
        
        <div class="row">
            <div class="text"><%= CruisesKeyword.DieuKhoanKhac %></div>
            <div class="pt5 cb">
                <CKEditor:CKEditorControl ID="tbDieuKhoanKhac" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Cruises"></CKEditor:CKEditorControl>
                <asp:HiddenField ID="hdDieuKhoanKhac" runat="server" Value=""/>
            </div>            
        </div>

        <div class="row">
            <div class="text"><%= CruisesKeyword.Services %></div>
            <div class="pt5 cb">
                <CKEditor:CKEditorControl ID="tbServices" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Cruises"></CKEditor:CKEditorControl>
                <asp:HiddenField ID="hdServices" runat="server" Value=""/>
            </div>            
        </div>
        
        <div class="row">
            <div class="text pb5"><%=CruisesKeyword.ThuocTinh %></div>
            <div class="khungThuocTinh cb">
                <asp:CheckBoxList ID="cblThuocTinh" runat="server" CssClass="cblThuocTinh"></asp:CheckBoxList>
            </div>
        </div>
        

        <div class="subHead"><%= CruisesKeyword.ToiUuTimKiem %> </div>

        <div class="row">
            <div class="text"><%= CruisesKeyword.ToiUuTheTieuDe %> (title)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.ToiUuDuongDan %> (url)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.ToiUuTheTuKhoa %> (meta keyword)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox>
            </div>
        </div>
        <div class="row">
            <div class="text"><%= CruisesKeyword.ToiUuTheMoTa %> (meta description)</div>
            <div class="control">
                <asp:TextBox ID="tbSeoDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc_Seo"></asp:TextBox>
            </div>
        </div>

        <div class="tac">
            <div class="text textFinish" style="font-size:0">Hoàn thành</div><div class="cb"><!----></div>

            <asp:Button ID="btOK" runat="server" OnClientClick="RemoveAutoNumeric()" onclick="btOK_Click"/>
            <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" onclick="btCancel_Click" CausesValidation="false"/>
        </div>
        <div class="cbh10"><!----></div>
    </div>
</div>