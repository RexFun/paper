package admin.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.entity.SysPermit;
import admin.entity.SysRole;
import admin.service.SysPermitService;
import admin.service.SysRoleService;
import chok.devwork.BaseController;
import chok.util.CollectionUtil;


@Scope("prototype")
@Controller
@RequestMapping("/admin/sysrole")
public class SysRoleAction extends BaseController<SysRole>
{
	@Autowired
	private SysRoleService service;
	@Autowired
	private SysPermitService permitService;
	
	@RequestMapping("/add1")
	public String add1() 
	{
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysrole/add.jsp";
	}
	@RequestMapping("/add2")
	public void add2(SysRole po) 
	{
		try
		{
			service.add(po);
			print("1");
	
		}
		catch(Exception e)
		{
			e.printStackTrace();
			print("0:" + e.getMessage());
		}
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
		put("po",service.getById(req.getLong("id")));
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysrole/upd.jsp";
	}
	@RequestMapping("/upd2")
	public void upd2(SysRole po) 
	{
		try
		{
			service.upd(po);
			print("1");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			print("0:" + e.getMessage());
		}
	}

	@RequestMapping("/getById")
	public String getById() 
	{
		put("po",service.getById(req.getLong("id")));
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysrole/getById.jsp";
	}

	@RequestMapping("/get")
	public String get() 
	{
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysrole/get.jsp";
	}
	
	@RequestMapping("getJson")
	public void getJson()
	{
		Map m = req.getParameterValueMap(false, true);
		result.put("total",service.getCount(m));
		result.put("rows",service.get(m));
		printJson(result.getData());
	}
	
	@RequestMapping("/getPermitTreeNodes")
	public void getPermitTreeNodes()
	{
		List<SysPermit> resultData = permitService.get(null);
		List<Object> treeNodes = new ArrayList<Object>();
		for(SysPermit o : resultData)
		{
			treeNodes.add(o.getM());
		}
		printJson(treeNodes);
	}
	
	@RequestMapping("/getPermitTreeNodesByRole")
	public void getPermitTreeNodesByRole()
	{
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("tc_sys_role_id", req.getLong("id"));
		List<SysPermit> rolePermitData = permitService.getByRoleId(m);
		List<SysPermit> permitData = permitService.get(null);
		List<Object> treeNodes = new ArrayList<Object>();
		
		for(int i=0; i<permitData.size(); i++)
		{
			SysPermit o = permitData.get(i);
			for(int j=0; j<rolePermitData.size(); j++)
			{
				SysPermit o1 = rolePermitData.get(j);
				if(o.getLong("id") == o1.getLong("id"))
				{
					o.set("checked", true);
				}
			}
			treeNodes.add(o.getM());
		}
		printJson(treeNodes);
	}
}