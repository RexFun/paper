<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="auth.action.AuthAction"%>
<%@ page import="admin.entity.SysUser"%>
<%
SysUser o = (SysUser)session.getAttribute(AuthAction.SessionName_CurLoginUser);
String userId = o==null?"":o.getString("id");
String account = o==null?"":o.getString("tc_code");
String menuPermitJson = o==null?"":o.getString("menuPermitJson");
%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$(function(){
	// nav
	$chok.nav.init(<%=menuPermitJson%>);
	// 导航菜单查询
	$("#navSearchForm").submit(function(event) {
		event.preventDefault();
		var url = $("#navSearchForm").attr('action');
		$.post(
			url, 
			{'menuName':$("#menuName").val()},
		  	function(rv) {
				if(rv.success){
					$chok.nav.init(JSON.parse(rv.data.menuPermitJson));
				}else{
					alert(data.msg);
				}
			}
		);
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
		<!-- 顶部导航栏 -->
		<nav class="navbar navbar-static-top">
			<!-- 左侧栏切换按钮-->
			<a href="javascript:void(0);return false;" class="sidebar-toggle" data-toggle="offcanvas" role="button"></a>
			<!-- 导航下拉菜单 -->
			<div class="navbar-custom-menu">
				<ul class="nav navbar-nav">
					<c:choose>
						<c:when test="${sessionScope.CUR_LOGIN_USER==null}">
							<li><a href="/static/login.jsp"><i class="glyphicon glyphicon-log-in"></i>登录</a></li>
						</c:when>
						<c:otherwise>
							<li class="dropdown user user-menu notifications-menu">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									<img src="/static/res/AdminLTE/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
									<span class="hidden-xs"> <%=account%></span><span class=" fa fa-angle-down"></span>
								</a>
								<ul class="dropdown-menu" style="height: 125px;">
									<li>
										<ul id="user-dropdown-menu" class="menu">
											<li menuId="myinfo"><a href="/static/admin/sysuser/getMyInfo.action?id=<%=userId%>&menuName=个人资料"><i class="fa fa-user text-aqua"></i> <span>个人资料</span></a></li>
											<li menuId="updpwd"><a href="/static/admin/sysuser/updPwd1.action?id=<%=userId%>&menuName=修改密码"><i class="glyphicon glyphicon-lock text-aqua"></i><span>修改密码</span></a></li>
											<li menuId="loginout"><a href="${ctx}/auth/logout.action"><i class="glyphicon glyphicon-log-out text-red"></i><span>登出</span></a></li>
										</ul>
									</li>
								</ul>
							</li>
						</c:otherwise>
					</c:choose>
					<!-- 右侧栏切换按钮 -->
					<li><a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a></li>
				</ul>
			</div>
		</nav>
	</header>
	<!-- 左侧栏 -->
	<aside class="main-sidebar">
		<section class="sidebar">
			<!-- 菜单搜索form -->
			<form id="navSearchForm" action="${pageContext.request.contextPath}/auth/getNavMenu.action" method="get" class="sidebar-form">
				<div class="input-group">
					<input type="text" id="menuName" name="q" class="form-control" placeholder="Search..."/>
					<span class="input-group-btn">
						<button type="submit" name="search" id="search-btn" class="btn btn-flat">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
			</form>
			<!-- 树状导航菜单，后台数据动态生成 
			...
			-->
		</section>
	</aside>