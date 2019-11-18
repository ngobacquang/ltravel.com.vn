// #region Khởi tạo datepicker
//$(".datepicker").datepicker({
//    firstDay: 1, //Ngày đầu tuần là thứ 2 (0 thì ngày đầu tuần là chủ nhật)
//    dateFormat: "dd-mm-yy", //định dạng ngày/tháng/năm, vd: 14/07/2015
//    changeYear: true, //Cho phép chọn năm dạng dropdownlist
//    yearRange: "-100:+100", //Số năm trước và sau năm hiện tại ở ô chọn năm
//    changeMonth: true, //Cho phép chọn tháng dạng dropdownlist
//    dayNames: ["Chủ Nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"],
//    dayNamesMin: ["CN", "T2", "T3", "T4", "T5", "T6", "T7"],
//    monthNames: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
//    monthNamesShort: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"]
//});
$(".datepicker").datepicker({
  format: "dd/mm/yyyy",
  language: 'vi-VN'
});

//$(".timepicker").timepicker({
//    timeFormat: "HH:mm:ss",
//    currentText: "Lấy hiện tại",
//    closeText: "Xong",
//    timeOnlyTitle: "Chọn giờ",
//    timeText: "Kết quả",
//    hourText: "Giờ",
//    minuteText: "Phút",
//    secondText: "Giây",
//    millisecText: "Mini giây",
//    microsecText: "Mini giây"
//});


//Tự định dạng lại ngày, giờ trong textbox
function FormatDatePicker(control) {
    if (Date.parse(control.value))
        control.value = Date.parse(control.value).toString("dd/MM/yyyy");
    else
        control.value = "";
}

//function FormatTimePicker(control) {
//    if (Date.parse(control.value))
//        control.value = Date.parse(control.value).toString("HH:mm:ss");
//    else
//        control.value = "";
//}

$(".datepicker").change(function () {
    FormatDatePicker(this);
});

//$(".timepicker").change(function () {
//    FormatTimePicker(this);
//});
// #endregion

// #region Khởi tạo autoNumuric
//var autoNumericSettings = {
//    aSep: ".",
//    aDec: ",",
//    aForm: true,
//    mDec: "0",
//    vMin: "0"
//};

//$(".autoNumeric").autoNumeric("init", autoNumericSettings);

//Xóa định dạng khi postback, phải gọi hàm này ở nút postback (OnClientClick=)
//function RemoveAutoNumeric() {
//    $(".autoNumeric").each(function () {
//        $(this).val($(this).autoNumeric("get"));
//    });
//}
// #endregion



// #region Khởi tạo click vào body đì đóng dropdown-menu
//$("body")
//    .click(function () {
//        $(".dropdown-menu").hide();
//    });
// #endregion

// #region Khởi tạo tự điều chỉnh chiều cao textarea
//autosize(document.querySelectorAll('textarea'));
// #endregion

// #region Khởi tạo dropdown
//$(".dropdown").dropdown();
// #endregion