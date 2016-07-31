<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="getPaperModels.action">模型管理</a></li>
	<li class="active">明细</li>
</ol>
<!-- form -->
<hr>
外键：${po.m.pid}<br>
分类名：${po.m.name}<br>
排序号：${po.m.sort}<br>
</body>
</html>
