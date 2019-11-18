function UpdateEnableSubItem(isid) {
    var val = "";
    var ElementCssClass = document.getElementById("nc" + isid).className;
    val = ElementCssClass.substring(ElementCssClass.length - 1, ElementCssClass.length)

    $.post(WebsiteUrl + "cms/admin/Ajax/SubItems/UpdateEnableSubItems.aspx", { "isid": isid, "isenable": val }, function (result) {
        if (val == 0) {
            $("#nc" + isid).removeClass("EnableIcon0");
            $("#nc" + isid).addClass("EnableIcon1");
        }
        else if (val == 1) {
            $("#nc" + isid).removeClass("EnableIcon1");
            $("#nc" + isid).addClass("EnableIcon0");
        }
    });
}

function DeleteSubItem(isid, titleItem,pic) {
    var msg = "<b>Bạn có chắc chắn muốn xóa bản ghi này không?</b>";
    var msgSuccess = "<b>Bạn đã xóa thành công ''" + titleItem + "''</b>";
    jConfirm(msg, 'Thông báo', function (r) {
        if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/SubItems/DeleteSubItems.aspx", { "isid": isid,"pic":pic }, function (result) {

                $("#Item-" + isid).slideUp();
                $("#DeleteItem").html(result);
                ThongBao('3000', msgSuccess);
            });
        }
    });
}

function DeleteListSubItems(pic) {
    var msg = "<b>Bạn có chắc chắn muốn xóa các bản ghi này không?</b>";
    var msgSuccess = "<b>Bạn đã xóa thành công các bản ghi vừa chọn</b>";
    var alertMes = "";
    var id = "";
    jQuery(".content input[type=checkbox]").each(function () {
        if (this.checked) {
            id = this.id.substring(this.id.lastIndexOf("_") + 1);
            alertMes += id + ",";
        }
    });
    jConfirm(msg, 'Thông báo', function (r) {
        if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/SubItems/DeleteListSubItems.aspx", { "listigid": alertMes,"pic":pic }, function (result) {
                ThongBao('3000', msgSuccess);
            });
        }

        jQuery(".content input[type=checkbox]").each(function () {
            if (this.checked) {
                id = this.id.substring(this.id.lastIndexOf("_") + 1);
                $("#Item-" + id).slideUp();
            }
        });
    });
}