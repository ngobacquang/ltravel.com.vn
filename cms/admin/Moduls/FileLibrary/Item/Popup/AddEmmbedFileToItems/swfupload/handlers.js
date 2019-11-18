function fileQueueError(file, errorCode, message) {
	try {
		//var imageName = "error.gif";
		var errorName = "";
		if (errorCode === SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED) {
			errorName = "Lỗi! Bạn đã chọn quá số lượng file trong một lần upload.";
		}

		if (errorName !== "") {
		    jAlert(errorName, "SBBC.VN");
			return;
		}

		switch (errorCode) {
		    case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
		        //imageName = "zerobyte.gif";
		        jAlert("Lỗi! File bạn upload có dung lượng bằng 0.", "SBBC.VN");
		        break;
		    case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
		        //imageName = "toobig.gif";
		        jAlert("Lỗi! File bạn upload có dung lượng vượt quá mức cho phép.", "SBBC.VN");
		        break;
		    case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
		        jAlert("Lỗi! Loại file không được phép upload.", "SBBC.VN");
		        break;
		    default:
		        jAlert(message, "SBBC.VN");
		        break;
		}

		//addImage("images/" + imageName);

	} catch (ex) {
		this.debug(ex);
	}

}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (numFilesQueued > 0) {
			this.startUpload();
		}
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadStart(file) {
    //jQuery("#khungNutUpload").slideUp();
    jQuery("#khungNutUpload").css({ "height": "1px", "width": "1px", "overflow": "hidden" });
    jQuery("#khungNhapLink").slideUp();
}
function uploadProgress(file, bytesLoaded) {

    try {
        var percent = Math.ceil((bytesLoaded / file.size) * 100);

        if (percent < 1)
            jQuery("#buttonCancelUpload").slideDown();

        var progress = new FileProgress(file, this.customSettings.upload_target);
        progress.setProgress(percent);
        if (percent >= 100) {
            progress.setStatus("Trạng thái: Sắp hoàn thành......");
            progress.toggleCancel(false, this);
        } else {
            progress.setStatus("Trạng thái: Đang upload " + percent + " %");
            progress.toggleCancel(true, this);
        }
        jQuery("#divComplete").slideUp();
    } catch (ex) {
        this.debug(ex);
    }
}

function uploadSuccess(file, serverData) {
	try {
		//addImage("thumbnail.aspx?id=" + serverData);

		var progress = new FileProgress(file,  this.customSettings.upload_target);

		//progress.setStatus("Thumbnail Created.");
		progress.toggleCancel(false);


	} catch (ex) {
		this.debug(ex);
	}
}

function uploadComplete(file) {
    try {
        /*  I want the next upload to continue automatically so I'll call startUpload here */
        if (this.getStats().files_queued > 0) {
            this.startUpload();
        } else {
            var progress = new FileProgress(file, this.customSettings.upload_target);
            progress.setComplete();
            progress.setStatus("Trạng thái: Hoàn thành upload.");
            progress.toggleCancel(false);
        }
    } catch (ex) {
        this.debug(ex);
    }
    //jQuery("#khungNhapLink").slideUp();
    jQuery("#buttonCancelUpload").slideUp();
   // jQuery("#khungNutUpload").slideUp();

    if (FileIsVideo(file.type) == true) {
        //Convert video
        ProcessingVideo();    
    }
    else
        jQuery("#nutHoanThanh").slideDown();

    jQuery("#divComplete").slideDown();
}

function FileIsVideo(filetype) {
    var kq = false;
    var list = ".flv,.mp4,.wmv,.avi,.3gp,.mpeg,.mkv,.swf,.FLV,.MP4,.WMV,.AVI,.3GP,.MPEG,.MKV,.SWF";
    list = "," + list + ",";
    if (list.indexOf(filetype) >= 0)
        kq = true;
    return kq;
}

function uploadError(file, errorCode, message) {
    //var imageName =  "error.gif";
    var progress;
    try {
        switch (errorCode) {
            case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
                try {
                    progress = new FileProgress(file, this.customSettings.upload_target);
                    progress.setCancelled();
                    progress.setStatus("Cancelled");
                    progress.toggleCancel(false);
                }
                catch (ex1) {
                    this.debug(ex1);
                }
                break;
            case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
                try {
                    progress = new FileProgress(file, this.customSettings.upload_target);
                    progress.setCancelled();
                    progress.setStatus("Stopped");
                    progress.toggleCancel(true);
                }
                catch (ex2) {
                    this.debug(ex2);
                }
            case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
                //imageName = "uploadlimit.gif";
                jAlert("Lỗi! Bạn đã sử dụng hết số lượt upload.", "SBBC.VN");
                break;
            default:
                jAlert(message, "SBBC.VN");
                break;
        }

        //addImage("images/" + imageName);

    } catch (ex3) {
        this.debug(ex3);
    }

}


function addImage(src) {
	var newImg = document.createElement("img");
	newImg.style.margin = "5px";

	document.getElementById("thumbnails").appendChild(newImg);
	if (newImg.filters) {
		try {
			newImg.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 0;
		} catch (e) {
			// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
			newImg.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + 0 + ')';
		}
	} else {
		newImg.style.opacity = 0;
	}

	newImg.onload = function () {
		fadeIn(newImg, 0);
	};
	newImg.src = src;
}

function fadeIn(element, opacity) {
	var reduceOpacityBy = 5;
	var rate = 30;	// 15 fps


	if (opacity < 100) {
		opacity += reduceOpacityBy;
		if (opacity > 100) {
			opacity = 100;
		}

		if (element.filters) {
			try {
				element.filters.item("DXImageTransform.Microsoft.Alpha").opacity = opacity;
			} catch (e) {
				// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
				element.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + opacity + ')';
			}
		} else {
			element.style.opacity = opacity / 100;
		}
	}

	if (opacity < 100) {
		setTimeout(function () {
			fadeIn(element, opacity);
		}, rate);
	}
}



/* ******************************************
 *	FileProgress Object
 *	Control object for displaying file info
 * ****************************************** */

function FileProgress(file, targetID) {
	this.fileProgressID = "divFileProgress";

	this.fileProgressWrapper = document.getElementById(this.fileProgressID);
	if (!this.fileProgressWrapper) {
		this.fileProgressWrapper = document.createElement("div");
		this.fileProgressWrapper.className = "progressWrapper";
		this.fileProgressWrapper.id = this.fileProgressID;

		this.fileProgressElement = document.createElement("div");
		this.fileProgressElement.className = "progressContainer";

		var progressCancel = document.createElement("a");
		progressCancel.className = "progressCancel";
		progressCancel.href = "#";
		progressCancel.style.visibility = "hidden";
		progressCancel.appendChild(document.createTextNode(" "));

		var progressText = document.createElement("div");
		progressText.className = "progressName";
		progressText.appendChild(document.createTextNode(file.name));
	
		var progressBar = document.createElement("div");
		progressBar.className = "progressBarInProgress";
	
		var progressStatus = document.createElement("div");
		progressStatus.className = "progressBarStatus";
		progressStatus.innerHTML = "&nbsp;";
		
		this.fileProgressElement.appendChild(progressCancel);
		this.fileProgressElement.appendChild(progressText);
		this.fileProgressElement.appendChild(progressStatus);
		this.fileProgressElement.appendChild(progressBar);		

		this.fileProgressWrapper.appendChild(this.fileProgressElement);

		document.getElementById(targetID).appendChild(this.fileProgressWrapper);
		fadeIn(this.fileProgressWrapper, 0);

	} else {
    this.fileProgressElement = this.fileProgressWrapper.firstChild;
    this.fileProgressElement.childNodes[1].firstChild.nodeValue = "Tên tệp: " + file.name + " - Dung lượng: " + Math.ceil(file.size / 1024) + " KB";
	}

	this.height = this.fileProgressWrapper.offsetHeight;

}
FileProgress.prototype.setProgress = function (percentage) {
	this.fileProgressElement.className = "progressContainer green";
	this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
	this.fileProgressElement.childNodes[3].style.width = percentage + "%";
};
FileProgress.prototype.setComplete = function () {
	this.fileProgressElement.className = "progressContainer blue";
	this.fileProgressElement.childNodes[3].className = "progressBarComplete";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setError = function () {
	this.fileProgressElement.className = "progressContainer red";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setCancelled = function () {
	this.fileProgressElement.className = "progressContainer";
	this.fileProgressElement.childNodes[3].className = "progressBarError";
	this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setStatus = function (status) {
	this.fileProgressElement.childNodes[2].innerHTML = status;
};

FileProgress.prototype.toggleCancel = function (show, swfuploadInstance) {
    this.fileProgressElement.childNodes[0].style.visibility = show ? "visible" : "hidden";
    if (swfuploadInstance) {
        var fileID = this.fileProgressID;
        this.fileProgressElement.childNodes[0].onclick = function () {
            swfuploadInstance.cancelUpload(fileID);
            return false;
        };
    }
};
