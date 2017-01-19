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
import admin.service.SysPermitService;
import gwen.devwork.BaseAction;
import gwen.devwork.PageNav;
import gwen.util.CollectionUtil;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/admin/syspermit")
public class SysPermitAction extends BaseAction<SysPermit>
{
	@Autowired
	private SysPermitService service;
	//实体类
	private SysPermit po;
	public SysPermit getPo() {return po;}
	public void setPo(SysPermit po) {this.po = po;}
	
	@Action(value="add1",results={ @Result(name = "success", location = "/WEB-INF/view/admin/syspermit/add.jsp")})
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
	
	@Action(value="upd1",results={ @Result(name = "success", location = "/WEB-INF/view/admin/syspermit/upd.jsp")})
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

	@Action(value="getById",results={ @Result(name = "success", location = "/WEB-INF/view/admin/syspermit/getById.jsp")})
	public String getById() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}

	@Action(value="get",results={ @Result(name = "success", location = "/WEB-INF/view/admin/syspermit/get.jsp")})
	public String get() 
	{
		return "success";
	}
	
	@Action(value="getJson")
	public void getJson()
	{
		Map m = getReq().getParameterValueMap(false, true);
		getResult().put("total",service.getCount(m));
		getResult().put("rows",service.get(m));
		printJson(getResult().getData());
	}
	
	@Action(value="getPermitTreeNodes")
	public void getPermitTreeNodes()
	{
		List<Object> treeNodes = new ArrayList<Object>();
		if(getReq().getLong("id")!=0)
		{// 所有权限，且标记已选权限
			SysPermit selectedPermitObj = service.getById(getReq().getLong("id"));
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