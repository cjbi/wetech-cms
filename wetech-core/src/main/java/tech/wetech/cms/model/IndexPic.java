package tech.wetech.cms.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 首页宣传图片
 * @author Administrator
 *
 */
@Entity
@Table(name="t_index_pic")
public class IndexPic {
	private int id;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 子标题
	 */
	private String subTitle;
	/**
	 * 首页的链接类型，如果为0表示网内链接，只要链接到一个文章节点中，/topic/xx
	 * 如果为1表示往外的链接，需要指定完整的url路径
	 */
	private int linkType;
	/**
	 * 链接的地址,如果是站内链接就用一个文章节点来表示
	 */
	private String linkUrl;
	/**
	 * 图片的新名称，使用当前时间的毫秒数
	 */
	private String newName;
	/**
	 * 图片的原始名称
	 */
	private String oldName;
	/**
	 * 图片的状态，0表示停用，1表示启动
	 */
	private int status;
	/**
	 * 位置
	 */
	private int pos;
	private Date createDate;
	
	
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	@Column(name="create_date")
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name="sub_title")
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	
	@Column(name="link_type")
	public int getLinkType() {
		return linkType;
	}
	public void setLinkType(int linkType) {
		this.linkType = linkType;
	}
	
	@Column(name="link_url")
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	
	@Column(name="new_name")
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}
	
	@Column(name="old_name")
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
