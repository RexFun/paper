<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/view.getById.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function(){
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$rex.view.fn.getUrlParams("${queryParams}");
	});
	 // 所属类别赋值
	$("#pid").val("${po.m.pid}");
});
</script>
</head>
<body>
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
<div class="container-fluid">
<div class="navbar-header"><a class="navbar-brand" href="#"><i class="glyphicon glyphicon-info-sign"></i></a></div>
<button type="button" class="btn btn-default navbar-btn back" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
</div>
</nav>
<!-- form
======================================================================================================= -->
<form class="dataForm" id="dataForm" role="form">
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
</form>
</body>
</html>
