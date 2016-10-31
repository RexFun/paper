<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="get.action">用户管理</a></li>
	<li class="active">明细</li>
</ol>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<dl class="dl-horizontal">
				<dt>用户ID：</dt><dd>${po.m.id}</dd>
				<dt>用户代号：</dt><dd>${po.m.tc_code}</dd>
				<dt>用户名称：</dt><dd>${po.m.tc_name}</dd>
				<dt>用户邮箱：</dt><dd>${po.m.tc_email}</dd>
				<dt>用户密码：</dt><dd>${po.m.tc_password}</dd>
				<dt>创建时间：</dt><dd>${po.m.tc_add_time}</dd>
			</dl>
		</div>
	</div>
</div>
</body>
</html>
