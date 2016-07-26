<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperImages.action?pid=${pid}&ppid=${ppid}";
	}
};
</script>
</head>
<body>
<h1>上传图片</h1>
<hr>
<form id="dataForm" action="addPaperImage2.action" enctype="multipart/form-data" method="post">
 	图片：
 	<input type="file" name="myFile" value="" multiple="multiple"/><br>
	<input type="text" name="pid" value="${pid}"/>
	<input type="submit" id="dataFormSave" value="上传" />
</form>
</body>
</html>

