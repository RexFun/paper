<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="get.action">菜单管理</a></li>
	<li class="active">明细</li>
</ol>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<dl class="dl-horizontal">
				<dt>菜单ID：</dt><dd>${po.m.id}</dd>
				<dt>菜单父ID：</dt><dd>${po.m.pid}</dd>
				<dt>菜单代号：</dt><dd>${po.m.tc_code}</dd>
				<dt>菜单名称：</dt><dd>${po.m.tc_name}</dd>
				<dt>菜单URL：</dt><dd>${po.m.tc_url}</dd>
				<dt>菜单权限ID：</dt><dd>${po.m.tc_sys_permit_id}</dd>
			</dl>
		</div>
	</div>
</div>
</body>
</html>
