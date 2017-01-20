package client.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;

import client.entity.PaperModel;
import client.service.PaperModelService;
import rex.devwork.BaseAction;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/client/papermodel")
//@InterceptorRefs(value={ @InterceptorRef("myStack") })
public class ClientPaperModelAction extends BaseAction<PaperModel>
{
	@Autowired
	private PaperModelService service;

	@Action(value="getPageByPid")
	public void getPageByPid() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		List<Map<String,String>> resultList = service.getMapJoinCategoryPage(m);
		print(new Gson().toJson(resultList));
		System.out.println(new Gson().toJson(resultList));
	}
}