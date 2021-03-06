package admin.dao;

import org.springframework.stereotype.Repository;

import admin.entity.PaperModel;
import chok.devwork.BaseDao;

@Repository("paperModelDao")
public class PaperModelDao extends BaseDao<PaperModel,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperModel.class;
	}
}
