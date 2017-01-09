package admin.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import admin.entity.SysMenu;
import admin.entity.SysPermit;
import admin.service.SysMenuService;
import admin.service.SysPermitService;
import gwen.devwork.BaseAction;
import gwen.devwork.PageNav;
import gwen.util.CollectionUtil;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/admin/sysmenu")
public class SysMenuAction extends BaseAction<SysMenu>
{
	@Autowired
	private SysMenuService service;
	@Autowired
	private SysPermitService permitService;
	//实体类
	private SysMenu po;
	public SysMenu getPo() {return po;}
	public void setPo(SysMenu po) {this.po = po;}
	
	@Action(value="add1",results={ @Result(name = "success", location = "/WEB-INF/view/admin/sysmenu/add.jsp")})
	public String add1() 
	{
		return "success";
	}
	@Action(value="add2")
	public void add2() 
	{
		service.add(po);
		print("1");
	}
	
	@Action(value="del")
	public void del() 
	{
		try
		{
			service.del(CollectionUtil.toLongArray(getReq().getLongArray("id[]", 0l)));
			getResult().setSuccess(true);
		}
		catch(Exception e)
		{
			getResult().setSuccess(false);
			getResult().setMsg(e.getMessage());
		}
		printJson(getResult());
	}
	
	@Action(value="upd1",results={ @Result(name = "success", location = "/WEB-INF/view/admin/sysmenu/upd.jsp")})
	public String upd1() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}
	@Action(value="upd2")
	public void upd2() 
	{
		service.upd(po);
		print("1");
	}

	@Action(value="getById",results={ @Result(name = "success", location = "/WEB-INF/view/admin/sysmenu/getById.jsp")})
	public String getById() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}

	@Action(value="get",results={ @Result(name = "success", location = "/WEB-INF/view/admin/sysmenu/get.jsp")})
	public String get() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		m.put("page", getReq().getInt("page", 1));
		m.put("pageSize", getReq().getInt("pageSize", 5));
		
		page = service.getPage(5, m);
		pageNav = new PageNav<SysMenu>(getReq(), page, "5,10,20");
		getResult().put("resultList", pageNav.getResult());
		return "success";
	}
	
	@Action(value="getJson")
	public void getJson()
	{
		Map m = getReq().getParameterValueMap(false, true);
		m.put("rownum", Integer.parseInt(m.get("offset").toString()));
		m.put("pagesize", Integer.parseInt(m.get("limit").toString()));
		getResult().put("total",service.getCount(m));
		getResult().put("rows",service.get(m));
		printJson(getResult().getData());
	}
	
	@Action(value="getMenuTreeNodes")
	public void getMenuTreeNodes()
	{
		List<Object> treeNodes = new ArrayList<Object>();
		if(getReq().getLong("id")!=0)
		{// 所有菜单，且标记已选菜单
			SysMenu selectedMenuObj = service.getById(getReq().getLong("id"));
			List<SysMenu> menuData = service.get(null);
			for(int i=0; i<menuData.size(); i++)
			{
				SysMenu o = menuData.get(i);
				if(o.getLong("id") == selectedMenuObj.getLong("id"))
				{
					o.set("checked", true);
				}
				treeNodes.add(o.getM());
			}
		}
		else
		{// 所有菜单
			List<SysMenu> resultData = service.get(null);
			for(SysMenu o : resultData)
			{
				treeNodes.add(o.getM());
			}
		}
		printJson(treeNodes);
	}
	
	@Action(value="getPermitTreeNodes")
	public void getPermitTreeNodes()
	{
		List<Object> treeNodes = new ArrayList<Object>();
		if(getReq().getLong("id")!=0)
		{// 所有权限，且标记已选权限
			SysPermit selectedPermitObj = permitService.getById(getReq().getLong("id"));
			List<SysPermit> permitData = permitService.get(null);
			for(int i=0; i<permitData.size(); i++)
			{
				SysPermit o = permitData.get(i);
				if(o.getLong("id") == selectedPermitObj.getLong("id"))
				{
					o.set("checked", true);
				}
				treeNodes.add(o.getM());
			}
		}
		else
		{// 所有权限
			List<SysPermit> resultData = permitService.get(null);
			for(SysPermit o : resultData)
			{
				treeNodes.add(o.getM());
			}
		}
		printJson(treeNodes);
	}
	
	@Action(value="getPermitTreeNodesByMenu")
	public void getPermitTreeNodesByMenu()
	{
		po = service.getById(getReq().getLong("id"));
		
		List<SysPermit> permitData = permitService.get(null);
		List<Object> treeNodes = new ArrayList<Object>();
		
		for(int i=0; i<permitData.size(); i++)
		{
			SysPermit o = permitData.get(i);
			if(po.getM().containsKey("tc_sys_permit_id") && o.getLong("id") == po.getLong("tc_sys_permit_id"))
			{
				o.set("checked", true);
			}
			treeNodes.add(o.getM());
		}
		printJson(treeNodes);
	}
}