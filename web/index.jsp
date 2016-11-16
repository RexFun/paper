<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="auth.action.AuthLoginAction"%>
<%@ page import="admin.entity.SysUser"%>
<%@ page import="auth.Auth"%>
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
			$("#mainFrame").attr("src",$(this).parent("li").attr("url"));
		}
	});
	//用户下拉菜单单击事件
	$("#user-dropdown-menu li").click(function(){
		$("#mainFrame").attr("src",$(this).attr("url"));
	});
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
        html += "<li class=\"active\" url=\"${ctx}/home.jsp\"><a href=\"javascript:void(0)\"><i class=\"fa fa-home\"></i>首页 </a>";
        if(k>0) html = "\n<ul class=\"treeview-menu\" style=\"display:none;\">\n";
        for(var i=0;i<a.length;i++){
        	if(this.groups[a[i].id] && this.groups[a[i].id].length > 0){ // 有子节点
        		if(a[i].pid == 0){// 1级菜单
        			if(a[i].tc_url == "")
						html += "<li class=\"treeview\"><a href=\"javascript:void(0)\"><i class=\"fa fa-cog\"></i>"+a[i].tc_name+" <span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
					else
						html += "<li class=\"treeview\" url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-cog\"></i>"+a[i].tc_name+" <span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
        		}else{// 非1级菜单
        			if(a[i].tc_url == "")
						html += "<li class=\"treeview\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i>"+a[i].tc_name+" <span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
					else
						html += "<li class=\"treeview\" url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i>"+a[i].tc_name+" <span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
        		}
        	}else{// 没有子节点
        		if(a[i].pid == 0){// 1级菜单
        			if(a[i].tc_url == "")
        				html += "<li><a href=\"javascript:void(0)\"><i class=\"fa fa-list\"></i>"+a[i].tc_name+" </a>";
       				else
        				html += "<li url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-list\"></i>"+a[i].tc_name+" </a>";
        		}else{ // 非1级菜单
        			if(a[i].tc_url == "")
        				html += "<li><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i>"+a[i].tc_name+" </a>";
       				else
        				html += "<li url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i>"+a[i].tc_name+" </a>";
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
			filterList($("#form"), $(".nav .side-menu"));
		});
		})(jQuery);
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <header class="main-header">

    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Admin</b>LTE</span>
    </a>

    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="${ctx}/lib/AdminLTE/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
              <span class="hidden-xs">Alexander Pierce</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="${ctx}/lib/AdminLTE/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">

                <p>
                  Alexander Pierce - Web Developer
                  <small>Member since Nov. 2012</small>
                </p>
              </li>
              <!-- Menu Body -->
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-center">
                    <a href="#">Followers</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Sales</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Friends</a>
                  </div>
                </div>
                <!-- /.row -->
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="#" class="btn btn-default btn-flat">Profile</a>
                </div>
                <div class="pull-right">
                  <a href="#" class="btn btn-default btn-flat">Sign out</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>

    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar:  左边导航栏 -->
    <section class="sidebar">
      <!-- search form: 菜单搜索form -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->
      <!-- sidebar menu: 树状导航菜单，js动态生成 -->
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Version 2.0</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-12">
          <div class="box">
            <div class="box-body">
              <div class="row">
                <div class="col-md-12">
					<iframe id="mainFrame" name="mainFrame" src="${ctx}/home.jsp"
						width="100%"
						onload="this.height=mainFrame.document.body.scrollHeight+65"
						frameborder="0" scrolling="auto"></iframe>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  <!-- /.content-wrapper -->

  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 2.3.7
    </div>
    <strong>Copyright &copy; 2014-2016 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights
    reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>

</div>
<!-- ./wrapper -->

<!-- AdminLTE App -->
<script src="${ctx}/lib/AdminLTE/dist/js/app.min.js"></script>
<!-- Slimscroll -->
<script src="${ctx}/lib/AdminLTE/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${ctx}/lib/AdminLTE/dist/js/demo.js"></script>
</body>
<%-- 
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.jsp" class="site_title"><i class="fa fa-paw"></i>
							<span>后台管理系统</span></a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img src="${ctx}/lib/gentelella/image/user.png" alt="..." class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Welcome,</span>
							<h2><%=account %></h2>
						</div>
					</div>
					<!-- /menu profile quick info -->
					
					<br />
					
					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<h3>&nbsp;&nbsp;&nbsp;&nbsp;</h3>
						</div>
					</div>
					<!-- /sidebar menu -->
					
					<!-- /menu footer buttons -->
					<div class="sidebar-footer hidden-small">
						<a data-toggle="tooltip" data-placement="top" title="Settings">
							<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="FullScreen">
							<span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Lock"> <span
							class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Logout">
							<span class="glyphicon glyphicon-off" aria-hidden="true"></span>
						</a>
					</div>
					<!-- /menu footer buttons -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
						<div class="nav toggle">
							<a id="menu_toggle"><i class="fa fa-bars"></i></a>
						</div>
						<ul class="nav navbar-nav navbar-right">
							<c:choose>
								<c:when test="${sessionScope.CUR_LOGIN_USER==null}">
									<li><a href="${ctx}/login.jsp"><i class="glyphicon glyphicon-log-in"></i> 登录 </a></li>
								</c:when>
								<c:otherwise>
									<li class="">
										<a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false"> 
											<i class="glyphicon glyphicon-user"></i>
											<%=account%> 
											<span class=" fa fa-angle-down"></span>
										</a>
										<ul id="user-dropdown-menu" class="dropdown-menu dropdown-usermenu pull-right">
											<li url="${ctx}/admin/sysuser/getMyInfo.action?id=<%=userId%>"><a href="#"><i class="glyphicon glyphicon-file"></i> 个人资料 </a></li>
											<li url="${ctx}/admin/sysuser/updPwd1.action?id=<%=userId%>"><a href="#"><i class="glyphicon glyphicon-lock"></i> 修改密码 </a></li>
											<li class="divider"></li>
											<li><a href="${ctx}/auth/logout.action"><i class="glyphicon glyphicon-log-out"></i> 登出</a></li>
										</ul></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="x_panel">
					<iframe id="mainFrame" name="mainFrame" src="${ctx}/home.jsp"
						width="100%"
						onload="this.height=mainFrame.document.body.scrollHeight+65"
						frameborder="0" scrolling="auto"></iframe>
				</div>
			</div>
			<!-- /page content -->

			<!-- footer content -->
			<footer>
				<div class="pull-right">
					Gentelella - Bootstrap Admin Template by <a
						href="https://colorlib.com">Colorlib</a>
				</div>
				<div class="clearfix"></div>
			</footer>
			<!-- /footer content -->
		</div>
	</div>
	<script type="text/javascript" src="${ctx}/lib/gentelella/js/custom.min.js"></script>
</body>
 --%>
</html>