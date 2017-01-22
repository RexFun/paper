package factory;

import admin.service.SysMenuService;
import admin.service.SysPermitService;
import rex.devwork.BeanFactory;


public class SysFactory {
	public static SysMenuService getSysMenuService(){return (SysMenuService) BeanFactory.getBean("sysMenuService");}
	public static SysPermitService getSysPermitService(){return (SysPermitService) BeanFactory.getBean("sysPermitService");}
}
