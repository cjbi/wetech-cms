package tech.wetech.cms.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.Valid;

import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.dto.UserDto;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.Group;
import tech.wetech.cms.model.User;
import tech.wetech.cms.service.IGroupService;
import tech.wetech.cms.service.IUserService;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/admin/group")
@Controller
@AuthClass
public class GroupController {
	@Inject
	private IGroupService groupService;
	@Inject
	private IUserService userService;

	@RequestMapping({ "/group", "/", "" })
	public String group(Model model) {
		return "admin/group";
	}

	@RequestMapping("/list")
	public @ResponseBody Map<String, Object> list() {
		return DataTableMap.getMapData(groupService.findGroup());
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public @ResponseBody ResponseData add(@Validated Group group, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		groupService.add(group);
		return ResponseData.SUCCESS_NO_DATA;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public @ResponseBody ResponseData edit(Integer id, @Validated Group group, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		Group ug = groupService.load(id);
		ug.setDescr(group.getDescr());
		ug.setName(group.getName());
		groupService.update(ug);
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	@RequestMapping(value = "/delete")
	public @ResponseBody ResponseData delete(Long[] ids) {
		for (Long id : ids) {
			groupService.delete(id.intValue());
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	/*-------------------------------------------------------------------*/

	@RequestMapping("/groups")
	public String list(Model model) {
		model.addAttribute("datas", groupService.findGroup());
		return "group/list";
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute(new Group());
		return "group/add";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String update(@PathVariable int id, Model model) {
		model.addAttribute(groupService.load(id));
		return "group/update";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	public String update(@PathVariable int id, @Validated Group group, BindingResult br) {
		if (br.hasErrors()) {
			return "group/update";
		}
		Group ug = groupService.load(id);
		ug.setDescr(group.getDescr());
		ug.setName(group.getName());
		groupService.update(ug);
		return "redirect:/admin/group/groups";
	}

	@RequestMapping("/delete/{id}")
	public String delete(@PathVariable int id) {
		groupService.delete(id);
		return "redirect:/admin/group/groups";
	}

	@RequestMapping("/{id}")
	public String show(@PathVariable int id, Model model) {
		model.addAttribute(groupService.load(id));
		model.addAttribute("us", userService.listGroupUsers(id));
		return "group/show";
	}

	@RequestMapping("/clearUsers/{id}")
	public String clearGroupUsers(@PathVariable int id) {
		groupService.deleteGroupUsers(id);
		return "redirect:/admin/group/groups";
	}

	@RequestMapping("/listChannels/{gid}")
	public String listChannels(@PathVariable int gid, Model model) {
		model.addAttribute(groupService.load(gid));
		return "/group/listChannel";
	}

	@RequestMapping("/groupTree/{gid}")
	public @ResponseBody List<ChannelTree> groupTree(@PathVariable Integer gid) {
		return groupService.generateGroupChannelTree(gid);
	}

	@RequestMapping("/setChannels/{gid}")
	public String setChannels(@PathVariable int gid, Model model) {
		model.addAttribute(groupService.load(gid));
		model.addAttribute("cids", groupService.listGroupChannelIds(gid));
		return "/group/setChannel";
	}
}
