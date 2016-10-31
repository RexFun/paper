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
	<li><a href="get.action">角色管理</a></li>
	<li class="active">新增</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="add2.action" method="post">
	<div class="form-group"><label for="pid">父ID：</label><input type="text" class="form-control" id="pid" name="po.m.pid" /></div>
	<div class="form-group"><label for="tc_code">角色代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" /></div>
	<div class="form-group"><label for="tc_name">角色名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" /></div>
	<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
	<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
</body>
</html>

