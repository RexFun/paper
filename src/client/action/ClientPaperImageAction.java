package client.action;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;

import client.entity.PaperImage;
import client.entity.PaperImage1;
import client.service.PaperImage1Service;
import client.service.PaperImageService;
import rex.devwork.BaseAction;
import rex.util.PropertiesUtil;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/client/paperimage")
public class ClientPaperImageAction extends BaseAction<PaperImage>
{
	@Autowired
	private PaperImageService service;
	@Autowired
	private PaperImage1Service service1;
	//Model
	private PaperImage po;
	public PaperImage getPaperImage() { return po; }
	public void setPaperImage(PaperImage po) { this.po = po; }
	private PaperImage1 po1;
	public PaperImage1 getPaperImage1() { return po1; }
	public void setPaperImage1(PaperImage1 po1) { this.po1 = po1; }
	
	@Action(value="getPageByPid")
	public void getPageByPid() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		List<Map<String,String>> resultList = service.getMapPage(m);
		print(new Gson().toJson(resultList));
		System.out.println(new Gson().toJson(resultList));
	}
	
	@Action(value="getListByPid")
	public void getListByPid() 
	{
		Map m = getReq().getParameterValueMap(false, true);
		List<Map<String,String>> resultList = service.getMap(m);
		print(new Gson().toJson(resultList));
		System.out.println(new Gson().toJson(resultList));
	}
}