package tech.wetech.cms.model;

import java.util.List;

/**
 * 系统栏目树对象
 * @author cjbi
 *
 */
public class ChannelTree {
	
	private Integer id;
	private String name;
	private Integer pid;
	private Channel channel;
	private List<Channel> child;
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public ChannelTree() {
	}
	
	public Channel getChannel() {
		return channel;
	}

	public void setChannel(Channel channel) {
		this.channel = channel;
	}

	public List<Channel> getChild() {
		return child;
	}

	public void setChild(List<Channel> child) {
		this.child = child;
	}

	public ChannelTree(Integer id, String name, Integer pid) {
		super();
		this.id = id;
		this.name = name;
		this.pid = pid;
	}

	@Override
	public String toString() {
		return "ChannelTree [id=" + id + ", name=" + name + ", pid=" + pid + ", channel=" + channel + ", child=" + child
				+ "]";
	}
	
}
