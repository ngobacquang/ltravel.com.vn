//Mở một của sổ mới
function NewWindow_(url, name, w, h, scrollbar, resizable) {
    var LeftPosition = screen.width / 2 - w / 2;
    var TopPosition = screen.height / 2 - h / 2 - 100 + 50;
    //    if (TopPosition < 1) top = 1;    
    var settings = "width=" + w + ",height=" + h + ",scrollbars=" + scrollbar + ",resizable=" + resizable + ",screenX=0,screenY=200'";
    mywindow = window.open(url, name, settings);
    mywindow.moveTo(LeftPosition, TopPosition);
}

//Lấy chiều rộng cửa sổ trình duyệt
function GetWindowWidth() {
    var myWidth = 0, myHeight = 0;
    if (typeof (window.innerWidth) == 'number') {
        //Non-IE
        myWidth = window.innerWidth;
        myHeight = window.innerHeight;
    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
        //IE 6+ in 'standards compliant mode'
        myWidth = document.documentElement.clientWidth;
        myHeight = document.documentElement.clientHeight;
    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
        //IE 4 compatible
        myWidth = document.body.clientWidth;
        myHeight = document.body.clientHeight;
    }
    return myWidth;
}

//Lấy chiều cao cửa sổ trình duyệt
function GetWindowHeight() {
    var myWidth = 0, myHeight = 0;
    if (typeof (window.innerWidth) == 'number') {
        //Non-IE
        myWidth = window.innerWidth;
        myHeight = window.innerHeight;
    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
        //IE 6+ in 'standards compliant mode'
        myWidth = document.documentElement.clientWidth;
        myHeight = document.documentElement.clientHeight;
    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
        //IE 4 compatible
        myWidth = document.body.clientWidth;
        myHeight = document.body.clientHeight;
    }
    return myHeight;
}