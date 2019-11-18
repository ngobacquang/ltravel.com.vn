//Chọn,bỏ chọn tất cả các checkbox theo một checkbox cha
//nameregex: regex để tìm ra các checkbox con
//parrentControl: checkbox cha
//Ví dụ: xem checkbox check all tại phần quản lý danh mục tin tức
function CheckAllCheckBox(nameregex, parrentControl) {
    var checked = parrentControl.checked;
    if (checked) {
        re = new RegExp(nameregex);
        for (i = 0; i < document.forms[0].elements.length; i++) {
            elm = document.forms[0].elements[i];
            if (elm.type == 'checkbox') {
                if (re.test(elm.id)) {
                    elm.checked = true;

                }
            }
        }
    } else {
        re = new RegExp(nameregex);
        for (i = 0; i < document.forms[0].elements.length; i++) {
            elm = document.forms[0].elements[i];
            if (elm.type == 'checkbox') {
                if (re.test(elm.id)) {
                    elm.checked = false;
                }
            }
        }
    }
}