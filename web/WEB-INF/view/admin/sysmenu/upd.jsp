<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>${param.menuName}<small>修改</small></h1>
		<ol class="breadcrumb">
			<li><a href="${ctx}/index.jsp"><i class="fa fa-dashboard"></i> 首页</a></li>
			<li><a href="get.action?menuId=${param.menuId}&menuName=${param.menuName}">${param.menuName}</a></li>
			<li class="active">修改</li>
		</ol>
	</section>
	<section class="content">
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title"><small><i class="glyphicon glyphicon-edit"></i></small></h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
				</div>
			</div>
			<div class="box-body">
				<form class="dataForm" id="dataForm" role="form" action="upd2.action" method="post">
					<div class="form-group"><label class="control-label" for="tc_code">菜单代号：</label><input type="text" class="form-control input-sm" id="tc_code" name="m['tc_code']" value="${po.m.tc_code}" validate validate-rule-required/></div>
					<div class="form-group"><label class="control-label" for="tc_name">菜单名称：</label><input type="text" class="form-control input-sm" id="tc_name" name="m['tc_name']" value="${po.m.tc_name}" validate validate-rule-required/></div>
					<div class="form-group"><label class="control-label" for="tc_url">菜单URL：</label><input type="text" class="form-control input-sm" id="tc_url" name="m['tc_url']" value="${po.m.tc_url}"/></div>
					<div class="form-group"><label class="control-label" for="tc_order">菜单排序号：</label><input type="text" class="form-control input-sm" id="tc_order" name="m['tc_order']" value="${po.m.tc_order}" validate validate-rule-inputType="integer"/></div>
					<div class="form-group"><label class="control-label" for="tc_sys_permit_id">绑定权限：</label>
						<input type="text" class="form-control input-sm" id="sel_permit" value="${po.m.tc_sys_permit_name}"/>
						<input type="hidden" class="form-control input-sm" id="tc_sys_permit_id" name="m['tc_sys_permit_id']" value="${po.m.tc_sys_permit_id}"/>
					</div>
					<div class="form-group"><label class="control-label" for="pid">父节点：</label>
						<input type="text" class="form-control input-sm" id="sel_menu" value="${po.m.tc_p_name}"/>
						<input type="hidden" class="form-control input-sm" id="pid" name="m['pid']" value="${po.m.pid}"/>
					</div>
					<input type="hidden" name="m['id']" value="${po.m.id}">
				</form>
				<!-- modal -->
				<div id="modal_sel1"></div>
				<div id="modal_sel2"></div>
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
<link rel="stylesheet" type="text/css" href="/static/res/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="/static/res/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="/static/res/chok/js/chok.view.upd.js"></script>
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
/* zTree配置 */
/**********************************************************/
//menuTree 的参数配置
var menuSetting = {
	async: 
	{
		enable: true,
		url:"getMenuTreeNodes.action?id=${po.m.pid}"
	} 
};
// permitTree 的参数配置
var permitSetting = {
	async: 
	{
		enable: true,
		url:"getPermitTreeNodes.action?id=${po.m.tc_sys_permit_id}"
	}
};
// zTree的初始化
$(function(){
	$chok.view.fn.selectSidebarMenu("${param.menuId}","${param.menuName}");
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$chok.view.fn.getUrlParams("${queryParams}");
	});
	
    var s1 = $("#modal_sel1").ztreeSelectorModal({treeid:"tree_menu",
    											  title:"请选择上级菜单节点",
    											  setting:menuSetting,
    											  callback:{
    												  onConfirm:function(modalObj,rtnVal){
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