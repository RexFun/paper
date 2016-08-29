package admin.dao;

import gwen.devwork.BaseDao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import admin.entity.PaperModel;

@Repository("paperModelDao")
public class PaperModelDao extends BaseDao<PaperModel,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperModel.class;
	}
	
	public void delByPids(Long[] pids)
	{
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("pids", pids);
		this.getSqlSession().update(getStatementName("delByPids"), m);
	}
}
