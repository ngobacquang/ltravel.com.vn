<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShortCutItem.ascx.cs" Inherits="cms_admin_Moduls_Tour_Item_ShortCutItem" %>
<%@ Import Namespace="Developer" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/UploadImage.ascx" TagPrefix="uc1" TagName="UploadImage" %>
<%@ Register Src="~/cms/admin/TempControls/InsertForm/GoogleMapMarkLocation.ascx" TagPrefix="uc1" TagName="GoogleMapMarkLocation" %>
<%@ Register Src="~/cms/admin/Moduls/Tour/Item/Popup/PopupThemLichTrinh.ascx" TagPrefix="uc1" TagName="PopupThemLichTrinh" %>
<%@ Register Src="~/cms/admin/Moduls/Tour/Item/Popup/PopupThemHinhAnh.ascx" TagPrefix="uc1" TagName="PopupThemHinhAnh" %>
<style>
  .text { padding-top: 5px !important; }
  textarea { padding-top: 5px!important }
</style>
<asp:HiddenField ID="hdTotalView" runat="server" />
<asp:HiddenField ID="hdGroupsItemId" runat="server" />
<div id="ShortCutItem" class="InsertPanel InitQuikMenu">
  <div class="head">
    <asp:Literal ID="LtInsertUpdate" runat="server"></asp:Literal>
  </div>
  <div class="controlBox">
    <div class="row">
      <div class="text"><%= TourKeyword.DanhMucCha %></div>
      <div class="control">
        <asp:DropDownList ID="ddlParentCate" runat="server"></asp:DropDownList>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.TieuDe %></div>
      <div class="control">
        <asp:TextBox ID="tbTenTour" runat="server" CssClass="tbTitle"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
          ErrorMessage="*" SetFocusOnError="True" Display="Dynamic" ControlToValidate="tbTenTour">
        </asp:RequiredFieldValidator>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.Ma %></div>
      <div class="control">
        <asp:TextBox ID="tbMaTour" runat="server"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.MoTa %></div>
      <div class="control">
        <asp:TextBox ID="tbMoTa" runat="server" TextMode="MultiLine" CssClass="tbDesc"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.NgayDang %></div>
      <div class="control">
        <asp:TextBox ID="tbNgayDang" runat="server" CssClass="stb"></asp:TextBox><span class="cccc fs11"> (mm/dd/yyyy)</span>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" SetFocusOnError="True" ControlToValidate="tbNgayDang"></asp:RequiredFieldValidator>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.ThuTu %></div>
      <div class="control">
        <asp:TextBox ID="tbThuTu" runat="server" Width="35px" Text="1" CssClass="NotReset"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
          ErrorMessage="Vui lòng nhập thứ tự kiểu số (vd:1 hoặc 2)" ControlToValidate="tbThuTu" Display="Dynamic"
          SetFocusOnError="True" ValidationExpression="(\d)*">
        </asp:RegularExpressionValidator>
      </div>
    </div>
    <uc1:UploadImage runat="server" ID="flAnhDaiDien" Text="Ảnh đại diện" />
    <div class="h10"></div>
    <style>
      .customWrap { display: flex; flex-wrap: wrap; max-width: 80%; }
        .customWrap > .row { width: 50%; }
        .customWrap .text { min-width: 140px; padding-left: 0 !important; }
    </style>
    <div class="<%=SetEnableClass(TourConfig.HienThiGiaBan) %>">
      <div class="customWrap">
        <div class="row <%=SetEnableClass(TourConfig.HienThiGiaBan) %> row-4 fl">
          <div class="text"><%= TourKeyword.GiaNiemYet %></div>
          <div class="control">
            <asp:TextBox ID="tbGiaNiemYet" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          </div>
        </div>
        <div class="row <%=SetEnableClass(TourConfig.HienThiGiaBan) %> row-4 fl cwauto">
          <div class="text"><%= TourKeyword.GiaKhuyenMai %></div>
          <div class="control">
            <asp:TextBox ID="tbGiaKhuyenMai" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          </div>
        </div>
      </div>
      <div class="customWrap">
        <div class="row <%=SetEnableClass(TourConfig.HienThiGiaBan) %> row-3 fl">
          <div class="text"><%= TourKeyword.GiaChoNguoiLon %></div>
          <div class="control">
            <asp:TextBox ID="tbGiaChoNguoiLon" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          </div>
        </div>
        <div class="row <%=SetEnableClass(TourConfig.HienThiGiaBan) %> row-3 fl cwauto">
          <div class="text">Giá cho trẻ từ 8 - 11 tuổi</div>
          <div class="control">
            <asp:TextBox ID="tbGiaChoTreViThanhNien" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          </div>
        </div>
        <div class="row <%=SetEnableClass(TourConfig.HienThiGiaBan) %> row-3 fl cwauto">
          <div class="text">Giá cho trẻ từ 3 - 7 tuổi</div>
          <div class="control">
            <asp:TextBox ID="tbGiaChoTreEm" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          </div>
        </div>
        <div class="row <%=SetEnableClass(TourConfig.HienThiGiaBan) %> row-3 fl cwauto">
          <div class="text">Giá cho trẻ dưới 3 tuổi</div>
          <div class="control">
            <asp:TextBox ID="tbGiaChoEmBe" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          </div>
        </div>
      </div>
    </div>

    <div class="cb h10">
      <!---->
    </div>

    <div class="row <%=SetEnableClass(TourConfig.HienThiThoiGianTour) %>">
      <div class="text"><%= TourKeyword.ThoiGianTour %></div>
      <div class="control">
        <div class="fl">
          <asp:TextBox ID="tbSoNgay" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          ngày
        </div>
        <div class="fl pl10">
          <asp:TextBox ID="tbSoDem" runat="server" CssClass="autoNumeric">0</asp:TextBox>
          đêm
        </div>
        <div class="cb">
          <!---->
        </div>
      </div>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiTongSoKhach) %>">
      <div class="text"><%= TourKeyword.TongSoKhach %></div>
      <div class="control">
        <asp:TextBox ID="tbTongSoKhach" runat="server" CssClass="autoNumeric">0</asp:TextBox>
      </div>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiNgayKhoiHanh) %>">
      <div class="text">Ngày khởi hành</div>
      <div class="control">
        <asp:TextBox ID="tbNgayKhoiHanh" runat="server" placeholder="VD: Hàng ngày, hàng tuần, 22/02/2020"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text">Giờ khởi hành</div>
      <div class="control">
        <asp:TextBox ID="tbGioKhoiHanh" runat="server" placeholder="VD: 8.30 am, 9:30, 12h10"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text">Xuất phát từ</div>
      <div class="control">
        <asp:TextBox ID="tbXuatPhat" runat="server" placeholder="VD: Hà Nội, Đà Nẵng"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text">Phương tiện di chuyển</div>
      <div class="control">
        <asp:TextBox ID="tbPhuongTien" runat="server" placeholder="VD: Ô tô, xe máy, tàu"></asp:TextBox>
      </div>
    </div>
    <style>
      .customSelect { width: 150px!important }
    </style>
    <div class="row <%=SetEnableClass(TourConfig.HienThiPhuongTien) %>">
      <div class="text">Thời gian tour</div>
      <asp:DropDownList ID="ddlThoiGianTour" CssClass="customSelect" runat="server"></asp:DropDownList>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiQuanLyThuocTinh) %>">
      <div class="text">Điểm đến</div>
      <asp:DropDownList ID="ddlDiemDen" CssClass="customSelect" runat="server"></asp:DropDownList>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiCacDiemDenSeQua) %>">
      <div class="text"><%= TourKeyword.CacDiemDenSeQua %></div>
      <div class="control">
        <asp:TextBox ID="tbCacDiemDenSeQua" runat="server" placeholder="VD: Hà Nội, Sapa"></asp:TextBox>
        <div class="pt5">
          Hoặc chọn thay thế từ danh sách dưới để liên kết với modul điểm đến (cần xóa trống ô ở trên)<br />
          <div class="chonDienDen">
            <div class="col1" onclick="HoverNutChon()">
              <div class="head">Tất cả điểm đến</div>
              <div class="cacDiemDenChuaChon">
                <asp:Literal ID="ltrCacDiemDenChuaChon" runat="server"></asp:Literal>
              </div>
            </div>
            <div class="col2">
              <a class="chon" href="javascript:ChonDiemDenSeQua()" title="Chọn các điểm đến đang được tích ở cột trái">>></a><br />
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
  <style>
    .customWrap2 { display: flex; align-items: center }
    .customWrap2 .text { padding-top: 0!important; min-width: 150px }
  </style>
    <div class="row <%=SetEnableClass(TourConfig.HienThiTongQuan) %>">
      <div class="text"><%= TourKeyword.TongQuan %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbTongQuan" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdTongQuan" runat="server" Value="" />
      </div>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiLichTrinh) %>">
      <div class="customWrap2">
        <div class="text">Lịch trình</div>
        <a class="LinkCreate" href="javascript:ThemLichTrinh(<%=iid %>)">Thêm lịch trình</a>
      </div>

      <uc1:PopupThemLichTrinh runat="server" ID="PopupThemLichTrinh" />
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiThuVienAnh) %>">
      <div class="customWrap2">
        <div class="text" style="width: auto; float: none; display: inline-block">Hình ảnh</div>
      <a class="LinkCreate" href="javascript:ThemHinhAnh(<%=iid %>)">Thêm hình ảnh</a>
      </div>

      <uc1:PopupThemHinhAnh runat="server" ID="PopupThemHinhAnh" />
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiBangGiaVaChoO) %>">
      <div class="text"><%= TourKeyword.BangGiaVaChoO %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbBangGiaVaChoO" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdBangGiaVaChoO" runat="server" Value="" />
      </div>
    </div>
    <div class="row">
      <div class="text">Mã nhúng Youtube</div>
      <div class="control">
        <asp:TextBox ID="tbYoutubeEmbed" runat="server" TextMode="MultiLine" placeholder="Là đoạn mã chia sẻ được lấy từ Youtube"></asp:TextBox>
      </div>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiBanDo) %>">
      <div class="text"><%= TourKeyword.MaDinhKemBanDoTour %></div>
      <div class="control">
        <asp:TextBox ID="tbMaDinhKemBanDoTour" runat="server" TextMode="MultiLine" placeholder="Là đoạn mã chia sẻ được lấy từ Google maps"></asp:TextBox>
      </div>
    </div>
    <div class="<%=SetEnableClass(TourConfig.HienThiBanDo) %> dn">
      <uc1:GoogleMapMarkLocation runat="server" ID="GoogleMapMarkLocation" Text="Hoặc chọn vị trí ở bản đồ sau" />
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiBaoGom) %>">
      <div class="text"><%= TourKeyword.BaoGom %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbBaoGom" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdBaoGom" runat="server" Value="" />
      </div>
      <div class="pt5">
        Hoặc tích chọn thay thế từ danh sách dưới (cần xóa trống ô ở trên)<br />
        <div class="khungThuocTinh cblBaoGom">
          <asp:CheckBoxList ID="cblBaoGom" runat="server"></asp:CheckBoxList>
        </div>
      </div>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiKhongBaoGom) %>">
      <div class="text"><%= TourKeyword.KhongBaoGom %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbKhongBaoGom" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdKhongBaoGom" runat="server" Value="" />
      </div>
      <div class="pt5">
        Hoặc tích chọn thay thế từ danh sách dưới (cần xóa trống ô ở trên)<br />
        <div class="khungThuocTinh cblKhongBaoGom">
          <asp:CheckBoxList ID="cblKhongBaoGom" runat="server"></asp:CheckBoxList>
        </div>
      </div>

      <script type="text/javascript">
        //js khi tích hoặc bỏ tích ở bao gồm, không bao gồm thì tự bỏ tích mục tương ứng ở phần kia
        $(".cblBaoGom input[type=checkbox]").change(function () {
          var text = $(this).parent().find("label").text();
          var checked = !this.checked;
          $(".cblKhongBaoGom label").filter(function (index) { return $(this).text() === text; }).parent().find("input[type=checkbox]").attr("checked", checked);
        });

        $(".cblKhongBaoGom input[type=checkbox]").change(function () {
          var text = $(this).parent().find("label").text();
          var checked = !this.checked;
          $(".cblBaoGom label").filter(function (index) { return $(this).text() === text; }).parent().find("input[type=checkbox]").attr("checked", checked);
        });
      </script>
    </div>
    <div class="row <%=SetEnableClass(TourConfig.HienThiDieuKhoanKhac) %>">
      <div class="text"><%= TourKeyword.DieuKhoanKhac %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbDieuKhoanKhac" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdDieuKhoanKhac" runat="server" Value="" />
      </div>
    </div>

    <div class="row <%=SetEnableClass(TourConfig.HienThiThongTinPhu1) %>">
      <div class="text"><%= TourKeyword.ThongTinPhu1 %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbThongTinPhu1" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdThongTinPhu1" runat="server" Value="" />
      </div>
    </div>

    <div class="row <%=SetEnableClass(TourConfig.HienThiThongTinPhu2) %>">
      <div class="text"><%= TourKeyword.ThongTinPhu2 %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbThongTinPhu2" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdThongTinPhu2" runat="server" Value="" />
      </div>
    </div>

    <div class="row <%=SetEnableClass(TourConfig.HienThiThongTinPhu3) %>">
      <div class="text"><%= TourKeyword.ThongTinPhu3 %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbThongTinPhu3" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdThongTinPhu3" runat="server" Value="" />
      </div>
    </div>

    <div class="row <%=SetEnableClass(TourConfig.HienThiThongTinPhu4) %>">
      <div class="text"><%= TourKeyword.ThongTinPhu4 %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbThongTinPhu4" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdThongTinPhu4" runat="server" Value="" />
      </div>
    </div>

    <div class="row <%=SetEnableClass(TourConfig.HienThiThongTinPhu5) %>">
      <div class="text"><%= TourKeyword.ThongTinPhu5 %></div>
      <div class="pt5 cb">
        <CKEditor:CKEditorControl ID="tbThongTinPhu5" runat="server" FilebrowserImageBrowseUrl="ckeditor/ckfinder/ckfinder.aspx?type=Images&path=pic/Tour"></CKEditor:CKEditorControl>
        <asp:HiddenField ID="hdThongTinPhu5" runat="server" Value="" />
      </div>
    </div>

    <div class="KhungToiUu PdKhungToiUu">
      <div class="subHead"><%= TourKeyword.ToiUuTimKiem %> </div>

    <div class="row">
      <div class="text"><%= TourKeyword.ToiUuTheTieuDe %> (title)</div>
      <div class="control">
        <asp:TextBox ID="tbSeoTitle" runat="server" CssClass="tbTitle_seo"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.ToiUuDuongDan %> (url)</div>
      <div class="control">
        <asp:TextBox ID="tbSeoLink" runat="server" CssClass="tbLink_seo"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.ToiUuTheTuKhoa %> (meta keyword)</div>
      <div class="control">
        <asp:TextBox ID="tbSeoKeyword" runat="server" CssClass="tbKeyword_seo"></asp:TextBox>
      </div>
    </div>
    <div class="row">
      <div class="text"><%= TourKeyword.ToiUuTheMoTa %> (meta description)</div>
      <div class="control">
        <asp:TextBox ID="tbSeoDescription" runat="server" TextMode="MultiLine" CssClass="tbDesc_Seo"></asp:TextBox>
      </div>
    </div>
    </div>

    <div class="h20"></div>
    <div class="row">
      <div class="text"><%= TourKeyword.TrangThai %></div>
      <div class="control">
        <asp:CheckBox ID="cbTrangThai" CssClass="flex-center" runat="server" Text="Tích chọn để hiển thị" Checked="true" />
      </div>
    </div>
    <div class="row">
      <div class="text">&nbsp;</div>
      <div class="control">
        <asp:CheckBox ID="cbTiepTuc" CssClass="flex-center" runat="server" Text="Tiếp tục tạo mục khác sau khi tạo mục này" />
      </div>
    </div>

    <div class="tac">
      <div class="text textFinish" style="font-size: 0">Hoàn thành</div>
      <div class="cb">
        <!---->
      </div>

      <asp:Button ID="btOK" runat="server" OnClientClick="RemoveAutoNumeric()" OnClick="btOK_Click" />
      <asp:Button ID="btCancel" runat="server" Text="Hủy bỏ" OnClick="btCancel_Click" CausesValidation="false" />
    </div>
    <div class="cbh10">
      <!---->
    </div>
  </div>
</div>
