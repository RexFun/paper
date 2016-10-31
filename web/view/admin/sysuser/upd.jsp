<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "get.action";
	}
};
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="get.action">用户管理</a></li>
	<li class="active">修改</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="upd2.action" method="post">
	<div class="form-group"><label for="tc_code">用户代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}"/></div>
	<div class="form-group"><label for="tc_name">用户名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}"/></div>
	<div class="form-group"><label for="tc_email">用户邮箱：</label><input type="text" class="form-control" id="tc_email" name="po.m.tc_email" value="${po.m.tc_email}"/></div>
	<div class="form-group"><label for="tc_password">用户密码：</label><input type="text" class="form-control" id="tc_password" name="po.m.tc_password" value="${po.m.tc_password}"/></div>
	<input type="hidden" name="po.m.id" value="${po.m.id}">
	<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
	<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
</body>
</html>
