package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysUserDao;
import admin.entity.SysUser;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;

@Service("sysUserService")
public class SysUserService extends BaseService<SysUser,Long>
{
	@Autowired
	private SysUserDao sysUserDao;

	@Override
	public BaseDao<SysUser,Long> getEntityDao() {
		return sysUserDao;
	}
}
