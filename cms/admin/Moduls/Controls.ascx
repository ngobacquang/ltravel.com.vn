<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Controls.ascx.cs" Inherits="cms_admin_Controls" %>
<%@ Register Src="~/cms/admin/Moduls/Other/DcLink/SubControls/SubDcLinkCheckLink.ascx" TagPrefix="uc1" TagName="SubDcLinkCheckLink" %>

<asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder>
<uc1:SubDcLinkCheckLink runat="server" ID="SubDcLinkCheckLink" />

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

<%--Khởi tạo menu di chuyển nhanh ở các form thêm mới, cập nhật--%>
<%--<div id="QuickMenuRight">
  <a href="#" class="headTab">Di chuyển nhanh (&uarr; lên đầu trang)</a>
</div>
<script type="text/javascript">
  //Khởi tạo menu di chuyển nhanh
  if ($(".InitQuikMenu").length < 1)
    $("#QuickMenuRight").hide();

  var countQM = 0;
  $(".InitQuikMenu .text:visible").each(function () {
    if ($(this).text().replace(/\s/g, '').length > 0) {
      countQM++;
      if ($(this).hasClass("textFinish"))
        $("#QuickMenuRight").append("<a class='textFinish' href='javascript://'>" + $(this).text() + "</a>");
      else
        $("#QuickMenuRight").append("<a href='javascript://'>" + countQM + ". " + $(this).text() + "</a>");
    }
  });

  //Khởi tạo sự kiện khi click vào di chuyển nhanh
  $("#QuickMenuRight a").click(function () {
    var text = $(this).text();

    if (text.indexOf(".") > 0)
      text = text.substring(text.indexOf(".") + 2);

    $('.text').removeClass("focus");
    $('.text').filter(function (index) { return $(this).text() === text; }).addClass("focus");

    $('html, body').animate({
      scrollTop: $('.text').filter(function (index) { return $(this).text() === text; }).offset().top - 10
    }, 500);
  });
</script>--%>