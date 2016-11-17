package tech.wetech.cms.dto;

public class TreeDto {
	private int id;
	private String name;
	private int isParent;
	private Object obj;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getIsParent() {
		return isParent;
	}
	public void setIsParent(int isParent) {
		this.isParent = isParent;
	}
	
	public Object getObj() {
		return obj;
	}
	
	public void setObj(Object obj) {
		this.obj = obj;
	}
	
	public TreeDto() {
	
	}
	
	public TreeDto(int id, String name, int isParent,Object obj) {
		super();
		this.id = id;
		this.name = name;
		this.isParent = isParent;
		this.obj = obj;
	}
}
