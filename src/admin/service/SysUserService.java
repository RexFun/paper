package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysUserDao;
import admin.dao.SysUserRoleMappingDao;
import admin.entity.SysRole;
import admin.entity.SysUser;
import admin.entity.SysUserRoleMapping;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;
import gwen.util.CollectionUtil;

@Service("sysUserService")
public class SysUserService extends BaseService<SysUser,Long>
{
	@Autowired
	private SysUserDao sysUserDao;
	@Autowired
	private SysUserRoleMappingDao sysUserRoleMappingDao;

	@Override
	public BaseDao<SysUser,Long> getEntityDao() {
		return sysUserDao;
	}
	
	@Override
	public void add(SysUser po)
	{
		// 插入系统用户表
		sysUserDao.add(po);
		// 插入系统角色权限表
		if (po.get("tc_sys_role_ids").toString().length()<1) return;
		Long tcSysUserId = po.getId();
		Long[] tcSysRoleIds = CollectionUtil.strToLongArray(po.get("tc_sys_role_ids").toString(), ",");
		for(Long tcSysRoleId : tcSysRoleIds)
		{
			SysUserRoleMapping o = new SysUserRoleMapping();
			o.set("tc_sys_user_id", tcSysUserId);
			o.set("tc_sys_role_id", tcSysRoleId);
			sysUserRoleMappingDao.add(o);
		}
	}
	
	@Override
	public void del(Long[] ids) 
	{
		for(Long id:ids)
		{
			sysUserRoleMappingDao.delByUserId(id);
			sysUserDao.del(id);
		}
	}
	
	@Override
	public void upd(SysUser po)
	{
		sysUserDao.upd(po);
		// 清空旧记录
		sysUserRoleMappingDao.delByUserId(po.getLong("id"));
		// 插入系统用户角色表
		if (po.get("tc_sys_role_ids").toString().length()<1) return;
		Long tcSysUserId = po.getLong("id");
		Long[] tcSysRoleIds = CollectionUtil.strToLongArray(po.get("tc_sys_role_ids").toString(), ",");
		for(Long tcSysRoleId : tcSysRoleIds)
		{
			SysUserRoleMapping o = new SysUserRoleMapping();
			o.set("tc_sys_user_id", tcSysUserId);
			o.set("tc_sys_role_id", tcSysRoleId);
			sysUserRoleMappingDao.add(o);
		}
	}
	
	@Override
	public SysUser getById(Long id) 
	{
		SysUser po = sysUserDao.getById(id);
		po.set("tc_sys_role_ids", sysUserRoleMappingDao.getRoleIdsByUserId(id));
		return po;
	}
}
