package auth;

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

import admin.SysFactory;
import admin.entity.SysUser;
import auth.action.AuthAction;

public class AuthFilter implements Filter 
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
		System.out.println("AuthFilter initialization");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
	{
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpServletRequestWrapper requestWrapper = new HttpServletRequestWrapper(req);
		HttpServletResponseWrapper responseWraper = new HttpServletResponseWrapper(res);
		//String currentUrl = req.getRequestURI().replaceAll(req.getContextPath(), "");// 取得当前路径
		try
		{
			SysUser u = (SysUser) req.getSession().getAttribute(AuthAction.SessionName_CurLoginUser);
			// 没有登录
			if (u == null || u.getString("tc_code") == null)
			{
				res.sendRedirect(req.getContextPath() + "/login.jsp");
				return;
			}
			// 校验用户action权限
			if (!checkUserActionPermit(req, res, u))
			{
				res.sendRedirect(req.getContextPath() + "/permitError.jsp");
				return;
			}
			// 每次action都去更新当前菜单权限id
			if(req.getParameter("menuPermitId") != null)
			{
				req.getSession().setAttribute("CUR_MENU_PERMIT_ID", req.getParameter("menuPermitId"));
			}
			chain.doFilter(requestWrapper, responseWraper);
		}
		catch(Exception e)
		{
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
