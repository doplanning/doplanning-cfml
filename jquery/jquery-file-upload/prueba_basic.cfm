<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>jQuery File Upload Example</title>
<style>
	.bar {
    height: 18px;
    background: green;
}
</style>
</head>
<body>
<form id="fileupload" action="UploadManager.cfc?method=uploadFile" method="POST" enctype="multipart/form-data">
	<input type="file" name="files[]" multiple>
</form>
<!---<input id="fileupload" type="file" name="files[]" data-url="UploadManager.cfc?method=uploadFile" multiple>--->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="js/vendor/jquery.ui.widget.js"></script>
<script src="js/jquery.iframe-transport.js"></script>
<script src="js/jquery.fileupload.js"></script>
<script>
$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
                $('<p/>').text(file.name).appendTo(document.body);
            });
        },
        add: function (e, data) {
            data.context = $('<button/>').text('Upload')
                .appendTo(document.body)
                .click(function () {
                    data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                });
        },
        progressall: function (e, data) {
	        var progress = parseInt(data.loaded / data.total * 100, 10);
	        $('#progress .bar').css(
	            'width',
	            progress + '%'
	        );
	    }
    });
});
</script>

<div id="progress">
    <div class="bar" style="width: 0%;"></div>
</div>

</body> 
</html>