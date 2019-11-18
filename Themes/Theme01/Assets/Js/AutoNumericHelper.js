// #region Khởi tạo autoNumuric
var autoNumericSettings = {
    aSep: ".",
    aDec: ",",
    aForm: true,
    mDec: "0",
    vMin: "0"
};

$(".autoNumeric").autoNumeric("init", autoNumericSettings);

//Xóa định dạng khi postback, phải gọi hàm này ở nút postback (OnClientClick=)
function RemoveAutoNumeric() {
    $(".autoNumeric").each(function () {
        $(this).val($(this).autoNumeric("get"));
    });
}
// #endregion