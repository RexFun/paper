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
	
	public void delByUserId(Long userId)
	{
		this.getSqlSession().delete(getStatementName("delByUserId"), userId);
	}
	
	public void delByRoleId(Long roleId)
	{
		this.getSqlSession().delete(getStatementName("delByRoleId"), roleId);
	}
	
	public String getRoleIdsByUserId(Long userId)
	{
		return this.getSqlSession().selectOne(getStatementName("getRoleIdsByUserId"), userId);
	}
}
