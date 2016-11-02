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
		url:"getRoleTreeNodesByUser.action?id=${po.m.id}"
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
			var zTree = $.fn.zTree.getZTreeObj("roleTree")
		    var nodes = zTree.getCheckedNodes(true);
	    	var ids = [];
	    	for(var i=0; i<nodes.length; i++) {
	    		ids.push(nodes[i].id);
	    	}
	    	$("#tc_sys_role_ids").val(ids);
		}
	}
};
// zTree的初始化
$(function(){
    zTreeObj = $.fn.zTree.init($("#roleTree"), setting);
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="get.action">用户管理</a></li>
	<li class="active">明细</li>
</ol>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<dl class="dl-horizontal">
				<dt>用户ID：</dt><dd>${po.m.id}</dd>
				<dt>用户代号：</dt><dd>${po.m.tc_code}</dd>
				<dt>用户名称：</dt><dd>${po.m.tc_name}</dd>
				<dt>用户邮箱：</dt><dd>${po.m.tc_email}</dd>
				<dt>用户密码：</dt><dd>${po.m.tc_password}</dd>
				<dt>创建时间：</dt><dd>${po.m.tc_add_time}</dd>
			</dl>
		</div>
		<div class="col-md-6 column">
			<div style="border:solid 1px gray;margin:10px 0px 10px 0px">
				<ul id="roleTree" class="ztree"></ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>
