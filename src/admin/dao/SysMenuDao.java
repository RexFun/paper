package admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import admin.entity.SysMenu;
import rex.devwork.BaseDao;


@Repository("sysMenuDao")
public class SysMenuDao extends BaseDao<SysMenu,Long>
{
	@Override
	public Class getEntityClass()
	{
		return SysMenu.class;
	}
	
	public List getByUserId(Long userId)
	{
		return this.getSqlSession().selectList(getStatementName("getByUserId"), userId);
	}
	
	public List getByUserIdAndParams(Map m)
	{
		return this.getSqlSession().selectList(getStatementName("getByUserIdAndParams"), m);
	}
}
