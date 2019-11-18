function GetPathOfPicDirectory(appString, thumbType) {
    var path = "";
    switch (thumbType) {
        case "Thumb":
            path = "pic/Thumb/Thumb/";
            break;

        case "Small":
            path = "pic/Thumb/Small/";
            break;

        case "Compact":
            path = "pic/Thumb/Compact/";
            break;

        case "Medium":
            path = "pic/Thumb/Medium/";
            break;

        case "Large":
            path = "pic/Thumb/Large/";
            break;

        default:
            path = "pic/";
            break;
    }

    return path + appString;
}

function GetImageTag(image, altImage, appString, thumbType, cssClass, attributeString) {
    var imageSrc = "";
    if (image !== "") {
        if (altImage === "") altImage = image;
        imageSrc = GetPathOfPicDirectory(appString, thumbType) + "/" + image;
    }
    else {
        switch (thumbType) {
            case "Thumb":
                imageSrc = NoImageSrcThumb;
                break;

            case "Small":
                imageSrc = NoImageSrcSmall;
                break;

            case "Compact":
                imageSrc = NoImageSrcCompact;
                break;

            case "Medium":
                imageSrc = NoImageSrcMedium;
                break;

            case "Large":
                imageSrc = NoImageSrcLarge;
                break;

            default:
                imageSrc = NoImageSrcLarge;
                break;
        }
    }

    if (imageSrc.startsWith('/'))
        imageSrc = imageSrc.substring(1);
    imageSrc = WebUrl + imageSrc;

    return "<img src=\"data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==\" data-src=\"{0}\" alt=\"{1}\" class=\"lazyload {2}\" {3}/>".format(imageSrc, altImage, cssClass, attributeString);
}

function GetImageTagAccount(image, altImage, appString, thumbType, cssClass, attributeString, gender) {
    var imageSrc = "";
    if (image !== "") {
        if (altImage === "") altImage = image;
        imageSrc = GetPathOfPicDirectory(appString, thumbType) + "/" + image;
    }
    else {
        switch (thumbType) {
            case "Thumb":
                imageSrc = (gender === 1
                    ? NoMaleImageSrcThumb
                    : (gender === 0 ? NoFemaleImageSrcThumb : NoImageSrcThumb));
                break;

            case "Small":
                imageSrc = (gender === 1
                    ? NoMaleImageSrcSmall
                    : (gender === 0 ? NoFemaleImageSrcSmall : NoImageSrcSmall));
                break;

            case "Compact":
                imageSrc = (gender === 1
                    ? NoMaleImageSrcCompact
                    : (gender === 0 ? NoFemaleImageSrcCompact : NoImageSrcCompact));
                break;

            case "Medium":
                imageSrc = (gender === 1
                    ? NoMaleImageSrcMedium
                    : (gender === 0 ? NoFemaleImageSrcMedium : NoImageSrcMedium));
                break;

            case "Large":
                imageSrc = (gender === 1
                    ? NoMaleImageSrcLarge
                    : (gender === 0 ? NoFemaleImageSrcLarge : NoImageSrcLarge));
                break;

            default:
                imageSrc = (gender === 1
                    ? NoMaleImageSrcLarge
                    : (gender === 0 ? NoFemaleImageSrcLarge : NoImageSrcLarge));
                break;
        }
    }

    if (imageSrc.startsWith('/'))
        imageSrc = imageSrc.substring(1);
    imageSrc = WebUrl + imageSrc;

    return "<img src=\"data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==\" data-src=\"{0}\" alt=\"{1}\" class=\"lazyload {2}\" {3}/>".format(imageSrc, altImage, cssClass, attributeString);
}

function GetImageTagByModuleType(article, moduleType) {
    if (article.Image.length > 0)
        return GetImageTag(article.Image, article.AltImage, article.App, 'Thumb', "", "");
    else {
        if (moduleType === "video" && article.LinkedFile.length > 0) {
            return "<img class=\"lazyload\" src=\"data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==\" data-src=\"{0}\" alt=\"{1}\"/>".format(GetYoutubeImageSrc(article.LinkedFile), article.AltImage);
        } else {
            return GetImageTag(article.Image, article.AltImage, article.App, 'Thumb', "", "");
        }
    }
}

function GetYoutubeImageSrc(youtubeLink) {
    var videoId = getQueryString("v", youtubeLink);

    return 'http://img.youtube.com/vi/' + videoId + '/default.jpg';

    //default: ảnh nhỏ
    //mqdefault: ảnh trung bình
    //0, hqdefault: ảnh lớn
    //sddefault: to hơn hddefault
    //1,2,3: các ảnh nhỏ
}