<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>${param.menuName}</h1>
		<ol class="breadcrumb">
			<li><a href="${ctx}/index.jsp"><i class="fa fa-dashboard"></i> 首页</a></li>
			<li class="active">${param.menuName}</li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
		<div class="col-md-12">
		<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title"><small><i class="glyphicon glyphicon-th-list"></i></small></h3>
		</div>
		<div class="box-body">
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
		</div>
		</div>
		</div>
		</div>
		<!-- query form modal ======================================================================================================= -->
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
							 <label for="f_tc_code">用户代号：</label><input type="text" class="form-control input-sm" id="f_tc_code"/>
							 <label for="f_tc_name">用户名称：</label><input type="text" class="form-control input-sm" id="f_tc_name"/>
							 <label for="f_tc_email">用户邮箱：</label><input type="text" class="form-control input-sm" id="f_tc_email"/>
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
	</section>
</div>
<%@ include file="/common/inc_footer.jsp"%>
<!-- ======================================================================================================= -->
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<script type="text/javascript" src="/static/res/chok/js/chok.view.get.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function() {
	$chok.view.fn.selectSidebarMenu("${param.menuId}","${param.menuName}");
	$chok.view.get.init.toolbar();
	$chok.view.get.init.modalFormQuery();
	$chok.view.get.init.table("${queryParams.f_page}","${queryParams.f_pageSize}");
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
});
/**********************************************************/
/* 初始化配置 */
/**********************************************************/
$chok.view.get.config.setPreFormParams = function(){
	$("#f_tc_code").val(typeof("${queryParams.f_tc_code}")=="undefined"?"":"${queryParams.f_tc_code}");
	$("#f_tc_name").val(typeof("${queryParams.f_tc_name}")=="undefined"?"":"${queryParams.f_tc_name}");
	$("#f_tc_email").val(typeof("${queryParams.f_tc_email}")=="undefined"?"":"${queryParams.f_tc_email}"); 
};
$chok.view.get.config.formParams = function(p){
	p.tc_code = $("#f_tc_code").val();
	p.tc_name = $("#f_tc_name").val();
	p.tc_email = $("#f_tc_email").val();
    return p;
};
$chok.view.get.config.urlParams = function(){
	return {f_tc_code : $("#f_tc_code").val(),
		   	f_tc_name : $("#f_tc_name").val(),
		   	f_tc_email : $("#f_tc_email").val()};
};
$chok.view.get.config.tableColumns = 
[
    {title:'ID', field:'m.id', align:'center', valign:'middle', sortable:true},
    {title:'用户代号', field:'m.tc_code', align:'center', valign:'middle', sortable:true},
    {title:'用户名称', field:'m.tc_name', align:'center', valign:'middle', sortable:true},
    {title:'用户邮箱', field:'m.tc_email', align:'center', valign:'middle', sortable:true},
    {title:'创建时间', field:'m.tc_add_time', align:'center', valign:'middle', sortable:true}
];
$chok.view.get.callback.delRows = function(){
};
$chok.view.get.callback.onLoadSuccess = function(){
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
};
</script>