// Scroll to top
$(document).ready(function () {
	var obJect = $('#nb-scrollTop');
	var windownScroll = $(window).scrollTop();

	// Kiểm tra nếu hiện tại scroll ở vị trí nào
	if (windownScroll > 100) {
		obJect.addClass('show');
	}
	else {
		obJect.removeClass('show');
	}
	// Nếu cuộn chuột
	$(window).scroll(function () {
		if ($(this).scrollTop() > 100) {
			obJect.addClass('show');
		} else {
			obJect.removeClass('show');
		}
	});
	//Click event to scroll to top
	obJect.click(function (e) {
		e.preventDefault();
		$('html, body').animate({
			scrollTop: 0
		}, 800);
		return false;
	});
});
//------------------- Style Navigation type 05 ------------
//Xử lý khi scroll
$(document).ready(function () {
	var oJect = $("#nb_navigation_type_07");
	var affixPad = $("#nb_affixPad");
	var nbTopNav = oJect.children(".nb-top-nav");
	var nbNavMain = oJect.children(".nb-main-navbar");
	var heightNavMain = nbNavMain.outerHeight();
	var heightCrrent = $(window).scrollTop();
	var offsetTop = nbNavMain.offset().top;

	//Kiểm tra khi load trang
	if (heightCrrent >= offsetTop) {
		oJect.addClass("nb-nav-fix");
		affixPad.css("padding-top", heightNavMain);
	} else {
		oJect.removeClass("nb-nav-fix");
		affixPad.css("padding-top", "0");
	}
	//Kiểm tra khi scroll
	$(window).scroll(function () {
		if ($(this).scrollTop() >= offsetTop) {
			oJect.addClass("nb-nav-fix");
			affixPad.css("padding-top", heightNavMain);
		}
		else {
			oJect.removeClass("nb-nav-fix");
			affixPad.css("padding-top", "0");
		}
	});
});
// Xứ lý khi click vào icon-menu
$(document).ready(function () {
	var oJect = $("#nb_navigation_type_07");
	var nbToggle = oJect.find(".blogToggler");
	var nbToggleShowToa = oJect.find(".nb-navbar-collapse");
	var nbToggleShowTob = nbToggleShowToa.find(".item");
	var widthWindow = $(window).outerWidth();
	nbToggle.on("click", function (e) {
		e.preventDefault();
		$(this).toggleClass("active");
		nbToggleShowToa.toggleClass("open");
		$("body").toggleClass("off");
	});
	nbToggleShowTob.on("click", function () {
		if ($(this).hasClass("active")) {
			$(this).removeClass("active");
		}
		else {
			nbToggleShowTob.removeClass("active")
			$(this).addClass("active");
		}
	});

});


//#region --- Origent Toolbar
$(document).ready(function () {
	$(function () {
		$(".post-size .large").click(function (e) {
			e.preventDefault();
			$(".post-content").each(function () {
				var size = parseInt($(this).css("font-size"));
				var lineheight = parseInt($(this).css("line-height"));
				size = size + 1 + "px";
				lineheight = lineheight + 2 + "px";
				$(this).css({
					'font-size': size,
					'line-height': lineheight
				});
				$(this).find("*").css({
					'font-size': size,
					'line-height': lineheight
				});
			});
		});
		$(".post-size .small").click(function (e) {
			e.preventDefault();
			$(".post-content").each(function () {
				var size = parseInt($(this).css("font-size"));
				var lineheight = parseInt($(this).css("line-height"));
				size = size - 1 + "px";
				lineheight = lineheight - 2 + "px";
				$(this).css({
					'font-size': size,
					'line-height': lineheight
				});
				$(this).find("*").css({
					'font-size': size,
					'line-height': lineheight
				});
			});
		});
		$(".post-size .normal").click(function (e) {
			e.preventDefault();
			$(".post-content").each(function () {
				var size = parseInt($(this).css("font-size"));
				var lineheight = parseInt($(this).css("line-height"));
				size = 15 + "px";
				lineheight = 24 + "px";
				$(this).css({
					'font-size': size,
					'line-height': lineheight
				});
				$(this).find("*").css({
					'font-size': size,
					'line-height': lineheight
				});
			});
		});
	});
});
//endregion --- end


(function ($) {
	$.fn.offsetTopScroll = function () {
		// Duyệt tất cả nếu có nhiều phần tử
		return this.each(function () {
			// Khởi tạo giá trị đầu cho obJect
			var obJect = $(this);
			var itemOffsetTop = obJect.offset().top;
			var widthWindown = $(window).outerWidth();
			if (widthWindown <= 1025) {
				obJect.addClass('tlt_scroll');
			}

			$(window).scroll(function () {

				if ($(this).scrollTop() >= itemOffsetTop - 45) {
					obJect.addClass("change");
				}
				else {
					obJect.removeClass("change");
				}
			});
		});
	}
})(jQuery);
//Collapse accordion
(function ($) {
	$.fn.collapse_accordion = function () {
		// Duyệt tất cả nếu có nhiều phần tử
		return this.each(function () {
			// Khởi tạo giá trị đầu cho obJect
			var obJect = $(this);
			var ojectCard = obJect.children('.nb-card');
			var ojectCardHead = ojectCard.find('.nb-head');
			var ojectCardBody = ojectCard.find('.nb-body');

			// Duyệt qua 1 lần và gán chiều cao cho tất cả phần tử, phần tử đầu tiêu để active
			ojectCard.each(function () {
				var cardCurrent = $(this);
				var index = cardCurrent.index();
				var headCurrent = cardCurrent.find('.nb-head');
				var bodyCurrent = cardCurrent.find('.nb-body');
				// Xét phần tử đầu tiên active
				if (index == 0) {
					headCurrent.addClass('active');
					bodyCurrent.addClass('open');
				}
				//Gọi hàm xét lại chiều cao body
				resizeHeightBody();
			});
			// Sự kiện click đóng & mở
			ojectCardHead.on('click', function (e) {
				e.preventDefault();
				var parentCurrent = $(this).parents('.nb-card');
				if ($(this).hasClass('active')) {
					parentCurrent.find('.nb-head').removeClass('active');
					parentCurrent.find('.nb-body').removeClass('open');
				}
				else {
					//ojectCardHead.removeClass('active');
					//ojectCardBody.removeClass('open');
					parentCurrent.find('.nb-head').addClass('active');
					parentCurrent.find('.nb-body').addClass('open');
				}
				//Gọi hàm xét lại chiều cao body
				resizeHeightBody();
			});

			// Hàm xét lại chiều cao cho body
			function resizeHeightBody() {
				ojectCard.each(function () {
					var cardCurrent = $(this);
					var headCurrent = cardCurrent.find('.nb-head');
					var bodyCurrent = cardCurrent.find('.nb-body');

					var bodyOpen = bodyCurrent.hasClass('open');

					if (bodyCurrent.hasClass('open')) {
						var heightWap = bodyCurrent.children('.wap').outerHeight();

						bodyCurrent.css('height', heightWap + 30);
					}
					else {
						bodyCurrent.css('height', 0);
					}
				});
			}
		});
	}
})(jQuery);

// Plugin video
$(document).ready(function () {
	var video = document.getElementById("nb-video");
	var juice = document.querySelector(".orange-juice");
	var btn = document.getElementById("nb-play-pause");
	// xử lý play - pause
	function togglePlayPause() {
		if (video.paused) {
			btn.className = "pause"
			video.play();
		} else {
			btn.className = "play";
			video.pause();
		}
	}
	// click play - pause
	btn.onclick = function () {
		togglePlayPause();
	}
	// update thanh thời gian
	video.addEventListener("timeupdate", function () {
		var juicePos = video.currentTime / video.duration;
		juice.style.width = juicePos * 100 + "%";
		if (video.ended) {
			btn.className = "";
			video.load();
		}
	});
});

//Input count
$(document).ready(function () {
	var obJect = $(".nb_input_count");
	var actionLinkTru = obJect.children(".action.acTru");
	var actionLinkCong = obJect.children(".action.acCong");


	actionLinkTru.on("click", function (e) {
		e.preventDefault();

		var objectCurrent = $(this).parents();
		var inputForm = objectCurrent.children(".form-control");

		var soluongCurent = inputForm.attr("value");
		var minValue = inputForm.attr("data-min");

		if (soluongCurent <= minValue) {
		  inputForm.attr("value", minValue);
		  inputForm.attr("value", minValue);
		}
		else {
			soluongCurent--;
			inputForm.attr("value", soluongCurent);
			inputForm.attr("value", soluongCurent);
		}

		$(this).parent().find('input').change();
	});
	actionLinkCong.on("click", function (e) {
		var objectCurrent = $(this).parents();
		var inputForm = objectCurrent.children(".form-control");
		e.preventDefault();

		var soluongCurent = inputForm.attr("value");

		if (soluongCurent >= 200) {
			inputForm.attr("value", "200");
			inputForm.attr("value", "200");
		}
		else {
			soluongCurent++;
			inputForm.attr("value", soluongCurent);
			inputForm.attr("value", soluongCurent);
		}

		$(this).parent().find('input').change();
	});
});


// poster frame click event
$(document).on('click', '.js-videoPoster', function (ev) {
	ev.preventDefault();
	var $poster = $(this);
	var $wrapper = $poster.closest('.js-videoWrapper');
	videoPlay($wrapper);
});

// play the targeted video (and hide the poster frame)
function videoPlay($wrapper) {
	var $iframe = $wrapper.find('.js-videoIframe');
	var src = $iframe.data('src');
	// hide poster
	$wrapper.addClass('videoWrapperActive');
	// add iframe src in, starting the video
	$iframe.attr('src', src);
}

// stop the targeted/all videos (and re-instate the poster frames)
function videoStop($wrapper) {
	// if we're stopping all videos on page
	if (!$wrapper) {
		var $wrapper = $('.js-videoWrapper');
		var $iframe = $('.js-videoIframe');
		// if we're stopping a particular video
	} else {
		var $iframe = $wrapper.find('.js-videoIframe');
	}
	// reveal poster
	$wrapper.removeClass('videoWrapperActive');
	// remove youtube link, stopping the video from playing in the background
	$iframe.attr('src', '');
}

$(document).ready(function () {
	var tour_cat = $('.section.tour-cat');

	tour_cat.each(function () {
		if ($(this).hasClass('stfirst')) {
			
		}
		else {
			$(this).find('.wap').addClass('overturn');
		}
	});
});

$(document).ready(function () {
	$(".inquiry").offsetTopScroll();
});

jQuery('select option').each(function () {
	var optionText = this.text;
	var optionTexts = optionText.length;
	var newOption = optionText.substring(0, 40);
	if (optionTexts < 40) {
		jQuery(this).text(newOption);
	} else {
		jQuery(this).text(newOption + '...');
	}
});
