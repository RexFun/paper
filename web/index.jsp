<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
<section class="content-header">
<h1>&nbsp;</h1>
<ol class="breadcrumb">
	<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
</ol>
</section>
<section class="content">
<div class="row">
<div class="col-md-12">
<div class="box box-default">
	&nbsp;
</div>
</div>
</div>
</section>
</div>
<%@ include file="/common/inc_footer.jsp"%>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function() {
	$rex.view.fn.selectSidebarMenu("${param.menuId}","${param.menuName}");
});
</script>