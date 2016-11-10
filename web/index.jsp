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
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css'>
<link rel="stylesheet" type="text/css" href="${ctx}/lib/gentelella/css/custom.min.css">
<script type="text/javascript" src="${ctx}/lib/bs/navsidebar/accordion/js/jquery-accordion-menu.js"></script>
<script type="text/javascript">
$(function(){
	/* navsidebar */
	var navMenuTreeHtml = new treeMenu(<%=navMenuTreeNodes%>).init(0);
	$(".menu_section h3").after(navMenuTreeHtml);
	//导航菜单单击事件
	$(".menu_section li").click(function(){
		if(typeof($(this).attr("url"))!="undefined"){
			$("#mainFrame").attr("src",$(this).attr("url"));
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
        var html = "\n<ul class=\"nav side-menu\">\n";
        html += "<li url=\"${ctx}/home.jsp\"><a href=\"#\"><i class=\"fa fa-home\"></i>首页 </a>";
        if(k>0) html = "\n<ul class=\"nav child_menu\">\n";
        for(var i=0;i<a.length;i++){
        	if(a[i].tc_url == "") 
				html += "<li><a href=\"#\"><i class=\"fa fa-cog\"></i>"+a[i].tc_name+" <span class=\"fa fa-chevron-down\"></span></a>";// parent node
            else 
				html += "<li url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"#\"><i class=\"fa fa-list\"></i>"+a[i].tc_name+" </a>";// child node
            		
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
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.jsp" class="site_title"><i class="fa fa-paw"></i>
							<span>Gentellela Alela!</span></a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img src="" alt="..."
								class="img-circle profile_img">
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
							<h3>General</h3>
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
				<iframe id="mainFrame" name="mainFrame" src="${ctx}/home.jsp"
					width="100%"
					onload="this.height=mainFrame.document.body.scrollHeight+65"
					frameborder="0" scrolling="no"></iframe>
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
</html>