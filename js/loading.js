function GetWindowWidth() {
    var myWidth = 0, myHeight = 0;
    if (typeof (window.innerWidth) == 'number') {
        //Non-IE
        myWidth = window.innerWidth;
        myHeight = window.innerHeight;
    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
        //IE 6+ in 'standards compliant mode'
        myWidth = document.documentElement.clientWidth;
        myHeight = document.documentElement.clientHeight;
    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
        //IE 4 compatible
        myWidth = document.body.clientWidth;
        myHeight = document.body.clientHeight;
    }
    return myWidth;
}
function loading(loading) {
    if (!document.getElementById("AjaxLoading")) {
        var left = (GetWindowWidth() - 36) / 2;
        var ajaxLoading = '<div id="AjaxLoading" onclick="loading(false)" style="background:#fff url(' + weburl + 'Js/AjaxLoading.gif) no-repeat center;display:none;width:36px;height:36px;line-height:36px;position:fixed;_position:absolute;top:40%;left:' + left + 'px;z-index:99999999;border:solid 1px #fff;border-radius:36px"><!----></div>';
        jQuery("body").append(ajaxLoading);
    }

    if (typeof loading == 'undefined' || loading) {
        jQuery("#AjaxLoading").show();
    } else {
        jQuery("#AjaxLoading").fadeOut();
    }
}