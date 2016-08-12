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
	
	public void set(String k, Object v)
	{
		this.getM().put(k, v);
	}
	
	public Object get(String k)
	{
		return this.getM().get(k);
	}
	
	
	public String getString(String k)
	{
		return String.valueOf(get(k));
	}
	
	public Long getLong(String k)
	{
		return Long.valueOf(String.valueOf(get(k)));
	}
	
	public Integer getInteger(String k)
	{
		return Integer.valueOf(String.valueOf(get(k)));
	}
	
	public byte[] getByteArray(String k)
	{
		return (byte[])get(k);
	}
}
