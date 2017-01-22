package auth.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import com.google.gson.Gson;

import admin.entity.SysUser;
import auth.action.AuthAction;
import factory.SysFactory;

public class AuthPermitActionFilter implements Filter 
{
	@Override
	public void init(FilterConfig filterConfig) throws ServletException 
	{
		try
		{
		}
		catch(Exception e)
		{
		}
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
	{
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(req);
		HttpServletResponseWrapper responseWraper = new HttpServletResponseWrapper(res);
		try
		{
			SysUser u = (SysUser) req.getSession().getAttribute(AuthAction.SessionName_CurLoginUser);
			// 校验用户action权限
			if (!checkUserActionPermit(req, res, u))
			{
				res.sendRedirect(req.getContextPath() + "/permitError.jsp");
				return;
			}
			chain.doFilter(requestWrapper, responseWraper);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	@Override
	public void destroy() 
	{
	}
	
	/**
	 * 校验用户action权限
	 * @param req
	 * @param res
	 * @param u
	 * @return
	 */
	public boolean checkUserActionPermit(HttpServletRequest req, HttpServletResponse res, SysUser u)
	{
		boolean v = false;
		String actionURL = req.getRequestURI().substring(req.getContextPath().length());
		System.out.println("user id -> "+u.getLong("id"));
		System.out.println("action's url -> "+actionURL);
		if (actionURL.equals("/index.jsp") || u.getString("tc_code").equals("root"))
		{
			v = true;
		}
		else
		{
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("tc_sys_user_id", u.getLong("id"));
			m.put("tc_url", actionURL);
			int count = SysFactory.getSysPermitService().getCountByUserIdAndActionUrl(m);
			if (count > 0) v = true;
		}
		return v;
	}
}
