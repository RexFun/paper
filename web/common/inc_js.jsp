<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${ctx}/res/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/res/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap-table-fixed-columns.js"></script>
<script type="text/javascript" src="${ctx}/res/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/res/gwen/form.js"></script>
<script type="text/javascript" src="${ctx}/res/gwen/ztree-selector-modal.js"></script>
<script type="text/javascript">
var $ctx="${ctx}";
function getGlobalHeight(type) {
	if (type=='table')
	   	return $(window).height() - 115;
	else if (type=='tree')
		return $(window).height() - 35;
}
function ajaxOnLoadError(status, data) {
    if(status == '0') {  
        if (confirm('会话已过期, 请重新登录。')) {  
            window.location.href = 'login.jsp';              
        }  
    } 
}
</script>