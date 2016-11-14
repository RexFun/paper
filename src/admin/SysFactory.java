package admin;

import admin.service.SysPermitService;
import gwen.devwork.BeanFactory;


public class SysFactory {
	public static SysPermitService getSysPermitService(){return (SysPermitService) BeanFactory.getBean("sysPermitService");}
}
