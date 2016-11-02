package admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysRoleDao;
import admin.dao.SysRolePermitMappingDao;
import admin.dao.SysUserRoleMappingDao;
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
	@Autowired
	private SysUserRoleMappingDao sysUserRoleMappingDao;

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
		if (po.get("tc_sys_permit_ids").toString().length()<1) return;
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
			sysUserRoleMappingDao.delByRoleId(id);
			sysRoleDao.del(id);
		}
	}
	
	@Override
	public void upd(SysRole po)
	{
		sysRoleDao.upd(po);
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
	
	@Override
	public SysRole getById(Long id) 
	{
		SysRole po = sysRoleDao.getById(id);
		po.set("tc_sys_permit_ids", sysRolePermitMappingDao.getPermitIdsByRoleId(id));
		return po;
	}
	
	public List getByUserId(Map<String, Object> m)
	{
		return sysRoleDao.getByUserId(m);
	}
}
