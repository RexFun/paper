package admin.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	//上传文件file属性（多个）
	private List<File> myFile;
	public List<File> getMyFile() { return myFile; }
	public void setMyFile(List<File> myFile) { this.myFile = myFile; }
	//封装上传文件名的属性 （包含后缀名，如：hello.jpg）
	private List<String> myFileFileName;
	public List<String> getMyFileFileName() { return myFileFileName; }
	public void setMyFileFileName(List<String> myFileFileName) { this.myFileFileName = myFileFileName; }
    //封装上传文件类型的属性  （如：image/jpeg）
    private List<String> myFileContentType;
    public List<String> getMyFileContentType() { return myFileContentType; }
	public void setMyFileContentType(List<String> myFileContentType) { this.myFileContentType = myFileContentType; }
	
	@RequestMapping("/add1")
	public String add1() 
	{
		put("pid",req.getLong("pid"));
		put("ppid",req.getLong("ppid"));
		put("modelName", modelService.getById(req.getLong("pid")).get("name"));
		return "/admin/paperimage/add.jsp";
	}
	@RequestMapping("/add2")
	public void add2() throws Exception
	{
		List<PaperImage> poList = new ArrayList<PaperImage>();
		for(int i=0; i<myFile.size(); i++){
			String __imgName = UniqueId.genGuid();
			//保存到硬盘
			FileUtils.copyFile(myFile.get(i), new File(PropertiesUtil.getImageUploadPath(), __imgName));
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
		long id = req.getLong("id");
		int sort = req.getInt("sort", 0);
		PaperImage po = new PaperImage();
		po.set("id",id);
		po.set("sort",sort);
		service.updSortById(po);
		print("1");
	}
	
	@RequestMapping("/updSortBatch")
	public void updSortBatch() 
	{
		service.updSortBatch(CollectionUtil.toLongArray(req.getLongArray("id", 0l)), 
							 CollectionUtil.toIntegerArray(req.getIntArray("sort", 0)));
		print("1");
	}
	
	@RequestMapping("/del")
	public void del() 
	{
		service.delBatch(CollectionUtil.toLongArray(req.getLongArray("keyIndex", 0l)));
		print("1");
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