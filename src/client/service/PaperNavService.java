package client.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import chok.devwork.BaseDao;
import chok.devwork.BaseService;
import client.dao.PaperCategoryDao;
import client.entity.PaperCategory;

@Service("paperNavService")
public class PaperNavService extends BaseService<PaperCategory,Long>
{
	@Autowired
	private PaperCategoryDao paperCategoryDao;

	@Override
	public BaseDao<PaperCategory,Long> getEntityDao() {
		return paperCategoryDao;
	}
	
	public String getNavDataJson(Map m) 
	{
		List<Map<String,String>> list = paperCategoryDao.getNavDataJson(m);
		Gson gson = new Gson();  
		return gson.toJson(list);
	}
}
