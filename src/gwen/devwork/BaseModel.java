package gwen.devwork;

import java.util.HashMap;

public abstract class BaseModel 
{
	HashMap<String, Object> m;

	public HashMap<String, Object> getM() 
	{
		m = m==null?new HashMap<String, Object>():m;
		return m;
	}

	public void setM(HashMap<String, Object> m) 
	{
		this.m = m;
	}
}
