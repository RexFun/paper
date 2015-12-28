package client.dao;

import gwen.devwork.BaseDao;

import org.springframework.stereotype.Repository;

import client.entity.PaperImage1;


@Repository("clientPaperImage1Dao")
public class PaperImage1Dao extends BaseDao<PaperImage1,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperImage1.class;
	}
	
	public PaperImage1 getByPidAndMaxSort(Long pid)
	{
		return (PaperImage1) this.getSqlSession().selectOne(getStatementName("getByPidAndMaxSort"), pid);
	}
}
