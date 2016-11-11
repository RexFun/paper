<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/lib/gentelella/vendors/animate.css/animate.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/lib/gentelella/vendors/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/lib/gentelella/css/custom.min.css">
<script type="text/javascript">
/* 
if (window != top) top.location.href = location.href;  
 */
if (window.top != window.self) window.top.location.href = window.self.location.href;
$(function(){
	$("#loginForm").submit(function(event) {
		event.preventDefault();
		var url = $("#loginForm").attr('action');
		$.post(
			url, 
			{'auth.account':$("#inputAccount").val(),'auth.password':$("#inputPassword").val()},
		  	function(data) {
				if(data.success){
					location.href = "${ctx}/index.jsp";
				}else{
					$('#msgModalText').html(data.msg);
					$('#msgModal').modal('show');
				}
			}
		);
	});
});
</script>
</head>
<body class="login">
<div>
	<a class="hiddenanchor" id="signup"></a> 
	<a class="hiddenanchor" id="signin"></a>
	<div class="login_wrapper">
		<div class="animate form login_form">
			<section class="login_content">
				<form id="loginForm" action ="${pageContext.request.contextPath}/auth/login.action" method="POST">
					<h1>Login Form</h1>
					<div>
						<input type="text" class="form-control" placeholder="Username" id="inputAccount" name="auth.account" required="" />
					</div>
					<div>
						<input type="password" class="form-control" id="inputPassword" name="auth.password" placeholder="Password" required="" />
					</div>
					<div>
						<button type="submit" class="btn btn-default submit">登录</button>
						<a class="reset_pass" href="#">忘记密码?</a>
					</div>
					<div class="clearfix"></div>
					<div class="separator">
						<p class="change_link">
							首次访问? <a href="#signup" class="to_register"> 创建账号 </a>
						</p>
						<div class="clearfix"></div>
						<br />
						<div>
							<h1>
								<i class="fa fa-paw"></i> Gentelella Alela!
							</h1>
							<p>©2016 All Rights Reserved. Gentelella Alela! is a
								Bootstrap 3 template. Privacy and Terms</p>
						</div>
					</div>
				</form>
			</section>
		</div>

		<div id="register" class="animate form registration_form">
			<section class="login_content">
				<form>
					<h1>创建账号</h1>
					<div>
						<input type="text" class="form-control" placeholder="Username" required="" />
					</div>
					<div>
						<input type="email" class="form-control" placeholder="Email" required="" />
					</div>
					<div>
						<input type="password" class="form-control" placeholder="Password" required="" />
					</div>
					<div>
						<a class="btn btn-default submit" href="index.html">提交</a>
					</div>
					<div class="clearfix"></div>
					<div class="separator">
						<p class="change_link">
							已有账号 ? <a href="#signin" class="to_register"> 登录 </a>
						</p>
						<div class="clearfix"></div>
						<br />
						<div>
							<h1>
								<i class="fa fa-paw"></i> Gentelella Alela!
							</h1>
							<p>©2016 All Rights Reserved. Gentelella Alela! is a
								Bootstrap 3 template. Privacy and Terms</p>
						</div>
					</div>
				</form>
			</section>
		</div>
	</div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="msgModalTitle">提示</h4>
			</div>
			<div class="modal-body alert-danger" id="msgModalText"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</body>
</html>