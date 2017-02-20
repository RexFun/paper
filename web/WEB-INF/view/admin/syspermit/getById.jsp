<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/js/view.getById.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function(){
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$rex.view.fn.getUrlParams("${queryParams}");
	});
	// 权限类型selection返回值
	$("#tc_type").val("${po.m.tc_type}");
});
</script>
</head>
<body class="body-content">
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
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<fieldset>
			<legend>基础信息</legend>
				<div class="form-group"><label for="id">权限ID：</label><input type="text" class="form-control input-sm" id="id" name="po.m.id" value="${po.m.id}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_code">权限代号：</label><input type="text" class="form-control input-sm" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_name">权限名称：</label><input type="text" class="form-control input-sm" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}" readonly="readonly"/></div>
				<div class="form-group">
					<label for="tc_type">权限类型：</label>
					<select class="form-control input-sm" id="tc_type" name="po.m.tc_type" readonly="readonly">
						<option value="0">默认</option>
						<option value="1">按钮</option>
					</select>
				</div>
				<div class="form-group"><label for="tc_url">权限URL：</label><input type="text" class="form-control input-sm" id="tc_url" name="po.m.tc_url" value="${po.m.tc_url}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_order">权限排序号：</label><input type="text" class="form-control input-sm" id="tc_order" name="po.m.tc_order" value="${po.m.tc_order}" readonly="readonly"/></div>
				<div class="form-group"><label for="pid">父节点：</label>
					<input type="text" class="form-control input-sm" value="${po.m.tc_p_name}" readonly="readonly"/>
					<input type="hidden" class="form-control input-sm" id="pid" name="po.m.pid" value="${po.m.pid}" readonly="readonly"/>
				</div>
			</fieldset>
		</div>
	</div>
</div>
</form>
</body>
</html>
