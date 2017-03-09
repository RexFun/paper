package auth.filter;

import java.io.IOException;

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

public class AuthPermitMenuFilter implements Filter 
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
			// 每次action都去更新当前菜单权限id，用于设置当前用户按钮权限
			if(req.getParameter("menuPermitId") != null)
			{
				req.getSession().setAttribute("CUR_MENU_PERMIT_ID", req.getParameter("menuPermitId"));
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
}
