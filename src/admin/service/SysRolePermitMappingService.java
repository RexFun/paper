package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysRolePermitMappingDao;
import admin.entity.SysRolePermitMapping;
import chok.devwork.BaseDao;
import chok.devwork.BaseService;

@Service("sysRolePermitService")
public class SysRolePermitMappingService extends BaseService<SysRolePermitMapping,Long>
{
	@Autowired
	private SysRolePermitMappingDao sysRolePermitMappingDao;

	@Override
	public BaseDao<SysRolePermitMapping,Long> getEntityDao() {
		return sysRolePermitMappingDao;
	}
	
	public void delByRoleId(Long roleId)
	{
		sysRolePermitMappingDao.delByRoleId(roleId);
	}
}
