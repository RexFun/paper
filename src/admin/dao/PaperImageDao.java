package admin.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import admin.entity.PaperImage;
import gwen.devwork.BaseDao;

@Repository("paperImageDao")
public class PaperImageDao extends BaseDao<PaperImage,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperImage.class;
	}
	
	public void updSortById(PaperImage po)
	{
		this.getSqlSession().update(getStatementName("updSortById"), po);
	}
	
	public void delByPids(Long[] pids)
	{
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("pids", pids);
		this.getSqlSession().update(getStatementName("delByPids"), m);
	}
}
