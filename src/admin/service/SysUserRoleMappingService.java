package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysUserRoleMappingDao;
import admin.entity.SysUserRoleMapping;
import chok.devwork.BaseDao;
import chok.devwork.BaseService;

@Service("sysUserRoleService")
public class SysUserRoleMappingService extends BaseService<SysUserRoleMapping,Long>
{
	@Autowired
	private SysUserRoleMappingDao sysUserRoleMappingDao;

	@Override
	public BaseDao<SysUserRoleMapping,Long> getEntityDao() {
		return sysUserRoleMappingDao;
	}
	
	@Override
	public void add(SysUserRoleMapping po){
		sysUserRoleMappingDao.add(po);
	}
}
