package admin.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysMenuDao;
import admin.entity.SysMenu;
import admin.entity.SysPermit;
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
	
	public List getByUserId(Long userId)
	{
		List<SysMenu> menuData = sysMenuDao.getByUserId(userId);
		List<Object> treeNodes = new ArrayList<Object>();
		for(int i=0; i<menuData.size(); i++)
		{
			SysMenu o = menuData.get(i);
			treeNodes.add(o.getM());
		}
		return treeNodes;
	}
}
