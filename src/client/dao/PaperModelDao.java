package client.dao;

import gwen.devwork.BaseDao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

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
		m.put("rownum", Integer.valueOf(m.get("rownum").toString()));
		m.put("pagesize", Integer.valueOf(m.get("pagesize").toString()));
		List result = this.getSqlSession().selectList(getStatementName("getMapJoinCategory"), m);
		return result;
	}
}
