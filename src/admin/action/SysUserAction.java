package admin.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.entity.SysRole;
import admin.entity.SysUser;
import admin.service.SysRoleService;
import admin.service.SysUserService;
import chok.devwork.BaseController;
import chok.util.CollectionUtil;
import chok.util.EncryptionUtil;

@Scope("prototype")
@Controller
@RequestMapping("/admin/sysuser")
public class SysUserAction extends BaseController<SysUser>
{
	@Autowired
	private SysUserService service;
	@Autowired
	private SysRoleService roleService;
	
	@RequestMapping("/add1")
	public String add1() 
	{
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysuser/add.jsp";
	}
	@RequestMapping("/add2")
	public void add2(SysUser po) 
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
		return "/admin/sysuser/upd.jsp";
	}
	@RequestMapping("/upd2")
	public void upd2(SysUser po) 
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
	
	@RequestMapping("/updPwd1")
	public String updPwd1() 
	{
		put("po",service.getById(req.getLong("id")));
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysuser/updPwd.jsp";
	}
	@RequestMapping("/updPwd2")
	public void updPwd2() 
	{
		try 
		{
			SysUser po = service.getById(req.getLong("id"));
			if(!EncryptionUtil.getMD5(req.getString("old_password")).equals(po.getString("tc_password")))
			{
				result.setSuccess(false);
				result.setMsg("原密码不正确");
			}
			else
			{
				po.set("tc_password", EncryptionUtil.getMD5(req.getString("new_password")));
				service.updPwd(po);
				result.setSuccess(true);
			}
		}
		catch (Exception e)
		{
			result.setSuccess(false);
			result.setMsg(e.getMessage());
		}
		printJson(result);
	}

	@RequestMapping("/getById")
	public String getById() 
	{
		put("po",service.getById(req.getLong("id")));
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysuser/getById.jsp";
	}
	
	@RequestMapping("/getMyInfo")
	public String getMyInfo() 
	{
		put("po",service.getById(req.getLong("id")));
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysuser/getMyInfo.jsp";
	}

	@RequestMapping("/get")
	public String get() 
	{
		put("queryParams",req.getParameterValueMap(false, true));
		return "/admin/sysuser/get.jsp";
	}
	
	@RequestMapping("/getJson")
	public void getJson()
	{
		Map m = req.getParameterValueMap(false, true);
		result.put("total",service.getCount(m));
		result.put("rows",service.get(m));
		printJson(result.getData());
	}
	
	@RequestMapping("/getRoleTreeNodes")
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
	
	@RequestMapping("/getRoleTreeNodesByUser")
	public void getRoleTreeNodesByUser()
	{
		Map m = new HashMap();
		m.put("tc_sys_user_id", req.getLong("id"));
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