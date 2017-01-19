package tech.wetech.cms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import tech.wetech.basic.model.Pager;
import tech.wetech.cms.dao.IAttachmentDao;
import tech.wetech.cms.dao.IChannelDao;
import tech.wetech.cms.dao.ITopicDao;
import tech.wetech.cms.dao.IUserDao;
import tech.wetech.cms.model.Attachment;
import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.CmsException;
import tech.wetech.cms.model.Topic;
import tech.wetech.cms.model.User;

@Service("topicService")
public class TopicService implements ITopicService {

	/**
	 * 日志对象
	 */
	private static final Logger log = LoggerFactory.getLogger(TopicService.class);

	@Inject
	private ITopicDao topicDao;
	@Inject
	private IAttachmentDao attachmentDao;
	@Inject
	private IChannelDao channelDao;
	@Inject
	private IUserDao userDao;

	private void addTopicAtts(Topic topic, Integer[] aids) {
		if (aids != null) {
			for (Integer aid : aids) {
				Attachment a = attachmentDao.load(aid);
				if (a == null)
					continue;
				a.setTopic(topic);
			}
		}
	}
	
	public static void main(String[] args){
		TopicService service = new TopicService();
		service.getThumb("<p><br></p><img height=\"400\" src=\"/resources/upload/1481991801740.jpg\" id=\"attach_609\"><img height=\"400\" src=\"/resources/upload/1481991801956.jpg\" id=\"attach_610\"><img height=\"400\" src=\"/resources/upload/1481991802190.jpg\" id=\"attach_611\"><img height=\"400\" src=\"/resources/upload/1481991802447.jpg\" id=\"attach_612\">222");
	}
	
	private String getThumb(String content) {
		Matcher m = Pattern.compile("(?<=src=\")(.*?).jpg|.png|.gif|.bmp").matcher(content);
		List<String> list = new ArrayList<>();
		while (m.find()) {
			list.add(m.group());
		}
		String thumb = list.size() > 0 ? list.get(0) : null;
		log.info("缩略图：" + thumb);
		return thumb;
	}

	@Override
	public void add(Topic topic, int cid, int uid, Integer[] aids) {
		Channel c = channelDao.load(cid);
		User u = userDao.load(uid);
		if (c == null || u == null)
			throw new CmsException("要添加的文章必须有用户和栏目");
		topic.setAuthor(u.getNickname());
		topic.setCname(c.getName());
		topic.setCreateDate(new Date());
		topic.setChannel(c);
		topic.setUser(u);
		// 生成缩略图
		topic.setThumb(getThumb(topic.getContent()));
		topicDao.add(topic);
		addTopicAtts(topic, aids);
	}

	@Override
	public void add(Topic topic, int cid, int uid) {
		add(topic, cid, uid, null);
	}

	@Override
	public void delete(int id) {
		List<Attachment> atts = attachmentDao.listByTopic(id);
		attachmentDao.deleteByTopic(id);
		topicDao.delete(id);
		// 删除硬盘上面的文件
		for (Attachment a : atts) {
			AttachmentService.deleteAttachFiles(a);
		}
	}

	@Override
	public void update(Topic topic, int cid, Integer[] aids) {
		Channel c = channelDao.load(cid);
		if (c == null)
			throw new CmsException("要更新的文章必须有用户和栏目");
		topic.setCname(c.getName());
		topic.setChannel(c);
		// 生成缩略图
		topic.setThumb(getThumb(topic.getContent()));
		topicDao.update(topic);
		addTopicAtts(topic, aids);
	}

	@Override
	public void update(Topic topic, int cid) {
		update(topic, cid, null);
	}

	@Override
	public Topic load(int id) {
		return topicDao.load(id);
	}

	@Override
	public Pager<Topic> find(String title, Integer status) {
		return topicDao.find(title, status);
	}

	@Override
	public Pager<Topic> find(Integer cid, String title, Integer status) {
		return topicDao.find(cid, title, status);
	}

	@Override
	public Pager<Topic> find(Integer uid, Integer cid, String title, Integer status) {
		return topicDao.find(uid, cid, title, status);
	}

	@Override
	public Pager<Topic> searchTopicByKeyword(String keyword) {
		return topicDao.searchTopicByKeyword(keyword);
	}

	@Override
	public Pager<Topic> searchTopic(String con) {
		return topicDao.searchTopic(con);
	}

	@Override
	public Pager<Topic> findRecommendTopic(Integer ci) {
		return topicDao.findRecommendTopic(ci);
	}

	@Override
	public void updateStatus(int tid) {
		Topic t = topicDao.load(tid);
		if (t.getStatus() == 0)
			t.setStatus(1);
		else
			t.setStatus(0);
		topicDao.update(t);
	}

	@Override
	public List<Topic> listTopicByChannelAndNumber(int cid, int num) {
		return topicDao.listTopicByChannelAndNumber(cid, num);
	}

	@Override
	public List<Topic> listTopicsByNumber(int num) {
		return topicDao.listTopicsByNumber(num);
	}

	@Override
	public List<Topic> listTopicByChannel(int cid) {
		return topicDao.listTopicsByChannel(cid);
	}

	@Override
	public boolean isUpdateIndex(int cid) {
		return topicDao.isUpdateIndex(cid);
	}

	@Override
	public Topic loadLastedTopicByColumn(int cid) {
		return topicDao.loadLastedTopicByColumn(cid);
	}

	@Override
	public List<Topic> listRecommendTopicByNumber(int num) {
		return topicDao.listRecommendTopicByNumber(num);
	}

}
