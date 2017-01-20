package client.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import client.dao.PaperCategoryDao;
import client.entity.PaperCategory;
import rex.devwork.BaseDao;
import rex.devwork.BaseService;

@Service("clientPaperCategoryService")
public class PaperCategoryService extends BaseService<PaperCategory,Long>
{
	@Autowired
	private PaperCategoryDao paperCategoryDao;

	@Override
	public BaseDao<PaperCategory,Long> getEntityDao() {
		return paperCategoryDao;
	}
}
