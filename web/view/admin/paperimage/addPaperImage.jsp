<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" href="<%=ctx%>/lib/bs/fileinput/css/fileinput.min.css"/>
<script type="text/javascript" src="<%=ctx%>/lib/bs/fileinput/js/fileinput.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#myFile").fileinput({
	    uploadUrl: "addPaperImage2.action?pid=${pid}", // server upload action
	    allowedFileExtensions : ['jpg', 'png','gif'],
	    uploadAsync: false,
	    minFileCount: 1,
	    maxFileCount: 5
	}).on('filebatchpreupload', function(event, data, id, index) {
	    $('#kv-success-2').html('<h4>Upload Status</h4><ul></ul>').hide();
	}).on('filebatchuploaderror', function(event, data, msg) {
	    var form = data.form, files = data.files, extra = data.extra,
	        response = data.response, reader = data.reader;
	    var out = '';
	    $.each(data.files, function(key, file) {
	        var fname = file.name;
	        out = out + '<li>' + '上传 # ' + (key + 1) + ' - '  +  fname + ' 失败.' + '</li>';
	    });
	    $('#kv-error-2 ul').append(out);
	    $('#kv-error-2').show();
	}).on('filebatchuploadsuccess', function(event, data, previewId, index) {
	    var form = data.form, files = data.files, extra = data.extra,
	        response = data.response, reader = data.reader;
	    var out = '';
	    $.each(data.files, function(key, file) {
	        var fname = file.name;
	        out = out + '<li>' + '上传 # ' + (key + 1) + ' - '  +  fname + ' 成功.' + '</li>';
	    });
	    $('#kv-success-2 ul').append(out);
	    $('#kv-success-2').show();
	    alert("上传图片成功！");
		location.href = "getPaperImages.action?pid=${pid}&ppid=${ppid}";
	});
});
</script>
</head>
<body>
<!-- title
======================================================================================================= -->
<ul class="breadcrumb">
	<li><a href="../papermodel/get.action">模型管理</a></li>
	<li><a href="getPaperImages.action?pid=${pid}&ppid=${ppid}">图片管理</a></li>
	<li class="active">上传图片</li>
</ul>
<!-- upload input
======================================================================================================= -->
<input id="myFile" name="myFile" type="file" multiple class="file-loading">
<div id="kv-error-2" style="margin-top:10px;display:none"></div>
<div id="kv-success-2" class="alert alert-success fade in" style="margin-top:10px;display:none"></div>
</body>
</html>

