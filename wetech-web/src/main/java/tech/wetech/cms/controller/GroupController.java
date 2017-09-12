package tech.wetech.cms.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.model.ChannelTree;
import tech.wetech.cms.model.CmsException;
import tech.wetech.cms.model.Group;
import tech.wetech.cms.service.IGroupService;
import tech.wetech.cms.service.IUserService;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

@RequestMapping("/admin/group")
@Controller
@AuthClass
public class GroupController {
	@Inject
	private IGroupService groupService;

	@RequestMapping({ "/group", "/", "" })
	public String group(Model model) {
		return "admin/group";
	}

	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list() {
		return DataTableMap.getMapData(groupService.findGroup());
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseData add(@Validated Group group, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		groupService.add(group);
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ResponseData edit(Integer id, @Validated Group group, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		Group ug = groupService.load(id);
		ug.setDescr(group.getDescr());
		ug.setName(group.getName());
		groupService.update(ug);
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public ResponseData delete(Long[] ids) {
		try {
			for (Long id : ids) {
				groupService.delete(id.intValue());
			}
		} catch (CmsException ex) {
			return new ResponseData(false, ex.getMessage());
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping("/clearUsers")
	public ResponseData clearGroupUsers(int id) {
		groupService.deleteGroupUsers(id);
		return ResponseData.SUCCESS_NO_DATA;
	}
}
