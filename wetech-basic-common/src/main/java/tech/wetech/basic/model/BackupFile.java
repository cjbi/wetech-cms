package tech.wetech.basic.model;

import java.util.Date;

public class BackupFile implements Comparable<BackupFile>{
	/**
	 * 备份的文件名称
	 */
	private String name;
	/**
	 * 备份的文件时间
	 */
	private Date time;
	/**
	 * 备份的文件的尺寸
	 */
	private int size;
	/**
	 * 备份的文件类型
	 */
	private String filetype;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	public int compareTo(BackupFile o) {
		return o.getTime().compareTo(this.getTime());
	}
	@Override
	public String toString() {
		return "BackupFile [name=" + name + ", time=" + time + ", size=" + size
				+ ", filetype=" + filetype + "]";
	}
}
