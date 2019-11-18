function UpdateOrderCate_Product(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Product/Ajax/UpdateOrderCate.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}

function UpdateOrderProperty_Product(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Product/Ajax/UpdateOrderProperty.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}

function UpdateOrderFilter_Product(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Product/Ajax/UpdateOrderFilter.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}

function UpdateOrderColor_Product(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Product/Ajax/UpdateOrderColor.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}

function UpdateOrderGroupItem_Product(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Product/Ajax/UpdateOrderGroupItem.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);

    });
}