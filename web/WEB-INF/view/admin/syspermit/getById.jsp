<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>${param.menuName}<small>明细</small></h1>
		<ol class="breadcrumb">
			<li><a href="${ctx}/index.jsp"><i class="fa fa-dashboard"></i> 首页</a></li>
			<li><a href="get.action?menuId=${param.menuId}&menuName=${param.menuName}">${param.menuName}</a></li>
			<li class="active">明细</li>
		</ol>
	</section>
	<section class="content">
		<div class="box box-default">
			<div class="box-header with-border">
				<h3 class="box-title">&nbsp;</h3>
				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
				</div>
			</div>
			<div class="box-body">
				<form class="dataForm" id="dataForm" role="form">
					<div class="form-group"><label class="control-label" for="id">权限ID：</label><input type="text" class="form-control input-sm" id="id" name="m['id']" value="${po.m.id}" readonly="readonly"/></div>
					<div class="form-group"><label class="control-label" for="tc_code">权限代号：</label><input type="text" class="form-control input-sm" id="tc_code" name="m['tc_code']" value="${po.m.tc_code}" readonly="readonly"/></div>
					<div class="form-group"><label class="control-label" for="tc_name">权限名称：</label><input type="text" class="form-control input-sm" id="tc_name" name="m['tc_name']" value="${po.m.tc_name}" readonly="readonly"/></div>
					<div class="form-group">
						<label for="tc_type">权限类型：</label>
						<select class="form-control input-sm" id="tc_type" name="m['tc_type']" readonly="readonly">
							<option value="0">默认</option>
							<option value="1">按钮</option>
						</select>
					</div>
					<div class="form-group"><label class="control-label" for="tc_url">权限URL：</label><input type="text" class="form-control input-sm" id="tc_url" name="m['tc_url']" value="${po.m.tc_url}" readonly="readonly"/></div>
					<div class="form-group"><label class="control-label" for="tc_order">权限排序号：</label><input type="text" class="form-control input-sm" id="tc_order" name="m['tc_order']" value="${po.m.tc_order}" readonly="readonly"/></div>
					<div class="form-group"><label class="control-label" for="pid">父节点：</label>
						<input type="text" class="form-control input-sm" value="${po.m.tc_p_name}" readonly="readonly"/>
						<input type="hidden" class="form-control input-sm" id="pid" name="m['pid']" value="${po.m.pid}" readonly="readonly"/>
					</div>
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
<script type="text/javascript" src="${ctx}/res/chok/js/chok.view.getById.js"></script>
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
	// 权限类型selection返回值
	$("#tc_type").val("${po.m.tc_type}");
});
</script>
</head>