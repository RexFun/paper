package auth.action;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import admin.entity.SysUser;
import admin.service.SysMenuService;
import admin.service.SysUserService;
import auth.Auth;
import chok.devwork.BaseController;
import chok.util.EncryptionUtil;

@Scope("prototype")
@Controller
@RequestMapping("/auth")
public class AuthAction extends BaseController<Auth> 
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
	
	@RequestMapping("/login")
	public void login()
	{
		try 
		{
			Map m = new HashMap();
			m.put("login_account", req.getString("auth.account"));
			if(service.getCount(m)<1)
			{
				result.setSuccess(false);
				result.setMsg("账号不存在");
			}
			else
			{
				SysUser u = (SysUser)service.get(m).get(0);
				if(!EncryptionUtil.getMD5(req.getString("auth.password")).equals(u.getString("tc_password")))
				{
					result.setSuccess(false);
					result.setMsg("密码不正确");
				}
				else
				{
					// 初始化菜单权限
					m.clear();
					m.put("tc_sys_user_id", u.getLong("id"));
					u.set("menuPermitJson", new Gson().toJson(menuService.getByUserId(m)));
					// 初始化按钮权限
					u.set("btnPermitJson","null");
					// session保存登录用户对象
					session.setAttribute(SessionName_CurLoginUser, u);
					// 返回结果
					result.setSuccess(true);
				}
			}
		}
		catch (Exception e)
		{
			result.setSuccess(false);
			result.setMsg(e.getMessage());
			e.printStackTrace();
		}
		printJson(result);
	}
	
	@RequestMapping("/logout")
	public String logout()
	{
		session.removeAttribute(SessionName_CurLoginUser);
		return "redirect:/login.jsp";
	}
	
	@RequestMapping("/getNavMenu")
	public void getNavMenu()
	{
		Map m = new HashMap();
		m.put("tc_name", req.getString("menuName"));
		m.put("tc_sys_user_id", ((SysUser)session.getAttribute(SessionName_CurLoginUser)).getLong("id"));
		String menuPermitJson = new Gson().toJson(menuService.getByUserId(m));
		// 更新用户session
		SysUser u = ((SysUser)session.getAttribute(SessionName_CurLoginUser));
		u.set("menuPermitJson", menuPermitJson);
		// 返回
		result.put("menuPermitJson", menuPermitJson);
		result.setSuccess(true);
		printJson(result);
	}
}