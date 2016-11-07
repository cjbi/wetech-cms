package tech.wetech.cms.controller;

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
import tech.wetech.basic.util.EnumUtils;
import tech.wetech.cms.auth.AuthClass;
import tech.wetech.cms.model.Role;
import tech.wetech.cms.model.RoleType;
import tech.wetech.cms.service.IRoleService;
import tech.wetech.cms.service.IUserService;
import tech.wetech.cms.web.DataTableMap;
import tech.wetech.cms.web.ResponseData;

@Controller
@RequestMapping("/admin/role")
@AuthClass
public class RoleController {
	@Inject
	private IRoleService roleService;
	@Inject
	private IUserService userService;

	@RequestMapping({ "/role", "/", "" })
	public String role(Model model) {
		model.addAttribute("types", EnumUtils.enum2Name(RoleType.class));
		return "admin/role";
	}

	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(Model model) {
		return DataTableMap.getMapData(roleService.findRole());
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ResponseData add(@Validated Role role, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		roleService.add(role);
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public ResponseData edit(Integer id, @Validated Role role, BindingResult br) {
		if (br.hasErrors()) {
			return new ResponseData("操作失败" + br.getFieldError().toString());
		}
		Role er = roleService.load(id);
		er.setName(role.getName());
		er.setRoleType(role.getRoleType());
		roleService.update(er);
		return ResponseData.SUCCESS_NO_DATA;
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public ResponseData delete(Long[] ids) {
		for (Long id : ids) {
			roleService.delete(id.intValue());
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

	/*-------------------------------------------------------------------*/

	/*
	 * @RequestMapping("/roles") public String list(Model model) {
	 * model.addAttribute("roles", roleService.listRole()); return "role/list";
	 * }
	 */

	@RequestMapping("/{id}")
	public String show(@PathVariable int id, Model model) {
		model.addAttribute(roleService.load(id));
		model.addAttribute("us", userService.listRoleUsers(id));
		return "role/show";
	}

	@RequestMapping("/delete/{id}")
	public String delete(@PathVariable int id) {
		roleService.delete(id);
		return "redirect:/admin/role/roles";
	}

	@RequestMapping("/clearUsers/{id}")
	public String clearUsers(@PathVariable int id) {
		roleService.deleteRoleUsers(id);
		return "redirect:/admin/role/roles";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String update(@PathVariable int id, Model model) {
		model.addAttribute(roleService.load(id));
		model.addAttribute("types", EnumUtils.enum2Name(RoleType.class));
		return "role/update";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	public String update(@PathVariable int id, Role role) {
		Role er = roleService.load(id);
		er.setName(role.getName());
		er.setRoleType(role.getRoleType());
		roleService.update(er);
		return "redirect:/admin/role/roles";
	}
}
