
/*
Author:		Robert Hashemian (http://www.hashemian.com/)
Modified by:	Munsifali Rashid (http://www.munit.co.uk/)
Modified by:	Tilesh Khatri
Modified by:    nguyenvanhoalh (http://tatthanh.com.vn)
*/

function StartCountDown(myStartDate, myTargetDate, myDiv, ngay, gio, phut, giay) {
    var dthen = new Date(myTargetDate);
    var dstart = new Date(myStartDate);
    var dnow = new Date();
    ddiff = new Date(dthen - dnow);
    gsecs = Math.floor(ddiff.valueOf() / 1000);

    ddiff = new Date(dthen - dstart);
    totalsecs = Math.floor(ddiff.valueOf() / 1000);
    //Gọi hàm đếm ngược thời gian
    CountBack(gsecs, totalsecs, myDiv, ngay, gio, phut, giay);
}

function Calcage(secs, num1, num2) {
    s = ((Math.floor(secs / num1)) % num2).toString();
    if (s.length < 2) {
        s = "0" + s;
    }
    return (s);
}

function CountBack(secs, total, myDiv, ngay, gio, phut, giay) {
    if (secs > 0) {
        /*Hiển thị phần trăm*/
        var pc = (total - secs) * 100 / total;

        /*Hiển thị đồng hồ*/
        var soNgay = Calcage(secs, 86400, 100000);
        var soGio = Calcage(secs, 3600, 24);
        var soPhut = Calcage(secs, 60, 60);
        var soGiay = Calcage(secs, 1, 60);

        document.getElementById(ngay).innerHTML = soNgay;
        document.getElementById(gio).innerHTML = soGio;
        document.getElementById(phut).innerHTML = soPhut;
        document.getElementById(giay).innerHTML = soGiay;

        setTimeout("CountBack(" + (secs - 1) + "," + total + ",'" + myDiv + "','" + ngay + "','" + gio + "','" + phut + "','" + giay + "');", 1000); //Code cũ họ để timeout là 990
    }
    else {
        document.getElementById(ngay).innerHTML = "00";
        document.getElementById(gio).innerHTML = "00";
        document.getElementById(phut).innerHTML = "00";
        document.getElementById(giay).innerHTML = "00";
    }
}




function UpdateOrderCate_Deal(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Deal/Ajax/UpdateOrderCate.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}

function UpdateOrderProperty_Deal(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Deal/Ajax/UpdateOrderProperty.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}

function UpdateOrderFilter_Deal(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Deal/Ajax/UpdateOrderFilter.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
        InitShowHideGroup(); //Khởi tạo trạng thái ẩn hiện các danh mục
    });
}

function UpdateOrderColor_Deal(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Deal/Ajax/UpdateOrderColor.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);
    });
}

function UpdateOrderGroupItem_Deal(igid, igparentid) {
    var tbvalue = document.getElementById('TbOrder' + igid).value;
    $.post(WebsiteUrl + "cms/admin/Moduls/Deal/Ajax/UpdateOrderGroupItem.aspx", { "igid": igid, "igorder": tbvalue, "igparentid": igparentid }, function (result) {
        $("#CateOrder-" + igparentid).html(result);

    });
}