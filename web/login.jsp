<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>登录</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=path%>/js/bootstrap/css/bootstrap.min.css"/>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#loginForm").submit(function(event) {
		event.preventDefault();
		var url = $("#loginForm").attr('action');
		$.post(
			url, 
			{'user.account':$("#inputAccount").val(),'user.password':$("#inputPassword").val()},
		  	function(data) {
				if(data.success){
					location.href = "<%=path%>/index.jsp";
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
<body>
<div class="container" style="padding: 40px;">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<form id="loginForm" class="form-horizontal" role="form" action ="${pageContext.request.contextPath}/auth/login.action" method="POST">
				<div class="form-group">
					 <label for="inputAccount" class="col-sm-2 control-label">账号</label>
					<div class="col-sm-10">	
						<input type ='text' value="admin" class="form-control input-lg" id="inputAccount" name='user.account'/>
					</div>
				</div>
				<div class="form-group">
					 <label for="inputPassword" class="col-sm-2 control-label">密码</label>
					<div class="col-sm-10">
						<input type="password" class="form-control input-lg" id="inputPassword" name='user.password'/>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						 <button type="submit" class="btn btn-default btn-block btn-success btn-lg">登录</button>
						 <button type="reset" class="btn btn-block btn-warning btn-lg">重置</button>
					</div>
				</div>
			</form>
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