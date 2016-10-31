package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysMenuDao;
import admin.entity.SysMenu;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;

@Service("sysMenuService")
public class SysMenuService extends BaseService<SysMenu,Long>
{
	@Autowired
	private SysMenuDao sysMenuDao;

	@Override
	public BaseDao<SysMenu,Long> getEntityDao() {
		return sysMenuDao;
	}
}
