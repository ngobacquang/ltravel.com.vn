function UpdateOrderCate_FileLibrary2(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/FileLibrary2/Ajax/UpdateOrderCate.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}

function UpdateOrderProperty_FileLibrary2(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/FileLibrary2/Ajax/UpdateOrderProperty.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}

function UpdateOrderGroupItem_FileLibrary2(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/FileLibrary2/Ajax/UpdateOrderGroupItem.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}