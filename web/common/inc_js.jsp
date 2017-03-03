<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${ctx}/res/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/res/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/res/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="${ctx}/res/bs/js/bootstrap-table-fixed-columns.js"></script>
<script type="text/javascript" src="${ctx}/res/rex/js/base.js"></script>
<script type="text/javascript" src="${ctx}/res/rex/js/validator.js"></script>
<script type="text/javascript" src="${ctx}/res/rex/js/form.js"></script>
<script type="text/javascript" src="${ctx}/res/rex/js/view.js"></script>
<script type="text/javascript" src="${ctx}/res/rex/js/nav.js"></script>
<script type="text/javascript" src="${ctx}/res/rex/js/ztree-selector-modal.js"></script>
<script type="text/javascript">
var $ctx="${ctx}";
function getGlobalHeight(type) {
	if (type=='table') {
		var minH = 300;
		var newH = $(window).height() - 373;
	   	return newH<minH?minH:newH;
	}
	else if (type=='tree') {
		return $(window).height() - 35;
	}
}
function ajaxOnLoadError(status, data) {
    if(status == '0') {  
        if (confirm('会话已过期, 请重新登录。')) {  
            window.location.href = $ctx+'/login.jsp';              
        }  
    } 
}
</script>