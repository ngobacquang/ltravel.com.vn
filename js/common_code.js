//Thêm hàm indexOf cho Array trong IE8
if (!Array.prototype.indexOf) {
  Array.prototype.indexOf = function (obj, start) {
    for (var i = (start || 0), j = this.length; i < j; i++) {
      if (this[i] === obj) { return i; }
    }
    return -1;
  }
}

function loading(loading) {
  if (!document.getElementById("AjaxLoading")) {
    var left = ($(window).width() - 36) / 2;
    var ajaxLoading = '<div id="AjaxLoading" onclick="loading(false)" style="display:none;width:80px;height:80px;position:fixed;top:40%;left:' + left + 'px;z-index:9999"><svg xmlns="http://www.w3.org/2000/svg" class="lds-default" width="80px" height="80px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid"><circle cx="75" cy="50" fill="undefined" r="4.04673"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.9166666666666666s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.9166666666666666s"/></circle><circle cx="71.65063509461098" cy="62.5" fill="undefined" r="3.38007"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.8333333333333334s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.8333333333333334s"/></circle><circle cx="62.5" cy="71.65063509461096" fill="undefined" r="3"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.75s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.75s"/></circle><circle cx="50" cy="75" fill="undefined" r="3"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.6666666666666666s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.6666666666666666s"/></circle><circle cx="37.50000000000001" cy="71.65063509461098" fill="undefined" r="3"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.5833333333333334s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.5833333333333334s"/></circle><circle cx="28.34936490538903" cy="62.5" fill="undefined" r="3"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.5s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.5s"/></circle><circle cx="25" cy="50" fill="undefined" r="3"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.4166666666666667s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.4166666666666667s"/></circle><circle cx="28.34936490538903" cy="37.50000000000001" fill="undefined" r="3"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.3333333333333333s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.3333333333333333s"/></circle><circle cx="37.499999999999986" cy="28.349364905389038" fill="undefined" r="3.2866"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.25s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.25s"/></circle><circle cx="49.99999999999999" cy="25" fill="undefined" r="3.95327"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.16666666666666666s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.16666666666666666s"/></circle><circle cx="62.5" cy="28.349364905389034" fill="undefined" r="4.61993"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="-0.08333333333333333s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="-0.08333333333333333s"/></circle><circle cx="71.65063509461096" cy="37.499999999999986" fill="undefined" r="4.7134"><animate attributeName="r" values="3;3;5;3;3" times="0;0.1;0.2;0.3;1" dur="1s" repeatCount="indefinite" begin="0s"/><animate attributeName="fill" values="#ffffcb;#ffffcb;#ff7c81;#ffffcb;#ffffcb" repeatCount="indefinite" times="0;0.1;0.2;0.3;1" dur="1s" begin="0s"/></circle></svg></div>';
    $("body").append(ajaxLoading);
  }

  if (typeof loading == 'undefined' || loading) {
    $("#AjaxLoading").show();
  } else {
    $("#AjaxLoading").fadeOut();
  }
}

function removeNotDigit(s, removeDot) {
  s = s.replace(/[^\d.]/g, '');
  if (removeDot) s = s.replace(/\./g, '');
  if (s == '') s = '0';

  return s;
}

function checkEmail(selector, message) {
  var msg = message || 'Email không hợp lệ!',
      email = $(selector),
      filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

  if (!filter.test(email.val())) {
    loading(false);
    email.css("border", "dashed 1px #ff0014").focus();
    alert(msg);
    return false;
  }
  return true;
}

function checkPhoneNumber(selector, message) {
  var msg = message || 'Số điện thoại không hợp lệ!',
      phone = $(selector),
      filter = /^(\d+\.\d+)$|^(\d+)$/gm;

  if (!filter.test(phone.val())) {
    loading(false);
    phone.css("border", "dashed 1px #ff0014").focus();
    alert(msg);
    return false;
  }
  return true;
}

function resetForm(selector, e) {
  e.preventDefault();
  $(selector).find('.required').removeAttr('style');
  $(selector).find('input, textarea').val('');
}

function validateForm(selector, msg1, msg2, msg3) {
  var pass = true,
      msg = msg1 || 'Vui lòng nhập đủ thông tin trước khi gửi yêu cầu!',
      target = $(selector + " .required");

  target.removeAttr("style");

  target.each(function () {
    if (this.value.length < 1) {
      loading(false);
      alert(msg)
      $(this).css("border", "dashed 1px #ff0014").focus();
      pass = false;
      return false;
    }
  });

  if (pass && $(selector + ' #tbPhone').length > 0) pass = checkPhoneNumber(selector + ' #tbPhone', msg3);
  if (pass && $(selector + ' #tbEmail').length > 0) pass = checkEmail(selector + ' #tbEmail', msg2);

  return pass;
}

function validateForm2(selector, msg1, msg2, msg3) {
  var pass = true,
      msg = msg1 || 'Vui lòng nhập đủ thông tin trước khi gửi yêu cầu!',
      target = $(selector + " .required");

  target.removeAttr("style");

  target.each(function () {
    if (this.value.length < 1) {
      loading(false);
      alert(msg)
      $(this).css("border", "dashed 1px #ff0014").focus();
      pass = false;
      return false;
    }
  });

  if (pass && $(selector + ' #tbPhone2').length > 0) pass = checkPhoneNumber(selector + ' #tbPhone2', msg3);
  if (pass && $(selector + ' #tbEmail2').length > 0) pass = checkEmail(selector + ' #tbEmail2', msg2);

  return pass;
}

function menuMarking(cRewrite) {
  var cHrefInUrl = XuLyLink(document.URL);

  $("#menu li.litop").removeClass("active");
  $("#menu li.litop a").each(function () {
    var href = $(this).attr("href");
    if (href) {
      href = XuLyLink(href);

      if (href === cHrefInUrl || href === cRewrite) $(this).parent().addClass("active");

      if (href === "thu-vien") {
        var active = false,
            listSubRewrite = ["hinh-anh", "video", "tai-lieu"];

        for (var i = 0; i < listSubRewrite.length; i++) {
          href = listSubRewrite[i];
          if (href) {
            if (href.lastIndexOf("/") > -1) href = href.substring(href.lastIndexOf("/") + 1);
            if (href.lastIndexOf(".") > -1) href = href.substring(0, href.lastIndexOf("."));
            if (href === "/") href = "";
            if (href === cRewrite) active = true;
          }
        }

        if (active) $(this).parent().addClass("active");
      }
    }
  });

  function XuLyLink(href) {
    if (href.lastIndexOf("/") > -1) href = href.substring(href.lastIndexOf("/") + 1);
    if (href.lastIndexOf(".") > -1) href = href.substring(0, href.lastIndexOf("."));
    if (href === "/") href = "";
    return href;
  }
}