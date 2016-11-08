<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/lib/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/lib/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">
/**********************************************************/
/* zTree配置 */
/**********************************************************/
// zTree 的参数配置
var zTreeObj;
var setting = 
{
	check: 
	{
		enable: true
	},
	async: 
	{
		enable: true,
		url:"getPermitTreeNodesByRole.action?id=${po.m.id}"
	},
	data: 
	{
		key: 
		{
			name:"tc_name"
		},
		simpleData: 
		{
			idKey:"id",
			pIdKey:"pid",
			enable: true
		}
	},
	callback: {
		onCheck: function (event, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("permitTree")
		    var nodes = zTree.getCheckedNodes(true);
	    	var ids = [];
	    	for(var i=0; i<nodes.length; i++) {
	    		ids.push(nodes[i].id);
	    	}
	    	$("#tc_sys_permit_ids").val(ids);
		}
	}
};
// zTree的初始化
$(function(){
    zTreeObj = $.fn.zTree.init($("#permitTree"), setting);
    // 全部展开/折叠
    $("#expandAll").click(function(){
    	var zTree = $.fn.zTree.getZTreeObj("permitTree");
        if($(this).prop("checked")==true){
        	zTree.expandAll(true);
        }else{
        	zTree.expandAll(false);
        }
    });
    // 全选/全不选
    $("#chkAll").click(function(){
    	var zTree = $.fn.zTree.getZTreeObj("permitTree");
        if($(this).prop("checked")==true){
        	zTree.checkAllNodes(true);
        }else{
        	zTree.checkAllNodes(false);
        }
    });
});
/**********************************************************/
/* 界面回调函数 */
/**********************************************************/
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "get.action";
	}
};
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="get.action">角色管理</a></li>
	<li class="active">修改</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="upd2.action" method="post">
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<fieldset>
			<legend>基础信息</legend>
				<div class="form-group"><label for="tc_code">角色代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}"/></div>
				<div class="form-group"><label for="tc_name">角色名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}"/></div>
				<input type="hidden" name="po.m.id" value="${po.m.id}">
				<input type="hidden" id="tc_sys_permit_ids" name="po.m.tc_sys_permit_ids" value="${po.m.tc_sys_permit_ids}">
				<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
				<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
			</fieldset>
		</div>
		<div class="col-md-6 column">
			<fieldset>
			<legend>权限</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<input type="checkbox" id="chkAll"/><label for="chkAll">&nbsp;全选</label>
				<ul id="permitTree" class="ztree"></ul>
			</fieldset>
		</div>
	</div>
</div>
</form>
</body>
</html>
