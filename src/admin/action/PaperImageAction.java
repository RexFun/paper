package admin.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.InterceptorRef;
import org.apache.struts2.convention.annotation.InterceptorRefs;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import admin.entity.PaperImage;
import admin.service.PaperImageService;
import admin.service.PaperModelService;
import rex.devwork.BaseAction;
import rex.devwork.PageNav;
import rex.util.CollectionUtil;
import rex.util.PropertiesUtil;
import rex.util.UniqueId;


@SuppressWarnings("serial")
@Controller
@Scope("prototype")
@ParentPackage(value="struts-default")
@Namespace("/admin/paperimage")
@InterceptorRefs(value = { @InterceptorRef("fileUploadStack") })
public class PaperImageAction extends BaseAction<PaperImage>
{
	@Autowired
	private PaperImageService service;
	@Autowired
	private PaperModelService modelService;
	//Model
	private PaperImage po;
	public PaperImage getPaperImage() { return po; }
	public void setPaperImage(PaperImage po) { this.po = po; }
	
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
	
	@Action(value="add1",results={ @Result(name = "success", location = "/WEB-INF/view/admin/paperimage/add.jsp")})
	public String add1() 
	{
		put("pid",getReq().getLong("pid"));
		put("ppid",getReq().getLong("ppid"));
		put("modelName", modelService.getById(getReq().getLong("pid")).get("name"));
		return "success";
	}
	@Action(value="add2")
	public void add2() throws Exception
	{
		List<PaperImage> poList = new ArrayList<PaperImage>();
		for(int i=0; i<myFile.size(); i++){
			String __imgName = UniqueId.genGuid();
			//保存到硬盘
			FileUtils.copyFile(myFile.get(i), new File(PropertiesUtil.getImageUploadPath(), __imgName));
			//保存到db
			po = new PaperImage();
			po.set("pid", getReq().getLong("pid"));
			po.set("url", __imgName);
			poList.add(po);
		}
		service.addBatch(poList);
		print("1");
	}
	
	@Action(value="updSortById")
	public void updSortById() 
	{
		long id = getReq().getLong("id");
		int sort = getReq().getInt("sort", 0);
		po = new PaperImage();
		po.set("id",id);
		po.set("sort",sort);
		service.updSortById(po);
		print("1");
	}
	
	@Action(value="updSortBatch")
	public void updSortBatch() 
	{
		service.updSortBatch(CollectionUtil.toLongArray(getReq().getLongArray("id", 0l)), 
							 CollectionUtil.toIntegerArray(getReq().getIntArray("sort", 0)));
		print("1");
	}
	
	@Action(value="del")
	public void del() 
	{
		service.delBatch(CollectionUtil.toLongArray(getReq().getLongArray("keyIndex", 0l)));
		print("1");
	}

	@Action(value="getById",results={ @Result(name = "success", location = "/WEB-INF/view/admin/paperimage/getById.jsp")})
	public String getById() 
	{
		po = service.getById(getReq().getLong("id"));
		put("po",po);
		put("ppid",getReq().getLong("ppid"));
		put("modelName", modelService.getById(po.getLong("pid")).get("name"));
		return "success";
	}

	@Action(value="get",results={ @Result(name = "success", location = "/WEB-INF/view/admin/paperimage/get.jsp")})
	public String get() 
	{
		setQueryParams(getReq().getParameterValueMap(false, true));
		Map<String, Object> m = getReq().getParameterValueMap(false, true);
		page = service.getPage(5, m);
		pageNav = new PageNav<PaperImage>(getReq(), page, "5,10,20");
		put("pid", getReq().getLong("pid"));
		put("ppid", getReq().getLong("ppid"));
		put("modelName", modelService.getById(getReq().getLong("pid")).get("name"));
		getResult().put("resultList", pageNav.getResult());
		return "success";
	}
}