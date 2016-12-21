<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li class="active">明细</li>
</ol>
<div class="wrapper">
	<div class="form-group"><label for="tc_p_name">父节点：</label><input type="text" class="form-control" id="tc_p_name" name="po.m.tc_p_name" value="${po.m.tc_p_name}" readonly="readonly"/></div>
	<div class="form-group"><label for="id">菜单ID：</label><input type="text" class="form-control" id="id" name="po.m.id" value="${po.m.id}" readonly="readonly"/></div>
	<div class="form-group"><label for="tc_code">菜单代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}" readonly="readonly"/></div>
	<div class="form-group"><label for="tc_name">菜单名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}" readonly="readonly"/></div>
	<div class="form-group"><label for="tc_url">菜单URL：</label><input type="text" class="form-control" id="tc_url" name="po.m.tc_url" value="${po.m.tc_url}" readonly="readonly"/></div>
	<div class="form-group"><label for="tc_order">菜单排序号：</label><input type="text" class="form-control" id="tc_order" name="po.m.tc_order" value="${po.m.tc_order}" readonly="readonly"/></div>
	<div class="form-group"><label for="tc_sys_permit_name">绑定权限：</label><input type="text" class="form-control" id="tc_sys_permit_name" name="po.m.tc_sys_permit_name" value="${po.m.tc_sys_permit_name}" readonly="readonly"/></div>
	<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</div>
</body>
</html>
