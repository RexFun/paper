<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperCategorys.action";
	}
};
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="getPaperCategorys.action">类别管理</a></li>
	<li class="active">新增</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="addPaperCategory2.action" method="post">
	<div class="form-group"><label for="name">类别名：</label><input type="text" class="form-control" name="po.name" /></div>
	<div class="form-group"><label for="name">排序号：</label><input type="text" class="form-control" name="po.sort" /></div>
	<button type="submit" class="btn btn-default" id="dataFormSave">保存</button>
</form>
</body>
</html>

