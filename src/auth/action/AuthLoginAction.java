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
import gwen.devwork.BaseAction;
import gwen.util.EncryptionUtil;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/auth")
public class AuthLoginAction extends BaseAction<Auth> 
{
	@Autowired
	private SysUserService service;
	@Autowired
	private SysMenuService menuService;
	
	public static final String SessionName_LoginUser = "COMMON_LOGIN_USER";
	public static final String SessionName_UserMenuTreeNodes = "COMMON_USER_MENU_TREE_NODES";
	
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
				System.out.println("inputpwd:"+auth.getPassword());
				System.out.println("userpwd:"+u.getString("tc_password"));
				if(!EncryptionUtil.getMD5(auth.getPassword()).equals(u.getString("tc_password")))
				{
					getResult().setSuccess(false);
					getResult().setMsg("密码不正确");
				}
				else
				{
					getSession().setAttribute(SessionName_LoginUser, u);
					getSession().setAttribute(SessionName_UserMenuTreeNodes, new Gson().toJson(menuService.getByUserId(u.getLong("id"))));
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
		getSession().removeAttribute(SessionName_LoginUser);
		return SUCCESS;
	}
}