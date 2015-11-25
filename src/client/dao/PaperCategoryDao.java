package client.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import client.entity.PaperCategory;
import gwen.devwork.BaseDao;

@Repository("clientPaperCategoryDao")
public class PaperCategoryDao extends BaseDao<PaperCategory,Long>
{
	@Override
	public Class<PaperCategory> getEntityClass()
	{
		return PaperCategory.class;
	}
	
	public List<Map<String, String>> getNavDataJson(Map m) 
	{
		return this.getSqlSession().selectList(getStatementName("getMap"), m);
	}
}
