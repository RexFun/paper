<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/js/view.add.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 保存后回调函数 */
/**********************************************************/
$rex.form.callback = function(){
	if($rex.result.type == 1){
 		location.href = "get.action?"+$rex.view.fn.getUrlParams("${queryParams}");
	}
};
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function(){
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$rex.view.fn.getUrlParams("${queryParams}");
	});
});
</script>
</head>
<body class="body-content">
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top navbar-fixed-top-extend" role="navigation">
	<div class="navbar-header navbar-header-extend">
		<a class="navbar-brand" href="#"><i class="glyphicon glyphicon-plus"></i></a>
		<div class="navbar-header-btn-right">
			<button type="submit" class="btn btn-default navbar-btn" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
			<button type="button" class="btn btn-default navbar-btn" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
		</div>
	</div>
</nav>
<!-- form
======================================================================================================= -->
<form class="dataForm" id="dataForm" action="add2.action" method="post">
<div class="form-group">
	<label for="pid">所属分类：</label>
 	<select class="form-control input-sm" id="pid" name="po.m.pid" validate validate-rule-required>
		<option value="">请选择</option>
		<s:iterator var="c" value="result.data.catList">
		<option value="${c.m.id}">${c.m.name}</option>
		</s:iterator>
	</select>
</div>
<div class="form-group"><label for="name">模型名：</label><input type="text" class="form-control input-sm" id="name" name="po.m.name" validate validate-rule-required/></div>
<div class="form-group"><label for="sort">排序号：</label><input type="text" class="form-control input-sm" id="sort" name="po.m.sort" validate validate-rule-inputType="integer"/></div>
</form>
</body>
</html>

