<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
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
	$("button[name='b_add']").click(function(){
		location.href = "addPaperImage1.action?pid=${pid}&ppid=${ppid}";
	});
	$("button[name='b_del']").click(function(){
		if(confirm("确认删除？")) $("#form_del").submit();
	});
	$("button[name='b_updSortBatch']").click(function(){
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
	$("button[name='b_back']").click(function(){
		location.href = "../papermodel/get.action";
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
<!-- title
======================================================================================================= -->
<ul class="breadcrumb">
	<li><a href="../papermodel/get.action">模型管理</a></li>
	<li class="active">图片管理 - ${modelName}</li>
</ul>
<!-- toolbar
======================================================================================================= -->
<div class="btn-group">
	<button type="button" class="btn btn-default" name="b_add">新增</button>
	<button type="button" class="btn btn-default" name="b_del">删除</button>
	<button type="button" class="btn btn-default" name="b_updSortBatch" >修改排序号</button>
	<button type="button" class="btn btn-default" name="b_back" >返回</button>
</div>
<!-- data list
======================================================================================================= -->
<form style="padding-top:10px;padding-bottom:10px" id="form_del" action="delPaperImage.action" method="post">
<table data-toggle="table" data-striped="true" onload="this.height=mainFrame.document.body.scrollHeight" >
	<thead>
	<tr>
		<th style="width:2%"><input id="ckb_all" type="checkbox"/></th>
		<th data-sortable="true">主键</th>
		<th data-sortable="true">外键</th>
		<th data-sortable="true">排序号</th>
		<th>图片</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator var="o" value="result.data.resultList">
	<tr>
		<td><input name="keyIndex" type="checkbox" value="${o.m.id}"/></td>
		<td>${o.m.id}</td>
		<td>${o.m.pid}</td>
		<td>
			<input type="hidden" name="hidden_id" value="${o.m.id}" style="width:50px"/>
			<input type="text" name="text_sort" value="${o.m.sort}" style="width:50px"/>
			<input type="button" name="btn_upd" value="修改"/>
		</td>
		<td>
			<a href="getPaperImageById.action?id=${o.m.id}&ppid=${ppid}">
			<img src="<%=ctx%>/share/data/img.jsp?id=${o.m.id}" alt="图片" style="width:100px;height:100px"/>
			</a>
		</td>
	</tr>
	</s:iterator>
	</tbody>
</table>
<input name="page" type="hidden" value="${page.curPage}" />
<input name="pid" type="hidden" value="${pid}" />
</form>
<div>
${pageNav.pageHtml}
</div>
</body>
</html>
