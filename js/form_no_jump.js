$('form').submit(function (event) {
    event.preventDefault();
    var form = $(this);
    if (!form.hasClass('fupload')) {
        $.ajax({
            "type": form.attr('method'),
            "url": form.attr('action'),
            "data": form.serialize(),
            "success": function () {
                alert("操作成功!");
                window.location.reload();
            },
            "error": function () {
                alert("操作失败!");
                window.location.reload();
            }
        });
    }
    else {
        var formData = new FormData(this);
        $.ajax({
            "type": form.attr('method'),
            "url": form.attr('action'),
            "data": formData,
            "mimeType": "multipart/form-data",
            "contentType": false,
            "cache": false,
            "processData": false,
            "success": function () {
                alert("操作成功!");
                window.location.reload();
            },
            "error": function () {
                alert("操作失败!");
                window.location.reload();
            }
        });
    }
});