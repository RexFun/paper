package client.entity;

public class PaperImage 
{
	private Long id;
	private Long pid;
	private String name;
	private int sort;
	private long datasize;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getPid() {
		return pid;
	}
	public void setPid(Long pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public long getDatasize(){
		return datasize;
	}
	public void setDatasize(long datasize){
		this.datasize = datasize;
	}
}
