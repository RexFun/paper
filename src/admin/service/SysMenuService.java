package admin.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysMenuDao;
import admin.entity.SysMenu;
import chok.devwork.BaseDao;
import chok.devwork.BaseService;

@Service("sysMenuService")
public class SysMenuService extends BaseService<SysMenu,Long>
{
	@Autowired
	private SysMenuDao sysMenuDao;

	@Override
	public BaseDao<SysMenu,Long> getEntityDao() {
		return sysMenuDao;
	}
	
	public List getAll()
	{
		List<SysMenu> menuData = sysMenuDao.get(null);
		List<Object> treeNodes = new ArrayList<Object>();
		for(int i=0; i<menuData.size(); i++)
		{
			SysMenu o = menuData.get(i);
			treeNodes.add(o.getM());
		}
		return treeNodes;
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
	
	public List getByUserIdAndMenuName(Map m)
	{
		List<SysMenu> menuData = sysMenuDao.getByUserIdAndMenuName(m);
		List<Object> treeNodes = new ArrayList<Object>();
		for(int i=0; i<menuData.size(); i++)
		{
			SysMenu o = menuData.get(i);
			treeNodes.add(o.getM());
		}
		return treeNodes;
	}
}
