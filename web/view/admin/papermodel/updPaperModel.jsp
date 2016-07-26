<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperModels.action?pid=${po.pid}";
	}
};
</script>
</head>
<body>
<h1>修改纸模</h1>
<hr>
<form id="dataForm" action="updPaperModel2.action" method="post">
分类名：<input type="text" name="po.name" value="${po.name}"><br>
排序号：<input type="text" name="po.sort" value="${po.sort}"><br>
<input type="hidden" name="po.id" value="${po.id}">
<input type="hidden" name="po.pid" value="${po.pid}">
<input type="submit" id="dataFormSave" value="修改" />
</form>
</body>
</html>
