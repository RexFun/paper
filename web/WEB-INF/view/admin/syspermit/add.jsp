<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>权限管理</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active">权限管理</li>
		</ol>
	</section>
	<section class="content">
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title"><small><i class="glyphicon glyphicon-plus"></i></small></h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
				</div>
			</div>
			<div class="box-body">
				<form class="dataForm" id="dataForm" role="form" action="add2.action" method="post">
					<div class="form-group"><label class="control-label" for="tc_code">权限代号：</label><input type="text" class="form-control input-sm" id="tc_code" name="po.m.tc_code" validate validate-rule-required /></div>
					<div class="form-group"><label class="control-label" for="tc_name">权限名称：</label><input type="text" class="form-control input-sm" id="tc_name" name="po.m.tc_name" validate validate-rule-required /></div>
					<div class="form-group">
						<label for="tc_type">权限类型：</label>
						<select class="form-control input-sm" id="tc_type" name="po.m.tc_type">
							<option value="0">默认</option>
							<option value="1">按钮</option>
						</select>
					</div>
					<div class="form-group"><label class="control-label" for="tc_url">权限URL：</label><input type="text" class="form-control input-sm" id="tc_url" name="po.m.tc_url" /></div>
					<div class="form-group"><label class="control-label" for="tc_order">权限排序号：</label><input type="text" class="form-control input-sm" id="tc_order" name="po.m.tc_order" validate validate-rule-inputType="integer" /></div>
					<div class="form-group"><label class="control-label" for="pid">父节点：</label>
						<input type="text" class="form-control input-sm" id="sel_permit"/>
						<input type="hidden" class="form-control input-sm" id="pid" name="po.m.pid"/>
					</div>
				</form>
				<!-- modal -->
				<div id="modal_sel"></div>
			</div>
			<div class="box-footer">
				<button type="submit" class="btn btn-block btn-success btn-flat pull-right" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
			</div>
		</div>
	</section>
</div>
<%@ include file="/common/inc_footer.jsp"%>
<!-- ======================================================================================================= -->
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="${ctx}/res/chok/js/view.add.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 保存后回调函数 */
/**********************************************************/
$chok.form.callback = function(){
	if($chok.result.type == 1){
 		location.href = "get.action?"+$chok.view.fn.getUrlParams("${queryParams}");
	}
};
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function(){
	$chok.view.fn.selectSidebarMenu("${param.menuId}","${param.menuName}");
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$chok.view.fn.getUrlParams("${queryParams}");
	});
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
/**********************************************************/
/* zTree配置 */
/**********************************************************/
// permitTree 的参数配置
var permitSetting = {
	async: 
	{
		enable: true,
		url:"getPermitTreeNodes.action"
	}
};
</script>