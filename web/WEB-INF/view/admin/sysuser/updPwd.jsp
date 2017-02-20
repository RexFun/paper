<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$(function(){
	$('input').keypress(function (e) { //这里给function一个事件参数命名为e，叫event也行，随意的，e就是IE窗口发生的事件。
	    var key = e.which; //e.which是按键的值
	    if (key == 13) {
	    	$("#save").click();
	    }
	});
	$("#save").click(function(){
		if(!$rex.validator.check()) return; 
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
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
<div class="container-fluid">
<div class="navbar-header"><a class="navbar-brand" href="#"><i class="glyphicon glyphicon-info-sign"></i></a></div>
<button type="button" class="btn btn-default navbar-btn dataFormSave" id="save"><i class="glyphicon glyphicon-floppy-save"></i></button>
</div>
</nav>
<!-- form -->
<form class="dataForm" id="pwdForm" role="form" action="updPwd2.action" method="post">
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<fieldset>
				<div class="form-group"><label for="old_password">原密码：</label><input type="password" class="form-control input-sm" id="old_password" value="" validate validate-rule-required/></div>
				<div class="form-group"><label for="new_password">新密码：</label><input type="password" class="form-control input-sm" id="new_password" value="" validate validate-rule-required/></div>
				<input type="hidden" id="id" value="${po.m.id}"/>
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