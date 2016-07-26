<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperModels.action?pid=${pid}";
	}
};
</script>
</head>
<body>
<h1>新增纸模型</h1>
<hr>
<form id="dataForm" action="addPaperModel2.action" method="post">
分类名：<input type="text" name="po.name"/><br>
排序号：<input type="text" name="po.sort"/><br>
<input type="hidden" name="po.pid" value="${pid}"/>
<input type="submit" id="dataFormSave" value="增加" />
</form>
</body>
</html>

