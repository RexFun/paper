package admin.dao;

import org.springframework.stereotype.Repository;

import admin.entity.SysUserRoleMapping;
import gwen.devwork.BaseDao;


@Repository("sysUserRoleDao")
public class SysUserRoleMappingDao extends BaseDao<SysUserRoleMapping,Long>
{
	@Override
	public Class getEntityClass()
	{
		return SysUserRoleMapping.class;
	}
}
