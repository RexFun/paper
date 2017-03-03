package admin.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import admin.entity.PaperImage;
import chok.devwork.BaseDao;

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
	
	public void delByPids(Map<String, Object> m)
	{
		this.getSqlSession().update(getStatementName("delByPids"), m);
	}
}
