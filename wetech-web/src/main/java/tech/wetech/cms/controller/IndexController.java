package tech.wetech.cms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import tech.wetech.basic.model.Pager;
import tech.wetech.basic.model.SystemContext;
import tech.wetech.cms.model.*;
import tech.wetech.cms.service.IAttachmentService;
import tech.wetech.cms.service.IChannelService;
import tech.wetech.cms.service.IKeywordService;
import tech.wetech.cms.service.ITopicService;
import tech.wetech.cms.web.BaseInfoUtil;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
public class IndexController {

	@Inject
	private IChannelService channelService;
	@Inject
	private ITopicService topicService;
	@Inject
	private IAttachmentService attachmentService;
	@Inject
	private IKeywordService keywordService;

	@RequestMapping({ "/", "/index" })
	public String index(Model model) {
		model.addAttribute("baseInfo", BaseInfoUtil.getInstacne().read());
		return "index/index";
	}

	@ResponseBody
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public List<Topic> search(String con) {
		SystemContext.setOrder("asc");
		SystemContext.setSort("c.orders");
		SystemContext.setOrder("desc");
		SystemContext.setSort("t.publishDate");
		Pager<Topic> topics = topicService.searchTopic(con);
		// 将关键字着色
		focus(topics, con);
		return topics.getDatas();
	}
	
	@RequestMapping(value = "/search/{con}")
	public String search(@PathVariable String con,Model model) {
		SystemContext.setOrder("asc");
		SystemContext.setSort("c.orders");
		model.addAttribute("cs", channelService.listChannelByType(ChannelType.NAV_CHANNEL));
		SystemContext.setOrder("desc");
		SystemContext.setSort("t.publishDate");
		Pager<Topic> topics = topicService.searchTopic(con);
		focus(topics,con);
		model.addAttribute("datas", topics);
		model.addAttribute("con", con);
		return "index/search";
	}

	@RequestMapping("/channel/{cid}")
	public String showChannel(@PathVariable int cid, Model model, HttpServletResponse resp, HttpServletRequest req) throws IOException {
		Channel c = channelService.load(cid);
		// System.out.println(c.getType());
		Channel pc = null;
		if (c.getType() == ChannelType.NAV_CHANNEL) {
			pc = c;
			// 如果是导航栏目，需要获取该栏目中的第一个栏目
			c = channelService.loadFirstChannelByNav(c.getId());
		} else {
			pc = c.getParent();
		}
		//如果是文章内容栏目，就获取最后发表的文章
		if (c.getType() == ChannelType.TOPIC_CONTENT) {
			Topic t = topicService.loadLastedTopicByColumn(cid);
			if(t == null) {
				throw new CmsException("该栏目还没有文章");
			}
			resp.sendRedirect(req.getContextPath() + "/topic/" + t.getId());
		} else if (c.getType() == ChannelType.TOPIC_IMG) {
			SystemContext.setPageSize(16);
			SystemContext.setSort("a.topic.publishDate");
			SystemContext.setOrder("desc");
			Pager<Attachment> atts = attachmentService.findChannelPic(cid);
			model.addAttribute("datas", atts);
		} else if (c.getType() == ChannelType.TOPIC_LIST) {
			SystemContext.setSort("t.publishDate");
			SystemContext.setOrder("desc");
			// System.out.println(c.getType());
			model.addAttribute("datas", topicService.find(c.getId(), null, 1));
		}
		SystemContext.removeSort();
		SystemContext.removeOrder();
		model.addAttribute("pc", pc);
		if (pc != null) {
			model.addAttribute("cs", channelService.listUseChannelByParent(pc.getId()));
		}
		model.addAttribute("channel", c);
		if (c.getType() == ChannelType.TOPIC_LIST) {
			return "index/channel";
		} else {
			return "index/channel_pic";
		}
	}

	@RequestMapping("/topic/{tid}")
	public String showTopic(@PathVariable int tid, Model model) {
		Topic t = topicService.load(tid);
		String keywords = t.getKeyword();
		model.addAttribute("topic", t);
		if (keywords == null || "".equals(keywords.trim()) || "\\|".equals(keywords.trim())) {
			model.addAttribute("hasKey", false);
		} else {
			String[] kws = keywords.split("\\|");
			model.addAttribute("hasKey", true);
			model.addAttribute("kws", kws);
		}
		List<Attachment> atts = attachmentService.listAttachByTopic(tid);
		if (atts.size() > 0) {
			model.addAttribute("hasAtts", true);
			model.addAttribute("atts", atts);
		} else {
			model.addAttribute("hasAtts", false);
		}
		model.addAttribute("recommendTopics", topicService.listRecommendTopicByNumber(8));
		model.addAttribute("channelTopics", topicService.listTopicByChannelAndNumber(t.getChannel().getId(), 8));
		return "index/topic";
	}

	@RequestMapping("/topics")
	public String topics(String title, Model model) {
		SystemContext.setSort("t.publishDate");
		SystemContext.setOrder("desc");
		SystemContext.setPageSize(10);
		model.addAttribute("recommendTopics", topicService.listRecommendTopicByNumber(8));
		model.addAttribute("datas", topicService.find(title, 1));
		return "index/topics";
	}

	@RequestMapping("/scroll")
	public String scroll(String title, Model model) {
		SystemContext.setSort("t.publishDate");
		SystemContext.setOrder("desc");
		model.addAttribute("datas", topicService.find(title,1));
		return "index/scroll";
	}

	@RequestMapping("/keyword/{con}")
	public String keyword(@PathVariable String con, Model model) {
		model.addAttribute("kws", keywordService.getMaxTimesKeyword(9));
		SystemContext.setOrder("desc");
		SystemContext.setSort("t.publishDate");
		Pager<Topic> topics = topicService.searchTopicByKeyword(con);
		focus(topics, con);
		model.addAttribute("datas", topics);
		model.addAttribute("con", con);
		return "index/keyword";
	}

	private void focus(Pager<Topic> topics, String con) {
		for (Topic t : topics.getDatas()) {
			if (t.getTitle().contains(con)) {
				String tt = t.getTitle().replaceAll(con, "<mark>" + con + "</mark>");
				t.setTitle(tt);
			}
		}
	}
}
