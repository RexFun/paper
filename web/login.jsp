<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
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
<body class="hold-transition login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="#"><b>Admin</b>统一认证平台</a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<form id="loginForm" action="${pageContext.request.contextPath}/auth/login.action" method="post">
				<div class="form-group has-feedback">
					<input type="text" class="form-control" placeholder="" id="inputAccount" name="auth.account">
				</div>
				<div class="form-group has-feedback">
					<input type="password" class="form-control" placeholder="Password" id="inputPassword" name="auth.password">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="row">
					<div class="col-xs-8">
					</div>
					<!-- /.col -->
					<div class="col-xs-4">
						<button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
					</div>
					<!-- /.col -->
				</div>
			</form>
		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="msgModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="msgModalTitle">提示</h4>
				</div>
				<div class="modal-body alert-danger" id="msgModalText"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
</html>