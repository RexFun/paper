package client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import chok.devwork.BaseDao;
import chok.devwork.BaseService;
import client.dao.PaperImageDao;
import client.entity.PaperImage;


@Service("clientPaperImageService")
public class PaperImageService extends BaseService<PaperImage,Long>
{
	@Autowired
	private PaperImageDao dao;

	@Override
	public BaseDao<PaperImage,Long> getEntityDao() {
		return dao;
	}
}
