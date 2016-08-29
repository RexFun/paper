package admin.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.PaperImageDao;
import admin.dao.PaperModelDao;
import admin.entity.PaperImage;
import admin.entity.PaperModel;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;
import gwen.util.PropertiesUtil;

@Service("paperModelService")
public class PaperModelService extends BaseService<PaperModel,Long>
{
	@Autowired
	private PaperModelDao paperModelDao;
	@Autowired
	private PaperImageDao imgDao;

	@Override
	public BaseDao<PaperModel,Long> getEntityDao() 
	{
		return paperModelDao;
	}
	
	public void delBatch(Long[] ids) throws IOException
	{
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("pids", ids);
		List<PaperImage> paperImages = imgDao.get(m);
		if (paperImages.size() == 0) return;
		// 批量物理删除图片文件
		for(PaperImage po : paperImages)
		{
			File f = new File(PropertiesUtil.getImageUploadPath()+po.getString("url"));
			if(f.exists()) FileUtils.forceDelete(f);
		}
		// 删除图片数据库记录
		imgDao.delByPids(ids);
		// 删除模型
		super.del(ids);
	}
}
