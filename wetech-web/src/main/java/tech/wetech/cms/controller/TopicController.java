package tech.wetech.cms.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import tech.wetech.basic.model.SystemContext;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.auth.AuthMethod;
import tech.wetech.cms.dto.TopicDto;
import tech.wetech.cms.model.Attachment;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.Topic;
import tech.wetech.cms.model.User;
import tech.wetech.cms.service.IAttachmentService;
import tech.wetech.cms.service.IChannelService;
import tech.wetech.cms.service.IGroupService;
import tech.wetech.cms.service.IIndexService;
import tech.wetech.cms.service.IKeywordService;
import tech.wetech.cms.service.ITopicService;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

@Controller
@AuthClass("login")
@RequestMapping("/admin/topic")
public class TopicController {

	@Inject
	private IChannelService channelService;
	@Inject
	private ITopicService topicService;
	@Inject
	private IKeywordService keywordService;
	@Inject
	private IAttachmentService attachmentService;
	@Inject
	private IIndexService indexService;
	@Inject
	private IGroupService groupService;

	private final static List<String> imgTypes = Arrays.asList("jpg", "jpeg", "gif", "png");

	@RequestMapping("/list")
	@AuthMethod(role = "ROLE_PUBLISH,ROLE_AUDIT")
	@ResponseBody
	public Map<String, Object> list(@RequestParam(required = false) String con, @RequestParam(required = false) Integer cid, Model model, HttpSession session, Integer status) {
		System.out.println(model);
		boolean isAdmin = (boolean) session.getAttribute("isAdmin");
		SystemContext.setSort("t.publishDate");
		SystemContext.setOrder("desc");
		if (isAdmin) {
			return DataTableMap.getMapData(topicService.find(cid, con, status));
		} else {
			User loginUser = (User) session.getAttribute("loginUser");
			return DataTableMap.getMapData(topicService.find(loginUser.getId(), cid, con, status));
		}
	}

	@RequestMapping({ "/topic", "/", "" })
	@AuthMethod(role = "ROLE_PUBLISH,ROLE_AUDIT")
	public String topic(Model model) {
		initChannel(model);
		return "admin/topic/topic";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	public String add(Model model) {
		return "admin/topic/add";
	}

	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	public String edit(@PathVariable int id, Model model) {
		Topic t = topicService.load(id);
		String keyword = t.getKeyword();
		if (keyword != null && !"".equals(keyword.trim())) {
			model.addAttribute("keywords", keyword.split("\\|"));
		}
		model.addAttribute("atts", attachmentService.listByTopic(id));
		TopicDto td = new TopicDto(t, t.getChannel().getId());
		model.addAttribute("topicDto", td);
		model.addAttribute("cname", t.getChannel().getName());
		return "admin/topic/edit";
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseData add(@Validated TopicDto topicDto, BindingResult br, String[] aks, Integer[] aids, HttpSession session) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		Topic t = topicDto.getTopic();
		User loginUser = (User) session.getAttribute("loginUser");
		StringBuffer keys = new StringBuffer();
		if (aks != null) {
			for (String k : aks) {
				keys.append(k).append("|");
				keywordService.addOrUpdate(k);
			}
		}
		t.setKeyword(keys.toString());
		topicService.add(t, topicDto.getCid(), loginUser.getId(), aids);
		if (topicDto.getStatus() == 1 && topicService.isUpdateIndex(topicDto.getCid())) {
			indexService.generateBody();
		}
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ResponseData edit(int id, @Validated TopicDto topicDto, BindingResult br, String[] aks, Integer[] aids, HttpSession session) {
		if (br.hasErrors()) {
			return ResponseData.FAILED_NO_DATA;
		}
		Topic tt = topicService.load(id);
		Topic t = topicDto.getTopic();
		StringBuffer keys = new StringBuffer();
		if (aks != null) {
			for (String k : aks) {
				keys.append(k).append("|");
				keywordService.addOrUpdate(k);
			}
		}
		tt.setKeyword(keys.toString());
		tt.setChannelPicId(t.getChannelPicId());
		tt.setContent(t.getContent());
		tt.setPublishDate(t.getPublishDate());
		tt.setRecommend(t.getRecommend());
		tt.setStatus(t.getStatus());
		tt.setSummary(t.getSummary());
		tt.setTitle(t.getTitle());
		topicService.update(tt, topicDto.getCid(), aids);
		/*if (topicService.isUpdateIndex(topicDto.getCid())) {
			indexService.generateBody();
		}*/
		indexService.generateBody();
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	@AuthMethod(role = "ROLE_PUBLISH")
	public ResponseData delete(Long[] ids) {
		for (Long id : ids) {
			Topic t = topicService.load(id.intValue());
			topicService.delete(id.intValue());
			// 判断是否更新首页
			/*if (topicService.isUpdateIndex(t.getChannel().getId())) {
				indexService.generateBody();
			}*/
			indexService.generateBody();
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	private void initChannel(Model model) {
		// model.addAttribute("con", con);
		// model.addAttribute("cid", cid);
		model.addAttribute("cs", channelService.listPublishChannel());
	}

}
