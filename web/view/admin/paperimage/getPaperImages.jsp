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
		location.href = "getPaperImages.action?pid=${pid}&ppid=${ppid}";
	}
};
$(function(){
	$("#ckb_all").click(function(){
		$("input[name='keyIndex']").prop("checked",$(this).prop("checked"));
	});
	$("a[name='a_del']").click(function(){
		$("#form_del").submit();
	});
	$("a[name='a_updSort']").click(function(){
		var idArr = [];   
		var i = 0;   
		$("input[name='hidden_id']").each(function(){
			idArr[i] = $(this).val();    
            i++;
        });
		var sortArr = [];   
		var j = 0;   
		$("input[name='text_sort']").each(function(){
			sortArr[j] = $(this).val();    
            j++;
        });
		$.ajax({  
		    url: "updSortBatch.action",  
		    data: {id:idArr, sort:sortArr},  
		    dataType: "json",  
		    type: "POST",  
		    traditional: true,  
		    success: function (responseJSON) {  
		        window.location.reload();
		    }  
		});
	});
	$("input[name='btn_upd']").click(function(){
		var _id = $(this).siblings("input[name='hidden_id']").val();
		var _sort = $(this).siblings("input[name='text_sort']").val();
		$.post("updSortById.action", {id:_id, sort:_sort}, function(data) {
			  window.location.reload();
		});
	});
});
</script>
</head>
<body>
<a name="a_add" href="addPaperImage1.action?pid=${pid}&ppid=${ppid}">新增</a>
<a name="a_del" href="javascript:void(0);">删除</a>
<a name="a_updSort" href="javascript:void(0);">修改排序</a>
<a name="a_back" href="../papermodel/getPaperModels.action?pid=${ppid}">返回</a>

<form id="form_del" action="delPaperImage.action" method="post">
<table border="0" cellspacing="1" cellpadding="0" class="listTable">
	<tr class="list_title">
		<td style="width:2%"><input id="ckb_all" type="checkbox"/></td>
		<td>主键</td>
		<td>外键</td>
		<td>排序</td>
		<td>图片</td>
		<td>操作</td>
	</tr>	
	<s:iterator var="po" value="resultList">
	<tr>
		<td><input name="keyIndex" type="checkbox" value="${po.id}"/></td>
		<td>${po.id}</td>
		<td>${po.pid}</td>
		<td>
			<input type="hidden" name="hidden_id" value="${po.id}" style="width:50px"/>
			<input type="text" name="text_sort" value="${po.sort}" style="width:50px"/>
			<input type="button" name="btn_upd" value="修改"/>
		</td>
		<td><img src="<%=path%>/share/data/img.jsp?id=${po.id}" alt="图片" style="width:100px;height:100px"/></td>
		<td><a name="a_getById" href="getPaperImageById.action?id=${po.id}">明细</a></td>
	</tr>
	</s:iterator>
</table>
<input name="page" type="hidden" value="${page.curPage}" />
<input name="pid" type="hidden" value="${pid}" />
</form>
<div align="right">
${pageNav.pageHtml}
</div>
</body>
</html>
