package admin.dao;

import org.springframework.stereotype.Repository;

import admin.entity.SysRole;
import gwen.devwork.BaseDao;


@Repository("sysRoleDao")
public class SysRoleDao extends BaseDao<SysRole,Long>
{
	@Override
	public Class getEntityClass()
	{
		return SysRole.class;
	}
}
