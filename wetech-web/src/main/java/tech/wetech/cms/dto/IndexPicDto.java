package tech.wetech.cms.dto;

public class IndexPicDto {
	/**
	 * 新文件名
	 */
	private String newName;
	/**
	 * 源文件名
	 */
	private String oldName;
	/**
	 * 上传之后的临时图片宽度
	 */
	private int imgWidth;
	/**
	 * 上传之后的临时图片高度
	 */
	private int imgHeight;
	/**
	 * 首页图片宽度
	 */
	private int indexPicWidth;
	/**
	 * 首页图片高度
	 */
	private int indexPicHeight;
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
	public int getImgWidth() {
		return imgWidth;
	}
	public void setImgWidth(int imgWidth) {
		this.imgWidth = imgWidth;
	}
	public int getImgHeight() {
		return imgHeight;
	}
	public void setImgHeight(int imgHeight) {
		this.imgHeight = imgHeight;
	}
	public int getIndexPicWidth() {
		return indexPicWidth;
	}
	public void setIndexPicWidth(int indexPicWidth) {
		this.indexPicWidth = indexPicWidth;
	}
	public int getIndexPicHeight() {
		return indexPicHeight;
	}
	public void setIndexPicHeight(int indexPicHeight) {
		this.indexPicHeight = indexPicHeight;
	}
}
