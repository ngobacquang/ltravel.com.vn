function IncreaseTextSize() {
    var size = parseInt(jQuery(".content-wrap-article-detail").css("font-size"));
    size++;
    var lineheight = parseInt(jQuery(".content-wrap-article-detail").css("line-height"));
    lineheight+=2;
    jQuery(".content-wrap-article-detail").css({ "font-size": size + "px", "line-height": lineheight + "px" });
}

function DecreaseTextSize() {
    var size = parseInt(jQuery(".content-wrap-article-detail").css("font-size"));
    size--;
    var lineheight = parseInt(jQuery(".content-wrap-article-detail").css("line-height"));
    lineheight-=2;
    jQuery(".content-wrap-article-detail").css({ "font-size": size + "px", "line-height": lineheight + "px" });
}

function ResetTextSize() {
    jQuery(".content-wrap-article-detail").css({ "font-size": "", "line-height": "" });
}
