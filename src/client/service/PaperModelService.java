package client.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import client.dao.PaperModelDao;
import client.entity.PaperModel;
import rex.devwork.BaseDao;
import rex.devwork.BaseService;

@Service("clientPaperModelService")
public class PaperModelService extends BaseService<PaperModel,Long>
{
	@Autowired
	private PaperModelDao paperModelDao;

	@Override
	public BaseDao<PaperModel,Long> getEntityDao() 
	{
		return paperModelDao;
	}
	
	public List getMapJoinCategoryPage(Map m)
	{
		return paperModelDao.getMapJoinCategoryPage(m);
	}
}
