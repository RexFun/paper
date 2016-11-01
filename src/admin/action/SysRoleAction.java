package admin.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import admin.entity.SysPermit;
import admin.entity.SysRole;
import admin.service.SysPermitService;
import admin.service.SysRolePermitMappingService;
import admin.service.SysRoleService;
import gwen.devwork.BaseAction;
import gwen.devwork.PageNav;
import gwen.util.CollectionUtil;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/admin/sysrole")
public class SysRoleAction extends BaseAction<SysRole>
{
	@Autowired
	private SysRoleService service;
	@Autowired
	private SysPermitService permitService;
	@Autowired
	private SysRolePermitMappingService sysRolePermitMappingService;
	
	//实体类
	private SysRole po;
	public SysRole getPo() {return po;}
	public void setPo(SysRole po) {this.po = po;}
	
	@Action(value="add1",results={ @Result(name = "success", location = "/view/admin/sysrole/add.jsp")})
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
	
	@Action(value="upd1",results={ @Result(name = "success", location = "/view/admin/sysrole/upd.jsp")})
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

	@Action(value="getById",results={ @Result(name = "success", location = "/view/admin/sysrole/getById.jsp")})
	public String getById() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}

	@Action(value="get",results={ @Result(name = "success", location = "/view/admin/sysrole/get.jsp")})
	public String get() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		m.put("page", getReq().getInt("page", 1));
		m.put("pageSize", getReq().getInt("pageSize", 5));
		
		page = service.getPage(5, m);
		pageNav = new PageNav<SysRole>(getReq(), page, "5,10,20");
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
	
	@Action(value="getPermitTreeNodes")
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
	
	@Action(value="getPermitTreeNodesByRole")
	public void getPermitTreeNodesByRole()
	{
		Map m = new HashMap();
		m.put("tc_sys_role_id", getReq().getLong("id"));
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