<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Leftmenu.ascx.cs" Inherits="cms_admin_Moduls_DuyetTin_Leftmenu" %>

<div id="NewAdmLeftMenu">
  <div class="BgTabTongQuan"><a class="TextInTabTongQuan" href="admin.aspx?uc=<%=uc %>">Tổng quan modul duyệt tin</a></div>
  <div class="DanhMucQuanLy"><%=Developer.DuyetTinKeyword.PheDuyetBaiViet %></div>
  <div class="PdSpaceCate">
    <div class=''>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>
  <div class="ArroundCate<%=SetSelectedCate("BaiVietDaDuyet") %>">
    <div class="PdIconInfomation">
      <a href="?uc=<%=uc %>&suc=BaiVietDaDuyet" title="<%=Developer.DuyetTinKeyword.BaiVietDaDuyet %>">
        <div class='iconDanhSach'>
          <!---->
        </div>
      </a>
    </div>
    <a class="TextCateManager" href="?uc=<%=uc %>&suc=BaiVietDaDuyet"><%=Developer.DuyetTinKeyword.BaiVietDaDuyet %></a>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="ArroundCate<%=SetSelectedCate("BaiVietChoPheDuyet") %>">
    <div class="PdIconInfomation">
      <a href="?uc=<%=uc %>&suc=BaiVietChoPheDuyet" title="<%=Developer.DuyetTinKeyword.BaiVietChoPheDuyet %>">
        <div class='iconDanhSach'>
          <!---->
        </div>
      </a>
    </div>
    <a class="TextCateManager" href="?uc=<%=uc %>&suc=BaiVietChoPheDuyet"><%=Developer.DuyetTinKeyword.BaiVietChoPheDuyet %><asp:Literal ID="totalPost" runat="server" /></a>
    <div class="cbh0">
      <!---->
    </div>
  </div>
  <div class="cbh20"></div>
  <div class="DanhMucQuanLy">Tìm kiếm nhanh</div>
  <div class="PdSpaceCate">
    <div class=''>
      <div class="SpaceCate">
        <!---->
      </div>
    </div>
  </div>

  <div id="LocDuyetTin">
    <div class="LocTitle">Tìm theo modul:</div>
    <asp:DropDownList ID="ddlModuleSearch" runat="server"></asp:DropDownList>
    <div class="LocTitle">Tìm theo người đăng:</div>
    <asp:DropDownList ID="ddlUserSearch" runat="server"></asp:DropDownList>
    <div class="LocTitle">Tìm theo tiêu đề:</div>
    <asp:TextBox ID="tbTitleSearch" runat="server"></asp:TextBox>
    <div class="LocTitle">Tìm theo khoảng thời gian:</div>
    <div class="rangeTime">
      <asp:TextBox ID="tbDateFrom" autocomplete="off" placeholder="Từ ngày" ClientIDMode="static" runat="server"></asp:TextBox>
      <asp:TextBox ID="tbDateTo" autocomplete="off" placeholder="Đến ngày" ClientIDMode="static" runat="server"></asp:TextBox>
    </div>
    <asp:LinkButton ID="ltrSearch" runat="server" CssClass="lbtSearch" OnClick="ltrSearch_Click">&nbsp;</asp:LinkButton>
  </div>
</div>

<script>
	$(function () {
	  $('#tbDateFrom, #tbDateTo').keypress(function (e) {
			e.preventDefault();
		});
	$.datepicker.setDefaults($.datepicker.regional["vi"]);
  var dateFormat = "dd/mm/yy",
    from = $("#tbDateFrom")
      .datepicker({
        defaultDate: "0",
        changeMonth: true,
        numberOfMonths: 1,
        dateFormat: dateFormat
      })
      .on( "change", function() {
        to.datepicker( "option", "minDate", getDate( this ) );
      }),
    to = $("#tbDateTo").datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat: dateFormat
    })
    .on( "change", function() {
      from.datepicker( "option", "maxDate", getDate( this ) );
    });
 
  function getDate( element ) {
    var date;
    try {
      date = $.datepicker.parseDate( dateFormat, element.value );
    } catch( error ) {
      date = null;
    }
    return date;
  }
});
</script>