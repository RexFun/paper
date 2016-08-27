package admin.service;

import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;
import gwen.util.CollectionUtil;
import gwen.util.PropertiesUtil;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.PaperImageDao;
import admin.entity.PaperImage;

@Service("paperImageService")
public class PaperImageService extends BaseService<PaperImage,Long>
{
	@Autowired
	private PaperImageDao dao;

	@Override
	public BaseDao<PaperImage,Long> getEntityDao() 
	{
		return dao;
	}
	
	public void addBatch(List<PaperImage> poList)
	{
		for(PaperImage po : poList)
		{
			add(po);
		}
	}
	
	public void delBatch(Long[] ids)
	{
		try 
		{
			// 删除图片文件
			for(int i=0; i<ids.length; i++)
			{
				FileUtils.forceDelete(new File(PropertiesUtil.getImageUploadPath()+dao.getById(ids[i]).getString("url")));
			}
			// 删除表记录
			super.del(ids);
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
	
	public void updSortById(PaperImage po)
	{
		dao.updSortById(po);
	}
	
	public void updSortBatch(Long[] ids, Integer[] sorts)
	{
		for(int i=0; i<ids.length; i++)
		{
			PaperImage po = new PaperImage();
			po.set("id",ids[i]);
			po.set("sort",sorts[i]);
			dao.updSortById(po);
		}
	}
}
