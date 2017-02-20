<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/js/view.add.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all.min.js"></script>
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
/* zTree配置 */
/**********************************************************/
//menuTree 的参数配置
var menuSetting = {
	async: 
	{
		enable: true,
		url:"getMenuTreeNodes.action"
	} 
};
// permitTree 的参数配置
var permitSetting = {
	async: 
	{
		enable: true,
		url:"getPermitTreeNodes.action"
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
    var s1 = $("#modal_sel1").ztreeSelectorModal({treeid:"tree_menu",
    											  title:"请选择上级菜单节点",
    											  setting:menuSetting,
    											  callback:{
    												  onConfirm:function(modalObj,rtnVal){
    													  //console.info(rtnVal);
    													  $("#sel_menu").val(rtnVal.vName);
    													  $("#pid").val(rtnVal.vId);
    												  }
    											  }
    });
    var s2 = $("#modal_sel2").ztreeSelectorModal({treeid:"tree_permit",
    											  title:"请选择权限节点",
    											  setting:permitSetting,
    											  callback:{
    												  onConfirm:function(modalObj,rtnVal){
    													  //console.info(rtnVal);
    													  $("#sel_permit").val(rtnVal.vName);
    													  $("#tc_sys_permit_id").val(rtnVal.vId);
    												  }
    											  }
    });
    $("#sel_menu").click(function(){
    	s1.modal("show");
    });
    $("#sel_permit").click(function(){
    	s2.modal("show");
    });
});
</script>
</head>
<body class="body-content">
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
<div class="container-fluid">
<div class="navbar-header"><a class="navbar-brand" href="#"><i class="glyphicon glyphicon-plus"></i></a></div>
<button type="button" class="btn btn-default navbar-btn back" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
<button type="submit" class="btn btn-default navbar-btn dataFormSave" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
</div>
</nav>
<!-- form
======================================================================================================= -->
<form class="dataForm" id="dataForm" role="form" action="add2.action" method="post">
	<div class="form-group"><label for="tc_code">菜单代号：</label><input type="text" class="form-control input-sm" id="tc_code" name="po.m.tc_code" validate validate-rule-required /></div>
	<div class="form-group"><label for="tc_name">菜单名称：</label><input type="text" class="form-control input-sm" id="tc_name" name="po.m.tc_name" validate validate-rule-required /></div>
	<div class="form-group"><label for="tc_url">菜单URL：</label><input type="text" class="form-control input-sm" id="tc_url" name="po.m.tc_url" validate validate-rule-required /></div>
	<div class="form-group"><label for="tc_order">菜单排序号：</label><input type="text" class="form-control input-sm" id="tc_order" name="po.m.tc_order" validate validate-rule-inputType="integer"/></div>
	<div class="form-group"><label for="tc_sys_permit_id">绑定权限：</label>
		<input type="text" class="form-control input-sm" id="sel_permit"/>
		<input type="hidden" class="form-control input-sm" id="tc_sys_permit_id" name="po.m.tc_sys_permit_id" />
	</div>
	<div class="form-group"><label for="pid">父节点：</label>
		<input type="text" class="form-control input-sm" id="sel_menu"/>
		<input type="hidden" class="form-control input-sm" id="pid" name="po.m.pid"/>
	</div>
</form>
<!-- modal -->
<div id="modal_sel1"></div>
<div id="modal_sel2"></div>
</body>
</html>

