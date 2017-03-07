package admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
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
	
	public List getByUserId(Map m)
	{
		List<Long> menuIds = new ArrayList<Long>();
		List<SysMenu> menus = new ArrayList<SysMenu>();
		Long userid = Long.valueOf(m.get("tc_sys_user_id").toString());
		// 1. 查找目的菜单
		List<SysMenu> targetMenus = sysMenuDao.getByUserId(m);
		for(SysMenu o : targetMenus)
		{
			menuIds.add(o.getLong("id"));
		}
		// 2. 根据目的菜单递归检索所有父菜单和子菜单
		if (m.containsKey("tc_name") && m.get("tc_name").toString().length()>0)
		{
			// 2.1 递归检索父菜单
			for(SysMenu o : targetMenus)
			{
				menuIds.addAll(getParentMenus(userid, o.getLong("pid")));
			}
			// 2.2 递归检索子菜单
			for(SysMenu o : targetMenus)
			{
				menuIds.addAll(getChildMenus(userid, o.getLong("id")));
			}
		}
		// 3. 合并菜单集合
		// 3.1 去重复
		HashSet set  =   new  HashSet(menuIds); 
		menuIds.clear(); 
		menuIds.addAll(set); 
		for(Long id : menuIds)
		{
			m.clear();
			m.put("id", id);
			m.put("tc_sys_user_id", userid);
			menus.add((SysMenu) sysMenuDao.getByUserId(m).get(0));
		}
		// 3.2 格式化为json
		List<Object> treeNodes = new ArrayList<Object>();
		for(int i=0; i<menus.size(); i++)
		{
			SysMenu o = menus.get(i);
			treeNodes.add(o.getM());
		}
		return treeNodes;
	}
	
	// 递归检索父菜单id集合
	public List<Long> getParentMenus(Long userid, Long pid)
	{
		List<Long> pids = new ArrayList<Long>();
		Map m = new HashMap();
		m.put("tc_sys_user_id", userid);
		m.put("id",pid);
		List<SysMenu> parentMenus = sysMenuDao.getByUserId(m);
		
		if(parentMenus.size()==1)
		{
			pids.add(parentMenus.get(0).getLong("id"));
			getParentMenus(userid, parentMenus.get(0).getLong("pid"));
		}
		return pids;
	}
	
	// 递归检索子菜单id集合
	public List<Long> getChildMenus(Long userid, Long id)
	{
		List<Long> cids = new ArrayList<Long>();
		Map m = new HashMap();
		m.put("tc_sys_user_id", userid);
		m.put("pid",id);
		List<SysMenu> childMenus = sysMenuDao.getByUserId(m);
		
		if(childMenus.size()>0)
		{
			for (int i=0; i<childMenus.size(); i++)
			{
				cids.add(childMenus.get(i).getLong("id"));
				getChildMenus(userid, childMenus.get(i).getLong("id"));
			}
		}
		return cids;
	}
}
