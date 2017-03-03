package admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import admin.entity.SysRole;
import chok.devwork.BaseDao;


@Repository("sysRoleDao")
public class SysRoleDao extends BaseDao<SysRole,Long>
{
	@Override
	public Class getEntityClass()
	{
		return SysRole.class;
	}
	
	public List getByUserId(Map<String, Object> m)
	{
		return this.getSqlSession().selectList(getStatementName("getByUserId"), m);
	}
}
