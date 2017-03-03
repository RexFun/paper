package client.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import chok.devwork.BaseDao;
import chok.devwork.BaseService;
import client.dao.PaperCategoryDao;
import client.entity.PaperCategory;

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
