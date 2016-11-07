package auth;

// 根据实际的需要，可以增减里面的属性
public class Auth
{
	private Long id;
	private String account;
	private String password;

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getAccount()
	{
		return account;
	}

	public void setAccount(String account)
	{
		this.account = account;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	@Override
	public String toString() {
		return "Auth [id=" + id + ", account=" + account + ", password="
				+ password + "]";
	}

}
