package client.action;

import gwen.devwork.BaseAction;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;

import client.service.PaperModelService;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/client/papermodel")
//@InterceptorRefs(value={ @InterceptorRef("myStack") })
public class ClientPaperModelAction extends BaseAction<Map<String,String>>
{
	@Autowired
	private PaperModelService service;

	@Action(value="getByPid")
	public void getByPid() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		resultList = service.getMapList(m);
		print(new Gson().toJson(resultList));
		System.out.println(new Gson().toJson(resultList));
	}
}