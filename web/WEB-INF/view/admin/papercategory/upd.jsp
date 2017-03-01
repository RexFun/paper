<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<div class="box box-default">
	<div class="box-header with-border">
		<h3 class="box-title"><i class="glyphicon glyphicon-edit"></i></h3>
		<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="row">
			<div class="col-md-12">
				<form class="dataForm" id="dataForm" role="form" action="upd2.action" method="post">
					<div class="form-group"><label class="control-label" for="name">类别名：</label><input type="text" class="form-control input-sm" id="name" name="po.m.name" value="${po.m.name}" validate validate-rule-required/></div>
					<div class="form-group"><label class="control-label" for="sort">排序号：</label><input type="text" class="form-control input-sm" id="sort" name="po.m.sort" value="${po.m.sort}" validate validate-rule-inputType="integer"/></div>
					<input type="hidden" name="po.m.id" value="${po.m.id}">
				</form>
			</div>
		</div>
	</div>
	<div class="box-footer">
		<button type="submit" class="btn btn-block btn-success btn-flat pull-right" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
	</div>
</div>
<%@ include file="/common/inc_footer.jsp"%>
<!-- ======================================================================================================= -->
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/js/view.upd.js"></script>
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
	$rex.view.fn.selectSidebarMenu("${param.menuId}");
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$rex.view.fn.getUrlParams("${queryParams}");
	});
});
</script>