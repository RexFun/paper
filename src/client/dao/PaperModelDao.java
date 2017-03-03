package client.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import chok.devwork.BaseDao;
import client.entity.PaperModel;

@Repository("clientPaperModelDao")
public class PaperModelDao extends BaseDao<PaperModel,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperModel.class;
	}
	
	public List getMapJoinCategoryPage(Map m)
	{
		List result = this.getSqlSession().selectList(getStatementName("getMapJoinCategory"), m);
		return result;
	}
}
