package factory;

import admin.service.PaperImageService;
import chok.devwork.BeanFactory;


public class MyFactory {
	public static PaperImageService getPaperImageService(){return (PaperImageService) BeanFactory.getBean("paperImageService");}
}
