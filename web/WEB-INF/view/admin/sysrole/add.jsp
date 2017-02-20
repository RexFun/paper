<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/js/view.add.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all.min.js"></script>
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
	// 返回列表页
	$("#back").click(function(){
		location.href = "get.action?"+$rex.view.fn.getUrlParams("${queryParams}");
	});
	// 初始化权限树
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
    	$("#tc_sys_permit_ids").val(getCheckedNodesIds());
    });
});
/**********************************************************/
/* zTree配置 */
/**********************************************************/
// 获取已选节点id集合
function getCheckedNodesIds()
{
	var zTree = $.fn.zTree.getZTreeObj("permitTree")
    var nodes = zTree.getCheckedNodes(true);
	var ids = [];
	for(var i=0; i<nodes.length; i++) {
		ids.push(nodes[i].id);
	}
	return ids;
}
// zTree 的参数配置
var zTreeObj;
var setting = 
{
	check: 
	{
		enable: true,
		chkboxType: { "Y": "ps", "N": "s" }
	},
	async: 
	{
		enable: true,
		url:"getPermitTreeNodes.action"
	},
	data: 
	{
		key: 
		{
			name:"tc_name2"
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
	    	$("#tc_sys_permit_ids").val(getCheckedNodesIds());
		}
	}
};
</script>
</head>
<body class="body-content">
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top navbar-fixed-top-extend" role="navigation">
	<div class="navbar-header navbar-header-extend">
		<a class="navbar-brand" href="#"><i class="glyphicon glyphicon-plus"></i></a>
		<div class="navbar-header-btn-right">
			<button type="submit" class="btn btn-default navbar-btn" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
			<button type="button" class="btn btn-default navbar-btn" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
		</div>
	</div>
</nav>
<!-- form
======================================================================================================= -->
<form class="dataForm" id="dataForm" role="form" action="add2.action" method="post">
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<fieldset>
			<legend>基础信息</legend>
				<div class="form-group"><label class="control-label" for="tc_code">角色代号：</label><input type="text" class="form-control input-sm" id="tc_code" name="po.m.tc_code" validate validate-rule-required /></div>
				<div class="form-group"><label class="control-label" for="tc_name">角色名称：</label><input type="text" class="form-control input-sm" id="tc_name" name="po.m.tc_name" validate validate-rule-required /></div>
				<input type="hidden" id="tc_sys_permit_ids" name="po.m.tc_sys_permit_ids" value="">
			</fieldset>
		</div>
		<div class="col-md-6 column">
			<fieldset>
			<legend>权限</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<input type="checkbox" id="chkAll"/><label for="chkAll">&nbsp;全选</label>
				<ul id="permitTree" class="ztree" style="height:700px; overflow:auto"></ul>
			</fieldset>
		</div>
	</div>
</div>
</form>
</body>
</html>