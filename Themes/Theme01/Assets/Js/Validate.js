(function ($) {
    var methods = {
        /* Khai báo tên các phương thức có thể gọi, bao gồm một init để khởi tạo và check để kiểm tra trước khi gửi lên server
         * $(selector).validate('init') //khởi tạo mặc định
         * $(selector).validate('init',{option}) //khởi tạo với options
         * $(selector).validate() //khởi tạo mặc định
         * $(selector).validate({option}) //khởi tạo với options
         */
        init: function (options) {
            return this.each(function () {
                var settings = $.extend({
                        requiredMsg: "Trường này không được để trống",
                        emailMsg: "Email chưa hợp lệ",
                        urlMsg: "Url chưa hợp lệ",
                        usernameMsg: "Vui lòng nhập tên đăng nhập chứa ít nhất 3 ký tự, không chứa dấu cách, không chứa ký tự đặc biệt",
                        passwordMsg: "Vui lòng nhập mật khẩu phức tạp, chứa ít nhất 8 ký tự",
                        compareMsg: "Nhập lại không chính xác",
                        minMsg: "Giá trị bé nhất là",
                        maxMsg: "Giá trị lớn nhất là",
                        maxlengthMsg: "Số ký tự tối đa là",
                        minlengthMsg: "Số ký tự tối thiểu là"
                    },
                    options);

                //Gán settings vào data có tên validate của đối tượng này để dùng tới khi gọi hàm check
                $(this).data('validate', settings);

                /*
                Sẽ kiểm tra tất cả input, textarea, select có thuộc tính data-validate="true"
                Các thông số:
                data-vld-required="true": yêu cầu nhập
                data-vld-email="true": nhập theo chuẩn email
                data-vld-url="true": nhập theo chuẩn url
                data-vld-username="true": nhập theo chuẩn tên đăng nhập
                data-vld-password="true": nhập theo chuẩn mật khẩu
                data-vld-max="1": số lớn nhất là 1
                data-vld-min="1": số nhỏ nhất là 1
                data-vld-maxlength="1": số kí tự lớn nhất là 1
                data-vld-minlength="1": số kí tự nhỏ nhất là 1
                */

                $("input[data-validate='true'],textarea[data-validate='true'],select[data-validate='true']", this)
                    .each(function () {
                        $(this).keyup(function () {
                            //Kiểm tra dữ liệu của từng controls
                            validateValue(this, true, settings);
                        });
                    });
            });
        },


        //Hàm kiểm tra trước khi gửi lên server
        check: function () {
            var result = true;
            this.each(function () {
                //Lấy dữ liệu settings được lưu ở data validate của đối tượng này
                var settings = $(this).data('validate');
                if (typeof settings !== 'object') {
                    $.error("Bạn cần khởi tạo với hàm validate('init', {options}) trước khi gọi được hàm check này");
                }

                //Sử dụng settings khi validate
                $("input[data-validate='true'],textarea[data-validate='true'],select[data-validate='true']", this)
                    .each(function () {
                        //Nếu có trường nào không được validate thì dừng vòng each
                        result = validateValue(this, true, settings);
                        if (!result)
                            return false;
                    });

                //Nếu có trường nào không được validate thì dừng vòng each
                if (!result)
                    return false;
            });

            return result;
        }
    };


    //Hàm chính có tên validate
    $.fn.validate = function (method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        }
        $.error('Phương thức "' + method + '" không được hỗ trợ bởi validate()');
    }


    //Hàm thông báo lỗi
    function alertMessage(elm, setfocus, msg) {
        //Trường hợp input không nằm trong .input-group
        if (!$(elm).parent().hasClass("input-group")) {
            if (!$(elm).parent().hasClass("vld-error-wrap")) {
                $(elm).parent().addClass("vld-error-wrap");
                $("<label class='vld-error-msg form-text'>" + msg + "</label>").insertAfter(elm);
            }
        }
        //Trường hợp input nằm trong .input-group
        else {
            if (!$(elm).parent().parent().hasClass("vld-error-wrap")) {
                $(elm).parent().parent().addClass("vld-error-wrap");
                $("<label class='vld-error-msg form-text'>" + msg + "</label>").insertAfter($(elm).parent());
            }
        }

        if (setfocus)
            $(elm).focus();
    }

    //Hàm kiểm tra dữ liệu từng control
    function validateValue(elm, setfocus, settings) {
        //Trường hợp input không mằm trong .input-group
        if (!$(elm).parent().hasClass("input-group")) {
            if ($(elm).parent().hasClass("vld-error-wrap")) {
                $(elm).parent().removeClass("vld-error-wrap");
                $(elm).next(".vld-error-msg").remove();
            }
        }
        //Trường hợp input nằm trong .input-group
        else {
            if ($(elm).parent().parent().hasClass("vld-error-wrap")) {
                $(elm).parent().parent().removeClass("vld-error-wrap");
                $(elm).parent().next(".vld-error-msg").remove();
            }
        }

        //data-vld-required="true": yêu cầu nhập
        if ($(elm).attr("data-vld-required") === 'true') {
            if ($(elm).val() === "") {
                alertMessage(elm, setfocus, settings.requiredMsg);
                return false;
            }
        }

        //data-vld-email="true": nhập theo chuẩn email
        if ($(elm).attr("data-vld-email") === 'true') {
            var emailFilter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!emailFilter.test($(elm).val())) {               
                alertMessage(elm, setfocus, settings.emailMsg);
                return false;
            }
        }


        //data-vld-url="true": nhập theo chuẩn url
        if ($(elm).attr("data-vld-url") === 'true') {
            var urlFilter = /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/gi;
            if (!urlFilter.test($(elm).val())) {                
                alertMessage(elm, setfocus, settings.urlMsg);
                return false;
            }
        }

        //data-vld-username="true": nhập theo chuẩn tên đăng nhập
        if ($(elm).attr("data-vld-username") === 'true') {
            var usernameFilter = /^([a-zA-Z0-9_\.\-\@]{3,50})+$/;

            if (!usernameFilter.test($(elm).val())) {                
                alertMessage(elm, setfocus, settings.usernameMsg);
                return false;
            }
        }

        //data-vld-password="true": nhập theo chuẩn mật khẩu
        if ($(elm).attr("data-vld-password") === 'true') {
            var minPasswordLength = 8;

            if ($(elm).val().length < minPasswordLength) {                
                alertMessage(elm, setfocus, settings.passwordMsg);
                return false;
            }
        }


        //data-vld-compare-with="#tbPassword": so sánh với trường ở #tbPassword
        if ($(elm).attr("data-vld-compare-with") && $(elm).attr("data-vld-compare-with")!=='') {
            var giaTriMau = $($(elm).attr("data-vld-compare-with")).val();

            if ($(elm).val()!==giaTriMau) {               
                alertMessage(elm, setfocus, settings.compareMsg);
                return false;
            }
        }


        //data-vld-min="1": số nhỏ nhất là 1
        if ($(elm).attr("data-vld-min")) {
            var min = parseFloat($(elm).attr("data-vld-min"));
            if (isNaN(min)) min = 0;

            var valm = parseFloat($(elm).val());
            if (isNaN(valm)) valm = 0;

            if (valm < min) {        
                alertMessage(elm, setfocus, settings.minMsg + " " + min);
                return false;
            }
        }

        // data-vld-max="1": số lớn nhất là 1
        if ($(elm).attr("data-vld-max")) {
            var max = parseFloat($(elm).attr("data-vld-max"));
            if (isNaN(max)) max = 0;

            var valmx = parseFloat($(elm).val());
            if (isNaN(valmx)) valmx = 0;

            if (valmx > max) {                
                alertMessage(elm, setfocus, settings.maxMsg + " " + max);
                return false;
            }
        }


        //data-vld-minlength="1": số kí tự nhỏ nhất là 1
        if ($(elm).attr("data-vld-minlength")) {
            var minlength = parseFloat($(elm).attr("data-vld-minlength"));
            if (isNaN(minlength)) minlength = 0;

            if ($(elm).val().length < minlength) {
                alertMessage(elm, setfocus, settings.minlengthMsg + " " + minlength);
                return false;
            }
        }


        //data-vld-maxlength="1": số kí tự lớn nhất là 1
        if ($(elm).attr("data-vld-maxlength")) {
            var maxlength = parseFloat($(elm).attr("data-vld-maxlength"));
            if (isNaN(maxlength)) maxlength = 0;

            if ($(elm).val().length > maxlength) {              
                alertMessage(elm, setfocus, settings.maxlengthMsg + " " + maxlength);
                return false;
            }
        }

        return true;
    }
    
}(jQuery));

