package tech.wetech.cms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.jboss.logging.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tech.wetech.basic.util.EnumUtils;
import tech.wetech.basic.util.JsonUtil;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.dto.AjaxObj;
import tech.wetech.cms.dto.TreeDto;
import tech.wetech.cms.model.Channel;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.ChannelType;
import tech.wetech.cms.model.CmsException;
import tech.wetech.cms.service.IChannelService;
import tech.wetech.cms.service.IIndexService;
import tech.wetech.cms.web.ResponseData;

@RequestMapping("/admin/channel")
@Controller
@AuthClass
public class ChannelController {

	@Inject
	private IChannelService channelService;
	@Inject
	private IIndexService indexService;

	@RequestMapping({ "/channel", "/", "" })
	public String channel(Model model) {
		model.addAttribute("types", EnumUtils.enumProp2NameMap(ChannelType.class, "name"));
		return "channel/channel";
	}

	@ResponseBody
	@RequestMapping("/getChannelTree")
	public List<TreeDto> getChannelTree(@Param Integer pId) {
		List<Channel> cs = channelService.listByParent(pId);
		List<TreeDto> tds = new ArrayList<TreeDto>();
		for (Channel c : cs) {
			tds.add(new TreeDto(c.getId(), c.getParent() != null ? c.getParent().getId() : 0, c.getName(),
					c.getIsLeaf() == 1 ? 0 : 1, c));
		}
		return tds;
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseData add(Integer pId, @Valid Channel c, BindingResult br) {
		System.out.println("发送过来的报文：" + JsonUtil.getInstance().obj2json(c));
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		channelService.add(c, pId);
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ResponseData edit(@Valid Channel c, BindingResult br) {
		System.out.println("发送过来的报文：" + JsonUtil.getInstance().obj2json(c));
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		Channel oc = channelService.load(c.getId());
		oc.setCustomLink(c.getCustomLink());
		oc.setCustomLinkUrl(c.getCustomLinkUrl());
		oc.setDescn(c.getDescn());
		oc.setIsIndex(c.getIsIndex());
		oc.setIsLeaf(c.getIsLeaf());
		oc.setIsTopNav(c.getIsTopNav());
		oc.setName(c.getName());
		oc.setNavOrder(c.getNavOrder());
		oc.setOrders(c.getOrders());
		oc.setRecommend(c.getRecommend());
		oc.setStatus(c.getStatus());
		oc.setType(c.getType());
		System.out.println(oc);
		channelService.update(oc);
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public ResponseData delete( Integer id, Model model) {
		try {
			
		channelService.delete(id);
		indexService.generateTop();
		} catch (CmsException e) {
			return new ResponseData(false, e.getMessage());
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	
	
	/*--------------------------------------------------------------------*/
	@RequestMapping("/channels")
	public String list(Model model) {
		model.addAttribute("treeDatas", JsonUtil.getInstance().obj2json(channelService.generateTree()));
		return "channel/list";
	}

	@Deprecated
	@RequestMapping("/channels/{pid}")
	public String listChild(@PathVariable Integer pid, @Param Integer refresh, Model model) {
		Channel pc = null;
		if (refresh == null) {
			model.addAttribute("refresh", 0);
		} else {
			model.addAttribute("refresh", 1);
		}
		if (pid == null || pid <= 0) {
			pc = new Channel();
			pc.setName(Channel.ROOT_NAME);
			pc.setId(Channel.ROOT_ID);
		} else
			pc = channelService.load(pid);
		model.addAttribute("pc", pc);
		model.addAttribute("channels", channelService.listByParent(pid));
		return "channel/list_child";
	}

	@RequestMapping("/treeAll")
	public @ResponseBody List<ChannelTree> tree() {
		return channelService.generateTree();
	}

	private void initAdd(Model model, Integer pid) {
		if (pid == null)
			pid = 0;
		Channel pc = null;
		if (pid == 0) {
			pc = new Channel();
			pc.setId(Channel.ROOT_ID);
			pc.setName(Channel.ROOT_NAME);
		} else {
			pc = channelService.load(pid);
		}
		model.addAttribute("pc", pc);
		model.addAttribute("types", EnumUtils.enumProp2NameMap(ChannelType.class, "name"));
	}

	@RequestMapping(value = "/add/{pid}", method = RequestMethod.GET)
	public String add(@PathVariable Integer pid, Model model) {
		initAdd(model, pid);
		model.addAttribute(new Channel());
		return "channel/add";
	}

	@RequestMapping(value = "/add/{pid}", method = RequestMethod.POST)
	public String add(@PathVariable Integer pid, Channel channel, BindingResult br, Model model) {
		if (br.hasErrors()) {
			initAdd(model, pid);
			return "channel/add";
		}
		channelService.add(channel, pid);
		indexService.generateTop();
		return "redirect:/admin/channel/channels/" + pid + "?refresh=1";
	}

	@RequestMapping("/delete/{pid}/{id}")
	public String delete(@PathVariable Integer pid, @PathVariable Integer id, Model model) {
		channelService.delete(id);
		indexService.generateTop();
		return "redirect:/admin/channel/channels/" + pid + "?refresh=1";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String update(@PathVariable Integer id, Model model) {
		Channel c = channelService.load(id);
		model.addAttribute("channel", c);
		Channel pc = null;
		if (c.getParent() == null) {
			pc = new Channel();
			pc.setId(Channel.ROOT_ID);
			pc.setName(Channel.ROOT_NAME);
		} else {
			pc = c.getParent();
		}
		model.addAttribute("pc", pc);
		model.addAttribute("types", EnumUtils.enumProp2NameMap(ChannelType.class, "name"));
		return "channel/update";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	public String update(@PathVariable Integer id, Channel channel, BindingResult br, Model model) {
		if (br.hasErrors()) {
			model.addAttribute("types", EnumUtils.enumProp2NameMap(ChannelType.class, "name"));
			return "channel/update";
		}
		Channel tc = channelService.load(id);
		int pid = 0;
		if (tc.getParent() != null)
			pid = tc.getParent().getId();
		tc.setCustomLink(channel.getCustomLink());
		tc.setCustomLinkUrl(channel.getCustomLinkUrl());
		tc.setIsIndex(channel.getIsIndex());
		tc.setIsTopNav(channel.getIsTopNav());
		tc.setName(channel.getName());
		tc.setRecommend(channel.getRecommend());
		tc.setStatus(channel.getStatus());
		tc.setType(channel.getType());
		tc.setNavOrder(channel.getNavOrder());
		channelService.update(tc);
		indexService.generateTop();
		return "redirect:/admin/channel/channels/" + pid + "?refresh=1";
	}

	@RequestMapping("/channels/updateSort")
	public @ResponseBody AjaxObj updateSort(@Param Integer[] ids) {
		try {
			channelService.updateSort(ids);
			indexService.generateTop();
		} catch (Exception e) {
			return new AjaxObj(0, e.getMessage());
		}
		return new AjaxObj(1);
	}
}
