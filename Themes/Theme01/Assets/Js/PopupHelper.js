function ClosePopup() {
    $(".light-popup").hide();
    $(".fade-popup").hide();

    //Lưu vào cookies trạng thái đóng cookie với các cookie có thuộc tính data-cookie-name
    $(".light-popup[data-cookie-name]")
        .each(function() {
            var cookieName = $(this).attr("data-cookie-name");

            setCookie(cookieName, "closed", 1);
        });
}

function OpenPopup(popupSelector) {
    /// <summary>Mở popup. Lưu ý dùng với href, không dùng với onclick</summary>

    ClosePopup();

    $(".fade-popup").show();
    $(popupSelector).show();

    $(document)
        .click(function() {
            ClosePopup();
        });

    $(popupSelector)
        .click(function (event) {
            event.stopPropagation();
        });

    //Xóa cookie đóng popup
    if ($(popupSelector).attr("data-cookie-name"))
        deleteCookie($(popupSelector).attr("data-cookie-name"));
}