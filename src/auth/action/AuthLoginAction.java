package auth.action;

import gwen.devwork.BaseAction;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import auth.Auth;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/auth")
public class AuthLoginAction extends BaseAction<Auth> 
{
	public static final String SessionName_LoginUser = "COMMON_LOGIN_USER";
	
	private Auth user;
	public Auth getUser() 
	{
		return user;
	}
	public void setUser(Auth user) 
	{
		this.user = user;
	}

	@Action(value = "login")
	public void login()
	{
		try 
		{
			if (user.getAccount().equals("admin") && user.getPassword().equals("52@linyanfun")) 
			{
				getSession().setAttribute(SessionName_LoginUser, user);
				getResultData().setSuccess(true);
			}
			else 
			{
				getResultData().setSuccess(false);
				getResultData().setMsg("账号或密码错误");
			}
		}
		catch (Exception e)
		{
			getResultData().setSuccess(false);
			getResultData().setMsg(e.getMessage());
		}
		returnJSON(getResultData());
	}
}