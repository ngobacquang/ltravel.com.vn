function UpdateOrderCate_Video(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Video/Ajax/UpdateOrderCate.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}

function UpdateOrderProperty_Video(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Video/Ajax/UpdateOrderProperty.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}

function UpdateOrderGroupItem_Video(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Video/Ajax/UpdateOrderGroupItem.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}