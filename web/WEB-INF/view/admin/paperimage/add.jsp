<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" href="${ctx}/res/bs/fileinput/css/fileinput.min.css"/>
<script type="text/javascript" src="${ctx}/res/bs/fileinput/js/fileinput.min.js"></script>
<script type="text/javascript">
$(function(){
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?pid=${pid}&ppid=${ppid}";
	});
	//
	$("#myFile").fileinput({
	    uploadUrl: "add2.action?pid=${pid}&ppid=${ppid}", // server upload action
	    allowedFileExtensions : ['jpg','png','gif'],
	    uploadAsync: false,
	    minFileCount: 1,
	    maxFileCount: 10
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
		location.href = "get.action?pid=${pid}&ppid=${ppid}";
	});
});
</script>
</head>
<body class="body-content">
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top navbar-fixed-top-extend" role="navigation">
	<div class="navbar-header navbar-header-extend">
		<a class="navbar-brand" href="#"><i class="glyphicon glyphicon-plus"></i></a>
		<div class="navbar-header-btn-right">
			<button type="button" class="btn btn-default navbar-btn" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
		</div>
	</div>
</nav>
<!-- upload input
======================================================================================================= -->
<form class="dataForm">
<input id="myFile" name="myFile" type="file" multiple class="file-loading">
<div id="kv-error-2" style="margin-top:10px;display:none"></div>
<div id="kv-success-2" class="alert alert-success fade in" style="margin-top:10px;display:none"></div>
</form>
</body>
</html>

