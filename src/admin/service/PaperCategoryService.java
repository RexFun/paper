package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.PaperCategoryDao;
import admin.entity.PaperCategory;
import rex.devwork.BaseDao;
import rex.devwork.BaseService;

@Service("paperCategoryService")
public class PaperCategoryService extends BaseService<PaperCategory,Long>
{
	@Autowired
	private PaperCategoryDao paperCategoryDao;

	@Override
	public BaseDao<PaperCategory,Long> getEntityDao() {
		return paperCategoryDao;
	}
}
