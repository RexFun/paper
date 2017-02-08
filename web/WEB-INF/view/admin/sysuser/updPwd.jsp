<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#pwdForm").submit(function(event) {
		event.preventDefault();
		var url = $("#pwdForm").attr('action');
		$.post(
			url, 
			{'id':$("#id").val(),'old_password':$("#old_password").val(),'new_password':$("#new_password").val()},
		  	function(data) {
				if(data.success){
					alert('密码修改成功');
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
<!-- form -->
<form id="pwdForm" role="form" action="updPwd2.action" method="post">
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<fieldset>
				<div class="form-group"><label for="old_password">原密码：</label><input type="password" class="form-control" id="old_password" value=""/></div>
				<div class="form-group"><label for="new_password">新密码：</label><input type="password" class="form-control" id="new_password" value=""/></div>
				<input type="hidden" id="id" value="${po.m.id}"/>
				<button type="submit" class="btn btn-default"><i class="glyphicon glyphicon-floppy-save"></i></button>
			</fieldset>
		</div>
	</div>
</div>
</form>
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