<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>&nbsp;</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li class="active"></li>
		</ol>
	</section>
	<section class="content">
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title"><small><i class="glyphicon glyphicon-info-sign"></i></small></h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
				</div>
			</div>
			<div class="box-body">
				<form class="dataForm" id="dataForm" role="form">
					<div class="form-group"><label class="control-label" for="name">类别名：</label><input type="text" class="form-control input-sm" id="name" name="po.m.name" value="${po.m.name}" readonly="readonly"/></div>
					<div class="form-group"><label class="control-label" for="sort">排序号：</label><input type="text" class="form-control input-sm" id="sort" name="po.m.sort" value="${po.m.sort}" readonly="readonly"/></div>
					<input type="hidden" name="po.m.id" value="${po.m.id}" readonly="readonly">
				</form>
			</div>
			<div class="box-footer">
			&nbsp;
			</div>
		</div>
	</section>
</div>
<%@ include file="/common/inc_footer.jsp"%>
<!-- ======================================================================================================= -->
<script type="text/javascript" src="${ctx}/res/chok/js/view.getById.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function(){
	$chok.view.fn.selectSidebarMenu("${param.menuId}","${param.menuName}");
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$chok.view.fn.getUrlParams("${queryParams}");
	});
});
</script>