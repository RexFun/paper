package auth.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;

import admin.entity.SysUser;
import admin.service.SysMenuService;
import admin.service.SysUserService;
import auth.Auth;
import chok.devwork.BaseAction;
import chok.util.EncryptionUtil;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/auth")
public class AuthAction extends BaseAction<Auth> 
{
	@Autowired
	private SysUserService service;
	@Autowired
	private SysMenuService menuService;
	
	public static final String SessionName_CurLoginUser = "CUR_LOGIN_USER";
	
	private Auth auth;
	public Auth getAuth() 
	{
		return auth;
	}
	public void setAuth(Auth auth) 
	{
		this.auth = auth;
	}
	
	@Action(value = "login")
	public void login()
	{
		try 
		{
			Map m = new HashMap();
			m.put("login_account", auth.getAccount());
			if(service.getCount(m)<1)
			{
				getResult().setSuccess(false);
				getResult().setMsg("账号不存在");
			}
			else
			{
				SysUser u = (SysUser)service.get(m).get(0);
				if(!EncryptionUtil.getMD5(auth.getPassword()).equals(u.getString("tc_password")))
				{
					getResult().setSuccess(false);
					getResult().setMsg("密码不正确");
				}
				else
				{
					// 初始化菜单权限
					u.set("menu_permit_json", new Gson().toJson(menuService.getAll()));
					// 初始化按钮权限
					u.set("btn_permit_json","null");
					// session保存登录用户对象
					getSession().setAttribute(SessionName_CurLoginUser, u);
					// 返回结果
					getResult().setSuccess(true);
				}
			}
		}
		catch (Exception e)
		{
			getResult().setSuccess(false);
			getResult().setMsg(e.getMessage());
		}
		printJson(getResult());
	}
	
	@Action(value="logout", results={@Result(name = "success", location = "/login.jsp")})
	public String logout()
	{
		getSession().removeAttribute(SessionName_CurLoginUser);
		return SUCCESS;
	}
	
	@Action(value="getNavMenu")
	public void getNavMenu()
	{
		Map m = new HashMap();
		m.put("tc_name",getReq().getString("menuName"));
		m.put("tc_sys_user_id", ((SysUser)getSession().getAttribute(SessionName_CurLoginUser)).getLong("id"));
		getResult().put("navMenuTreeNodes", new Gson().toJson(menuService.getByUserId(m)));
		getResult().setSuccess(true);
		printJson(getResult());
	}
}