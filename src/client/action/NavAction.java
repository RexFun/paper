package client.action;

import java.util.Map;

import gwen.devwork.BaseAction;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import client.entity.PaperCategory;
import client.service.PaperNavService;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/client/nav")
public class NavAction extends BaseAction<PaperCategory>
{
	@Autowired
	private PaperNavService paperNavService;

	@Action(value="getNav1Json")
	public void getNav1Json()
	{
		getBaseResp().setContentType("application/json");
		String result = paperNavService.getNav1Json();
		System.out.println(result);
		print(result);
	}
	
	@Action(value="getNav2Json")
	public void getNav2Json()
	{
		getBaseResp().setContentType("application/json");
		Map m = getReq().getParameterValueMap(false, true);
		String result = paperNavService.getNav2Json(m);
		System.out.println(result);
		print(result);
	}
	
	@Action(value="getNavDataJson")
	public void getNavDataJson()
	{
		getBaseResp().setContentType("application/json");
		Map m = getReq().getParameterValueMap(false, true);
		String result = paperNavService.getNavDataJson(m);
		System.out.println(result);
		print(result);
	}
	
}