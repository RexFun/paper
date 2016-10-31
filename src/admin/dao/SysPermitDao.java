package admin.dao;

import org.springframework.stereotype.Repository;

import admin.entity.SysPermit;
import gwen.devwork.BaseDao;


@Repository("sysPermitDao")
public class SysPermitDao extends BaseDao<SysPermit,Long>
{
	@Override
	public Class getEntityClass()
	{
		return SysPermit.class;
	}
}
