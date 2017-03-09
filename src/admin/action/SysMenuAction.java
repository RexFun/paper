package admin.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.entity.SysMenu;
import admin.entity.SysPermit;
import admin.service.SysMenuService;
import admin.service.SysPermitService;
import chok.devwork.BaseController;
import chok.util.CollectionUtil;


@Scope("prototype")
@Controller
@RequestMapping("/admin/sysmenu")
public class SysMenuAction extends BaseController<SysMenu>
{
	@Autowired
	private SysMenuService service;
	@Autowired
	private SysPermitService permitService;
	
	@RequestMapping("/add1")
	public String add1() 
	{
		put("queryParams", req.getParameterValueMap(false, true));
		return "/admin/sysmenu/add.jsp";
	}
	@RequestMapping("/add2")
	public void add2(SysMenu po) 
	{
		service.add(po);
		print("1");
	}
	
	@RequestMapping("/del")
	public void del() 
	{
		try
		{
			service.del(CollectionUtil.toLongArray(req.getLongArray("id[]", 0l)));
			result.setSuccess(true);
		}
		catch(Exception e)
		{
			result.setSuccess(false);
			result.setMsg(e.getMessage());
		}
		printJson(result);
	}
	
	@RequestMapping("/upd1")
	public String upd1() 
	{
		put("po", service.getById(req.getLong("id")));
		put("queryParams", req.getParameterValueMap(false, true));
		return "/admin/sysmenu/upd.jsp";
	}
	@RequestMapping("/upd2")
	public void upd2(SysMenu po) 
	{
		service.upd(po);
		print("1");
	}

	@RequestMapping("/getById")
	public String getById() 
	{
		put("po", service.getById(req.getLong("id")));
		put("queryParams", req.getParameterValueMap(false, true));
		return "/admin/sysmenu/getById.jsp";
	}

	@RequestMapping("/get")
	public String get() 
	{
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysmenu/get.jsp";
	}
	
	@RequestMapping("/getJson")
	public void getJson()
	{
		Map<String, Object> m = req.getParameterValueMap(false, true);
		result.put("total", service.getCount(m));
		result.put("rows", service.get(m));
		printJson(result.getData());
	}
	
	@RequestMapping("/getMenuTreeNodes")
	public void getMenuTreeNodes()
	{
		List<Object> treeNodes = new ArrayList<Object>();
		if(req.getLong("id")!=0)
		{// 所有菜单，且标记已选菜单
			SysMenu selectedMenuObj = service.getById(req.getLong("id"));
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
	
	@RequestMapping("/getPermitTreeNodes")
	public void getPermitTreeNodes()
	{
		List<Object> treeNodes = new ArrayList<Object>();
		if(req.getLong("id")!=0)
		{// 所有权限，且标记已选权限
			SysPermit selectedPermitObj = permitService.getById(req.getLong("id"));
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
	
	@RequestMapping("/getPermitTreeNodesByMenu")
	public void getPermitTreeNodesByMenu()
	{
		SysMenu po = service.getById(req.getLong("id"));
		
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