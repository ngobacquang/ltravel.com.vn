function UpdateOrderCate_New(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/New/Ajax/UpdateOrderCate.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}

function UpdateOrderProperty_New(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/New/Ajax/UpdateOrderProperty.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}

function UpdateOrderGroupItem_New(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/New/Ajax/UpdateOrderGroupItem.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}