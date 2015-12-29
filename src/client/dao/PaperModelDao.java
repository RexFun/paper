package client.dao;

import gwen.devwork.BaseDao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import client.entity.PaperModel;

@Repository("clientPaperModelDao")
public class PaperModelDao extends BaseDao<PaperModel,Long>
{
	@Override
	public Class getEntityClass()
	{
		return PaperModel.class;
	}
	
}
