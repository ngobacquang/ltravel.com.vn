function UpdateOrderCate_Tour(igid, igparentid) {
  var tbvalue = document.getElementById('TbOrder' + igid).value;
  $.post(WebsiteUrl + "cms/admin/Moduls/Tour/Ajax/UpdateOrderCate.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
    $("#CateOrder-" + igparentid).html(result);
    InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
  });
}