function UpdateOrderCate_SupportOnline(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Other/SupportOnline/Ajax/UpdateOrderCate.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}