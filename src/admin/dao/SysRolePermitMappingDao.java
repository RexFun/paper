package admin.dao;

import org.springframework.stereotype.Repository;

import admin.entity.SysRolePermitMapping;
import chok.devwork.BaseDao;


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
	
	public void delByPermitId(Long permitId)
	{
		this.getSqlSession().delete(getStatementName("delByPermitId"), permitId);
	}
	
	public String getPermitIdsByRoleId(Long roleId)
	{
		return this.getSqlSession().selectOne(getStatementName("getPermitIdsByRoleId"), roleId);
	}
}
