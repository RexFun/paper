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

import com.google.gson.Gson;

import admin.entity.SysRole;
import admin.entity.SysUser;
import admin.service.SysRoleService;
import admin.service.SysUserService;
import gwen.devwork.BaseAction;
import gwen.devwork.PageNav;
import gwen.util.CollectionUtil;
import gwen.util.EncryptionUtil;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/admin/sysuser")
public class SysUserAction extends BaseAction<SysUser>
{
	@Autowired
	private SysUserService service;
	@Autowired
	private SysRoleService roleService;
	
	//实体类
	private SysUser po;
	public SysUser getPo() {return po;}
	public void setPo(SysUser po) {this.po = po;}
	
	@Action(value="add1",results={ @Result(name = "success", location = "/view/admin/sysuser/add.jsp")})
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
	
	@Action(value="upd1",results={ @Result(name = "success", location = "/view/admin/sysuser/upd.jsp")})
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
	
	@Action(value="updPwd1",results={ @Result(name = "success", location = "/view/admin/sysuser/updPwd.jsp")})
	public String updPwd1() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}
	@Action(value="updPwd2")
	public void updPwd2() 
	{
		try 
		{
			po = service.getById(getReq().getLong("id"));
			if(!EncryptionUtil.getMD5(getReq().getString("old_password")).equals(po.getString("tc_password")))
			{
				getResult().setSuccess(false);
				getResult().setMsg("原密码不正确");
			}
			else
			{
				po.set("tc_password", EncryptionUtil.getMD5(getReq().getString("new_password")));
				service.updPwd(po);
				getResult().setSuccess(true);
			}
		}
		catch (Exception e)
		{
			getResult().setSuccess(false);
			getResult().setMsg(e.getMessage());
		}
		printJson(getResult());
	}

	@Action(value="getById",results={ @Result(name = "success", location = "/view/admin/sysuser/getById.jsp")})
	public String getById() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}
	
	@Action(value="getMyInfo",results={ @Result(name = "success", location = "/view/admin/sysuser/getMyInfo.jsp")})
	public String getMyInfo() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}

	@Action(value="get",results={ @Result(name = "success", location = "/view/admin/sysuser/get.jsp")})
	public String get() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		m.put("page", getReq().getInt("page", 1));
		m.put("pageSize", getReq().getInt("pageSize", 5));
		
		page = service.getPage(5, m);
		pageNav = new PageNav<SysUser>(getReq(), page, "5,10,20");
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
	
	@Action(value="getRoleTreeNodes")
	public void getRoleTreeNodes()
	{
		List<SysRole> resultData = roleService.get(null);
		List<Object> treeNodes = new ArrayList<Object>();
		for(SysRole o : resultData)
		{
			treeNodes.add(o.getM());
		}
		printJson(treeNodes);
	}
	
	@Action(value="getRoleTreeNodesByUser")
	public void getRoleTreeNodesByUser()
	{
		Map m = new HashMap();
		m.put("tc_sys_user_id", getReq().getLong("id"));
		List<SysRole> userRoleData = roleService.getByUserId(m);
		List<SysRole> roleData = roleService.get(null);
		List<Object> treeNodes = new ArrayList<Object>();
		
		for(int i=0; i<roleData.size(); i++)
		{
			SysRole o = roleData.get(i);
			for(int j=0; j<userRoleData.size(); j++)
			{
				SysRole o1 = userRoleData.get(j);
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