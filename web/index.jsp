<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String catpath = request.getContextPath()+"/admin/papercategory/getPaperCategorys.action";
String modelpath = request.getContextPath()+"/admin/papermodel/getPaperModels.action";
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=path%>/js/pushy/css/pushy.css">
<link rel="stylesheet" href="<%=path%>/js/bootstrap/css/bootstrap.min.css"/>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
function jumpToUrl(url)
{
	$("#mainFrame").attr("src",url);
}
</script>
</head>
<body>
<!-- 导航菜单 -->
<nav class="pushy pushy-left">
<ul>
    <li class="pushy-link"><a href="#" onclick="jumpToUrl('<%=catpath%>')">类别管理</a></li>
    <li class="pushy-link"><a href="#" onclick="jumpToUrl('<%=modelpath%>')">内容管理</a></li>
    <li class="pushy-link"><a href="#">用户管理</a></li>
</ul>
</nav>
<!-- 遮罩层 -->
<div class="site-overlay"></div>
<!-- 内容容器 -->
<div id="container" style="padding: 10px;">
	<!-- Menu Button -->
	<div class="menu-btn">&#9776; 导航</div>
	<!-- Main Frame -->
	<iframe id="mainFrame" name="mainFrame" src="<%=catpath%>" width="100%" onload="this.height=mainFrame.document.body.scrollHeight" frameborder="0" scrolling="no"></iframe>
</div>
<!-- Pushy JS -->
<script src="<%=path%>/js/pushy/js/pushy.min.js"></script>
</body>
</html>
 