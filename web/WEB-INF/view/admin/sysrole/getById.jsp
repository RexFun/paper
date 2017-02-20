<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">
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
});
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
</script>
</head>
<body>
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
<div class="container-fluid">
<div class="navbar-header"><a class="navbar-brand" href="#"><i class="glyphicon glyphicon-info-sign"></i></a></div>
<button type="button" class="btn btn-default navbar-btn back" id="back"><i class="glyphicon glyphicon-arrow-left"></i></button>
</div>
</nav>
<!-- form
======================================================================================================= -->
<form class="dataForm" id="dataForm" role="form">
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<div class="form-group"><label for="id">角色ID：</label><input type="text" class="form-control input-sm" id="id" name="po.m.id" value="${po.m.id}" readonly="readonly"/></div>
			<div class="form-group"><label for="tc_code">角色代号：</label><input type="text" class="form-control input-sm" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}" readonly="readonly"/></div>
			<div class="form-group"><label for="tc_name">角色名称：</label><input type="text" class="form-control input-sm" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}" readonly="readonly"/></div>
		</div>
		<div class="col-md-6 column">
			<fieldset>
			<legend>权限</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<ul id="permitTree" class="ztree" style="height:700px; overflow:auto"></ul>
			</fieldset>
		</div>
	</div>
</div>
</form>
</body>
</html>
