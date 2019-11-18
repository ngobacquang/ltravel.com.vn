function ShowHideGroup(idList) {
    var val = "";
    val = document.getElementById("Cate-" + idList).className;
    ChangeShowHideGroup(idList, val);    
}
function ChangeShowHideGroup(idList,val) {        
    if (val == 0) {        
        $('#' + idList).slideDown();
        
        $("#Cate-" + idList).removeClass("0");
        $("#Cate-" + idList).addClass("1");

        $("#showhide" + idList).removeClass("IcoArrowShow0");
        $("#showhide" + idList).addClass("IcoArrowShow1");

        SaveShowHideGroupStatus(idList, 1);
    } else {        
        $('#' + idList).slideUp();

        $("#Cate-" + idList).removeClass("1");
        $("#Cate-" + idList).addClass("0");

        $("#showhide" + idList).removeClass("IcoArrowShow1");
        $("#showhide" + idList).addClass("IcoArrowShow0");

        SaveShowHideGroupStatus(idList, 0);
    }
}

function SaveShowHideGroupStatus(idList, status) {
    var value = getCookie("ShowHideGroup");
    if (!value)
        value = "&";
    
    if (value.indexOf("&" + idList + "=1" + "&") < 0 && value.indexOf("&" + idList + "=0" + "&") < 0)
        value = value + idList + "=" + status + "&";
    else {
        value = value.replace("&" + idList + "=1" + "&", "&" + idList + "=" + status + "&");
        value = value.replace("&" + idList + "=0" + "&", "&" + idList + "=" + status + "&");
    }

    setCookie("ShowHideGroup", value, "30", "/", "", "");
}

function InitShowHideGroup() {
    var value = getCookie("ShowHideGroup");
    if (!value)
        value = "&";    
    value = value.split("&");

    for (var i = 0; i < value.length; i++) {        
        var idList = value[i].split("=")[0];
        var status = value[i].split("=")[1];
        if (idList && status) {
            if (status == 0)
                status = 1;
            else
                status = 0;
            
            ChangeShowHideGroup(idList, status);
        }
    }
}


function DeleteGroup(igid, titleCate) {
    var msg = "<b>Bạn có chắc chắn muốn xóa bản ghi này không?</b>";
    var msgSuccess = "<b>Bạn đã xóa thành công ''" + titleCate + "''</b>";
    jConfirm(msg, 'Thông báo', function (r) {
        if (r) {
            $.post(WebsiteUrl + "cms/admin/Ajax/Groups/DeleteGroup.aspx", { "igid": igid }, function (result) {
                $("#Cate-" + igid).slideUp();
                $("#DeleteCate").html(result);
                ThongBao('3000', msgSuccess);
            });
        }
    });
}

function DeleteListGroups() {
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
            $.post(WebsiteUrl + "cms/admin/Ajax/Groups/DeleteListGroups.aspx", { "listigid": alertMes }, function (result) {
                $("#DeleteCate").html(result);
                alertMes = "Bạn đã xóa thành công các bản ghi vừa chọn!";
                ThongBao('3000', msgSuccess);
            });
        }

        jQuery(".content input[type=checkbox]").each(function () {
            if (this.checked) {
                id = this.id.substring(this.id.lastIndexOf("_") + 1);
                $("#Cate-" + id).slideUp();
            }
        });
    });
}

function UpdateEnableGroup(igid) {
    var val = "";
    var ElementCssClass = document.getElementById("nc" + igid).className;
    val = ElementCssClass.substring(ElementCssClass.length - 1, ElementCssClass.length)
    
    $.post(WebsiteUrl + "cms/admin/Ajax/Groups/UpdateEnableGroup.aspx", { "igid": igid, "igenable": val }, function (result) {
        if (val == 0) {
            $("#nc" + igid).removeClass("EnableIcon0");
            $("#nc" + igid).addClass("EnableIcon1");
        }
        else if (val == 1) {
            $("#nc" + igid).removeClass("EnableIcon1");
            $("#nc" + igid).addClass("EnableIcon0");
        }
    });
}

function RestoreGroup(igid, statusParent, listIgidChild, titleCate) {
    var msg = "<b>Bạn có chắc chắn muốn khôi phục bản ghi này không?</b>";
    var msg2 = "<b>Bạn phải khôi phục menu cha của bản ghi này!</b>";
    var msgSuccess = "Bạn đã khôi phục thành công '" + titleCate + "' ";
    if (statusParent == 1) {
        jConfirm(msg, 'Thông báo', function (r) {
            if (r) {
                $.post(WebsiteUrl + "cms/admin/Ajax/Groups/RestoreGroup.aspx", { "igid": igid }, function (result) {

                    $("#Cate-" + igid).slideUp();                    
                    var mySplitResult = listIgidChild.split(",");
                    for (i = 0; i < mySplitResult.length; i++) {
                        $("#Cate-" + mySplitResult[i]).slideUp();
                    }
                    ThongBao('3000', msgSuccess);
                });
            }
        });
    } else {
        jAlert(msg2, 'Thông báo');
    }
}

function DeleteRecGroup(igid,listIgidChild, titleCate,pic) {
    var msg = "<b>Bạn có chắc chắn muốn xóa bản ghi này không?</b>";
    var msgSuccess = "<b>Bạn đã xóa thành công ''" + titleCate + "''</b>";
    jConfirm(msg, 'Thông báo', function (r) {
        if (r) {
            $("#DeleteCate").html("");
            $.post(WebsiteUrl + "cms/admin/Ajax/Groups/DeleteRecGroup.aspx", { "igid": igid,"pic":pic }, function (result) {

                $("#Cate-" + igid).slideUp();
                var mySplitResult = listIgidChild.split(",");
                for (i = 0; i < mySplitResult.length; i++) {
                    $("#Cate-" + mySplitResult[i]).slideUp();
                }
                ThongBao('3000', msgSuccess);
            });
        }
    });
}

function DeleteRecListGroup(pic) {
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
            $.post(WebsiteUrl + "cms/admin/Ajax/Groups/DeleteRecListGroups.aspx", { "listigid": alertMes,"pic":pic }, function (result) {
                $("#DeleteCate").html(result);
                ThongBao('3000', msgSuccess);
            });
        }

        jQuery(".content input[type=checkbox]").each(function () {
            if (this.checked) {
                id = this.id.substring(this.id.lastIndexOf("_") + 1);
                $("#Cate-" + id).slideUp();
            }
        });
    });
}


function UpdateMenuType(igid) {
    var val = "";
    var ElementCssClass = document.getElementById("nc_" + igid).className;
    val = ElementCssClass.substring(ElementCssClass.length - 1, ElementCssClass.length);

    $.post(WebsiteUrl + "cms/admin/Ajax/Groups/UpdateMenuType.aspx", { "igid": igid, "igenable": val }, function (result) {
        if (val == 0) {
            $("#nc_" + igid).removeClass("EnableIcon0");
            $("#nc_" + igid).addClass("EnableIcon1");
        }
        else if (val == 1) {
            $("#nc_" + igid).removeClass("EnableIcon1");
            $("#nc_" + igid).addClass("EnableIcon0");
        }
    });
}
