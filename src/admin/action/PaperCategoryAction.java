package admin.action;

import gwen.devwork.BaseAction;
import gwen.devwork.PageNav;
import gwen.util.CollectionUtil;

import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import admin.entity.PaperCategory;
import admin.service.PaperCategoryService;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/admin/papercategory")
public class PaperCategoryAction extends BaseAction<PaperCategory>
{
	@Autowired
	private PaperCategoryService service;
	//实体类
	private PaperCategory po;
	public PaperCategory getPo() {return po;}
	public void setPo(PaperCategory po) {this.po = po;}
	
	@Action(value="add1",results={ @Result(name = "success", location = "/WEB-INF/view/admin/papercategory/add.jsp")})
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
	
	@Action(value="upd1",results={ @Result(name = "success", location = "/WEB-INF/view/admin/papercategory/upd.jsp")})
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

	@Action(value="getById",results={ @Result(name = "success", location = "/WEB-INF/view/admin/papercategory/getById.jsp")})
	public String getById() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}

	@Action(value="get",results={ @Result(name = "success", location = "/WEB-INF/view/admin/papercategory/get.jsp")})
	public String get() 
	{
		return "success";
	}
	
	@Action(value="getJson")
	public void getJson()
	{
		Map m = getReq().getParameterValueMap(false, true);
		getResult().put("total",service.getCount(m));
		getResult().put("rows",service.get(m));
		printJson(getResult().getData());
	}
}