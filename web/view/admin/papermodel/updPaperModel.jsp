<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperModels.action";
	}
};
$(function(){
	$("#pid").val("${po.pid}");
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="getPaperModels.action">模型管理</a></li>
	<li class="active">修改</li>
</ol>
<!-- form -->
<form id="dataForm" action="updPaperModel2.action" method="post">
<div class="form-group">
	<label for="pid">类别名：</label>
 	<select class="form-control" id="pid" name="po.pid">
		<option value="">请选择</option>
		<s:iterator var="o" value="result.data.catList">
		<option value="${o.id}">${o.name}</option>
		</s:iterator>
	</select>
</div>
<div class="form-group"><label for="name">模型名：</label><input type="text" class="form-control" name="po.name" value="${po.name}" /></div>
<div class="form-group"><label for="name">排序号：</label><input type="text" class="form-control" name="po.sort" value="${po.sort}" /></div>
<input type="hidden" name="po.id" value="${po.id}">
<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
</body>
</html>
