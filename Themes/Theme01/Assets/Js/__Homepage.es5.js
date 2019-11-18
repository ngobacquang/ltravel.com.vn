"use strict";

(function ($) {
  "use strict";
  smartScroll.init({
    speed: 700,
    addActive: true,
    activeClass: "active",
    offset: 0
  }, function () {
    console.log("callback");
  });
})(jQuery);

$(document).ready(function () {
  $(".nav-scrollspy").offsetTopScroll();

  $(".inquiry").offsetTopScroll();

  $(".nb-collapse-accordion").collapse_accordion();
});

