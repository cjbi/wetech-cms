package tech.wetech.cms.model;

import java.util.List;

public class IndexTopic {
	private int cid;
	private String cname;
	private List<Topic> topics;
	
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public List<Topic> getTopics() {
		return topics;
	}
	public void setTopics(List<Topic> topics) {
		this.topics = topics;
	}
	@Override
	public String toString() {
		return "IndexTopic [cid=" + cid + ", cname=" + cname + ", topics="
				+ topics + "]";
	}
}
