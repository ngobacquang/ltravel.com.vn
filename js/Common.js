$(window).load(function () {
    /*Phần khung ảnh*/
    CropImage();
    $(".khungAnhCrop0 img").each(function () {
        $(this).fadeIn();
    });
    $('body').append('<style>' +
        '.khungAnhCrop0:after {background:none,animation:none;-moz-animation:none;-webkit-animation:none}' +
        '.khungAnhCrop:after {background:none,animation:none;-moz-animation:none;-webkit-animation:none}' +
        '</style>');
    /*end Phần khung ảnh*/

    $('.dotdotdot').dotdotdot();
    $('.dotafter').dotdotdot({
        after: 'a.xthem'
});
});


/*Phần cố định*/
/*Hàm cho Owlcarousel*/
function owlslide(num, margin, autoplay, dot, nav, mobile, mobilel, tablet, tabletl, pc) {
    var option;
    if (num > 1) {
        option = {
            items: num,
            autoplay: autoplay,
            autoplayTimeout: 5000,
            smartSpeed: 1500,
            loop: true,
            nav: nav,
            dots: dot,
            autoplayHoverPause: true,
            margin: margin,
            navText: [''],
            responsive: {
                0: {
                    items: mobile,
                    margin: margin
                },
                479: {
                    items: mobilel,
                    margin: margin
                },
                767: {
                    items: tablet,
                    margin: margin
                },
                991: {
                    items: tabletl,
                    margin: margin
                },
                1199: {
                    items: pc,
                    margin: margin
                }
            }
        }
    } else {
        option = {
            items: num,
            autoplay: autoplay,
            autoplayTimeout: 5000,
            smartSpeed: 1500,
            nav: nav,
            dots: dot,
            autoplayHoverPause: true,
            margin: margin,
            navText: [''],
            responsive: {
                0: {
                    items: mobile,
                    margin: margin
                },
                479: {
                    items: mobilel,
                    margin: margin
                },
                767: {
                    items: tablet,
                    margin: margin
                },
                991: {
                    items: tabletl,
                    margin: margin
                },
                1199: {
                    items: pc,
                    margin: margin
                },

            }
        }
    }
    return option;
}
function resizearr(num1199, numother, num478, namediv, namechild) {
    var name = $(namediv);
    if ($(window).width() > 1199) {
        if (name.find(namechild).size() < num1199) {
            name.find('.owl-nav').hide();
        } else {
            name.find('.owl-nav').show();
        }
    } else if ($(window).width() < 478) {
        if (name.find(namechild).size() < num478) {
            name.find('.owl-nav').hide();
        } else {
            name.find('.owl-nav').show();
        }
    }
    else {
        if (name.find(namechild).size() < numother) {
            name.find('.owl-nav').hide();
        } else {
            name.find('.owl-nav').show();
        }
    }
}
/*Hàm cho Owlcarousel*/
$(document).ready(function () {
    $(".TextSize iframe[src*='youtube']").each(function () {
        var iframeCopy = $(this).clone();
        $(this).replaceWith($("<div class='youtube-iframe-wrap'></div>").append(iframeCopy));
    });

    $(function () {
        $(window).scroll(function () {
            if ($(this).scrollTop() >= 800) { $('#bttop').fadeIn(); }
            else { $('#bttop').fadeOut(); }
        });
        $('#bttop').click(function () {
            event.preventDefault();
            $('body,html').animate({ scrollTop: 0 }, 1600)
            ;
        })
        ;
    });

    /*Datepicker*/
    if ($('body').find('.datepicker').size() > 0) {
        //datepicker chọn ngày tháng
        jQuery(".datepicker").datepicker({
            firstDay: 1, //Ngày đầu tuần là thứ 2 (0 thì ngày đầu tuần là chủ nhật)
            dateFormat: "dd/mm/yy", //định dạng ngày/tháng/năm, vd: 14/07/2015
            changeYear: true, //Cho phép chọn năm dạng dropdownlist
            yearRange: "-100:+100", //Số năm trước và sau năm hiện tại ở ô chọn năm
            changeMonth: true, //Cho phép chọn tháng dạng dropdownlist
            dayNames: ["Chủ Nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"],
            dayNamesMin: ["CN", "T2", "T3", "T4", "T5", "T6", "T7"],
            monthNames: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
            monthNamesShort: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
            minDate: 'today'
        });
        //Tự định dạng lại ngày, giờ trong textbox
        function FormatDateTimeInput(control) {
            if (Date.parse(control.value))
                control.value = Date.parse(control.value).toString("dd/MM/yyyy");
            else
                control.value = "";
        }

        function FormatTimeInput(control) {
            if (control.value[control.value.length - 1] == 'h')
                control.value = control.value + "00";

            if (Date.parse(control.value.replace('h', ':')))
                control.value = Date.parse(control.value.replace('h', ':')).toString("HH") + "h" + Date.parse(control.value.replace('h', ':')).toString("mm");
            else
                control.value = "";
        }

        jQuery(".datepicker").change(function () {
            FormatDateTimeInput(this);
        });

        jQuery(".timepicker").change(function () {
            FormatTimeInput(this);
        });
    }
    /*end Datepicker*/ 
});
/*end Phần cố định*/

function CropImage() {
    $(".khungAnhCrop img").each(function () {
        $(this).removeClass("wide tall").addClass((this.width / this.height > $(this).parent().width() / $(this).parent().height()) ? "wide" : "tall");
        $(this).fadeIn();
    });
}

//$(window).resize(function () {
//    $('.dotdotdot').height('auto');
//    $('.dotafter').height('auto');
//    $('.dotdotdot').dotdotdot();
//    $('.dotafter').dotdotdot({
//        after: 'a.xthem'
//    });
//});

$(document).ready(function () { 
    $(window).resize(function() {
        resizearr(4, 2, 1, '#gioithieu .other', '.item');
        resizearr(2, 1, 1, '#about .other .group', '.slide');
        resizearr(1, 1, 1, '.serviceleft .group', '.item');
        resizearr(3, 2, 1, '#about .other #service .group', '.item');
        resizearr(3, 2, 1, '#about #gallery .other .group', '.item');
        resizearr(3, 2, 2, '#pro.detail .other .group', '.item');

    });
    $('#gioithieu .other').owlCarousel(owlslide(4, 17, true, false, true, 1, 2, 3, 3, 4));
    resizearr(4, 2, 1, '#gioithieu .other', '.item');

    $('#about .other #service .group').owlCarousel(owlslide(3, 20, true, false, true, 1, 2, 3, 4, 3));
    $('#about #gallery .other .group').owlCarousel(owlslide(3, 35, true, false, true, 2, 2, 3, 3, 3));
    $('#about .other .group').owlCarousel(owlslide(2, 30, true, false, true, 1, 1, 2, 2, 2));
    resizearr(2, 1, 1, '#about .other .group', '.slide');
    resizearr(3, 2, 1, '#about .other #service .group', '.item');
    resizearr(3, 2, 1, '#about #gallery .other .group', '.item');

    $('#pro.detail .other .group').owlCarousel(owlslide(3, 10, true, false, true, 2, 2, 3, 4, 3));
    resizearr(3, 2, 2, '#pro.detail .other .group', '.item');
      
    $('.serviceleft .group').owlCarousel(owlslide(1, 10, true, false, true, 1, 1, 1, 1, 1));
    resizearr(1, 1, 1, '.serviceleft .group', '.item');

    lightbox.option({
        'maxWidth': $(window).innerWidth() - 40
    });


    function responsive() {
        if ($(window).innerWidth() < 1200) {
            $('#contact .contact-left .contact-input').insertBefore('#contact .contact-right .contact-input');
             
            if ($(window).innerWidth() < 768) {
                $('#pro.detail #CommonCuoiChiTietTin').insertBefore('#pro.detail .other');
            } else {
                $('#pro.detail #CommonCuoiChiTietTin').appendTo('#pro.detail .baiviet');
            }

        } else { 
            if ($('#contact .contact-left').find('.contact-input').size() < 1) {
                $('#contact .contact-right .contact-input:first-child').insertAfter('#contact .contact-left .contact-info');
            } 
        }
    }

    responsive();
    $(window).resize(function() {
        responsive();
    });
}); 
 

var size = parseInt(jQuery(".TextSize").css("font-size"));
var lineheight = parseInt(jQuery(".TextSize").css("line-height"));
if (!size)
    size = 14;
if (!lineheight)
    lineheight = 22;
function IncreaseTextSize() {
    size++;
    lineheight += 2;

    jQuery(".TextSize")
        .css('cssText',
            'font-size:' +
            size +
            'px !important; line-height:' +
            lineheight +
            'px !important');
    jQuery(".TextSize")
        .find("*")
        .css('cssText',
            'font-size:' +
            size +
            'px !important; line-height:' +
            lineheight +
            'px !important');
} 
function DecreaseTextSize() {
    size--;
    lineheight -= 2;

    jQuery(".TextSize")
        .css('cssText',
            'font-size:' +
            size +
            'px !important; line-height:' +
            lineheight +
            'px !important');
    jQuery(".TextSize")
        .find("*")
        .css('cssText',
            'font-size:' +
            size +
            'px !important; line-height:' +
            lineheight +
            'px !important');
} 
function ResetTextSize() {
    size = 14;
    lineheight = 22;

    jQuery(".TextSize")
        .css('cssText',
            'font-size:' +
            size +
            'px !important; line-height:' +
            lineheight +
            'px !important');
    jQuery(".TextSize")
        .find("*")
        .css('cssText',
            'font-size:' +
            size +
            'px !important; line-height:' +
            lineheight +
            'px !important');
}
 