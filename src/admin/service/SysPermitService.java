package admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import admin.dao.SysPermitDao;
import admin.entity.SysPermit;
import gwen.devwork.BaseDao;
import gwen.devwork.BaseService;

@Service("sysPermitService")
public class SysPermitService extends BaseService<SysPermit,Long>
{
	@Autowired
	private SysPermitDao sysPermitDao;

	@Override
	public BaseDao<SysPermit,Long> getEntityDao() {
		return sysPermitDao;
	}
	
	public List getByRoleId(Map<String, Object> m)
	{
		return sysPermitDao.getByRoleId(m);
	}
}
