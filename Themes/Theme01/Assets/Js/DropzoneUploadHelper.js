//Mảng chứa các dropzone, khi khai báo thì add vào mảng để chạy vòng lặp reset khi thêm mới nhiều tin, sản phẩm liên tục
var dropzones = [];

// #region Đánh dấu xóa ảnh trong album
function RemoveSavedImageGallery(id, dropzoneWrapId) {
    /// <summary>Đánh giấu xóa ảnh trong album</summary>
    /// <param name="id" type="String">Id ảnh</param>
    /// <param name="dropzoneWrapId" type="String">Id khối chứa dropzone upload ảnh</param>

    event.preventDefault();

    var deletedImageGalleriesData = [];

    if ($("#" + dropzoneWrapId + " input[data-name='DeletedImageData']").val() !== "")
        deletedImageGalleriesData = JSON.parse($("#" + dropzoneWrapId + " input[data-name='DeletedImageData']").val());
    
    deletedImageGalleriesData.push({ "savedFileName": id.toString() });
    
    $("#" + dropzoneWrapId + " input[data-name='DeletedImageData']").val(JSON.stringify(deletedImageGalleriesData));

    $("#" + dropzoneWrapId + " div[data-name='SavedImages'] div[data-subid='" + id + "']").remove();
}
// #endregion

// #region Xóa phần upload ảnh cũ cho tất cả dropzone
function RemoveAllDropzoneUpload() {
    /// <summary>Xóa phần upload ảnh cũ cho tất cả dropzone</summary>

    dropzones.forEach(function (dropzone) {
        dropzone.removeAllFiles();
    });
}
// #endregion

// #region Xử lý lưu danh sách ảnh được upload và xóa ở phần upload ảnh dùng dropzone
function UpdateUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId) {
    var files =[];
    var $inputHidden = $("#" +imageUploadDataHiddenFieldId);
    if($inputHidden.val() !== "")
        files = JSON.parse($inputHidden.val());

    files.push({
        "savedFileName": savedFileName,
        "orgFileName": orgFileName
    });

    $inputHidden.val(JSON.stringify(files));
}

function RemoveUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId) {
    var files =[];
    var $inputHidden = $("#" +imageUploadDataHiddenFieldId);
    if($inputHidden.val() !== "")
        files = JSON.parse($inputHidden.val());

    for(var i = 0; i < files.length; i++) {
        if(files[i].savedFileName === savedFileName && files[i].orgFileName === orgFileName)
            files.splice(i, 1);
}

    $inputHidden.val(JSON.stringify(files));
}
// #endregion

// #region Khởi tạo phần upload ảnh
function InitImageUpload(dropzoneWrapId, maxFiles, maxFilesize, acceptedFiles, notResize, dictDefaultMessage) {
    /// <summary>Khởi tạo upload ảnh đại diện (thường là 1 ảnh). Khối chứa dropzone phải theo mẫu ở cuối chú thích này.</summary>    
    /// <param name="dropzoneWrapId" type="String">Id khối bao dropzone. Nên để là ImageUploadWrap</param>
    /// <param name="maxFiles" type="Int">Số tệp tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 1</param>
    /// <param name="maxFilesize" type="Int">Dung lượng tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 10</param>
    /// <param name="acceptedFiles" type="String">Các đuôi file nhận, ví dụ ".jpg,.jpeg" Nếu null hoặc rỗng sẽ lấy mặc định là ".jpg,.jpeg,.png,.gif"</param>
    /// <param name="notResize" type="Bool">True: không resize ảnh, mặc định resize max width 1920px</param>    
    /// <param name="dictDefaultMessage" type="String">Placeholder ở ô upload, mặc định là Click hoặc kéo ảnh vào đây</param>    
    /*
<div class="dropzone-wrap dropzone-small" id="dropzoneWrapId">
	<div data-name="ImageUploadArea" class="dropzone"></div>
	<input data-name="ImageUploadData" type="hidden" />
	<div data-name="SavedImages" class="row"></div>
	<input data-name="DeletedImageData" type="hidden" />
</div>
     */

    if (!maxFiles || (maxFiles!=="undefined" && parseInt(maxFiles) === 0)) maxFiles = 1;
    if (!maxFilesize || (maxFilesize!=="undefined" && parseInt(maxFilesize) === 0)) maxFilesize = 10;
    if (!acceptedFiles || (acceptedFiles !== "undefined" && acceptedFiles.toString() === ""))
        acceptedFiles = ".jpg,.jpeg,.png,.gif";
    if (!dictDefaultMessage) dictDefaultMessage = "Click hoặc kéo ảnh vào đây";

    Dropzone.options.myAwesomeDropzone = false;
    Dropzone.autoDiscover = false;

    //Id của hidden field lưu danh sách ảnh upload để gửi lên server khi lưu thông tin tài khoản
    var imageUploadDataHiddenFieldId = dropzoneWrapId + " [data-name='ImageUploadData']";

    var dropzone = new Dropzone("#" + dropzoneWrapId + " [data-name='ImageUploadArea']", {
        url: "/themes/themes01/ajax/ImageUpload.aspx?action=ImageUpload",
        maxFiles: maxFiles,
        maxFilesize: maxFilesize,
        resizeWidth: (notResize ? null : 1920),
        resizeQuality: 0.9,
        resizeMethod: "contain",
        addRemoveLinks: true,
        uploadMultiple: false,
        acceptedFiles: acceptedFiles,
        dictDefaultMessage: dictDefaultMessage,
        dictFallbackMessage: "Trình duyệt của bạn không hỗ trợ kéo thả để upload",
        dictFileTooBig: "Tệp quá lớn ({{filesize}}MiB). Tối đa là: {{maxFilesize}}MiB.",
        dictInvalidFileType: "Bạn không thể tải lên loại tệp này",
        dictMaxFilesExceeded: "Bạn không thể tải thêm tệp lên",
        dictRemoveFile: "Xóa tệp này",
        init: function () {
            this.on("maxfilesexceeded", function (data) {
                alert("Số tệp tải lên vượt quá giới hạn cho phép");
            });

            // #region Hoàn thành upload một file
            this.on("success", function (data) {
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    UpdateUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion

            // #region Click nút xóa một file
            this.on("removedfile", function (data) {
                // If you want to the delete the file on the server as well,
                // you can do the AJAX request here.
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    RemoveUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion
        }
    });

    //Add vào mảng để chạy vòng lặp reset khi thêm mới nhiều tin, sản phẩm liên tục
    dropzones.push(dropzone);
}
// #endregion

// #region Khởi tạo phần upload tệp đính kèm
function InitFileUpload(dropzoneWrapId, maxFiles, maxFilesize, acceptedFiles, dictDefaultMessage) {
    /// <summary>Khởi tạo upload tệp đính kèm - 1 tệp. Tương tự upload ảnh đại diện, chỉ fix sẵn các thông số mặc định cho phù hợp.</summary>
    /// <param name="dropzoneWrapId" type="String">Id khối bao dropzone. Nên để là FileUploadWrap</param>
    /// <param name="maxFiles" type="Int">Số tệp tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 1</param>
    /// <param name="maxFilesize" type="Int">Dung lượng tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 100</param>
    /// <param name="acceptedFiles" type="String">Các đuôi file nhận, ví dụ ".jpg,.jpeg" Nếu null hoặc rỗng sẽ lấy mặc định là ".jpg,.jpeg,.png,.gif,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.rar,.zip,.txt"</param>
    /// <param name="dictDefaultMessage" type="String">Placeholder ở ô upload, mặc định là Click hoặc kéo tệp vào đây</param>
    /*
<div class="dropzone-wrap dropzone-small" id="dropzoneWrapId">
    <div data-name="ImageUploadArea" class="dropzone"></div>
    <input data-name="ImageUploadData" type="hidden" />
    <div data-name="SavedImages" class="row"></div>
    <input data-name="DeletedImageData" type="hidden" />
</div>
 */

    if (!maxFiles || (maxFiles !== "undefined" && parseInt(maxFiles) === 0)) maxFiles = 1;
    if (!maxFilesize || (maxFilesize !== "undefined" && parseInt(maxFilesize) === 0)) maxFilesize = 100;
    if (!acceptedFiles || (acceptedFiles !== "undefined" && acceptedFiles.toString() === ""))
        acceptedFiles = ".jpg,.jpeg,.png,.gif,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.rar,.zip,.txt";
    if (!dictDefaultMessage || (dictDefaultMessage !== "undefined" && dictDefaultMessage.toString() === "")) dictDefaultMessage = "Click hoặc kéo tệp vào đây";

    Dropzone.options.myAwesomeDropzone = false;
    Dropzone.autoDiscover = false;

    //Id của hidden field lưu danh sách ảnh upload để gửi lên server khi lưu thông tin tài khoản
    var imageUploadDataHiddenFieldId = dropzoneWrapId + " [data-name='ImageUploadData']";

    var dropzone = new Dropzone("#" + dropzoneWrapId + " [data-name='ImageUploadArea']", {
        url: "/themes/themes01/ajax/ImageUpload.aspx?action=ImageUpload",
        maxFiles: maxFiles,
        maxFilesize: maxFilesize,
        addRemoveLinks: true,
        uploadMultiple: false,
        acceptedFiles: acceptedFiles,
        dictDefaultMessage: dictDefaultMessage,
        dictFallbackMessage: "Trình duyệt của bạn không hỗ trợ kéo thả để upload",
        dictFileTooBig: "Tệp quá lớn ({{filesize}}MiB). Tối đa là: {{maxFilesize}}MiB.",
        dictInvalidFileType: "Bạn không thể tải lên loại tệp này",
        dictMaxFilesExceeded: "Bạn không thể tải thêm tệp lên",
        dictRemoveFile: "Xóa tệp này",
        init: function () {
            this.on("maxfilesexceeded", function (data) {
                alert("Số tệp tải lên vượt quá giới hạn cho phép");
            });

            // #region Hoàn thành upload một file
            this.on("success", function (data) {
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    UpdateUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion

            // #region Click nút xóa một file
            this.on("removedfile", function (data) {
                // If you want to the delete the file on the server as well,
                // you can do the AJAX request here.
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    RemoveUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion
        }
    });

    //Add vào mảng để chạy vòng lặp reset khi thêm mới nhiều tin, sản phẩm liên tục
    dropzones.push(dropzone);
}
// #endregion

// #region Khởi tạo phần upload video đính kèm
function InitVideoUpload(dropzoneWrapId, maxFiles, maxFilesize, acceptedFiles) {
    /// <summary>Khởi tạo upload video đính kèm - 1 video. Tương tự upload ảnh đại diện, chỉ fix sẵn các thông số mặc định cho phù hợp.</summary>
    /// <param name="dropzoneWrapId" type="String">Id khối bao dropzone. Nên để là VideoUploadWrap</param>
    /// <param name="maxFiles" type="Int">Số tệp tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 1</param>
        /// <param name="maxFilesize" type="Int">Dung lượng tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 100</param>
    /// <param name="acceptedFiles" type="String">Các đuôi file nhận, ví dụ ".jpg,.jpeg" Nếu null hoặc rỗng sẽ lấy mặc định là ".mp4"</param>
        /*
    <div class="dropzone-wrap dropzone-small" id="dropzoneWrapId">
        <div data-name="ImageUploadArea" class="dropzone"></div>
        <input data-name="ImageUploadData" type="hidden" />
        <div data-name="SavedImages" class="row"></div>
        <input data-name="DeletedImageData" type="hidden" />
    </div>
     */

    if (!maxFiles || (maxFiles !== "undefined" && parseInt(maxFiles) === 0)) maxFiles = 1;
    if (!maxFilesize || (maxFilesize !== "undefined" && parseInt(maxFilesize) === 0)) maxFilesize = 100;
    if (!acceptedFiles || (acceptedFiles !== "undefined" && acceptedFiles.toString() === ""))
        acceptedFiles = ".mp4";

    Dropzone.options.myAwesomeDropzone = false;
    Dropzone.autoDiscover = false;

    //Id của hidden field lưu danh sách ảnh upload để gửi lên server khi lưu thông tin tài khoản
    var imageUploadDataHiddenFieldId = dropzoneWrapId + " [data-name='ImageUploadData']";

    var dropzone = new Dropzone("#" + dropzoneWrapId + " [data-name='ImageUploadArea']", {
        url: "/themes/themes01/ajax/ImageUpload.aspx?action=ImageUpload",
        maxFiles: maxFiles,
        maxFilesize: maxFilesize,
        addRemoveLinks: true,
        uploadMultiple: false,
        acceptedFiles: acceptedFiles,
        dictDefaultMessage: "Click hoặc kéo tệp đính kèm vào đây",
        dictFallbackMessage: "Trình duyệt của bạn không hỗ trợ kéo thả để upload",
        dictFileTooBig: "Tệp quá lớn ({{filesize}}MiB). Tối đa là: {{maxFilesize}}MiB.",
        dictInvalidFileType: "Bạn không thể tải lên loại tệp này",
        dictMaxFilesExceeded: "Bạn không thể tải thêm tệp lên",
        dictRemoveFile: "Xóa tệp này",
        init: function () {
            this.on("maxfilesexceeded", function (data) {
                alert("Số tệp tải lên vượt quá giới hạn cho phép");
            });

            // #region Hoàn thành upload một file
            this.on("success", function (data) {
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    UpdateUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion

            // #region Click nút xóa một file
            this.on("removedfile", function (data) {
                // If you want to the delete the file on the server as well,
                // you can do the AJAX request here.
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    RemoveUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion
        }
    });

     //Add vào mảng để chạy vòng lặp reset khi thêm mới nhiều tin, sản phẩm liên tục
    dropzones.push(dropzone);
}
// #endregion

// #region Khởi tạo phần upload ảnh trong album hoặc các phần khách dạng upload nhiều ảnh
function InitImageGalleryUpload(dropzoneWrapId, maxFiles, maxFilesize, acceptedFiles, notResize) {
    /// <summary>Khởi tạo upload ảnh trong albm. Khối chứa dropzone phải theo mẫu ở cuối chú thích này.</summary>    
    /// <param name="dropzoneWrapId" type="String">Id khối bao dropzone. Nên để là ImageGalleryUploadWrap</param>
    /// <param name="maxFiles" type="Int">Số tệp tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 100</param>
    /// <param name="maxFilesize" type="Int">Dung lượng tối đa up lên. Nếu null khoặc bằng 0 sẽ lấy mặc định là 500</param>
    /// <param name="acceptedFiles" type="String">Các đuôi file nhận, ví dụ ".jpg,.jpeg" Nếu null hoặc rỗng sẽ lấy mặc định là ".jpg,.jpeg,.png,.gif"</param>
    /// <param name="notResize" type="Bool">True: không resize ảnh, mặc định resize max width 1920px</param>    
    /*
<div class="dropzone-wrap dropzone-small" id="dropzoneWrapId">
	<div data-name="ImageUploadArea" class="dropzone"></div>
	<input data-name="ImageUploadData" type="hidden" />
	<div data-name="SavedImages" class="row"></div>
	<input data-name="DeletedImageData" type="hidden" />
</div>
     */

    if (!maxFiles || (maxFiles !== "undefined" && parseInt(maxFiles) === 0)) maxFiles = 100;
    if (!maxFilesize || (maxFilesize !== "undefined" && parseInt(maxFilesize) === 0)) maxFilesize = 500;
    if (!acceptedFiles || (acceptedFiles !== "undefined" && acceptedFiles.toString() === ""))
        acceptedFiles = ".jpg,.jpeg,.png,.gif";

    Dropzone.options.myAwesomeDropzone = false;
    Dropzone.autoDiscover = false;

    //Id của hidden field lưu danh sách ảnh upload để gửi lên server khi lưu thông tin tài khoản
    var imageUploadDataHiddenFieldId = dropzoneWrapId + " [data-name='ImageUploadData']";

    var dropzone = new Dropzone("#" + dropzoneWrapId + " [data-name='ImageUploadArea']", {
        url: "/themes/themes01/ajax/ImageUpload.aspx?action=ImageUpload",
        maxFiles: maxFiles,
        maxFilesize: maxFilesize,
        resizeWidth: (notResize ? null : 1920),
        resizeQuality: 0.9,
        resizeMethod: "contain",
        addRemoveLinks: true,
        uploadMultiple: false,
        acceptedFiles: acceptedFiles,
        dictDefaultMessage: "Click hoặc kéo các ảnh vào đây",
        dictFallbackMessage: "Trình duyệt của bạn không hỗ trợ kéo thả để upload",
        dictFileTooBig: "Ảnh quá lớn ({{filesize}}MiB). Tối đa là: {{maxFilesize}}MiB.",
        dictInvalidFileType: "Bạn không thể tải lên loại ảnh này",
        dictMaxFilesExceeded: "Bạn không thể tải thêm ảnh lên",
        dictRemoveFile: "Xóa ảnh này",
        init: function () {
            this.on("maxfilesexceeded", function (data) {
                alert("Số ảnh tải lên vượt quá giới hạn cho phép");
            });

            // #region Hoàn thành upload một file
            this.on("success", function (data) {
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    UpdateUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion

            // #region Click nút xóa một file
            this.on("removedfile", function (data) {
                // If you want to the delete the file on the server as well,
                // you can do the AJAX request here.
                if (data.xhr) {
                    var fileInfo = JSON.parse(data.xhr.responseText);
                    var savedFileName = fileInfo[0];
                    var orgFileName = fileInfo[1];

                    //Cập nhật danh sách file đã upload vào input hidden để gửi lên server khi lưu thông tin tài khoản
                    RemoveUploadedImageList(savedFileName, orgFileName, imageUploadDataHiddenFieldId);
                }
            });
            // #endregion
        }
    });

    //Add vào mảng để chạy vòng lặp reset khi thêm mới nhiều tin, sản phẩm liên tục
    dropzones.push(dropzone);
}
// #endregion