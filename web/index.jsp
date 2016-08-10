<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="auth.action.AuthLoginAction"%>
<%@page import="auth.Auth"%>
<%
String catpath = request.getContextPath()+"/admin/papercategory/get.action";
String modelpath = request.getContextPath()+"/admin/papermodel/get.action";

Object o = session.getAttribute(AuthLoginAction.SessionName_LoginUser);
String account = o==null?"":((Auth)o).getAccount();
%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#nav-menu li").click(function(){
		$(this).addClass("active");
		$(this).siblings().removeClass("active");
		$("#mainFrame").attr("src",$(this).attr("url"));
	});
});
</script>
</head>
<body>
<div class="container">
	<!-- 导航
	========================================================= -->
	<div class="row clearfix">
		<div class="col-md-12 column">
			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#">后台管理系统</a>
				</div>
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul id="nav-menu" class="nav navbar-nav">
					    <li class="" url=""><a href="#mainFrame">首页</a></li>
					    <li class="active" url="<%=catpath%>"><a href="#mainFrame">类别管理</a></li>
					    <li class="" url="<%=modelpath%>"><a href="#mainFrame">模型管理</a></li>
					    <li class="" url=""><a href="#mainFrame">用户管理</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><i class="glyphicon glyphicon-user"></i><%=account%></a></li>
						<li><a href="<%=ctx%>/auth/logout.action"><i class="glyphicon glyphicon-log-out"></i>登出</a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<!-- 主界面
	========================================================= -->
	<div class="row clearfix">
		<div class="col-md-12 column">
			<iframe id="mainFrame" name="mainFrame" src="<%=catpath%>" width="100%" onload="this.height=mainFrame.document.body.scrollHeight+65" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>
</div>
</body>
</html>