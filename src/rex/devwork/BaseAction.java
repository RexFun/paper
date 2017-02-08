package rex.devwork;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;


public abstract class BaseAction<T> extends ActionSupport 
{
	//持久化表单查询参数
	private Map<String,Object> queryParams;
	public Map<String,Object> getQueryParams() {return queryParams;}
	public void setQueryParams(Map<String,Object> queryParams) {this.queryParams = queryParams;}
	
	protected PrintWriter out;
	
	public HttpServletRequest getBaseReq()
	{
		return ServletActionContext.getRequest();
	}
	public HttpServletResponse getBaseResp()
	{
		ServletActionContext.getResponse().setCharacterEncoding("UTF-8");
		return ServletActionContext.getResponse();
	}
	public HttpSession getSession()
	{
		return getBaseReq().getSession();
	}
	public MyReq getReq()
	{
		return new MyReq(getBaseReq());
	}
	
	//返回值对象
	protected Result result;
	public Result getResult()
	{
		if (result == null)
		{
			result = new Result();
		}
		return result;
	}

	//返回值集合
	protected List<T> resultList;
	public List<T> getResultList() 
	{
		return resultList;
	}
	//Page对象
	protected Page<T> page;
	public Page<T> getPage() 
	{
		return page;
	}
	//PageNav对象
	protected PageNav<T> pageNav;
	public PageNav<T> getPageNav() 
	{
		return pageNav;
	}
	
	public void put(String key, Object value)
	{
		getReq().setAttribute(key, value);
	}
	
	public void print(Object o)
	{
		try
		{
			if(out == null)
			{
				out = getBaseResp().getWriter();
			}
			out.print(o);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	public void printJson(Object o)
	{
		getBaseResp().setContentType("application/json");
		try
		{
			if(out == null)
			{
				out = getBaseResp().getWriter();
			}
			out.print(new Gson().toJson(o));
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
}
