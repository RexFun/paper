package admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import admin.entity.SysMenu;
import gwen.devwork.BaseDao;


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
}
