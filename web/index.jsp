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
	#nav-menu-list a{
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
	var navMenuTreeHtml = new treeMenu(<%=navMenuTreeNodes%>).init(0);
	$(".jquery-accordion-menu-header").after(navMenuTreeHtml);
	$("#jquery-accordion-menu").jqueryAccordionMenu();
	//导航菜单单击事件
	$("#nav-menu-list li").click(function(){
		$(this).addClass("active");
		$(this).siblings().removeClass("active");
		//$("#nav-menu-list li.active").removeClass("active");
		if(typeof($(this).attr("url"))!="undefined"){
			$("#mainFrame").attr("src",$(this).attr("url"));
			$('.openMdNav').click();
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
        var html = "\n<ul id=\"nav-menu-list\">\n";
        html += "<li url=\"${ctx}/home.jsp\"><a href=\"#\"><i class=\"fa fa-cog\"></i>首页 </a>";
        if(k>0) html = "\n<ul class=\"submenu\">\n";
        for(var i=0;i<a.length;i++){
        	if(a[i].tc_url != "")
				html += "<li url=\"${ctx}"+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"#\"><i class=\"fa fa-cog\"></i>"+a[i].tc_name+" </a>";
            else
				html += "<li><a href=\"#\"><i class=\"fa fa-cog\"></i>"+a[i].tc_name+" </a>";
            		
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
			filterList($("#form"), $("#nav-menu-list"));
		});
		})(jQuery);
</script>
</head>
<body>
	<nav class="mdNav">
		<div class="content">
			<div id="jquery-accordion-menu" class="jquery-accordion-menu skyblue">
				<div class="jquery-accordion-menu-header" id="form"></div>
				<div class="jquery-accordion-menu-footer"></div>
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
						 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a class="navbar-brand" href="#">后台管理系统</a>
					</div>
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav navbar-right">
						<c:choose>
						<c:when test="${sessionScope.CUR_LOGIN_USER==null}">
							<li><a href="${ctx}/login.jsp"><i class="glyphicon glyphicon-log-in"></i> 登录 </a></li>
						</c:when> 
						<c:otherwise>
						 	<li class="dropdown">
				                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> <%=account%> <b class="caret"></b></a>
				                <ul id="user-dropdown-menu" class="dropdown-menu">
				                    <li url="${ctx}/admin/sysuser/getMyInfo.action?id=<%=userId%>"><a href="#"><i class="glyphicon glyphicon-file"></i> 个人资料 </a></li>
				                    <li class="divider"></li>
				                    <li url="${ctx}/admin/sysuser/updPwd1.action?id=<%=userId%>"><a href="#"><i class="glyphicon glyphicon-lock"></i> 修改密码 </a></li>
				                </ul>
				            </li>
						</c:otherwise> 
						</c:choose>
							<li><a href="${ctx}/auth/logout.action"><i class="glyphicon glyphicon-log-out"></i> 登出</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
		<!-- 主界面
		========================================================= -->
		<div class="row clearfix">
			<div class="col-md-12 column">
				<iframe id="mainFrame" name="mainFrame" src="${ctx}/home.jsp" width="100%" onload="this.height=mainFrame.document.body.scrollHeight+65" frameborder="0" scrolling="no"></iframe>
			</div>
		</div>
	</div>
</body>
</html>