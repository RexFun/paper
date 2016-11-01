package admin.dao;

import org.springframework.stereotype.Repository;

import admin.entity.SysRolePermitMapping;
import gwen.devwork.BaseDao;


@Repository("sysRolePermitDao")
public class SysRolePermitMappingDao extends BaseDao<SysRolePermitMapping,Long>
{
	@Override
	public Class getEntityClass()
	{
		return SysRolePermitMapping.class;
	}
	
	public void delByRoleId(Long roleId)
	{
		this.getSqlSession().delete(getStatementName("delByRoleId"), roleId);
	}
}
