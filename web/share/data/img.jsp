<%
MyReq req = new MyReq(request);
long id = req.getLong("id",0);
if(id > 0)
{
	byte[] po = null;
	po = (byte[])MyFactory.getPaperImageService().getById(id).getM().get("image");
	ServletOutputStream sender = response.getOutputStream();
	response.setContentType("application/octet-stream");
	sender.write(po);
	sender.flush();
	sender.close();
}
%><%@page language="java" pageEncoding="UTF-8"
import="
gwen.devwork.MyReq,admin.MyFactory"%>