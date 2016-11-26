<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="auth.action.AuthLoginAction"%>
<%@ page import="admin.entity.SysUser"%>
<%
SysUser o = (SysUser)session.getAttribute(AuthLoginAction.SessionName_CurLoginUser);
String userId = o==null?"":o.getString("id");
String account = o==null?"":o.getString("tc_code");
String navMenuTreeNodes = o==null?"":o.getString("menu_permit_json");
%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet" href="${ctx}/lib/AdminLTE/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="${ctx}/lib/AdminLTE/dist/css/skins/_all-skins.min.css">

<link rel="stylesheet" href="${ctx}/lib/jquery/ui-bootstrap/jquery-ui-1.10.0.custom.css"/>
<!--[if IE 7]>
<link rel="stylesheet" href="${ctx}/lib/jquery/ui-bootstrap/assets/css/font-awesome-ie7.min.css">
<![endif]-->
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="${ctx}/lib/jquery/ui-bootstrap/css/custom-theme/jquery.ui.1.10.0.ie.css"/>
<![endif]-->
<script type="text/javascript" src="${ctx}/lib/jquery/ui-bootstrap/jquery-ui-1.10.0.custom.min.js"></script>

<script type="text/javascript" src="${ctx}/index.nav.js"></script>
<script type="text/javascript" src="${ctx}/index.tab.js"></script>
<script type="text/javascript">
$(function(){
	// tab
	$tab.init();
	// nav
	$nav.init(<%=navMenuTreeNodes%>);
	$nav.onItemClick(function(_menuId,_url,_title){
		$tab.add(_menuId,_url,_title);
	});
	//用户下拉菜单单击事件
	$("#user-dropdown-menu li").click(function(){
		$("#mainFrame").attr("src",$(this).attr("url"));
		$("section[class='content-header'] h1").html($(this).children("a").children("span").html());
	});
});
</script>
</head>
<!-- 3种 sidebar布局  -->
<!-- 
<body class="hold-transition skin-blue layout-boxed sidebar-mini">
<body class="hold-transition skin-blue sidebar-collapse sidebar-mini">
 -->
<body class="hold-transition skin-blue fixed sidebar-mini">
<!--/ 3种 sidebar布局  -->

<div class="wrapper">
	<header class="main-header">
		<!-- Logo -->
		<a href="javascript:void(0);return false;" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
			<span class="logo-mini"><b>A</b>SYS</span> <!-- logo for regular state and mobile devices -->
			<span class="logo-lg"><b>Admin</b>SYSTEM</span>
		</a>
		<!-- Header Navbar: style can be found in header.less -->
		<nav class="navbar navbar-static-top">
			<!-- Sidebar toggle button-->
			<a href="javascript:void(0);return false;" class="sidebar-toggle" data-toggle="offcanvas" role="button"></a>
			<!-- Navbar Right Menu -->
			<div class="navbar-custom-menu">
				<ul class="nav navbar-nav">
					<c:choose>
						<c:when test="${sessionScope.CUR_LOGIN_USER==null}">
							<li><a href="${ctx}/login.jsp"><i class="glyphicon glyphicon-log-in"></i>登录</a></li>
						</c:when>
						<c:otherwise>
							<li class="dropdown user user-menu notifications-menu">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<img src="${ctx}/lib/AdminLTE/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
									<span class="hidden-xs"> <%=account%></span><span class=" fa fa-angle-down"></span>
								</a>
								<ul class="dropdown-menu" style="height: 125px;">
									<li>
										<ul id="user-dropdown-menu" class="menu">
											<li url="${ctx}/admin/sysuser/getMyInfo.action?id=<%=userId%>"><a href="#"><i class="fa fa-user text-aqua"></i> <span>个人资料</span></a></li>
											<li url="${ctx}/admin/sysuser/updPwd1.action?id=<%=userId%>"><a href="#"><i class="glyphicon glyphicon-lock text-aqua"></i><span>修改密码</span></a></li>
											<li><a href="${ctx}/auth/logout.action"><i class="glyphicon glyphicon-log-out text-red"></i><span>登出</span></a></li>
										</ul>
									</li>
								</ul>
							</li>
						</c:otherwise>
					</c:choose>
					<!-- Control Sidebar Toggle Button -->
					<li><a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a></li>
				</ul>
			</div>
		</nav>
	</header>
	<!-- Main Sidebar -->
	<aside class="main-sidebar">
		<section class="sidebar">
			<!-- Search Form: 菜单搜索form -->
			<form action="#" method="get" class="sidebar-form">
				<div class="input-group">
					<input type="text" name="q" class="form-control" placeholder="Search..."/>
					<span class="input-group-btn">
						<button type="submit" name="search" id="search-btn" class="btn btn-flat">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
			</form>
			<!-- Sidebar Menu: 树状导航菜单，js动态生成 -->
		</section>
	</aside>
	<!-- /.main-sidebar -->
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Main content -->
		<section class="content">
			<div id="tabs">
				<ul>
					<li><a href="#tabs-0">首页</a></li>
				</ul>
				<div id="tabs-0">
					<iframe src="${ctx}/home.jsp" width="100%" height="700" frameborder="0" scrolling="auto"></iframe>
				</div>
       		</div>
		</section>
	</div>
	<!-- /.content-wrapper -->
	<!-- Main Footer -->
	<footer class="main-footer">
		<div class="pull-right hidden-xs"><b>Version</b> 1.0.0</div>
		<strong>Copyright &copy; 2014-2016 <a href="https://github.com/RexFun" target="blank">RexFun GitHub</a>.</strong> All rights reserved.
	</footer>
	<!-- /.main-footer -->
	<!-- Control Sidebar -->
	<aside class="control-sidebar control-sidebar-dark">
		<!-- Create the tabs -->
		<ul class="nav nav-tabs nav-justified control-sidebar-tabs"></ul>
		<!-- Tab panes -->
		<div class="tab-content"></div>
	</aside>
	<!-- /.control-sidebar -->
	<!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
	<div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- AdminLTE App -->
<script src="${ctx}/lib/AdminLTE/dist/js/app.min.js"></script>
<!-- Slimscroll -->
<script src="${ctx}/lib/AdminLTE/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="${ctx}/lib/AdminLTE/plugins/fastclick/fastclick.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${ctx}/lib/AdminLTE/dist/js/demo.js"></script>
</body>
</html>