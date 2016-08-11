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
	    uploadAsync: true,
	    minFileCount: 1,
	    maxFileCount: 5
	});
	$('#myFile').on('filebatchuploadcomplete', function(event, files, extra) {
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
	<li><a href="getPaperImages.action?pid=${pid}&ppid=${ppid}">图片管理</a></li>
	<li class="active">上传图片</li>
</ul>
<!-- upload input
======================================================================================================= -->
<input id="myFile" name="myFile" type="file" multiple class="file-loading">
</body>
</html>

