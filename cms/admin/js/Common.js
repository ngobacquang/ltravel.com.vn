//Thêm hàm indexOf cho Array trong IE8
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (obj, start) {
        for (var i = (start || 0), j = this.length; i < j; i++) {
            if (this[i] === obj) { return i; }
        }
        return -1;
    }
}

function ShowList(idList) {
    $('#' + idList).stop(true, true).show("slow");
}
function HideList(idList) {
    $('#' + idList).stop(true, true).hide("slow");
}

//Ẩn hiện khối
function Toggle(destID) {
    //if (document.getElementById(destID).style.display == "none") {
    if (!jQuery('#' + destID).is(":visible")) {
        jQuery('#' + destID).slideDown();
        setCookie(destID, 'block', '', '/', '', '');
    }
    else {
        jQuery('#' + destID).slideUp();
        setCookie(destID, 'none', '', '/', '', '');
    }
}

//Khởi tạo trạng thái ẩn hiện khối
function InitToggle(destID) {
    if (destID) {
        var status = getCookie(destID);
        if (status) {
            if (status == "block") jQuery('#' + destID).slideDown();
            else jQuery('#' + destID).slideUp();
        }
        else
            jQuery('#' + destID).slideUp();
    }
    else {
        //Khởi tạo tất cả các khối có id bắt đầu bằng Toogle_
        jQuery("div[id^='Toogle_']").each(function () { InitToggle(this.id) });
    }
}


function loading(loading) {
    if (!document.getElementById("AjaxLoading")) {
        var left = (GetWindowWidth() - 36) / 2;
        var ajaxLoading = '<div id="AjaxLoading" onclick="loading(false)" style="background:#fff url(' + weburl + 'cms/admin/cs/AllModul/AjaxLoading.gif) no-repeat center;display:none;width:36px;height:36px;line-height:36px;position:fixed;_position:absolute;top:40%;left:' + left + 'px;z-index:9999;border:solid 1px #fff;border-radius:36px"><!----></div>';
        jQuery("body").append(ajaxLoading);
    }

    if (typeof loading == 'undefined' || loading) {
        jQuery("#AjaxLoading").show();
    } else {
        jQuery("#AjaxLoading").fadeOut();
    }
}
