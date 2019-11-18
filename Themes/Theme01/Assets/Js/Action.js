// #region Kiểm tra số checkbox được check để ẩn hiện khối công cụ thao tác với nhiều bản ghi cùng lúc
function OpenToolsPanel() {
    var countChecked = $(".ajax-list tbody input[type=checkbox]:checked").length;
    if (countChecked > 0) {
        $(".page-content-tools .btn-disabled").removeClass("disabled");

        $(".page-content-tools .count-checked").html("Đã chọn " + countChecked + " mục");
    } else {
        $(".page-content-tools .btn-disabled").addClass("disabled");
        $(".page-content-tools .count-checked").html("");
    }
}
// #endregion

// #region Xóa các checkbox và các thông báo cũ trước khi gọi lại hàm lấy danh sách
function ClearCheckedAjaxList() {
    $(".ajax-list tbody input[type=checkbox]:checked").prop("checked", false);
    $(".ajax-list thead input[type=checkbox]#cbAll").prop("checked", false);

    $(".page-content-tools .btn-disabled").addClass("disabled");
    $(".page-content-tools .count-checked").html("");
}
// #endregion     

// #region Tích chọn tất cả checkbox, có cho phép callback
function CheckAllCheckbox(elm, callback) {
    $(".ajax-list tbody input[type=checkbox]").prop("checked", $(elm).is(":checked"));

    // Make sure the callback is a function​
    if (callback && typeof callback === "function") {
        // Call it, since we have confirmed it is callable​
        callback();
    }
}
// #endregion


// #region Xóa nội dung trong form
function ResetFormControls(formSelector) {
    $(formSelector + " input[type=text]:not(.notReset)").val("");
    $(formSelector + " input[type=password]:not(.notReset)").val("");
    $(formSelector + " input[type=number]:not(.notReset)").val("");
    $(formSelector + " input[type=file]:not(.notReset)").val("");
    $(formSelector + " input[type=hidden]:not(.notReset)").val("");

    $(formSelector + " textarea:not(.notReset)").val("");

    $(formSelector + " select:not(.notReset)")
        .each(function () {
            this.selectedIndex = 0;
        });

    //Tăng thứ tự
    $(formSelector + " input.autoIncrease")
        .each(function () {
            var $this = $(this);

            $this.val(parseInt($this.val()) + 1);
        });


    $(formSelector + " input.firstInput").focus();
}
// #endregion

// #region Tạo thông báo ở form thêm mới
(function ($) {
    $.fn.CreateFormAlert = function (message, isSuccessAlert, notScrollToTop) {
        return this.each(function () {
            $(this).html("<div class='form-alert-content text-center alert " + (isSuccessAlert ? "alert-success" : "alert-danger") + "'>" + message + "<a href='javascript:void(0)' onclick='$(this).parent().remove()'><i class='fa fa-times'><i></a></div>");

            if (!notScrollToTop)
                document.body.scrollTop = document.documentElement.scrollTop = 0;
        });
    };
})(jQuery);
// #endregion