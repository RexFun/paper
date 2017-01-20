package admin.dao;

import org.springframework.stereotype.Repository;

import admin.entity.PaperCategory;
import rex.devwork.BaseDao;

@Repository("paperCategoryDao")
public class PaperCategoryDao extends BaseDao<PaperCategory,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperCategory.class;
	}
}
