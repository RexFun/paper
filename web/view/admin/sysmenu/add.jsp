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
	<li><a href="get.action">菜单管理</a></li>
	<li class="active">新增</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="add2.action" method="post">
	<div class="form-group"><label for="pid">父ID：</label><input type="text" class="form-control" id="pid" name="po.m.pid" /></div>
	<div class="form-group"><label for="tc_code">菜单代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" /></div>
	<div class="form-group"><label for="tc_name">菜单名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" /></div>
	<div class="form-group"><label for="tc_url">菜单URL：</label><input type="text" class="form-control" id="tc_url" name="po.m.tc_url" /></div>
	<div class="form-group"><label for="tc_sys_permit_id">菜单权限ID：</label><input type="text" class="form-control" id="tc_sys_permit_id" name="po.m.tc_sys_permit_id" /></div>
	<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
	<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
</body>
</html>

