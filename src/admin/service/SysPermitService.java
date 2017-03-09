package admin.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysPermitDao;
import admin.entity.SysPermit;
import chok.devwork.BaseDao;
import chok.devwork.BaseService;

@Service
public class SysPermitService extends BaseService<SysPermit,Long>
{
	@Autowired
	private SysPermitDao sysPermitDao;

	@Override
	public BaseDao<SysPermit,Long> getEntityDao() {
		return sysPermitDao;
	}
	
	@Override
	public void del(Long[] ids) 
	{
		for(Long id:ids)
		{
			// 删除菜单关联关系
			// 删除角色关联关系
			// 删除父子关联关系
			// 删除主表记录
			sysPermitDao.del(id);
		}
	}
	
	public List getByRoleId(Map<String, Object> m)
	{
		return sysPermitDao.getByRoleId(m);
	}
	
	public List getBtnPermitByUserId(Long userId)
	{
		List<SysPermit> btnPermitData = sysPermitDao.getBtnPermitByUserId(userId);
		List<Object> treeNodes = new ArrayList<Object>();
		for(int i=0; i<btnPermitData.size(); i++)
		{
			SysPermit o = btnPermitData.get(i);
			treeNodes.add(o.getM());
		}
		return treeNodes;
	}
	
	public int getCountByUserIdAndActionUrl(Map m)
	{
		return sysPermitDao.getCountByUserIdAndActionUrl(m);
	}
}
