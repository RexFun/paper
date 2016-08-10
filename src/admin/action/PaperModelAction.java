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

import admin.entity.PaperModel;
import admin.service.PaperCategoryService;
import admin.service.PaperModelService;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/admin/papermodel")
public class PaperModelAction extends BaseAction<PaperModel>
{
	@Autowired
	private PaperModelService service;
	@Autowired
	private PaperCategoryService catService;
	//实体类
	private PaperModel po;
	public PaperModel getPo() {return po;}
	public void setPo(PaperModel po) {this.po = po;}
	
	@Action(value = "add1", results={@Result(name = "success", location = "/view/admin/papermodel/add.jsp")})
	public String add1() 
	{
		getResult().put("catList", catService.get(null));
		return "success";
	}
	@Action(value = "add2")
	public void add2() 
	{
		service.add(po);
		print("1");
	}
	
	@Action(value="del")
	public void del()
	{
		try{
			service.del(CollectionUtil.toLongArray(getReq().getLongArray("id[]", 0l)));
			getResult().setSuccess(true);
		}catch(Exception e){
			getResult().setSuccess(false);
			getResult().setMsg(e.getMessage());
		}
		printJson(getResult());
	}
	
	@Action(value="upd1",results={@Result(name = "success", location = "/view/admin/papermodel/upd.jsp")})
	public String upd1() 
	{
		po = service.getById(getReq().getLong("id"));
		getResult().put("catList", catService.get(null));
		return "success";
	}
	@Action(value="upd2")
	public void upd2() 
	{
		service.upd(po);
		print("1");
	}

	@Action(value="getById",results={@Result(name = "success", location = "/view/admin/papermodel/getById.jsp")})
	public String getById() 
	{
		po = service.getById(getReq().getLong("id"));
		return "success";
	}

	@Action(value="get", results={@Result(name = "success", location = "/view/admin/papermodel/get.jsp")})
	public String get() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		m.put("page", getReq().getInt("page", 1));
		m.put("pageSize", getReq().getInt("pageSize", 10));
		
		page = service.getPage(5, m);
		pageNav = new PageNav<PaperModel>(getReq(), page);
		
		getResult().put("pid", m.get("pid"));
		getResult().put("catList", catService.get(null));
		getResult().put("resultList", pageNav.getResult());
		return "success";
	}
	
	@Action(value="getJson")
	public void getJson()
	{
		Map m = getReq().getParameterValueMap(false, true);
		m.put("rownum", Integer.parseInt(m.get("offset").toString()));
		m.put("pagesize", Integer.parseInt(m.get("limit").toString()));
		getResult().put("total",service.getCount(m));
		getResult().put("rows",service.get(m));
		printJson(getResult().getData());
	}
}