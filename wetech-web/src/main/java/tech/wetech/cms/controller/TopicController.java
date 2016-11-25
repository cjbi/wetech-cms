package tech.wetech.cms.controller;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import tech.wetech.basic.model.SystemContext;
import tech.wetech.basic.util.JsonUtil;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.auth.AuthMethod;
import tech.wetech.cms.dto.AjaxObj;
import tech.wetech.cms.dto.TopicDto;
import tech.wetech.cms.model.Attachment;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.Topic;
import tech.wetech.cms.model.User;
import tech.wetech.cms.service.*;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
	public Map<String, Object> list(@RequestParam(required = false) String con,
			@RequestParam(required = false) Integer cid, Model model, HttpSession session, Integer status) {
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
	public String topic(Model model) {
		initChannel(model);
		return "topic/topic";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	public String add(Model model) {
		return "topic/add";
	}

	private void initChannel(Model model) {
		// model.addAttribute("con", con);
		// model.addAttribute("cid", cid);
		model.addAttribute("cs", channelService.listPublishChannel());
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseData add(@Validated TopicDto topicDto, BindingResult br, String[] aks, Integer[] aids,
			HttpSession session) {
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
	@RequestMapping(value = "/delete")
	@AuthMethod(role = "ROLE_PUBLISH")
	public ResponseData delete(Long[] ids) {
		for (Long id : ids) {
			Topic t = topicService.load(id.intValue());
			topicService.delete(id.intValue());
			// 判断是否更新首页
			if (topicService.isUpdateIndex(t.getChannel().getId())) {
				indexService.generateBody();
			}
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	/*------------------------------------------------------------------------------------------------*/

	private void initList(String con, Integer cid, Model model, HttpSession session, Integer status) {
		SystemContext.setSort("t.publishDate");
		SystemContext.setOrder("desc");
		boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
		if (isAdmin) {
			model.addAttribute("datas", topicService.find(cid, con, status));
		} else {
			User loginUser = (User) session.getAttribute("loginUser");
			model.addAttribute("datas", topicService.find(loginUser.getId(), cid, con, status));
		}
		if (con == null)
			con = "";
		SystemContext.removeOrder();
		SystemContext.removeSort();
		model.addAttribute("con", con);
		model.addAttribute("cid", cid);
		model.addAttribute("cs", channelService.listPublishChannel());
	}

	/*
	 * @RequestMapping("/audits")
	 * 
	 * @AuthMethod(role="ROLE_PUBLISH,ROLE_AUDIT") public String
	 * auditList(@RequestParam(required=false) String
	 * con,@RequestParam(required=false) Integer cid,Model model,HttpSession
	 * session) { initList(con, cid, model, session,1); return "topic/list"; }
	 */

	@RequestMapping("/unaudits")
	@AuthMethod(role = "ROLE_PUBLISH,ROLE_AUDIT")
	public String unauditList(@RequestParam(required = false) String con, @RequestParam(required = false) Integer cid,
			Model model, HttpSession session) {
		initList(con, cid, model, session, 0);
		return "topic/list";
	}

	@RequestMapping("/changeStatus/{id}")
	@AuthMethod(role = "ROLE_AUDIT")
	public String changeStatus(@PathVariable int id, Integer status) {
		topicService.updateStatus(id);
		Topic t = topicService.load(id);
		if (topicService.isUpdateIndex(t.getChannel().getId())) {
			indexService.generateBody();
		}
		if (status == 0) {
			return "redirect:/admin/topic/unaudits";
		} else {
			return "redirect:/admin/topic/audits";
		}
	}

	@RequestMapping("/delete/{id}")
	@AuthMethod(role = "ROLE_PUBLISH")
	public String delete(@PathVariable int id, Integer status) {
		Topic t = topicService.load(id);
		topicService.delete(id);
		if (topicService.isUpdateIndex(t.getChannel().getId())) {
			indexService.generateBody();
		}
		if (status == 0) {
			return "redirect:/admin/topic/unaudits";
		} else {
			return "redirect:/admin/topic/audits";
		}
	}

	@RequestMapping(value = "/add2", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	public String add2(Model model) {
		Topic t = new Topic();
		t.setPublishDate(new Date());
		TopicDto td = new TopicDto(t);
		model.addAttribute("topicDto", td);
		return "topic/add2";
	}

	/*
	 * @RequestMapping(value = "/add", method = RequestMethod.POST) public
	 * String add(@Validated TopicDto topicDto, BindingResult br, String[] aks,
	 * Integer[] aids, HttpSession session) { if (br.hasErrors()) { return
	 * "topic/add"; } Topic t = topicDto.getTopic(); User loginUser = (User)
	 * session.getAttribute("loginUser"); StringBuffer keys = new
	 * StringBuffer(); if (aks != null) { for (String k : aks) {
	 * keys.append(k).append("|"); keywordService.addOrUpdate(k); } }
	 * t.setKeyword(keys.toString()); topicService.add(t, topicDto.getCid(),
	 * loginUser.getId(), aids); if (topicDto.getStatus() == 1 &&
	 * topicService.isUpdateIndex(topicDto.getCid())) {
	 * indexService.generateBody(); } return "redirect:/jsp/common/addSuc.jsp";
	 * }
	 */

	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	public String update(@PathVariable int id, Model model) {
		Topic t = topicService.load(id);
		String keyword = t.getKeyword();
		if (keyword != null && !"".equals(keyword.trim()))
			model.addAttribute("keywords", keyword.split("\\|"));
		model.addAttribute("atts", attachmentService.listByTopic(id));
		TopicDto td = new TopicDto(t, t.getChannel().getId());
		model.addAttribute("topicDto", td);
		model.addAttribute("cname", t.getChannel().getName());
		return "topic/update";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	public String update(@PathVariable int id, @Validated TopicDto topicDto, BindingResult br, String[] aks,
			Integer[] aids, HttpSession session) {
		if (br.hasErrors()) {
			return "topic/update";
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
		if (topicService.isUpdateIndex(topicDto.getCid())) {
			indexService.generateBody();
		}
		return "redirect:/jsp/common/addSuc.jsp";
	}

	@RequestMapping("/{id}")
	public String show(@PathVariable int id, Model model) {
		model.addAttribute(topicService.load(id));
		model.addAttribute("atts", attachmentService.listByTopic(id));
		return "topic/show";
	}

	@RequestMapping(value = "/searchKeyword")
	@AuthMethod(role = "ROLE_PUBLISH")
	public @ResponseBody List<String> searchKeyword(String term) {
		return keywordService.listKeywordStringByCon(term);
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST) // 返回的是json类型的值，而uploadify只能接受字符串
	@AuthMethod(role = "ROLE_PUBLISH")
	public void upload(MultipartFile attach, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/plain;charset=utf-8");
		AjaxObj ao = null;
		try {
			Attachment att = new Attachment();
			String ext = FilenameUtils.getExtension(attach.getOriginalFilename());
			// System.out.println(ext);
			att.setIsAttach(0);
			if (imgTypes.contains(ext))
				att.setIsImg(1);
			else
				att.setIsImg(0);
			att.setIsIndexPic(0);
			att.setNewName(String.valueOf(new Date().getTime()) + "." + ext);
			att.setOldName(FilenameUtils.getBaseName(attach.getOriginalFilename()));
			att.setSuffix(ext);
			att.setType(attach.getContentType());
			att.setTopic(null);
			att.setSize(attach.getSize());
			attachmentService.add(att, attach.getInputStream());
			ao = new AjaxObj(1, null, att);
		} catch (IOException e) {
			ao = new AjaxObj(0, e.getMessage());
		}
		resp.getWriter().write(JsonUtil.getInstance().obj2json(ao));
	}

	@ResponseBody
	@RequestMapping("/treeAll")
	@AuthMethod(role = "ROLE_PUBLISH")
	public List<ChannelTree> tree(HttpSession session) {
		boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
		User loginUser = (User) session.getAttribute("loginUser");
		if (isAdmin)
			return channelService.generateTree();
		else
			return groupService.generateUserChannelTree(loginUser.getId());
	}
}
