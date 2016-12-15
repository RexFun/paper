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
	<div class="row clearfix">
		<div class="col-md-12 column">
			<fieldset>
			<legend>基础信息</legend>
				<div class="form-group"><label for="id">权限ID：</label><input type="text" class="form-control" id="id" name="po.m.id" value="${po.m.id}" readonly="readonly"/></div>
				<div class="form-group"><label for="pid">父ID：</label><input type="text" class="form-control" id="pid" name="po.m.pid" value="${po.m.pid}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_code">权限代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_name">权限名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_type">权限类型：</label><input type="text" class="form-control" id="tc_type" name="po.m.tc_type" value="${po.m.tc_type}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_url">权限URL：</label><input type="text" class="form-control" id="tc_url" name="po.m.tc_url" value="${po.m.tc_url}" readonly="readonly"/></div>
				<div class="form-group"><label for="tc_order">权限排序号：</label><input type="text" class="form-control" id="tc_order" name="po.m.tc_order" value="${po.m.tc_order}" readonly="readonly"/></div>
			</fieldset>
		</div>
	</div>
</div>
</body>
</html>
