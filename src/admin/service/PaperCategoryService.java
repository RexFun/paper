package admin.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.PaperCategoryDao;
import admin.dao.PaperImageDao;
import admin.dao.PaperModelDao;
import admin.entity.PaperCategory;
import admin.entity.PaperImage;
import admin.entity.PaperModel;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;
import gwen.util.PropertiesUtil;

@Service("paperCategoryService")
public class PaperCategoryService extends BaseService<PaperCategory,Long>
{
	@Autowired
	private PaperCategoryDao paperCategoryDao;
	@Autowired
	private PaperModelDao paperModelDao;
	@Autowired
	private PaperImageDao paperImageDao;

	@Override
	public BaseDao<PaperCategory,Long> getEntityDao() 
	{
		return paperCategoryDao;
	}
	
	public void delBatch(Long[] ids) throws IOException
	{
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("pids", ids);
		// 获取model id列表
		List<PaperModel> paperModels = paperModelDao.get(m);
		Long[] paperModelIds = new Long[paperModels.size()];
		for(int i=0; i<paperModels.size(); i++)
		{
			paperModelIds[i] = paperModels.get(i).getLong("id");
		}
		// 获取image列表
		m.put("pids", paperModelIds);
		List<PaperImage> paperImages = paperImageDao.get(m);
		// 批量物理删除图片文件
		for(PaperImage pi : paperImages)
		{
			File f = new File(PropertiesUtil.getImageUploadPath()+pi.getString("url"));
			if(f.exists()) FileUtils.forceDelete(f);
		}
		// 删除图片数据库记录
		paperImageDao.delByPids(paperModelIds);
		// 删除模型
		paperModelDao.delByPids(ids);
		// 删除类别
		super.del(ids);
	}
}
