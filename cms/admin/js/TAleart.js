//Bật lên thông báo tự tắt sau vài giây (miliSecondDelay: số mili giây đếm ngược đến khi thông báo tắt, noiDungThongBao: nội dung thông báo)
function ThongBao(miliSecondDelay, contentPopup) {
    TaoThongBao();
    document.getElementById('divNoiDungThongBao').innerHTML = contentPopup;
    miliSecondDelay = parseInt(miliSecondDelay) / 1000;
    var int = self.setInterval(
            function () {
                document.getElementById('divDemNguoiThoiGian').innerHTML = miliSecondDelay + "&nbsp;";
                miliSecondDelay--;
                if (miliSecondDelay < 0) {
                    window.clearInterval(int);
                    HuyThongBao();
                }
            }
            , 1000);
}
function TaoThongBao() {
    var TextForm = "<div id='divThongBao'><div id='divKhungThongBao'><div id='divDemNguoiThoiGian'>&nbsp;</div><div id='divThongBaoNho'>Chú ý: bạn có thể tiếp tục làm việc khi có thông báo này.</div><div id='divNoiDungThongBao'><!----></div></div></div>";
    var left = (GetWindowWidth() - 400) / 2;
    jQuery("#form1").append(TextForm);
    document.getElementById('divThongBao').style.cssText = "background:#666;position:fixed;_position:absolute;bottom:10%;right:10%;z-index:9999;display:none;border:solid 1px #fff;border-radius:15px;width:400px";
    document.getElementById('divKhungThongBao').style.cssText = "position:relative;padding:30px 50px 30px 20px";
    document.getElementById('divNoiDungThongBao').style.cssText = "font:normal 18px Arial;color:#fff";

    document.getElementById('divThongBaoNho').style.cssText = "font:normal 11px Arial;color:#fff;position:absolute;bottom:6px;right:10px";

    document.getElementById('divDemNguoiThoiGian').style.cssText = "font:normal 50px Arial;color:#fff;position:absolute;top:10px;right:-5px;-moz-opacity: 0.5;opacity:.50;filter: alpha(opacity=50)";
    document.getElementById('divThongBao').style.display = "block";
    window.scrollTo(0, 0);
}
function HuyThongBao() {
    document.getElementById('divThongBao').style.display = "none";
    document.getElementById('form1').removeChild(document.getElementById('divThongBao'));
}