<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "get.action";
	}
};
/* 全局函数 */
$(function() {
	initBtnPermit();
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li class="active">新增</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="add2.action" method="post">
	<div class="form-group"><label for="name">类别名：</label><input type="text" class="form-control" id="name" name="po.m.name" /></div>
	<div class="form-group"><label for="sort">排序号：</label><input type="text" class="form-control" id="sort" name="po.m.sort" /></div>
	<button type="submit" class="btn btn-default" id="dataFormSave" pbtnId="pbtn_addSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
	<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
</body>
</html>

