// #region Thay thế tiêu đề dạng url
function ReplaceTitle(text) {
    text = text.trim();//Xoá các khoảng trắng ở hai đầu

    //Thay thế các kí tự thường có dấu bởi các kí tự thường không dấu
    text = text.replace(/(ä|à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/g, "a");
    text = text.replace(/(ä|à|á|ạ|ả|ã|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/g, "a");//Unicode tổ hợp
    text = text.replace(/ç/g, "c");
    text = text.replace(/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/g, "e");
    text = text.replace(/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/g, "e");//Unicode tổ hợp
    text = text.replace(/(ì|í|î|ị|ỉ|ĩ)/g, "i");
    text = text.replace(/(ì|í|î|ị|ỉ|ĩ)/g, "i");//Unicode tổ hợp
    text = text.replace(/(ö|ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/g, "o");
    text = text.replace(/(ö|ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/g, "o");//Unicode tổ hợp
    text = text.replace(/(ü|ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/g, "u");
    text = text.replace(/(ü|ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/g, "u");//Unicode tổ hợp
    text = text.replace(/(ỳ|ý|ỵ|ỷ|ỹ)/g, "y");
    text = text.replace(/(ỳ|ý|ỵ|ỷ|ỹ)/g, "y");//Unicode tổ hợp
    text = text.replace(/(đ)/g, "d");
    text = text.replace(/(đ)/g, "d");//Unicode tổ hợp
    text = text.replace(/(ð)/g, "d");

    //Thay thế các kí tự viết hoa có dấu bởi các kí tự viết hoa không dấu
    text = text.replace(/(Ä|À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)/g, "A");
    text = text.replace(/(Ä|À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)/g, "A");//Unicode tổ hợp
    text = text.replace(/Ç/g, "C");
    text = text.replace(/(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)/g, "E");
    text = text.replace(/(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)/g, "E");//Unicode tổ hợp
    text = text.replace(/(Ì|Í|Ị|Ỉ|Ĩ)/g, "I");
    text = text.replace(/(Ì|Í|Ị|Ỉ|Ĩ)/g, "I");//Unicode tổ hợp
    text = text.replace(/(Ö|Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)/g, "O");
    text = text.replace(/(Ö|Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)/g, "O");//Unicode tổ hợp
    text = text.replace(/(Ü|Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)/g, "U");
    text = text.replace(/(Ü|Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)/g, "U");//Unicode tổ hợp
    text = text.replace(/(Ỳ|Ý|Ỵ|Ỷ|Ỹ)/g, "Y");
    text = text.replace(/(Ỳ|Ý|Ỵ|Ỷ|Ỹ)/g, "Y");//Unicode tổ hợp
    text = text.replace(/(Đ)/g, "D");


    //Thay thế các khoảng trắng bởi một dấu -
    text = text.replace(/[\t\r\n\v\f]/g, "-");

    //Thay một hoặc nhiều kí tự trống bới một dấu -
    text = text.replace(/( )+/g, "-");

    //Chỉ giữ lại các chữ cái từ A-Z, từ a-z, các số từ 0-9, dấu _ và dấu -
    text = text.replace(/[^A-Za-z0-9_-]/g, "-");

    //Thay một hoặc nhiều dấu _ bởi một đấu _
    text = text.replace(/(_)+/g, "_");

    //Thay một hoặc nhiều dấu - bởi một dấu -
    text = text.replace(/(-)+/g, "-");

    //Xoá những ký tự _ đầu và cuối
    text = text.replace(/^\_+|\_+$/g, '');

    //Xoá những ký tự - đầu và cuối
    text = text.replace(/^\-+|\-+$/g, '');

    return text.toLowerCase();
}
// #endregion

// #region Định dạng con số. Ví dụ numberWithCommas(12345.6789) -> 12,345.6789
function numberWithCommas(x, useDot) {
    /// <summary>Định dạng con số. Ví dụ numberWithCommas(12345.6789) -> 12,345.6789</summary>
    /// <param name="x" type="Double">Số cần định dạng</param>
    /// <param name="useDot" type="Boolean">True: dùng dấu . để phân chia hàng nghìn thay vì dấu , mặc định</param>

    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    x = parts.join(".");

    if (useDot)
        x = x.replace(/\./g, '-').replace(/\,/g, '.').replace(/-/g, ',');

    return x;
}
// #endregion

// #region Lấy query string
/**
 * Get the value of a querystring
 * @param  {String} field The field to get the value of
 * @param  {String} url   The URL to get the value from (optional)
 * @return {String}       The field value
 */
var getQueryString = function (field, url) {
    var href = url ? url : window.location.href;
    var reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i');
    var string = reg.exec(href);
    return string ? decodeURI(string[1]) : null;
};
// #endregion

// #region Tạo chuỗi ngẫu nhiên làm ID
function RandomString() {
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

    for (var i = 0; i < 8; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}
// #endregion

// #region Chuyển đổi chữ hoa thường trên một dòng
function Sentencecase(str) {
    /// <summary>Viết hoa chữ đầu tiên. Ví dụ: "Một hai ba"</summary>

    if (str.length > 0) {
        str = str.toLowerCase();
        var f = str.charAt(0).toUpperCase();
        str = f + str.substring(1);
    }

    return str;
}

function TitleCase(str) {
    /// <summary>Viết hoa đầu các chữ. Ví dụ: "Một Hai Ba"</summary>

    var res = '';

    var strs = str.split(' ');
    strs.forEach(function (word) {
        res += ' ' + Sentencecase(word);
    });
    if (res.length > 0) res = res.substring(1);

    return res;
}

function UPPERCASE(str) {
    /// <summary>Viết hoa tất. Ví dụ: "MỘT HAI BA"</summary>

    return str.toUpperCase();
}

function lowercase(str) {
    /// <summary>Viết thường tất. Ví dụ: "một hai ba"</summary>

    return str.toLowerCase();
}

function DoSentencecase(selector) {
    event.preventDefault();

    $(selector).val(Sentencecase($(selector).val())).keyup();//Gọi thêm sự kiện keyup để xử lý tương tự khi click vào ô textbox để gõ
}

function DoTitleCase(selector) {
    event.preventDefault();

    $(selector).val(TitleCase($(selector).val())).keyup();//Gọi thêm sự kiện keyup để xử lý tương tự khi click vào ô textbox để gõ
}

function DoUPPERCASE(selector) {
    event.preventDefault();

    $(selector).val(UPPERCASE($(selector).val())).keyup();//Gọi thêm sự kiện keyup để xử lý tương tự khi click vào ô textbox để gõ
}

function Dolowercase(selector) {
    event.preventDefault();

    $(selector).val(lowercase($(selector).val())).keyup();//Gọi thêm sự kiện keyup để xử lý tương tự khi click vào ô textbox để gõ
}
// #endregion