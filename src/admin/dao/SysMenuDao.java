package admin.dao;

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
}
