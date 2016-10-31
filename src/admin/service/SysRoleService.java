package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysRoleDao;
import admin.entity.SysRole;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;

@Service("sysRoleService")
public class SysRoleService extends BaseService<SysRole,Long>
{
	@Autowired
	private SysRoleDao sysRoleDao;

	@Override
	public BaseDao<SysRole,Long> getEntityDao() {
		return sysRoleDao;
	}
}
