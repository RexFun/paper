package admin.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.entity.SysPermit;
import admin.service.SysPermitService;
import chok.devwork.BaseController;
import chok.util.CollectionUtil;


@Scope("prototype")
@Controller
@RequestMapping("/admin/syspermit")
public class SysPermitAction extends BaseController<SysPermit>
{
	@Autowired
	private SysPermitService service;
	
	@RequestMapping("/add1")
	public String add1() 
	{
		put("queryParams", req.getParameterValueMap(false, true));
		return "/admin/syspermit/add.jsp";
	}
	@RequestMapping("/add2")
	public void add2(SysPermit po) 
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
		return "/admin/syspermit/upd.jsp";
	}
	@RequestMapping("/upd2")
	public void upd2(SysPermit po) 
	{
		service.upd(po);
		print("1");
	}

	@RequestMapping("/getById")
	public String getById() 
	{
		put("po", service.getById(req.getLong("id")));
		put("queryParams", req.getParameterValueMap(false, true));
		return "/admin/syspermit/getById.jsp";
	}

	@RequestMapping("/get")
	public String get() 
	{
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/syspermit/get.jsp";
	}
	
	@RequestMapping("/getJson")
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
		List<Object> treeNodes = new ArrayList<Object>();
		if(req.getLong("id")!=0)
		{// 所有权限，且标记已选权限
			SysPermit selectedPermitObj = service.getById(req.getLong("id"));
			List<SysPermit> permitData = service.get(null);
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
			List<SysPermit> permitData = service.get(null);
			for(int i=0; i<permitData.size(); i++)
			{
				SysPermit o = permitData.get(i);
				treeNodes.add(o.getM());
			}
		}
		printJson(treeNodes);
	}
}