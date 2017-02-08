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
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li class="active">明细</li>
</ol>
<div class="form-group"><label for="name">类别名：</label><input type="text" class="form-control" id="name" name="po.m.name" value="${po.m.name}" readonly="readonly"/></div>
<div class="form-group"><label for="sort">排序号：</label><input type="text" class="form-control" id="sort" name="po.m.sort" value="${po.m.sort}" readonly="readonly"/></div>
<input type="hidden" name="po.m.id" value="${po.m.id}" readonly="readonly">
<button type="button" class="btn btn-default" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
</body>
</html>
