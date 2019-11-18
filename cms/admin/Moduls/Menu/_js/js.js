function UpdateOrderGroup(igid, igparentid, app) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Menu/Ajax/UpdateOrderGroup.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid, "app": app }, function(result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}