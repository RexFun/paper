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
<link type="text/css" href="${ctx}/lib/jquery/ui-bootstrap/jquery-ui-1.10.0.custom.css" rel="stylesheet" />
<!--[if IE 7]>
<link rel="stylesheet" href="${ctx}/lib/jquery/ui-bootstrap/assets/css/font-awesome-ie7.min.css">
<![endif]-->
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="${ctx}/lib/jquery/ui-bootstrap/css/custom-theme/jquery.ui.1.10.0.ie.css"/>
<![endif]-->
<script type="text/javascript" src="${ctx}/lib/jquery/ui-bootstrap/jquery-ui-1.10.0.custom.min.js"></script>

<script type="text/javascript">
$(function(){
	/* navsidebar */
	var navMenuTreeHtml = new treeMenu(<%=navMenuTreeNodes%>).init(0);
	$(".sidebar-form").after(navMenuTreeHtml);
	//导航菜单单击事件
 	$(".sidebar li a").click(function(){
 		$(this).parent("li").siblings(".treeview").children(".treeview-menu").removeClass("menu-open").css({"display":"none"});
		$(this).parent("li").siblings().removeClass("active");
		$(this).parent("li").addClass("active");
		if(typeof($(this).parent("li").attr("url"))!="undefined"){
			//$("#mainFrame").attr("src",$(this).parent("li").attr("url"));
			//$("section[class='content-header'] h1").html($(this).children("span").html());
			addTab($(this).parent("li").attr("url"),$(this).children("span").html());
		}
	});
	//用户下拉菜单单击事件
	$("#user-dropdown-menu li").click(function(){
		$("#mainFrame").attr("src",$(this).attr("url"));
		$("section[class='content-header'] h1").html($(this).children("a").children("span").html());
	});
	// tab
	$("#tabs").tabs();
});
</script>
<script type="text/javascript">
/*******************************
 * treeMenu 用于生成HTML菜单元素
 *******************************/
function treeMenu(a){
    this.tree=a||[];
    this.groups={};
};
// 扩展原型方法
treeMenu.prototype={
   	/*
     * 初始化
	 * pid : json对象中的pid值，默认传0
	 */
    init:function(pid){
        this.group();
        return this.getDom(pid,this.groups[pid]);
    },
    /*
     * 按pid为key分类存放菜单数组，如：Object {0: Array[3], 3: Array[1]}
     */
    group:function(){
        for(var i=0;i<this.tree.length;i++){
            if(this.groups[this.tree[i].pid]){
                this.groups[this.tree[i].pid].push(this.tree[i]);
            }else{
                this.groups[this.tree[i].pid]=[];
                this.groups[this.tree[i].pid].push(this.tree[i]);
            }
        }
    },
    /*
     * 递归遍历生成菜单元素
     * k : this.groups对象的key值(以pid为key)
     * a : this.groups对象的value值(数组类型)
    */
    getDom:function(k,a){
        if(!a){return ""}
        var html = "\n<ul class=\"sidebar-menu\">\n";
        html += "<li class=\"active\" url=\"${ctx}/home.jsp\"><a href=\"javascript:void(0)\"><i class=\"fa fa-home\"></i><span>首页</span></a>";
        if(k>0) html = "\n<ul class=\"treeview-menu\" style=\"display:none;\">\n";
        for(var i=0;i<a.length;i++){
        	if(this.groups[a[i].id] && this.groups[a[i].id].length > 0){ // 有子节点
        		if(a[i].pid == 0){// 1级菜单
        			if(a[i].tc_url == "")
						html += "<li class=\"treeview\"><a href=\"javascript:void(0)\"><i class=\"fa fa-cog\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
					else
						html += "<li class=\"treeview\" url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-cog\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
        		}else{// 非1级菜单
        			if(a[i].tc_url == "")
						html += "<li class=\"treeview\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
					else
						html += "<li class=\"treeview\" url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
        		}
        	}else{// 没有子节点
        		if(a[i].pid == 0){// 1级菜单
        			if(a[i].tc_url == "")
        				html += "<li><a href=\"javascript:void(0)\"><i class=\"fa fa-list\"></i><span>"+a[i].tc_name+"</span></a>";
       				else
        				html += "<li url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-list\"></i><span>"+a[i].tc_name+"</span></a>";
        		}else{ // 非1级菜单
        			if(a[i].tc_url == "")
        				html += "<li><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span></a>";
       				else
        				html += "<li url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span></a>";
        		}
        	}
            html += this.getDom(a[i].id,this.groups[a[i].id]);
            html += "</li>\n";
        };
        html += '</ul>\n';
        return html;
    }
};
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
			filterList($("#form"), $(".sidebar-menu"));
		});
		})(jQuery);
</script>
<script type="text/javascript">
//Dynamic tabs
var tabCounter = 2;
function addTab(_tabUrl, _tabTitle) {
	var tabHeader = "<li><a href=\"#tab_"+tabCounter+"\">"+_tabTitle+"</a> <span class=\"ui-icon ui-icon-close\">Remove Tab</span></li>";
	var tabBody = "<div id=\"tab_" + tabCounter + "\"><iframe src=\""+_tabUrl+"\" width=\"100%\" height=\"700\" frameborder=\"0\" scrolling=\"auto\"></iframe></div>";
	$("#tabs ul").append(tabHeader);
	$("#tabs").append(tabBody);
	$("#tabs").tabs("refresh");
	tabCounter++;
}
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
		<!-- Content Header (Page header) -->
		<!-- 
		<section class="content-header">
			<h1>首页</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
				<li class="active">Dashboard</li>
			</ol>
		</section>
		 -->
		<!-- Main content -->
		<section class="content">
			<div id="tabs">
				<ul>
					<li><a href="#tabs-1">首页</a></li>
				</ul>
				<div id="tabs-1">
					<iframe src="${ctx}/home.jsp" id="mainFrame" name="mainFrame" width="100%" onload="this.height=mainFrame.document.body.scrollHeight+65" frameborder="0" scrolling="auto"></iframe>
				</div>
       		</div>
		</section>
		
<%-- 		
		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-default">
						<div class="box-body">
							<iframe src="${ctx}/home.jsp" id="mainFrame" name="mainFrame" width="100%" onload="this.height=mainFrame.document.body.scrollHeight+65" frameborder="0" scrolling="auto"></iframe>
						</div>
					</div>
				</div>
			</div>
		</section>
		 --%>
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