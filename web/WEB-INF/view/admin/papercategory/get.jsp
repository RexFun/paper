<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/view.get.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function() {
	$rex.view.get.init.toolbar();
	$rex.view.get.init.modalFormQuery();
	$rex.view.get.init.table("${queryParams.f_page}","${queryParams.f_pageSize}");
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
});
/**********************************************************/
/* 初始化配置 */
/**********************************************************/
$rex.view.get.config.setPreFormParams = function(){
	$("#f_name").val(typeof("${queryParams.f_name}")=="undefined"?"":"${queryParams.f_name}");
};
$rex.view.get.config.formParams = function(p){
	p.name = $("#f_name").val();
    return p;
};
$rex.view.get.config.urlParams = function(){
	return {f_name : $("#f_name").val()};
};
$rex.view.get.config.tableColumns = 
[
    {title:'ID', field:'m.id', align:'center', valign:'middle', sortable:true},
    {title:'类别名', field:'m.name', align:'center', valign:'middle', sortable:true},
    {title:'排序号', field:'m.sort', align:'center', valign:'middle', sortable:true}
];
$rex.view.get.callback.delRows = function(){
};
$rex.view.get.callback.onLoadSuccess = function(){
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
};
</script>
</head>
<body>
<!-- toolbar
======================================================================================================= -->
<div id="toolbar">
<button type="button" class="btn btn-default" id="bar_btn_add" pbtnId="pbtn_add"><i class="glyphicon glyphicon-plus"></i></button>
<button type="button" class="btn btn-default" id="bar_btn_del" pbtnId="pbtn_del"><i class="glyphicon glyphicon-remove"></i></button>
<button type="button" class="btn btn-default" id="bar_btn_query" pbtnId="pbtn_query" data-toggle="modal" data-target="#modal_form_query"><i class="glyphicon glyphicon-search"></i></button>
</div>
<!-- data list
======================================================================================================= -->
<table id="tb_list"></table>
<!-- query form modal
======================================================================================================= -->
<form id="form_query">
<div id="modal_form_query" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			   <h4 class="modal-title" id="modal_label">筛选条件</h4>
			</div>
			<div class="modal-body">
				<!-- queryForm -->
				<div class="form-group">
					 <label for="f_name">类别名：</label><input type="text" class="form-control" id="f_name"/>
				</div>
			</div>
			<div class="modal-footer">
			   <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-repeat"></i></button>
			   <button type="button" class="btn btn-primary" id="form_query_btn"><i class="glyphicon glyphicon-ok"></i></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</form>
</body>
</html>