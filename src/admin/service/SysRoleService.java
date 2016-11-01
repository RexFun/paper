package admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysRoleDao;
import admin.dao.SysRolePermitMappingDao;
import admin.entity.SysRole;
import admin.entity.SysRolePermitMapping;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;
import gwen.util.CollectionUtil;

@Service("sysRoleService")
public class SysRoleService extends BaseService<SysRole,Long>
{
	@Autowired
	private SysRoleDao sysRoleDao;
	@Autowired
	private SysRolePermitMappingDao sysRolePermitMappingDao;

	@Override
	public BaseDao<SysRole,Long> getEntityDao() {
		return sysRoleDao;
	}
	
	@Override
	public void add(SysRole po)
	{
		// 插入系统角色表
		sysRoleDao.add(po);
		// 插入系统角色权限表
		Long tcSysRoleId = po.getId();
		Long[] tcSysPermitIds = CollectionUtil.strToLongArray(po.get("tc_sys_permit_ids").toString(), ",");
		for(Long tcSysPermitId : tcSysPermitIds)
		{
			SysRolePermitMapping o = new SysRolePermitMapping();
			o.set("tc_sys_role_id", tcSysRoleId);
			o.set("tc_sys_permit_id", tcSysPermitId);
			sysRolePermitMappingDao.add(o);
		}
	}
	
	@Override
	public void del(Long[] ids) 
	{
		for(Long id:ids)
		{
			sysRolePermitMappingDao.delByRoleId(id);
			sysRoleDao.del(id);
		}
	}
	
	@Override
	public void upd(SysRole po)
	{
		// 清空旧记录
		sysRolePermitMappingDao.delByRoleId(po.getLong("id"));
		// 插入系统角色权限表
		if (po.get("tc_sys_permit_ids").toString().length()<1) return;
		Long tcSysRoleId = po.getLong("id");
		Long[] tcSysPermitIds = CollectionUtil.strToLongArray(po.get("tc_sys_permit_ids").toString(), ",");
		for(Long tcSysPermitId : tcSysPermitIds)
		{
			SysRolePermitMapping o = new SysRolePermitMapping();
			o.set("tc_sys_role_id", tcSysRoleId);
			o.set("tc_sys_permit_id", tcSysPermitId);
			sysRolePermitMappingDao.add(o);
		}
	}
}
