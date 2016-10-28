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
	<!-- navsidebar -->
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/bs/navsidebar/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/bs/navsidebar/css/default.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/bs/navsidebar/css/styles.css">
	<!-- accordion-menu -->
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/bs/navsidebar/accordion/css/htmleaf-demo.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/lib/bs/navsidebar/accordion/css/jquery-accordion-menu.css"/>
	<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css'>
	<style type="text/css">
	    .content{width:300px;}
		.filterinput{
			background-color:rgba(249, 244, 244, 0);
			border-radius:15px;
			width:90%;
			height:30px;
			border:thin solid #FFF;
			text-indent:0.5em;
			font-weight:bold;
			color:#FFF;
		}
		#demo-list a{
			overflow:hidden;
			text-overflow:ellipsis;
			-o-text-overflow:ellipsis;
			white-space:nowrap;
			width:100%;
		}
	</style>
<script src="${ctx}/lib/bs/navsidebar/accordion/js/jquery-accordion-menu.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	/* navsidebar */
	$('.openMdNav').click(function () {
	    $('body').toggleClass('navOpen');
	    $('.mdNav').toggleClass('open');
	    $('.wrapper').toggleClass('open');
	    $(this).toggleClass('open');
	});
	/* accordion-menu */
	$("#jquery-accordion-menu").jqueryAccordionMenu();

	//列表项背景颜色切换
	$("#demo-list li").click(function(){
		$("#demo-list li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	//
	$("#url-list li").click(function(){
		$(this).addClass("active");
		$(this).siblings().removeClass("active");
		if(typeof($(this).attr("url"))!="undefined"){
			$("#mainFrame").attr("src",$(this).attr("url"));
			$('.openMdNav').click();
		}
	});
});
</script>
<script type="text/javascript">
	(function($) {
		$.expr[":"].Contains = function(a, i, m) {
			return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
		};
		function filterList(header, list) {
			//@header 头部元素
			//@list 无序列表
			//创建一个搜素表单
			var form = $("<form>").attr({
				"class":"filterform",
				action:"#"
			}), input = $("<input>").attr({
				"class":"filterinput",
				type:"text"
			});
			$(form).append(input).appendTo(header);
			$(input).change(function() {
				var filter = $(this).val();
				if (filter) {
					$matches = $(list).find("a:Contains(" + filter + ")").parent();
					$("li", list).not($matches).slideUp();
					$matches.slideDown();
				} else {
					$(list).find("li").slideDown();
				}
				return false;
			}).keyup(function() {
				$(this).change();
			});
		}
		$(function() {
			filterList($("#form"), $("#demo-list"));
		});
		})(jQuery);
</script>
</head>
<body>
	<nav class="mdNav">
		<div class="content">
			<div id="jquery-accordion-menu" class="jquery-accordion-menu skyblue">
				<div class="jquery-accordion-menu-header" id="form"></div>
				<ul id="url-list">
					<li class="active" url=""><a href="#"><i class="fa fa-home"></i>主页
					</a></li>
					<li url="<%=catpath%>"><a href="#"><i class="fa fa-glass"></i>类别管理</a></li>
					<li url="<%=modelpath%>"><a href="#"><i class="fa fa-file-image-o"></i>模型管理</a><span class="jquery-accordion-menu-label"> 12 </span></li>
					<li><a href="#"><i class="fa fa-cog"></i>系统管理 </a>
						<ul class="submenu">
							<li><a href="#">菜单管理 </a></li>
							<li><a href="#">权限管理 </a></li>
							<li><a href="#">角色管理 </a></li>
							<li><a href="#">用户管理 </a>
								<ul class="submenu">
									<li><a href="#">Graphics </a></li>
									<li><a href="#">Vectors </a></li>
									<li><a href="#">Photoshop </a></li>
									<li><a href="#">Fonts </a></li>
								</ul></li>
						</ul>
					</li>
				</ul>
				<div class="jquery-accordion-menu-footer">Footer</div>
			</div>
		</div>
	</nav>
	<div class="openMdNav">
		<div class="icon"></div>
	</div>
	<div class="wrapper">
	<!-- 主界面Head Bar
	========================================================= -->
	<div class="row clearfix">
		<div class="col-md-12 column">
			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#">后台管理系统</a>
				</div>
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
	<%-- 
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
 --%>
</body>
</html>