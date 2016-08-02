<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="get.action">类别管理</a></li>
	<li class="active">明细</li>
</ol>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<dl class="dl-horizontal">
				<dt>类别名：</dt><dd>${po.m.name}</dd>
				<dt>排序号：</dt><dd>${po.m.sort}</dd>
			</dl>
		</div>
	</div>
</div>
</body>
</html>
