<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$rex.form.callback = function(){
	if($rex.result.type == 1){
		location.href = "get.action";
	}
};
$(function(){
	$("#pid").val("${po.m.pid}");
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li class="active">修改</li>
</ol>
<!-- form -->
<form id="dataForm" action="upd2.action" method="post">
<div class="form-group">
	<label for="pid">所属类别：</label>
 	<select class="form-control" id="pid" name="po.m.pid">
		<option value="">请选择</option>
		<s:iterator var="c" value="result.data.catList">
		<option value="${c.m.id}">${c.m.name}</option>
		</s:iterator>
	</select>
</div>
<div class="form-group"><label for="name">模型名：</label><input type="text" class="form-control" id="name" name="po.m.name" value="${po.m.name}" /></div>
<div class="form-group"><label for="sort">排序号：</label><input type="text" class="form-control" id="sort" name="po.m.sort" value="${po.m.sort}" /></div>
<input type="hidden" name="po.m.id" value="${po.m.id}">
<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
</body>
</html>
