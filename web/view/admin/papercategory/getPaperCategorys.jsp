<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=path%>/js/bootstrap/css/bootstrap.min.css"/>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="<%=path%>/js/gwen/form.js"></script>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperCategorys.action";
	}
};
$(function(){
	$("#ckb_all").click(function(){
		$("input[name='keyIndex']").prop("checked",$(this).prop("checked"));
	});
	$("a[name='a_del']").click(function(){
		$("#form_del").submit();
	});
});
</script>
</head>
<body>
<ol class="breadcrumb">
  <li><a href="#">Home</a></li>
  <li><a href="#">2013</a></li>
  <li class="active">十一月</li>
</ol>
<h1>纸模分类管理</h1>
<hr>
<a name="a_add" href="addPaperCategory1.action">新增</a>
<a name="a_del" href="javascript:void(0);">删除</a>
<form id="from_query" action="getPaperCategorys.action" method="post">
分类名：<input type="text" name="name">
<input type="submit" id="submit_query" value="查询"/>
</form>
<form id="form_del" action="delPaperCategory.action" method="post">
<table class="table table-striped table-hover">
	<tr>
		<td style="width:2%"><input id="ckb_all" type="checkbox"/></td>
		<td>主键</td>
		<td>分类名</td>
		<td>排序号</td>
		<td>操作</td>
	</tr>
	<s:iterator var="d" value="resultList">
	<tr>
		<td><input name="keyIndex" type="checkbox" value="${d.id}"/></td>
		<td>${d.id}</td>
		<td>${d.name}</td>
		<td>${d.sort}</td>
		<td>
			<a name="a_upd" href="updPaperCategory1.action?id=${d.id}">修改</a>
			<a name="a_getById" href="getPaperCategoryById.action?id=${d.id}">明细</a>
			<a name="a_getPaperModelsByPid" href="../papermodel/getPaperModels.action?pid=${d.id}">模型管理</a>
		</td>
	</tr>
	</s:iterator>
</table>
<input name="page" type="hidden" value="${page.curPage}" />
</form>
<table border="0" cellspacing="0" cellpadding="0" class="bottomTable">
	<tr><td>${pageNav.pageHtml}</td></tr>
</table>
</body>
</html>
