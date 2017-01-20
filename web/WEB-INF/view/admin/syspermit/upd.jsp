<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 保存后回调函数 */
/**********************************************************/
$rex.form.callback = function(){
	if($rex.result.type == 1){
		location.href = "get.action";
	}
};
/**********************************************************/
/* zTree配置 */
/**********************************************************/
// permitTree 的参数配置
var permitSetting = {
	async: 
	{
		enable: true,
		url:"getPermitTreeNodes.action?id=${po.m.pid}"
	}
};
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function(){
    var s = $("#modal_sel").ztreeSelectorModal({treeid:"tree_permit",
 											  	title:"请选择权限节点",
 											  	setting:permitSetting,
 											  	callback:{
 													onConfirm:function(modalObj,rtnVal){
 														$("#sel_permit").val(rtnVal.vName);
 														$("#pid").val(rtnVal.vId);
 													}
 											  	}
    });
    $("#sel_permit").click(function(){
    	s.modal("show");
    });
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li class="active">修改</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="upd2.action" method="post">
	<div class="form-group"><label for="tc_code">权限代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}"/></div>
	<div class="form-group"><label for="tc_name">权限名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}"/></div>
	<div class="form-group"><label for="tc_url">权限URL：</label><input type="text" class="form-control" id="tc_url" name="po.m.tc_url" value="${po.m.tc_url}"/></div>
	<div class="form-group"><label for="tc_order">权限排序号：</label><input type="text" class="form-control" id="tc_order" name="po.m.tc_order" value="${po.m.tc_order}"/></div>
	<div class="form-group">
		<label for="tc_type">权限类型：</label>
		<select class="form-control" id="tc_type" name="po.m.tc_type">
			<option value="0">默认</option>
			<option value="1">按钮</option>
		</select>
	</div>
	<div class="form-group"><label for="pid">父节点：</label>
		<input type="text" class="form-control" id="sel_permit" value="${po.m.tc_p_name}"/>
		<input type="hidden" class="form-control" id="pid" name="po.m.pid" value="${po.m.pid}"/>
	</div>
	<input type="hidden" name="po.m.id" value="${po.m.id}">
	<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
	<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
<!-- modal -->
<div id="modal_sel"></div>
</body>
</html>
