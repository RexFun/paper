package gwen.devwork;

import java.util.HashMap;

public abstract class BaseModel 
{
	HashMap<String, Object> m;

	public HashMap<String, Object> getM() 
	{
		return m;
	}

	public void setM(HashMap<String, Object> m) 
	{
		this.m = m;
	}
}
