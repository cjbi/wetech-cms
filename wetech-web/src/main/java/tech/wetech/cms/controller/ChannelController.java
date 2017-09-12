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
		return "admin/channel";
	}

	@ResponseBody
	@RequestMapping("/getChannelTree")
	public List<TreeDto> getChannelTree(@Param Integer pId) {
		List<Channel> cs = channelService.listByParent(pId);
		List<TreeDto> tds = new ArrayList<TreeDto>();
		for (Channel c : cs) {
			tds.add(new TreeDto(c.getId(), c.getParent() != null ? c.getParent().getId() : 0, c.getName(), c.getIsLeaf() == 1 ? 0 : 1, c));
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
		// 如果添加的栏目是顶部栏目
		if (c.getIsTopNav() == 1) {
			indexService.generateTop();
		}
		// 如果添加的栏目是首页栏目
		if (c.getIsIndex() == 1) {
			indexService.generateBody();
		}
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
		
		//更新首页标识
		boolean generateTopNav = oc.getIsTopNav() !=c.getIsTopNav();
		boolean generateIndex = oc.getIsIndex() != c.getIsIndex();
		
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
		
		if (generateTopNav) {
			indexService.generateTop();
		}
		if (generateIndex) {
			indexService.generateBody();
		}

		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping("/delete")
	public ResponseData delete(Integer id, Model model) {
		try {
			Channel c = channelService.load(id);
			channelService.delete(id);
			if (c.getIsTopNav() == 1) {
				indexService.generateTop();
			}
			if (c.getIsIndex() == 1) {
				indexService.generateBody();
			}
		} catch (CmsException e) {
			return new ResponseData(false, e.getMessage());
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	@RequestMapping("/treeAll")
	public @ResponseBody List<ChannelTree> tree() {
		return channelService.generateTree();
	}
}
