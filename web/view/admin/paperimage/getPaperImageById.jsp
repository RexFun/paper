<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
</head>
<body>
<!-- title
======================================================================================================= -->
<ul class="breadcrumb">
	<li><a href="../papermodel/get.action">模型管理</a></li>
	<li><a href="getPaperImages.action?pid=${po.m.pid}&ppid=${ppid}">图片管理 - ${modelName}</a></li>
	<li class="active">明细</li>
</ul>
<img src="<%=ctx%>/share/data/img.jsp?id=${po.m.id}" alt="图片"/>
</body>
</html>
