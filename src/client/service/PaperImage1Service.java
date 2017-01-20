package client.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import client.dao.PaperImage1Dao;
import client.entity.PaperImage1;
import rex.devwork.BaseDao;
import rex.devwork.BaseService;


@Service("clientPaperImage1Service")
public class PaperImage1Service extends BaseService<PaperImage1,Long>
{
	@Autowired
	private PaperImage1Dao dao;

	@Override
	public BaseDao<PaperImage1,Long> getEntityDao() 
	{
		return dao;
	}
	
	public PaperImage1 getByPidAndMaxSort(Long pid)
	{
		return dao.getByPidAndMaxSort(pid);
	}
}
