package client.dao;

import org.springframework.stereotype.Repository;

import chok.devwork.BaseDao;
import client.entity.PaperImage;


@Repository("clientPaperImageDao")
public class PaperImageDao extends BaseDao<PaperImage,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperImage.class;
	}
}
