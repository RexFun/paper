package admin.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import admin.entity.PaperImage;
import admin.service.PaperImageService;
import admin.service.PaperModelService;
import chok.devwork.BaseController;
import chok.devwork.Page;
import chok.devwork.PageNav;
import chok.util.CollectionUtil;
import chok.util.PropertiesUtil;
import chok.util.UniqueId;

@Scope("prototype")
@Controller
@RequestMapping("/admin/paperimage")
public class PaperImageAction extends BaseController<PaperImage>
{
	@Autowired
	private PaperImageService service;
	@Autowired
	private PaperModelService modelService;
	
	@RequestMapping("/add1")
	public String add1() 
	{
		put("pid",req.getLong("pid"));
		put("ppid",req.getLong("ppid"));
		put("modelName", modelService.getById(req.getLong("pid")).get("name"));
		return "/admin/paperimage/add.jsp";
	}
	@RequestMapping("/add2")
	public void add2(@RequestParam("myFile") CommonsMultipartFile files[]) throws Exception
	{
		List<PaperImage> poList = new ArrayList<PaperImage>();
		for(int i=0; i<files.length; i++){
			String __imgName = UniqueId.genGuid();
			//保存到硬盘
			File srcFile = ((DiskFileItem)files[i].getFileItem()).getStoreLocation();
			File destFile = new File(PropertiesUtil.getImageUploadPath(), __imgName);
			FileUtils.copyFile(srcFile, destFile);
			//保存到db
			PaperImage po = new PaperImage();
			po.set("pid", req.getLong("pid"));
			po.set("url", __imgName);
			poList.add(po);
		}
		service.addBatch(poList);
		print("1");
	}
	
	@RequestMapping("/updSortById")
	public void updSortById() 
	{
		try
		{
			long id = req.getLong("id");
			int sort = req.getInt("sort", 0);
			PaperImage po = new PaperImage();
			po.set("id",id);
			po.set("sort",sort);
			service.updSortById(po);
			print("1");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			print("0:" + e.getMessage());
		}
	}
	
	@RequestMapping("/updSortBatch")
	public void updSortBatch() 
	{
		try
		{
			service.updSortBatch(CollectionUtil.toLongArray(req.getLongArray("id", 0l)), 
								 CollectionUtil.toIntegerArray(req.getIntArray("sort", 0)));
			print("1");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			print("0:" + e.getMessage());
		}
	}
	
	@RequestMapping("/del")
	public void del() 
	{
		try
		{
			service.delBatch(CollectionUtil.toLongArray(req.getLongArray("keyIndex", 0l)));
			print("1");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			print("0:" + e.getMessage());
		}
	}

	@RequestMapping("/getById")
	public String getById() 
	{
		PaperImage po = service.getById(req.getLong("id"));
		put("po", po);
		put("modelName", modelService.getById(po.getLong("pid")).get("name"));
		return "/admin/paperimage/getById.jsp";
	}

	@RequestMapping("/get")
	public String get() 
	{
		Map<String, Object> m = req.getParameterValueMap(false, true);
		Page<PaperImage>page = service.getPage(5, m);
		PageNav<PaperImage> pageNav = new PageNav<PaperImage>(req, page, "5,10,20");
		put("pid", req.getLong("pid"));
		put("ppid", req.getLong("ppid"));
		put("modelName", modelService.getById(req.getLong("pid")).get("name"));
		put("queryParams", req.getParameterValueMap(false, true));
		put("page", page);
		put("pageNav", pageNav);
		put("resultList", pageNav.getResult());
		return "/admin/paperimage/get.jsp";
	}
}