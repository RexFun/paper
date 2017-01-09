/**
 * $nav 导航类
 */
var $nav={
	// 生成菜单
	init : function(json){
//		var navMenuTreeHtml = new treeMenu(json).init(0);
		var navMenuTreeHtml = new treeMenu(json).init();
		$(".sidebar-form").nextAll().empty();
		$(".sidebar-form").after(navMenuTreeHtml);
	},
	// 菜单单击事件
	onItemClick : function(callback){
	 	$(".sidebar li a").click(function(){
	 		$(this).parent("li").siblings(".treeview").children(".treeview-menu").removeClass("menu-open").css({"display":"none"});
			$(this).parent("li").siblings().removeClass("active");
			$(this).parent("li").addClass("active");
			if(typeof($(this).parent("li").attr("url"))!="undefined"){
				if (typeof callback === "function"){
					var menuId = $(this).parent("li").attr("menuId");
					var url = $(this).parent("li").attr("url");
					var title = $(this).children("span").html();
		            callback(menuId,url,title); 
		        }
			}
		});
	}
};
/**
 * treeMenu 用于生成HTML菜单元素
 */
function treeMenu(a){
    this.tree=a||[];
    this.groups={};
};
// 扩展原型方法
treeMenu.prototype={
   	/*
     * 初始化
	 */
    init:function(){
        this.group();
        var k;
        for(var groupKey in this.groups){
        	if (groupKey!=null){
        		k = groupKey;
        		break;
        	} 
        }  
        return this.getDom(k,this.groups[k]);
    },
   	/*
     * 初始化
	 * pid : json对象中的pid值，默认传0
	 */
//    init:function(pid){
//    	this.group();
//      return this.getDom(pid,this.groups[pid]);
//    },
    /*
     * 按pid为key分类存放菜单数组，如：Object {0: Array[3], 3: Array[1]}
     */
    group:function(){
        for(var i=0;i<this.tree.length;i++){
            if(this.groups[this.tree[i].pid]){
                this.groups[this.tree[i].pid].push(this.tree[i]);
            }else{
                this.groups[this.tree[i].pid]=[];
                this.groups[this.tree[i].pid].push(this.tree[i]);
            }
        }
    },
    /*
     * 递归遍历生成菜单元素
     * k : this.groups对象的key值(以pid为key)
     * a : this.groups对象的value值(数组类型)
    */
    getDom:function(k,a){
        if(!a){return ""}
        var html = "\n<ul class=\"sidebar-menu\">\n";
        html += "<li class=\"active\" menuId=\"0\" url=\""+$ctx+"/home.jsp\"><a href=\"javascript:void(0)\"><i class=\"fa fa-home\"></i><span>首页</span></a>";
        if(k>0) html = "\n<ul class=\"treeview-menu\" style=\"\">\n";
//        if(k>0) html = "\n<ul class=\"treeview-menu\" style=\"display:none\">\n";
        for(var i=0;i<a.length;i++){
        	if(this.groups[a[i].id] && this.groups[a[i].id].length > 0){ // 有子节点
        		if(a[i].pid == 0){// 1级菜单
        			if(a[i].tc_url == "")
						html += "<li class=\"treeview\" menuId=\""+a[i].id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-cog\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
					else
						html += "<li class=\"treeview\" menuId=\""+a[i].id+"\" url=\""+$ctx+""+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-cog\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
        		}else{// 非1级菜单
        			if(a[i].tc_url == "")
						html += "<li class=\"treeview\" menuId=\""+a[i].id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
					else
						html += "<li class=\"treeview\" menuId=\""+a[i].id+"\" url=\""+$ctx+""+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span><span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
        		}
        	}else{// 没有子节点
        		if(a[i].pid == 0){// 1级菜单
        			if(a[i].tc_url == "")
        				html += "<li menuId=\""+a[i].id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-list\"></i><span>"+a[i].tc_name+"</span></a>";
       				else
        				html += "<li menuId=\""+a[i].id+"\" url=\""+$ctx+""+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-list\"></i><span>"+a[i].tc_name+"</span></a>";
        		}else{ // 非1级菜单
        			if(a[i].tc_url == "")
        				html += "<li menuId=\""+a[i].id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span></a>";
       				else
        				html += "<li menuId=\""+a[i].id+"\" url=\""+$ctx+""+a[i].tc_url+"?menuPermitId="+a[i].tc_sys_permit_id+"\"><a href=\"javascript:void(0)\"><i class=\"fa fa-circle-o\"></i><span>"+a[i].tc_name+"</span></a>";
        		}
        	}
            html += this.getDom(a[i].id,this.groups[a[i].id]);
            html += "</li>\n";
        };
        html += '</ul>\n';
        return html;
    }
};