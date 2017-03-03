package admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import admin.entity.SysPermit;
import chok.devwork.BaseDao;


@Repository("sysPermitDao")
public class SysPermitDao extends BaseDao<SysPermit,Long>
{
	@Override
	public Class getEntityClass()
	{
		return SysPermit.class;
	}
	
	public List getByRoleId(Map<String, Object> m)
	{
		return this.getSqlSession().selectList(getStatementName("getByRoleId"), m);
	}
	
	public List getBtnPermitByUserId(Long userId)
	{
		return this.getSqlSession().selectList(getStatementName("getBtnPermitByUserId"), userId);
	}
	
	public int getCountByUserIdAndActionUrl(Map m){
		return (Integer) this.getSqlSession().selectOne(getStatementName("getCountByUserIdAndActionUrl"), m);
	}
}
