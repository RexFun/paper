package client.dao;

import org.springframework.stereotype.Repository;

import client.entity.PaperImage;
import rex.devwork.BaseDao;


@Repository("clientPaperImageDao")
public class PaperImageDao extends BaseDao<PaperImage,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperImage.class;
	}
}
