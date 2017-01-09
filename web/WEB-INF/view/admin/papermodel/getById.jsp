<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#pid").val("${po.m.pid}");
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li class="active">明细</li>
</ol>
<!-- form -->
<div class="form-group">
	<label for="pid">所属类别：</label>
 	<select class="form-control" id="pid" name="po.m.pid" disabled="disabled">
		<option value="">请选择</option>
		<s:iterator var="c" value="result.data.catList">
		<option value="${c.m.id}">${c.m.name}</option>
		</s:iterator>
	</select>
</div>
<div class="form-group"><label for="name">模型名：</label><input type="text" class="form-control" id="name" name="po.m.name" value="${po.m.name}" readonly="readonly"/></div>
<div class="form-group"><label for="sort">排序号：</label><input type="text" class="form-control" id="sort" name="po.m.sort" value="${po.m.sort}" readonly="readonly"/></div>
<input type="hidden" name="po.m.id" value="${po.m.id}" readonly="readonly">
<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</body>
</html>
